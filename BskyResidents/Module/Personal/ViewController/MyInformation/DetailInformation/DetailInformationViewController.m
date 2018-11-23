//
//  DetailInformationViewController.m
//  BskyResidents
//
//  Created by 罗林轩 on 2017/10/18.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "DetailInformationViewController.h"
#import "DetailInformationWithStringModel.h"
#import "DetailInformationWithHeadImageModel.h"
#import "DetailInformationWithLabelModel.h"
#import "DetailInfomationCell.h"
#import "DetailInformationPickerView.h"
#import "UIImageView+WebCache.h"
#import "BSAddressModel.h"  // 保存数据
#import "GFAddressPicker.h"
#import "TeamPickerView.h"
#import "BSChangePersonInformationRequest.h"
#import "BSChangeUserHead.h"
#import "MyInfomationNotifier.h"
@interface DetailInformationViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *datas;
@property (strong, nonatomic) UIPickerView *pickView;
@property(nonatomic,strong)UIActionSheet *actionSheet;
@property (nonatomic ,strong) BSDivision *area;
@property (nonatomic ,copy) NSArray *divisionArray;
@property (nonatomic ,copy) NSArray *streetArray;
@property (nonatomic ,strong) BSAddressModel *upModel;
@property (strong, nonatomic) BSUser *user;
@property (assign, nonatomic) BOOL changeArea;//修改了地区

@end

@implementation DetailInformationViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self setData];
    self.title = @"基本信息";
}

#pragma mark - 设置数据
- (void)setData{
    _datas = [NSMutableArray array];
    //获取地址
    [self selectedAdressData];
    
    //头像
    DetailInformationWithHeadImageModel *imageModel = [[DetailInformationWithHeadImageModel alloc] init];
    imageModel.title = @"头像";
    imageModel.canEdit = YES;
    imageModel.cellH = 80;
//    UIImage * result;
//    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:_user.realnameInfo.photourl]];
//    result = [UIImage imageWithData:data];
//    imageModel.head = result;
    [_datas addObject:imageModel];
    
    //真实姓名
    DetailInformationWithStringModel *realNameModel = [[DetailInformationWithStringModel alloc] init];
    realNameModel.title = @"真实姓名";
    realNameModel.content = self.user.realnameInfo.realName;
    [_datas addObject:realNameModel];
    
    //身份证号
    DetailInformationWithStringModel *IDCardModel = [[DetailInformationWithStringModel alloc] init];
    IDCardModel.title = @"身份证号";
    IDCardModel.content = _user.realnameInfo.documentNo.length > 15 ? [_user.realnameInfo.documentNo stringByReplacingCharactersInRange:NSMakeRange(3, 11) withString:@"**********"] : _user.realnameInfo.documentNo;
    IDCardModel.isNeedImg =  [_user.realnameInfo.verifStatus isEqualToString:@"01006003"] ? YES : NO;
    [_datas addObject:IDCardModel];
    
    //手机号
    DetailInformationWithStringModel *phoneModel = [[DetailInformationWithStringModel alloc] init];
    phoneModel.title = @"手机号";
    phoneModel.content =  [_user.realnameInfo.mobileNo stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    [_datas addObject:phoneModel];
    
    //性别;
    DetailInformationWithStringModel *sexModel = [[DetailInformationWithStringModel alloc] init];
    sexModel.title = @"性别";
    sexModel.content = [_user.realnameInfo.sex integerValue] == 1 ? @"男" : @"女";
    [_datas addObject:sexModel];
    
    //生日
    DetailInformationWithStringModel *birthdayModel = [[DetailInformationWithStringModel alloc] init];
    birthdayModel.title = @"出生年月";
    birthdayModel.content = _user.realnameInfo.birthday;
    [_datas addObject:birthdayModel];
    
    //身高
    DetailInformationWithStringModel *heightModel = [[DetailInformationWithStringModel alloc] init];
    heightModel.title = @"身高(cm)";
    heightModel.content = (_user.realnameInfo.height.length == 0 || [_user.realnameInfo.height isEqualToString:@"0"]) ? @"请填写身高" : _user.realnameInfo.height;
    heightModel.defaultContent = @"请填写身高";
    heightModel.canEdit = YES;
    heightModel.keyboardType = UIKeyboardTypeNumberPad;
    heightModel.showArrow = YES;
    [_datas addObject:heightModel];
    
    //体重
    DetailInformationWithStringModel *weightModel = [[DetailInformationWithStringModel alloc] init];
    weightModel.title = @"体重(kg)";
    weightModel.content  = (_user.realnameInfo.weight.length == 0 || [_user.realnameInfo.weight isEqualToString:@"0.0"]) ? @"请填写体重" : _user.realnameInfo.weight;
    weightModel.defaultContent = @"请填写体重";
    weightModel.canEdit = YES;
    weightModel.keyboardType = UIKeyboardTypeDecimalPad;
    weightModel.showArrow = YES;
    [_datas addObject:weightModel];
    
    //标签
    DetailInformationWithLabelModel *labelModel = [[DetailInformationWithLabelModel alloc] init];
    labelModel.title = @"我的标签";
   
    NSArray *labelArray = [_user.tag componentsSeparatedByString:@","];
    if (labelArray.count == 1) {
        NSString *str = [labelArray firstObject];
        if (str.length == 0)labelArray = nil;
    }
    labelModel.labels = labelArray;
    [_datas addObject:labelModel];
    
    //省市区
    DetailInformationWithStringModel *areaModel = [[DetailInformationWithStringModel alloc] init];
    areaModel.title = @"省市区";
    areaModel.content = [NSString stringWithFormat:@"%@%@%@",_user.realnameInfo.provinceName,_user.realnameInfo.cityName,_user.realnameInfo.properName];
    areaModel.showArrow = YES;
    [_datas addObject:areaModel];
    
    //街道
    DetailInformationWithStringModel *streetModel = [[DetailInformationWithStringModel alloc] init];
    streetModel.title = @"乡镇、街道";
    streetModel.showArrow = YES;
    streetModel.content = _user.realnameInfo.areaName;
    [_datas addObject:streetModel];
    
    //详细地址
    DetailInformationWithStringModel *detailModel = [[DetailInformationWithStringModel alloc] init];
    detailModel.title  = @"详细地址";
    detailModel.canEdit = YES;
    detailModel.showArrow = YES;
    detailModel.content = _user.realnameInfo.detailAddress.length == 0 ? @"请输入详细地址" : _user.realnameInfo.detailAddress;
    detailModel.defaultContent = @"请输入详细地址";
    detailModel.keyboardType = UIKeyboardTypeDefault;
    [_datas addObject:detailModel];
    
    //保存按钮
    DetailInfomationModel *model = [[DetailInfomationModel alloc] init];
    model.cellH = 55;
    [_datas addObject:model];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailInfomationModel *model = _datas[indexPath.row];
    return model.cellH;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    DetailInformationPickerView *pickView;
    switch (indexPath.row) {
        case 0:
            //拍照或选择头像
            [self openActionSheetFunc];
            [self.view endEditing:YES];
            break;
        case 6 :{
//             pickView = [DetailInformationPickerView showWithState:PickerViewStateHeight];
//            [self.view addSubview:pickView];
//            [self.view endEditing:YES];
        }
            break;
        case 7:{
//            pickView = [DetailInformationPickerView showWithState:PickerViewStateWeight];
//            [self.view addSubview:pickView];
//            [self.view endEditing:YES];
        }
            break;
        case 9:{
            //选择省市区
            [self showSheet];
            [self.view endEditing:YES];
        }
            break;
        case 10:{
            //选择街道信息
            [self showStreet];
            [self.view endEditing:YES];
        }
            break;
        case 12:{
            //保存信息
            [self saveInfomation];
            [self.view endEditing:YES];
        }
        default:
            break;
    }
    if (pickView != nil) {
        pickView.selectedBlock = ^(NSArray *data) {
            NSMutableString *string = [NSMutableString string];
            for (NSString *str in data) {
                [string appendString:str];
            }
            DetailInfomationModel *model = _datas[indexPath.row];
            model.content  = string;
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        };
    }
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailInfomationCell *cell = [DetailInfomationCell showWithModel:_datas[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datas.count;
}

#pragma mark - 选取头像
//调用ActionSheet
- (void)openActionSheetFunc
{
    //判断设备是否有具有摄像头(相机)功能
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        _actionSheet = [[UIActionSheet alloc]initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    }
    else
    {
        _actionSheet = [[UIActionSheet alloc]initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil];
    }
    _actionSheet.tag = 100;
    //显示提示栏
    [_actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 100)
    {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            switch (buttonIndex)
            {
                case 0:
                    //来源:相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:
                    //来源:相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                case 2:
                    return;
            }
        }
        else
        {
            if (buttonIndex == 2)
            {
                return;
            }
            else
            {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        //跳转到相机或者相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.allowsEditing  = YES;
        imagePickerController.sourceType = sourceType;
        imagePickerController.delegate = self;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}

//pickerController的代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    DetailInformationWithHeadImageModel *headModel = _datas[0];
    headModel.head = image;
    [self saveHeadImage];
    [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - 选择地址
- (void)selectedAdressData{
    self.upModel = [BSAddressModel mj_objectWithKeyValues:[self.user.realnameInfo mj_keyValues]];
    self.upModel.isAutoAddr = @"1";
    self.area = [[BSDivision alloc]init];
    self.area.divisionId = self.upModel.properId;
    self.area.divisionFullName =  [NSString stringWithFormat:@"%@ %@ %@",self.upModel.provinceName,self.upModel.cityName,self.upModel.properName];
    [self getStreetData];
}

- (void)getStreetData{
    BSDivisionIdRequest *divisionIdRequest = [[BSDivisionIdRequest alloc]init];
    divisionIdRequest.divisionId = self.area.divisionId;
    [MBProgressHUD showHud];
    @weakify(self);
    [divisionIdRequest startWithCompletionBlockWithSuccess:^(__kindof BSDivisionIdRequest * _Nonnull request) {
        [MBProgressHUD hideHud];
        @strongify(self);
        self.streetArray = request.divisionList;
        if (_changeArea == YES && self.streetArray.count > 0) {
            //如果修改了地区,同步刷新街道
            BSDivision *street = self.streetArray[0];
            self.upModel.areaId = street.divisionId;
            self.upModel.areaName = street.divisionName;
            self.upModel.areaCode = street.divisionCode;
            DetailInformationWithStringModel *streetModel = _datas[10];
            streetModel.content = street.divisionName;
            [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:10 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }
        [self initData];
    } failure:^(__kindof BSDivisionIdRequest * _Nonnull request) {
        [MBProgressHUD hideHud];
        [UIView makeToast:request.msg];
    }];
}

- (void)initData{
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

- (void)showSheet{
    if (self.divisionArray.count < 1) {
        [UIView makeToast:@"正在获取区划信息"];
        return;
    }
    GFAddressPicker *picker = [[GFAddressPicker alloc]initWithDataArray:self.divisionArray];
    picker.font = [UIFont systemFontOfSize:18];
    [picker updateArea:self.area];
    __weak typeof(self) weak_self = self;
    picker.selected = ^(BSDivision *province,BSDivision *city, BSDivision *area){
        if (!weak_self.area || ![weak_self.area.divisionFullName isEqualToString:area.divisionFullName]){
            weak_self.area = area;
            
            weak_self.upModel.areaId = nil;
            weak_self.upModel.areaName = nil;
            
            weak_self.upModel.provinceId = province.divisionId;
            weak_self.upModel.provinceName = province.divisionName;
            
            weak_self.upModel.cityId = city.divisionId;
            weak_self.upModel.cityName = city.divisionName;
            
            weak_self.upModel.properId = area.divisionId;
            weak_self.upModel.properName = area.divisionName;
            [weak_self getStreetData];
            _changeArea = YES;//修改了地区
            DetailInformationWithStringModel *areaModel = _datas[9];
             areaModel.content = [NSString stringWithFormat:@"%@%@%@",province.divisionName,city.divisionName,area.divisionName];
            [weak_self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:9 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }
    };
            [picker show];
}

- (void)showStreet{
    if (!self.upModel.provinceId || self.upModel.provinceId.length < 1) {
        [UIView makeToast:@"请先选择地区"];
        return;
    }
    if (self.streetArray.count < 1) {
        [UIView makeToast:@"正在获取街道信息"];
        return;
    }
    TeamPickerView *picker = [[TeamPickerView alloc]init];
    NSMutableArray *array = [NSMutableArray array];
    for (BSDivision *model in self.streetArray) {
        [array addObject:model.divisionName];
    }
    [picker setItems:array title:nil defaultStr:self.upModel.areaName];
    __weak typeof(self) weak_self = self;
    picker.selectedIndex = ^(NSInteger index) {
        BSDivision *street = self.streetArray[index];
        self.upModel.areaId = street.divisionId;
        self.upModel.areaName = street.divisionName;
        self.upModel.areaCode = street.divisionCode;
        DetailInformationWithStringModel *areaModel = _datas[10];
        areaModel.content = street.divisionName;
        [weak_self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:10 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    };
    [picker show];
}

#pragma mark - 保存信息
- (void)saveInfomation{
//    areaCode (string, optional): 区划编码（乡、镇、街道、办事处一级） ,
//    areaId (string, optional): 乡、镇、街道、办事处一级Id ,
//    cityId (string, optional): 市州ID ,
//    detailAddress (string, optional): 详细地址 ,
//    height (string, optional): 身高 ,
//    phone (string, optional): 居民电话号码 ,
//    photo (file, optional): 头像 ,
//    properId (string, optional): 区县ID ,
//    provinceId (string, optional): 省份ID ,
//    residentId (string, optional): 居民ID ,
//    signingLabel (string, optional): 签约标签 ,
//    userId (string, optional): 用户ID ,
//    weight (string, optional): 体重
//    _user.realnameInfo.areaId = _upModel.areaId;
//    _user.realnameInfo.cityId = _upModel.cityId;
//    _user.realnameInfo.provinceId = _upModel.provinceId;
//    _user.realnameInfo.properId = _upModel.properId;
//    _user.realnameInfo.areaCode = _upModel.areaCode;
    
    //身高
    DetailInfomationModel *heightModel = _datas[6];
//    if ([heightModel.content isEqualToString:@"请填写身高"]) {
//        [UIView makeToast:@"请填写身高"];
//        return;
//    }
    _user.realnameInfo.height = [heightModel.content isEqualToString:@"请填写身高"] ? @"" : heightModel.content;
    
    //体重
    DetailInfomationModel *weightModel = _datas[7];
//    if ([weightModel.content isEqualToString:@"请填写体重"]) {
//        [UIView makeToast:@"请填写体重"];
//        return;
//    }
    _user.realnameInfo.weight = [weightModel.content isEqualToString:@"请填写体重"] ? @"" : weightModel.content;
    
    //详细地址
    DetailInfomationModel *adressModel = _datas[11];
    _user.realnameInfo.detailAddress = [adressModel.content isEqualToString:@"请输入详细地址"] ? @"" : adressModel.content;
//    if ([adressModel.content isEqualToString:@"请输入详细地址"]) {
//        [UIView makeToast:@"请输入详细地址"];
//        return;
//    }
    
    BSChangePersonInformationRequest *updateRequest = [[BSChangePersonInformationRequest alloc]init];
    updateRequest.areaCode = _upModel.areaCode;
    updateRequest.areaId = _upModel.areaId;
    updateRequest.cityId = _upModel.cityId;
    updateRequest.detailAddress = _user.realnameInfo.detailAddress;
    updateRequest.height = _user.realnameInfo.height;
    updateRequest.weight = _user.realnameInfo.weight;
    updateRequest.phone = _user.realnameInfo.mobileNo;
    updateRequest.properId =  _upModel.properId;
    updateRequest.provinceId = _upModel.provinceId;
    updateRequest.signingLabel = _user.realnameInfo.signingLabel;
    updateRequest.userId = _user.realnameInfo.userId;
    updateRequest.residentId  = _user.realnameInfo.residentId;
    [MBProgressHUD showHud];
    
    [updateRequest startWithCompletionBlockWithSuccess:^(__kindof BSChangePersonInformationRequest * _Nonnull request) {
        [UIView makeToast:@"已修改个人信息"];
        [self refreshUserInfo];
        [MBProgressHUD hideHud];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(__kindof BSChangePersonInformationRequest * _Nonnull request) {
        [MBProgressHUD hideHud];
        NSError *error = request.error;
        [UIView makeToast:request.msg];
    }];
}

#pragma mark - 保存头像
- (void)saveHeadImage{
    DetailInformationWithHeadImageModel *headModel = _datas[0];
    //修改头像,并刷新用户信息
    if (headModel.head) {
        BSChangeUserHead *changeHead = [[BSChangeUserHead alloc] initWithImage:headModel.head];
        changeHead.phone = _user.realnameInfo.mobileNo;
        changeHead.userId = _user.realnameInfo.userId;
        [MBProgressHUD showHud];
        [changeHead startWithCompletionBlockWithSuccess:^(__kindof BSChangeUserHead * _Nonnull request){
            NSDictionary *dic = request.responseObject;
            [MBProgressHUD hideHud];
            [self refreshUserInfo];
        } failure:^(__kindof BSChangeUserHead * _Nonnull request) {
            [MBProgressHUD hideHud];
            [UIView makeToast:request.msg];
        }];
    }
}


#pragma mark - 刷新用户信息
- (void)refreshUserInfo{
    BSRealnameInfoRequest* request = [BSRealnameInfoRequest new];
    [request startWithCompletionBlockWithSuccess:^(__kindof BSRealnameInfoRequest * _Nonnull request) {
        [[NSNotificationCenter defaultCenter] postNotificationName:updateUserInfomation object:nil];
    } failure:^(__kindof BSRealnameInfoRequest * _Nonnull request) {
    }];
}


#pragma mark - get
- (BSUser *)user{
    if (!_user) {
        _user =  [BSAppManager sharedInstance].currentUser;
    }
    return _user;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Bsky_SCREEN_WIDTH, Bsky_SCREEN_HEIGHT - Bsky_TOP_BAR_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        //        _tableView.bounces = NO;//回弹效果
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
@end
