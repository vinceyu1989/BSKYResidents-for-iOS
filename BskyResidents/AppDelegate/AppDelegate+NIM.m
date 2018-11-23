//
//  AppDelegate+NIM.m
//  BskyResidents
//
//  Created by 何雷 on 2017/7/20.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "AppDelegate+NIM.h"
#import "NTESSDKConfigDelegate.h"
#import "NTESBundleSetting.h"
#import "NTESNotificationCenter.h"
#import "NTESSubscribeManager.h"
#import "NTESCustomAttachmentDecoder.h"
#import "NTESCellLayoutConfig.h"

NSString *NTESNotificationLogout = @"NTESNotificationLogout";

@implementation AppDelegate (NIM)

- (void)setupNIMSDKWithType:(AppType)type
{
    //在注册 NIMSDK appKey 之前先进行配置信息的注册，如是否使用新路径,是否要忽略某些通知，是否需要多端同步未读数等
    NTESSDKConfigDelegate *sdkConfigDelegate = [[NTESSDKConfigDelegate alloc] init];
    [[NIMSDKConfig sharedConfig] setDelegate:sdkConfigDelegate];
    [[NIMSDKConfig sharedConfig] setShouldSyncUnreadCount:YES];
    [[NIMSDKConfig sharedConfig] setMaxAutoLoginRetryTimes:10];
    [[NIMSDKConfig sharedConfig] setMaximumLogDays:[[NTESBundleSetting sharedConfig] maximumLogDays]];
    [[NIMSDKConfig sharedConfig] setShouldCountTeamNotification:[[NTESBundleSetting sharedConfig] countTeamNotification]];
    [[NIMSDKConfig sharedConfig] setAnimatedImageThumbnailEnabled:[[NTESBundleSetting sharedConfig] animatedImageThumbnailEnabled]];
    // 支持http
    [NIMSDKConfig sharedConfig].enabledHttpsForInfo = NO;
    
    
    //appkey 是应用的标识，不同应用之间的数据（用户、消息、群组等）是完全隔离的。
    //如需打网易云信 Demo 包，请勿修改 appkey ，开发自己的应用时，请替换为自己的 appkey 。
    //并请对应更换 Demo 代码中的获取好友列表、个人信息等网易云信 SDK 未提供的接口。
    NSString *appKey = nil;
    NSString *apnsCername = nil;
    switch (type) {
        case AppType_Dev:
            appKey = @"87b042f423244adff232d86d34fdf101";
            apnsCername = @"UserDevPush";
            break;
        case AppType_Test:
            appKey = @"630a6e5118f93605715760823496287c";
            apnsCername = @"UserAdHocPush";
            break;
        case AppType_Release:
            appKey = @"5e83fb6ad8eb9295e80d4420b33d4a12";
            apnsCername = @"UserReleasePush";
            break;
            
        default:
            break;
    }
    
    NIMSDKOption *option    = [NIMSDKOption optionWithAppKey:appKey];
    option.apnsCername      = apnsCername;
    [[NIMSDK sharedSDK] registerWithOption:option];
    
    //注册 NIMKit UI配置
    [NIMKit sharedKit].config.avatarType = NIMKitAvatarTypeRadiusCorner;
    
    //注册自定义消息的解析器
    [NIMCustomObject registerCustomDecoder:[[NTESCustomAttachmentDecoder alloc]init]];
    
    //注册 NIMKit 自定义排版配置
    [[NIMKit sharedKit] registerLayoutConfig:[[NTESCellLayoutConfig alloc]init]];
    
    BOOL isUsingDemoAppKey = [[NIMSDK sharedSDK] isUsingDemoAppKey];
    [[NIMSDKConfig sharedConfig] setTeamReceiptEnabled:isUsingDemoAppKey];
    
    [self setupServices];
    [self registerRemoteNotification];
}
- (void)setupServices
{
    [[NTESNotificationCenter sharedCenter] start];
    [[NTESSubscribeManager sharedManager] start];
}
/** 注册 APNs */
- (void)registerRemoteNotification {
    /*
     警告：Xcode8 需要手动开启"TARGETS -> Capabilities -> Push Notifications"
     */
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError *_Nullable error) {
            if (!granted)
            {
                dispatch_async_main_safe(^{
                    [UIView makeToast:@"请开启推送功能否则无法收到推送通知"];
                })
            }
        }];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
    } else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    } else {
        
    }
}
#pragma mark ----  UIApplicationDelegate
/** 远程通知注册成功委托 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {

    [[NIMSDK sharedSDK] updateApnsToken:deviceToken];
}


@end
