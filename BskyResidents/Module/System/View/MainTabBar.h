//
//  MainTabBar.h
//  BskyResidents
//
//  Created by 何雷 on 2017/10/10.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainTabBar;

@protocol MainTabBarDelegate <UITabBarDelegate>

- (void)tabBarShowBtnClick:(MainTabBar *)tabBar;

@end

@interface MainTabBar : UITabBar

@property (nonatomic, weak) id<MainTabBarDelegate> myDelegate;

@end
