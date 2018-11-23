//
//  AuthenticateViewController.m
//  BskyResidents
//
//  Created by 何雷 on 2017/9/27.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "AuthenticateViewController.h"
#import "LoginTextField.h"
#import "GFAddressPicker.h"
#import "TeamPickerView.h"
#import "BSNavigationController.h"

#import "BSDivisionRequest.h"
#import "BSDivisionCodeRequest.h"
#import "BSDivisionIdRequest.h"
#import "BSRegisterHealthCard.h"
@interface AuthenticateViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet LoginTextField *phoneTF;
@property (weak, nonatomic) IBOutlet LoginTextField *nameTF;
@property (weak, nonatomic) IBOutlet LoginTextField *idCardTF;
@property (weak, nonatomic) IBOutlet LoginTextField *districtTF;
@property (weak, nonatomic) IBOutlet LoginTextField *streetTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (nonatomic ,strong) BSDivision *area;
@property (nonatomic ,copy) NSArray *divisionArray;
@property (nonatomic ,copy) NSArray *streetArray;

@property (nonatomic ,strong) BSRealnameAuthRequest *authRequest;

@end

@implementation AuthenticateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.authRequest = [[BSRealnameAuthRequest alloc]init];
    [self initView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getRealNameInfodData) name:GetRealnameAuthenticateInfoSuccessNotification object:nil];
}

- (void)initView
{
    if ([BSAppManager sharedInstance].currentUser.realnameInfo.verifStatus.integerValue != RealInfoVerifStatusTypeSuccess) {
        self.title = @"实名认证";
    }
    else if ([BSAppManager sharedInstance].currentUser.isChooseAD.integerValue != 2)
    {
        self.title = @"完善区划信息" ;
    }
    if ((self.navigationController && self.navigationController.viewControllers.count <= 1) || !self.navigationController ) {
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightBtn setTitle:@"跳过" forState:UIControlStateNormal];
        [rightBtn setTitleColor:Bsky_UIColorFromRGBA(0x4e7dd3,1) forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        rightBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [rightBtn sizeToFit];
        [rightBtn addTarget:self action:@selector(rightBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    }
    
    self.phoneTF.text = [BSClientManager sharedInstance].lastUsername;
    self.phoneTF.backgroundColor = Bsky_UIColorFromRGB(0xf7f7f7);
    self.phoneTF.rightView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"correct_icon"]];
    self.phoneTF.rightViewMode = UITextFieldViewModeAlways;
    self.phoneTF.enabled = NO;
    
    self.districtTF.rightView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"authenticate_loc_icon"]];
    self.districtTF.rightViewMode = UITextFieldViewModeAlways;
    
    if ([BSAppManager sharedInstance].currentUser.realnameInfo.verifStatus.integerValue == RealInfoVerifStatusTypeSuccess) {
        self.nameTF.text = [BSAppManager sharedInstance].currentUser.realnameInfo.realName;
        self.nameTF.enabled = NO;
        self.idCardTF.text = [BSAppManager sharedInstance].currentUser.realnameInfo.documentNo;
        self.idCardTF.enabled = NO;
        [self.loginBtn setTitle:@"提交" forState:UIControlStateNormal];
    }
    
    //添加监听
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidChange:)
                                               name:@"UITextFieldTextDidChangeNotification"
                                             object:_idCardTF];

    
    @weakify(self);
    self.districtTF.tapAcitonBlock = ^{
        @strongify(self);
        if (self.divisionArray.count < 1) {
            [UIView makeToast:@"正在获取区划信息"];
            return;
        }
        GFAddressPicker *picker = [[GFAddressPicker alloc]initWithDataArray:self.divisionArray];
        [picker updateArea:self.area];
        picker.selected = ^(BSDivision *province,BSDivision *city, BSDivision *area)
        {
            @strongify(self);
            if (!self.area || ![self.area.divisionFullName isEqualToString:area.divisionFullName])
            {
                self.area = area;
                self.districtTF.text = [NSString stringWithFormat:@"%@ %@ %@",province.divisionName,city.divisionName,area.divisionName];
                
                self.authRequest.provinceId = province.divisionId; // 四川
                self.authRequest.cityId = city.divisionId;
                self.authRequest.properId = area.divisionId;
                
                [self getStreetData];
            }
        };
        [picker show];
    };
    
    self.streetTF.rightView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"authenticate_loc_icon"]];
    self.streetTF.rightViewMode = UITextFieldViewModeAlways;
    self.streetTF.tapAcitonBlock = ^{
        @strongify(self);
        if (!self.area) {
            [UIView makeToast:@"请先选择地区"];
            return;
        }
        TeamPickerView *picker = [[TeamPickerView alloc]init];
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < self.streetArray.count; i++) {
            BSDivision *model = self.streetArray[i];
            [array insertObject:model.divisionName atIndex:array.count];
        }
        if (array.count < 1) {
            [UIView makeToast:@"街道信息有误"];
            return;
        }
        [picker setItems:array title:nil defaultStr:nil];
        picker.selectedIndex = ^(NSInteger index) {
            @strongify(self);
            BSDivision *model = self.streetArray[index];
            self.streetTF.text = model.divisionName;
            self.authRequest.areaCode = model.divisionCode;
            self.authRequest.areaId = model.divisionId;
        };
        [picker show];
    };
    
    [self.loginBtn setCornerRadius:self.loginBtn.height/2];
    
    //对srcollView添加点击响应
    UITapGestureRecognizer *sigleTapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
    sigleTapRecognizer.numberOfTapsRequired = 1;
    [self.scrollView addGestureRecognizer:sigleTapRecognizer];
    
    [self initData];
}
- (void)initData
{
    BSDivisionRequest *divisionRequest = [[BSDivisionRequest alloc]init];
    divisionRequest.divisionCode = @"51";
    BSDivisionCodeRequest *divisionCodeRequest = [[BSDivisionCodeRequest alloc]init];
    divisionCodeRequest.divisionCode = @"51";
    
    [MBProgressHUD showHud];
    @weakify(self);
    YTKBatchRequest *batchRequest = [[YTKBatchRequest alloc] initWithRequestArray:@[divisionRequest, divisionCodeRequest]];
    [batchRequest startWithCompletionBlockWithSuccess:^(YTKBatchRequest *batchRequest) {
        [MBProgressHUD hideHud];
        @strongify(self);
        NSArray *requests = batchRequest.requestArray;
        BSDivisionRequest *aRequest = (BSDivisionRequest *)requests[0];
        BSDivisionCodeRequest *bRequest = (BSDivisionCodeRequest *)requests[1];
        BSDivision *province = [[BSDivision alloc]init];
        province.divisionName = @"四川";
        province.divisionCode = @"51";
        province.divisionId = aRequest.divisionId;
        province.children = bRequest.divisionList;
        self.divisionArray = [NSArray arrayWithObject:province];
        
    } failure:^(YTKBatchRequest *batchRequest) {
        [MBProgressHUD hideHud];
        [UIView makeToast:@"获取区划信息失败"];
    }];
}
- (void)getStreetData
{
    BSDivisionIdRequest *divisionIdRequest = [[BSDivisionIdRequest alloc]init];
    divisionIdRequest.divisionId = self.area.divisionId;
    [MBProgressHUD showHud];
    @weakify(self);
    [divisionIdRequest startWithCompletionBlockWithSuccess:^(__kindof BSDivisionIdRequest * _Nonnull request) {
        [MBProgressHUD hideHud];
        @strongify(self);
        self.streetArray = request.divisionList;
        
    } failure:^(__kindof BSDivisionIdRequest * _Nonnull request) {
        [MBProgressHUD hideHud];
        [UIView makeToast:request.msg];
    }];
}
- (void)getRealNameInfodData{
    self.phoneTF.text = [BSClientManager sharedInstance].lastUsername;
    self.nameTF.text = [BSAppManager sharedInstance].currentUser.realnameInfo.realName;
    self.idCardTF.text = [BSAppManager sharedInstance].currentUser.realnameInfo.documentNo;
}
#pragma mark -----  click

- (IBAction)loginBtnPressed:(UIButton *)sender {
    
    for (UIView *view in self.contentView.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField *)view;
            if (textField.text.length < 1) {
                [UIView makeToast:@"请完善个人信息"];
                return;
            }
        }
    }
    if (![self.idCardTF.text isIdCard]) {
        [UIView makeToast:@"请填写正确的身份证号"];
        return;
    }
    if ([self.idCardTF.text containsString:@"x"]) {
        self.idCardTF.text = [self.idCardTF.text replaceWithKeyWord:@"x" replace:@"X"];
    }
    self.authRequest.realName = self.nameTF.text;
    self.authRequest.userId = [BSAppManager sharedInstance].currentUser.userId;
    self.authRequest.documentNo = self.idCardTF.text;
    
    BSUser *user = [BSAppManager sharedInstance].currentUser;
    
    [MBProgressHUD showHud];
    @weakify(self);
    [self.authRequest startWithCompletionBlockWithSuccess:^(__kindof BSRealnameAuthRequest * _Nonnull request) {
        [MBProgressHUD hideHud];
        @strongify(self);
        [(BSNavigationController *)self.navigationController back];
        if (request.resultStatus == FamilyDoctorSignTypeVerified ||
            request.resultStatus == FamilyDoctorSignTypeSubmitted) {
            if (self.authCompleteBlock) {
                self.authCompleteBlock(YES);
            }
        }
        else
        {
            if (self.authCompleteBlock) {
                self.authCompleteBlock(NO);
            }
        }
        [BSAppManager sharedInstance].currentUser.isChooseAD = @"2";//已完善区划信息
        [self registerHealtyCard];//申请健康卡
    } failure:^(__kindof BSRealnameAuthRequest * _Nonnull request) {
        NSLog(@"%ld",(long)request.code);
        [MBProgressHUD hideHud];
        [UIView makeToast:request.msg];
    }];
}
-(void)handleTapGesture:( UITapGestureRecognizer *)tapRecognizer
{
    [self.view endEditing:YES];
}
- (void)rightBtnPressed:(UIButton *)sender
{
    [(BSNavigationController *)self.navigationController back];
    if (self.authCompleteBlock) {
        self.authCompleteBlock(NO);
    }
}

#pragma mark - 申请健康卡
- (void)registerHealtyCard{
    BSRegisterHealthCard *registerHealthCard = [[BSRegisterHealthCard alloc] init];
    [registerHealthCard startWithCompletionBlockWithSuccess:^(__kindof BSRegisterHealthCard * _Nonnull request) {
        NSLog(@"请求成功%@",request.ret);
    } failure:^(__kindof BSRegisterHealthCard * _Nonnull request) {
        NSLog(@"请求失败 %@",request.error);
    }];
}

- (void)textFieldDidChange:(NSNotification *)textFieldNotification
{
    UITextField *textField = textFieldNotification.object;
    //身份证位数限制
    if (textField == self.idCardTF) {
        if (textField.text.length > 18) {
            textField.text = [textField.text substringToIndex:18];
        }
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                  name:@"UITextFieldTextDidChangeNotification"
                                                object:_idCardTF];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:GetRealnameAuthenticateInfoSuccessNotification object:nil];
}
@end

