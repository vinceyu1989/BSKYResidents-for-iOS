//
//  BSKYUpdateViewController.m
//  BskyResidents
//
//  Created by 罗林轩 on 2017/12/12.
//  Copyright © 2017年 罗林轩. All rights reserved.
//

#import "BSKYUpdateViewController.h"
#import "BSAppUpdateView.h"
#import "MainTabBarController.h"
#import "AppDelegate.h"
@interface BSKYUpdateViewController ()<BSAppUpadteViewDelegate>

@end

@implementation BSKYUpdateViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - 展示更新界面
- (void)showUpdateView{
    [BSAppUpdateView showInView:self.view animated:YES info:self.info mandatoryUpdate:self.mandatoryUpdate downloadUrl:self.downloadUrl delegate:self];
}

#pragma mark - BSAppUpadteViewDelegate
#pragma mark - 取消更新
- (void)cancelUpdate{
    [[NSNotificationCenter defaultCenter] postNotificationName:CancelUpdate object:nil];
}
@end
