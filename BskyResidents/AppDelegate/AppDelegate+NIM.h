//
//  AppDelegate+NIM.h
//  BskyResidents
//
//  Created by 何雷 on 2017/7/20.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "AppDelegate.h"
// iOS10 及以上需导入 UserNotifications.framework
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate (NIM) <UNUserNotificationCenterDelegate>

- (void)setupNIMSDKWithType:(AppType)type;

@end
