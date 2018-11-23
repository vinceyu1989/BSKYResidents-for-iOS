//
//  AppDelegate.m
//  BskyResidents
//
//  Created by 何雷 on 2017/7/18.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+NIM.h"
#import "AppDelegate+Network.h"
#import "AppDelegate+UMShare.h"
#import "AppDelegate+UMStatistical.h"
#import "AppDelegate+BSKYCheckAppVersion.h"
#import "LoginViewController.h"
#import "LocationManager.h"

@interface AppDelegate ()
@end
@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    [self setupNIMSDKWithType:AppType_Test];
    [self setupNetworkWithType:AppType_Test];
    [self setupUMShare];
    [self setupUMStatistical];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self addNotifiction];
    Bsky_WeakSelf;
    
    
    [self chekAppVersionWithSuccesBlock:^(BOOL isUpdate) {
        Bsky_StrongSelf;
        if (isUpdate == NO) {
            //不需要更新
            [self login];
        }
    } failBlock:^{
        [self login];
    }];
    
    return YES;
}

#pragma mark - 添加通知
- (void)addNotifiction{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(login) name:CancelUpdate object:nil];
}

- (void)login{
    self.tabBarVC = [[MainTabBarController alloc]init];
    NSString* token = [BSClientManager sharedInstance].tokenId;
    if (token) {
        // 自动登录
        [self autoLogin];
    }else {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        self.loginNav = [[BSNavigationController alloc]initWithRootViewController:loginVC];
        self.window.rootViewController = self.loginNav;
    }
    [[NSNotificationCenter defaultCenter]removeObserver:self name:CancelUpdate object:nil];
    [self.window makeKeyAndVisible];
}

- (void)autoLogin{
    BSCmsLoginRequest* req = [BSCmsLoginRequest new];
    req.phone = [BSClientManager sharedInstance].lastUsername;
    req.cmsCode = @"";
    Bsky_WeakSelf
    [req startWithCompletionBlockWithSuccess:^(__kindof BSCmsLoginRequest * _Nonnull request) {
//        Bsky_StrongSelf
        RealInfoVerifStatusType type = [BSAppManager sharedInstance].currentUser.verifStatus.integerValue;
            if (type == RealInfoVerifStatusTypeSuccess) {
                
                BSRealnameInfoRequest* request = [[BSRealnameInfoRequest alloc]init];
                [request startWithCompletionBlockWithSuccess:^(__kindof BSRealnameInfoRequest * _Nonnull request) {
                    Bsky_StrongSelf
                    self.window.rootViewController = self.tabBarVC;
                } failure:^(__kindof BSRealnameInfoRequest * _Nonnull request) {
                    [UIView makeToast:request.msg];
                    Bsky_StrongSelf
                    self.window.rootViewController = self.tabBarVC;
                }];
                
                
            }else{
                self.window.rootViewController = self.tabBarVC;
            }

    } failure:^(__kindof BSCmsLoginRequest * _Nonnull request) {
        [UIView makeToast:request.msg];
        Bsky_StrongSelf;
        [BSClientManager sharedInstance].tokenId = @"";
        [self login];
    }];
}

#pragma mark - 系统回调
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSInteger count = [[[NIMSDK sharedSDK] conversationManager] allUnreadCount];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:count];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [[LocationManager locationShare] checkAuthorizationStatus];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
@end
