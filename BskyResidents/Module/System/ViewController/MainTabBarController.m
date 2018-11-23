//
//  BaseTabBarController.m
//  BskyResidents
//
//  Created by 何雷 on 2017/10/10.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "MainTabBarController.h"
#import "MainTabBar.h"
#import "HomeViewController.h"
#import "BSNavigationController.h"
#import "MyInformationVC.h"
#import "HealthViewController.h"
#import "BSMessageViewController.h"
#import "BSGetHealthCardInfo.h"
#import "HealthCardViewController.h"
#import "AuthenticateViewController.h"
#import "LoginViewController.h"
#import "BSCannotCallViewController.h"
#import "BSAppVersionRequest.h"
#import "BSAppUpdateView.h"
#import "RegisterHealthCard.h"

@interface MainTabBarController ()<MainTabBarDelegate>

@property (nonatomic ,strong) HomeViewController *homeVC;

@end

@implementation MainTabBarController
- (instancetype)init
{
    self = [super init];
    if (self) {
        //暂时注释,将检查版本移到启动图界面
//       [self checkAppVersion];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建自己的tabbar，然后用kvc将自己的tabbar和系统的tabBar替换下
    MainTabBar *tabbar = [[MainTabBar alloc] initWithFrame:CGRectMake(0, 0, Bsky_SCREEN_WIDTH, Bsky_TAB_BAR_HEIGHT)];
    tabbar.myDelegate = self;
    //kvc实质是修改了系统的_tabBar
    [self setValue:tabbar forKeyPath:@"tabBar"];
    [self setup];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout) name:LogoutNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getRealnameInfo) name:RealnameAuthenticateSuccessNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setup
{
    self.homeVC = [[HomeViewController alloc]init];
    BSNavigationController *nav1 = [[BSNavigationController alloc] initWithRootViewController:self.homeVC];
    [self builderTabBarWithTitle:@"家医" selectImg:@"familyDoctors_tab_select" normalImg:@"familyDoctors_tab" vc:nav1];
    
    BSNavigationController *nav2 = [[BSNavigationController alloc] initWithRootViewController:[[HealthViewController alloc] init]];
    [self builderTabBarWithTitle:@"健康" selectImg:@"health_tab_select" normalImg:@"health_tab" vc:nav2];
    
    BSNavigationController *nav4 = [[BSNavigationController alloc] initWithRootViewController:[[BSMessageViewController alloc] init]];
    [self builderTabBarWithTitle:@"消息" selectImg:@"message_tab_select" normalImg:@"message_tab" vc:nav4];
    
    BSNavigationController *nav5 = [[BSNavigationController alloc] initWithRootViewController:[[MyInformationVC alloc] init]];
    [self builderTabBarWithTitle:@"我的" selectImg:@"mine_tab_select" normalImg:@"mine_tab" vc:nav5];
    
    self.viewControllers = [NSArray arrayWithObjects:nav1,nav2,nav4,nav5, nil];
}
-(void)builderTabBarWithTitle:(NSString *)title selectImg:(NSString *) selectImg normalImg:(NSString *) normalImg vc:(UINavigationController *)vc{
    NSDictionary *selectTitleDic = @{NSForegroundColorAttributeName:Bsky_UIColorFromRGB(0x4e7dd3),NSFontAttributeName:[UIFont systemFontOfSize:11.f]};
    NSDictionary *mormalTitleDic = @{NSForegroundColorAttributeName:Bsky_UIColorFromRGB(0x333333),NSFontAttributeName:[UIFont systemFontOfSize:11.f]};
    [vc.tabBarItem setTitle:title];
    vc.view.backgroundColor = [UIColor clearColor];
    [vc.tabBarItem setImageInsets:UIEdgeInsetsMake(0.f, 0.f, 0.f, 0.f)];
    [vc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0.f, 0.f)];
    [vc.tabBarItem setSelectedImage:[[UIImage imageNamed:selectImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [vc.tabBarItem setImage:[[UIImage imageNamed:normalImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [vc.tabBarItem setTitleTextAttributes:selectTitleDic forState:UIControlStateSelected];
    [vc.tabBarItem setTitleTextAttributes:mormalTitleDic forState:UIControlStateNormal];
    
}
#pragma mark ----- 通知处理

- (void)logout {
    self.selectedIndex = 0;
    [BSClientManager sharedInstance].tokenId = @"";
    [BSAppManager sharedInstance].currentUser = nil;
    
    Bsky_WeakSelf
    [[[NIMSDK sharedSDK] loginManager] logout:^(NSError * _Nullable error) {
        Bsky_StrongSelf
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        BSNavigationController *nav = [[BSNavigationController alloc]initWithRootViewController:loginVC];
        [self presentViewController:nav animated:YES completion:nil];
    }];
}
#pragma mark --- 获取实名认证信息
- (void)getRealnameInfo
{
    BSRealnameInfoRequest* request = [BSRealnameInfoRequest new];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof BSRealnameInfoRequest * _Nonnull request) {
        
    } failure:^(__kindof BSRealnameInfoRequest * _Nonnull request) {
        
    }];
}
#pragma mark --- 检查版本
//- (void)checkAppVersion {
//    Bsky_WeakSelf;
//    BSAppVersionRequest* request = [BSAppVersionRequest new];
//    
//    [request startWithCompletionBlockWithSuccess:^(__kindof BSAppVersionRequest * _Nonnull request) {
//        Bsky_StrongSelf;
//        NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
//        NSString *currentAppVersion = infoDic[@"CFBundleShortVersionString"];
//        NSString* versionNum = request.ret[@"versionNum"];
//        NSInteger mandatoryUpdate = [request.ret[@"mandatoryUpdate"] integerValue];
//        NSLog(@"%@",request.ret);
//        if (mandatoryUpdate != 9 && ![versionNum containsString:currentAppVersion]) {
//            NSString* versionDesc = request.ret[@"versionDesc"];
//            [BSAppUpdateView showInView:self.view animated:YES info:versionDesc mandatoryUpdate:mandatoryUpdate downloadUrl:request.ret[@"downloadUrl"]delegate:nil];
//        }
//    } failure:^(__kindof BSAppVersionRequest * _Nonnull request) {
//        
//    }];
//}


#pragma mark - LBTabBarDelegate
//点击中间按钮的代理方法
- (void)tabBarShowBtnClick:(MainTabBar *)tabBar
{
    NSInteger verifStatus = [BSAppManager sharedInstance].currentUser.realnameInfo.verifStatus.integerValue;
    if (verifStatus != RealInfoVerifStatusTypeSuccess)  // 未实名验证 ，跳转实名验证
    {
        BSNavigationController *nav = [[BSNavigationController alloc] initWithRootViewController:[[AuthenticateViewController alloc] init]];
        [self presentViewController:nav animated:YES completion:nil];
    }  else {
        BSGetHealthCardInfo *healthCardInfo = [[BSGetHealthCardInfo alloc] init];
        [MBProgressHUD showHud];
        Bsky_WeakSelf
        [healthCardInfo startWithCompletionBlockWithSuccess:^(__kindof BSGetHealthCardInfo * _Nonnull request) {
            Bsky_StrongSelf
            [MBProgressHUD hideHud];
            if (request.code == 200) {
                NSDictionary *dic = request.ret;
                HealthCardViewController *card_vc = [[HealthCardViewController alloc] init];
                QRModel *model = [QRModel mj_objectWithKeyValues:dic];
                [model decryptCBCModel];
                card_vc.model = model;
                BSNavigationController *nav = [[BSNavigationController alloc] initWithRootViewController:card_vc];
                [self presentViewController:nav animated:YES completion:nil];
            }else{
                RegisterHealthCard *registerHealthCard = [[RegisterHealthCard alloc] init];
                BSNavigationController *nav = [[BSNavigationController alloc] initWithRootViewController:registerHealthCard];
                [self presentViewController:nav animated:YES completion:nil];
            }
        } failure:^(__kindof BSGetHealthCardInfo * _Nonnull request) {
            [MBProgressHUD hideHud];
            Bsky_StrongSelf
            if (request.code == 401 || request.code == 404 || request.code == 406) {
                RegisterHealthCard *registerHealthCard = [[RegisterHealthCard alloc] init];
                BSNavigationController *nav = [[BSNavigationController alloc] initWithRootViewController:registerHealthCard];
                [self presentViewController:nav animated:YES completion:nil];
            }
            NSLog(@"请求失败 %ld",(long)request.code);
        }];
        
//        CallViewController *callVC = [[CallViewController alloc]init];
//        callVC.dismissCompleteBlock = ^{
//            Bsky_StrongSelf
//            if (self.homeVC.currentMemberModel)   // 已有签约，跳转详情
//            {
//                self.selectedIndex = 0;
//                [self.homeVC pushSigningTeamHomeVC];
//            }
//            else
//            {
//                BSCannotCallViewController* viewController = [[BSCannotCallViewController alloc]init];
//                viewController.status = self.homeVC.signInfoRequest.model.resultStatus.integerValue;
//                viewController.signCompleteBlock = ^{   // 跳转签约界面
//                    self.selectedIndex = 0;
//                    [self.homeVC pushVerifiedSigningVC];
//                };
//                UINavigationController *nav3 = [[BSNavigationController alloc] initWithRootViewController:viewController];
//                [self presentViewController:nav3 animated:NO completion:nil];
//            }
//
//        };
//        UINavigationController *nav =[[BSNavigationController alloc]initWithRootViewController:callVC];
//        [self presentViewController:nav animated:YES completion:nil];
    }
}
@end
