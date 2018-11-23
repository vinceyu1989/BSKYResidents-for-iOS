//
//  LoginViewController.m
//  BskyResidents
//
//  Created by 何雷 on 2017/9/26.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginTextField.h"
#import "RegisterViewController.h"
#import "AuthenticateViewController.h"
#import "BSNavigationController.h"
#import "AppDelegate.h"
#import "ToAgreementH5Request.h"

@interface LoginViewController ()
{
    int _timerNum;
}

@property (weak, nonatomic) IBOutlet LoginTextField *phoneTF;
@property (weak, nonatomic) IBOutlet LoginTextField *codeTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *protocolBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@property (nonatomic ,strong) UIImageView *phoneIcon;
@property (nonatomic ,strong) UIImageView *codeIcon;
@property (nonatomic ,strong) UIButton *codeBtn;    // 获取验证码
@property (nonatomic ,assign) NSUInteger failedTimes; //登录失败次数
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)initView
{
    self.phoneTF.maxNum = 11;
    self.phoneTF.keyboardType = UIKeyboardTypePhonePad;
    self.phoneTF.leftView = self.phoneIcon;
    self.phoneTF.leftViewMode = UITextFieldViewModeAlways;
    self.phoneTF.text = [BSClientManager sharedInstance].lastUsername;
    
    self.codeTF.maxNum = 6;
    self.codeTF.keyboardType = UIKeyboardTypeNumberPad;
    self.codeTF.leftView = self.codeIcon;
    self.codeTF.leftViewMode = UITextFieldViewModeAlways;
    self.codeTF.rightView = self.codeBtn;
    self.codeTF.rightViewMode =UITextFieldViewModeAlways;
    
    [self.loginBtn setCornerRadius:self.loginBtn.height/2];
    //创建NSMutableAttributedString
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:self.protocolBtn.titleLabel.text];
    //添加文字颜色
    [attrStr addAttribute:NSForegroundColorAttributeName value:Bsky_UIColorFromRGB(0x4e7dd3) range:NSMakeRange(8, 10)];
    [self.protocolBtn setAttributedTitle:attrStr forState:UIControlStateNormal];
    
    self.registerBtn.hidden = YES;
}

#pragma mark --- Setter  Getter

- (UIImageView *)phoneIcon
{
    if (!_phoneIcon) {
        _phoneIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"phone_icon"]];
        [_phoneIcon sizeToFit];
    }
    return _phoneIcon;
}
- (UIImageView *)codeIcon
{
    if (!_codeIcon) {
        _codeIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"password_icon"]];
        [_codeIcon sizeToFit];
    }
    return _codeIcon;
}
- (UIButton *)codeBtn
{
    if (!_codeBtn) {
        _codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _codeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_codeBtn setTitleColor:Bsky_UIColorFromRGB(0x4e7dd3) forState:UIControlStateNormal];
        [_codeBtn addTarget:self action:@selector(codeBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_codeBtn sizeToFit];
    }
    return _codeBtn;
}
#pragma mark -----  click

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (void)codeBtnPressed:(UIButton *)sender
{
    if (self.phoneTF.text.length < 1 || ![self.phoneTF.text isPhoneNumber]) {
        [UIView makeToast:@"请输入正确手机号码"];
        return;
    }
    // 获取验证码
    BSCmsCodeRequest *cmsRequest = [[BSCmsCodeRequest alloc]init];
    cmsRequest.phone = self.phoneTF.text;
    
    [MBProgressHUD showHud];
    @weakify(self);
    [cmsRequest startWithCompletionBlockWithSuccess:^(__kindof BSCmsCodeRequest * _Nonnull request) {
        [MBProgressHUD hideHud];
        @strongify(self);
        [self startTimer];
        [UIView makeToast:request.msg];
   } failure:^(__kindof BSCmsCodeRequest * _Nonnull request) {
        [MBProgressHUD hideHud];
        [UIView makeToast:request.msg];
    }];
}
- (IBAction)registerBtnPressed:(UIButton *)sender {
    
    RegisterViewController *vc = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)protocolBtnPressed:(UIButton *)sender {
    ToAgreementH5Request *requet = [[ToAgreementH5Request alloc] init];
    [MBProgressHUD showHud];
    Bsky_WeakSelf
    [requet startWithCompletionBlockWithSuccess:^(__kindof ToH5Request * _Nonnull request) {
        [MBProgressHUD hideHud];
        Bsky_StrongSelf
        BSWebViewController *webVC = [[BSWebViewController alloc]init];
        webVC.showNavigationBar = YES;
        webVC.title = @"用户协议";
        webVC.ba_web_progressTintColor = Bsky_UIColorFromRGBA(0x599dff,1);
        webVC.ba_web_progressTrackTintColor = [UIColor whiteColor];
        [webVC ba_web_loadURLString:requet.urlString];
        [self.navigationController pushViewController:webVC animated:YES];

    } failure:^(__kindof ToH5Request * _Nonnull request) {
        [MBProgressHUD hideHud];
        [UIView makeToast:requet.msg];
    }];
    
}
- (IBAction)loginBtnPressed:(UIButton *)sender {
    
    if (self.phoneTF.text.length < 1 || ![self.phoneTF.text isPhoneNumber]) {
        [UIView makeToast:@"请输入正确手机号码"];
        return;
    }
    if (self.codeTF.text.length != 6 || ![self.codeTF.text isNumText]) {
        [UIView makeToast:@"请输入正确验证码"];
        return;
    }
    NSNumber *number = [NSNumber numberWithInt:(int)[[NSDate date] timeIntervalSince1970]];
    NSNumber *time = [[NSUserDefaults standardUserDefaults] objectForKey:LoginFailedTime];
    NSInteger loss = number.integerValue - time.integerValue;
    NSInteger total = 300;
    if (loss < 300) {
        [UIView makeToast:[NSString stringWithFormat:@"验证码错误次数过多，请%ld秒后再试！",300 - loss]];
        return;
    }else{
        if (self.failedTimes >= 3) {
            self.failedTimes = 0;
        }
    }
    [MBProgressHUD showHud];
    BSCmsLoginRequest* request = [BSCmsLoginRequest new];
    request.phone = self.phoneTF.text;
    request.cmsCode = self.codeTF.text;
    @weakify(self);
    [request startWithCompletionBlockWithSuccess:^(__kindof BSCmsLoginRequest * _Nonnull request) {
        [MBProgressHUD hideHud];
//        @strongify(self);
        if ([BSAppManager sharedInstance].currentUser.verifStatus.integerValue == RealInfoVerifStatusTypeSuccess) {
            
            BSRealnameInfoRequest* request = [[BSRealnameInfoRequest alloc]init];
            [request startWithCompletionBlockWithSuccess:^(__kindof BSRealnameInfoRequest * _Nonnull request) {
                Bsky_StrongSelf
                [self pushToTabBar];
                self.failedTimes = 0;
            } failure:^(__kindof BSRealnameInfoRequest * _Nonnull request) {
                [UIView makeToast:request.msg];
                Bsky_StrongSelf
                [self pushToTabBar];
                self.failedTimes = 0;
            }];
            
            
        }else{
            Bsky_StrongSelf
            [self pushToTabBar];
            self.failedTimes = 0;
        }
        
        
    } failure:^(__kindof BSCmsLoginRequest * _Nonnull request) {
        @strongify(self);
        if (self.failedTimes >= 2) {
            NSNumber *number = [NSNumber numberWithInt:(int)[[NSDate date] timeIntervalSince1970]] ;
            [[NSUserDefaults standardUserDefaults] setObject:number forKey:LoginFailedTime];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }else{
            self.failedTimes ++;
        }
        
        [MBProgressHUD hideHud];
        [UIView makeToast:request.msg];
    }];
}
- (void)pushToTabBar{
    BSUser *user = [BSAppManager sharedInstance].currentUser;
    if ([[BSAppManager sharedInstance].currentUser.verifStatus integerValue] != RealInfoVerifStatusTypeSuccess || [[BSAppManager sharedInstance].currentUser.isChooseAD integerValue] == 1) {
        [self realnameAuthenticate];
    }
    else
    {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        if (appDelegate.window.rootViewController == appDelegate.loginNav ) {
            appDelegate.window.rootViewController = appDelegate.tabBarVC;
            [self removeFromParentViewController];
            [appDelegate.loginNav removeFromParentViewController];
            appDelegate.loginNav = nil;
        }
        else
        {
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }
    }
}
- (void)realnameAuthenticate{
    AuthenticateViewController *viewController = [[AuthenticateViewController alloc]init];
    Bsky_WeakSelf;
    viewController.authCompleteBlock = ^(BOOL succeed) {
        Bsky_StrongSelf;
        if (succeed) {
            BSRealnameInfoRequest* request = [BSRealnameInfoRequest new];
            [request startWithCompletionBlockWithSuccess:^(__kindof BSRealnameInfoRequest * _Nonnull request) {
                
            } failure:^(__kindof BSRealnameInfoRequest * _Nonnull request) {
                [UIView makeToast:request.msg];
            }];
        }
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        if (appDelegate.window.rootViewController == appDelegate.loginNav ) {
            appDelegate.window.rootViewController = appDelegate.tabBarVC;
            [self removeFromParentViewController];
            [appDelegate.loginNav removeFromParentViewController];
            appDelegate.loginNav = nil;
        }
        else
        {
            [self.navigationController dismissViewControllerAnimated:NO completion:nil];
        }
    };
    BSNavigationController *nav = [[BSNavigationController alloc] initWithRootViewController:viewController];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

#pragma mark  ----- timer

///启动定时器
-(void)startTimer
{
    self.codeBtn.enabled = NO;
    _timerNum = 60;
    NSString * strTitle = [NSString stringWithFormat:@"%.ds", _timerNum];
    [self.codeBtn setTitle:strTitle forState:UIControlStateNormal];
    [self.codeBtn sizeToFit];
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(funcTimer:) userInfo:nil repeats:YES];
}

-(void)funcTimer:(NSTimer *)timer
{
    _timerNum--;
    NSString * strTitle = [NSString stringWithFormat:@"%.ds", _timerNum];
    [self.codeBtn setTitle:strTitle forState:UIControlStateNormal];
    if(_timerNum == 0)
    {
        [timer invalidate];
        [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.codeBtn.enabled = YES;
    }
    [self.codeBtn sizeToFit];
}

@end
