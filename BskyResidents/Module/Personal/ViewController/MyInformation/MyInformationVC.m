//
//  MyInformationVC.m
//  BskyResidents
//
//  Created by 罗林轩 on 2017/10/9.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "MyInformationVC.h"
#import "MyInfomationCell.h"
#import "BlankTableViewCell.h"
#import "MyInfomationHeader.h"
#import "MyInfomationNotifier.h"
#import "DetailInformationViewController.h"
#import "HealthCardViewController.h"
#import "QRCodeViewController.h"
#import "LoginViewController.h"
#import "AddressListVC.h"
#import "SettingViewController.h"
#import "AuthenticateViewController.h"
#import <UShareUI/UShareUI.h>
#import "RegisterHealthCard.h"
#import "BSGetHealthCardInfo.h"
#import "QRModel.h"
#import "HealthCardQRCodeVC.h"
static NSString *const cellIndentifier = @"myInfomationCell";
static NSString *const headerIndentifier = @"myInfomationHeader";

@interface MyInformationVC ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *names;//项目名
@property (strong, nonatomic) NSArray *icons;//图标名
@property (assign, nonatomic) BOOL updateHead;//是否更新头像

@end

@implementation MyInformationVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.updateHead = YES;
    [self.tableView reloadData];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
#warning 审核未使用功能
//    _names = @[@"我的订单",@"呼医咨询",@"我的服务",@"我的处方",@"优惠券",@"地址管理",@"邀请码",@"设置"];
    _names = @[@"地址管理",@"邀请码",@"设置"];
//    _icons = @[@"myInformation_ico1",@"myInformation_ico2",@"myInformation_ico3",@"myInformation_ico4",@"myInformation_ico5",@"myInformation_ico6",@"myInformation_ico7",@"myInformation_ico8"];
    _icons = @[@"myInformation_ico6",@"myInformation_ico7",@"myInformation_ico8"];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clickBtn:) name:clickBtnNotifier object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateUserInfomation) name:updateUserInfomation object:nil];
    [self initSubView];
}

- (void)initSubView{
    self.view.backgroundColor = Bsky_UIColorFromRGB(0xf7f7f7);
    [self.view addSubview:self.tableView];
}

#pragma mark - get
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -Bsky_STATUS_BAR_HEIGHT, CGRectGetWidth(self.view.frame), Bsky_SCREEN_HEIGHT-Bsky_TAB_BAR_HEIGHT+20) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = Bsky_UIColorFromRGB(0xf7f7f7);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MyInfomationCell class]) bundle:nil] forCellReuseIdentifier:cellIndentifier];
        [_tableView registerClass:[BlankTableViewCell class] forCellReuseIdentifier:[BlankTableViewCell cellIdentifier]];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MyInfomationHeader class]) bundle:nil] forHeaderFooterViewReuseIdentifier:headerIndentifier];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        BlankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BlankTableViewCell cellIdentifier]];
        return cell;
    }
    MyInfomationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    [cell setWithName:_names[indexPath.row-1] icon:_icons[indexPath.row-1]];
    if (indexPath.row != 1) {
        cell.topLine.hidden = YES;
    }
    if (indexPath.row == _names.count) {
        [cell.bottomLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.mas_left);
        }];
    }
    return cell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MyInfomationHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIndentifier];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushDetailInfoVC)];
    [header addGestureRecognizer:tap];
    header.userInteractionEnabled = YES;
    if (_updateHead == YES) {
        [header update];
        _updateHead = NO;
    }
    return header;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _names.count+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 10;
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 200;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
#warning 审核未使用功能
    switch (indexPath.row-1) {
//        case 0://我的订单
//        {
//            [UIView makeToast:@"该功能暂未开放"];
////            LoginViewController *vc = [[LoginViewController alloc] init];
////            [self.navigationController pushViewController:vc animated:YES];
//        }
//            break;
//        case 1://呼医咨询
//            [UIView makeToast:@"该功能暂未开放"];
//            break;
//        case 2://我的服务
//            [UIView makeToast:@"该功能暂未开放"];
//            break;
//        case 3://我的处方
//            [UIView makeToast:@"该功能暂未开放"];
//            break;
//        case 4://优惠券
//            [UIView makeToast:@"该功能暂未开放"];
//            break;
        case 0://地址管理
        {
            AddressListVC *vc = [[AddressListVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1://邀请码
//            显示分享面板
        {
//            NSArray *platformTypeArray = [[UMSocialManager defaultManager] platformTypeArray];
            [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_Qzone),@(UMSocialPlatformType_QQ)]];
            [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
                // 根据获取的platformType确定所选平台进行下一步操作
                [self shareWebPageToPlatformType:platformType];
            }];
        }
            break;
        case 2://设置
        {
            SettingViewController *vc = [[SettingViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - 分享
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    NSString* thumbURL =  @"http://hos.bsky.jksczy.cn/bsky3/H5link/user_link.html";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"巴蜀快医用户端" descr:@"欢迎使用巴蜀快医用户端！" thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = @"http://hos.bsky.jksczy.cn/bsky3/H5link/user_link.html";
    shareObject.thumbImage = [UIImage imageNamed:@"icon-60"];
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
//        [UIView makeToast:error];
    }];
}

#pragma mark - push到详细信息
- (void)pushDetailInfoVC{
    
    // 未实名认证或者未完善区划
    if ([BSAppManager sharedInstance].currentUser.realnameInfo.verifStatus.integerValue != RealInfoVerifStatusTypeSuccess || [[BSAppManager sharedInstance].currentUser.isChooseAD integerValue] != 2) {
        AuthenticateViewController *vc = [[AuthenticateViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        DetailInformationViewController *detailVC = [[DetailInformationViewController alloc] init];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

#pragma mark - header点击功能条跳转
- (void)clickBtn:(NSNotification *)notification{
    UIButton *btn = notification.object;
#warning 审核未使用功能
    switch (btn.tag) {
//        case 1000:  // 收藏
//            [UIView makeToast:@"该功能暂未开放"];
//            break;
//        case 1001:  // 关注
//            [UIView makeToast:@"该功能暂未开放"];
//            break;
//        case 1002:  // 家人
//            [UIView makeToast:@"该功能暂未开放"];
//            break;
        case 1000:{
            if([[BSAppManager sharedInstance].currentUser.realnameInfo.verifStatus isEqualToString:@"01006003"] == NO || [[BSAppManager sharedInstance].currentUser.isChooseAD integerValue] == 1){
                AuthenticateViewController *authenticate = [[AuthenticateViewController alloc]init];
                [self.navigationController pushViewController:authenticate animated:YES];
            }else{
                QRCodeViewController *QRCodeVC = [[QRCodeViewController alloc] init];
                QRCodeVC.title = @"我的二维码";
                [self.navigationController pushViewController:QRCodeVC animated:YES];
            }
        }
            break;
        case 1001:{
            if ([[BSAppManager sharedInstance].currentUser.realnameInfo.verifStatus isEqualToString:@"01006003"] == NO || [[BSAppManager sharedInstance].currentUser.isChooseAD integerValue] == 1) {
                AuthenticateViewController *authenticate = [[AuthenticateViewController alloc]init];
                [self.navigationController pushViewController:authenticate animated:YES];
            }else{
                [self getHealthCardInfo];//获取健康卡信息
            }
        }
            break;
        default:
            break;                                                
    }
}

#pragma mark - 请求健康卡信息
- (void)getHealthCardInfo{
    BSGetHealthCardInfo *healthCardInfo = [[BSGetHealthCardInfo alloc] init];
    [MBProgressHUD showHud];
    [healthCardInfo startWithCompletionBlockWithSuccess:^(__kindof BSGetHealthCardInfo * _Nonnull request) {
        [MBProgressHUD hideHud];
        if (request.code == 200) {
            NSDictionary *dic = request.ret;
            QRModel *model = [QRModel mj_objectWithKeyValues:dic];
            [model decryptCBCModel];
            HealthCardQRCodeVC *card = [[HealthCardQRCodeVC alloc] init];
            card.model = model;
            [self.navigationController pushViewController:card animated:YES];
        }else{
            [UIView makeToast:request.msg];
        }
    } failure:^(__kindof BSGetHealthCardInfo * _Nonnull request) {
        [MBProgressHUD hideHud];
        NSLog(@"%lu %@",request.code,request.msg);
        if (request.code == 401 || request.code == 404 || request.code == 406) {
            RegisterHealthCard *registerHealthCard = [[RegisterHealthCard alloc] init];
            [self.navigationController pushViewController:registerHealthCard animated:YES];
        }
        NSLog(@"请求失败 %ld",(long)request.code);
    }];
}

#pragma mark - 更新header
- (void)updateUserInfomation{
    _updateHead = YES;
    [_tableView reloadData];
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:clickBtnNotifier object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:updateUserInfomation object:nil];
}
@end
