//
//  AppDelegate+UMStatistical.m
//  BskyResidents
//
//  Created by 何雷 on 2017/11/14.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "AppDelegate+UMStatistical.h"
#import "UMMobClick/MobClick.h"

@implementation AppDelegate (UMStatistical)

- (void)setupUMStatistical {
    UMConfigInstance.appKey = UMAppkey;
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
}

@end
