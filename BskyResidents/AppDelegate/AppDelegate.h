//
//  AppDelegate.h
//  BskyResidents
//
//  Created by 何雷 on 2017/7/18.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabBarController.h"
#import "BSNavigationController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic ,strong) MainTabBarController *tabBarVC;

@property (nonatomic ,strong) BSNavigationController *loginNav;

@end

