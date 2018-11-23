//
//  HomeViewController.h
//  BskyResidents
//
//  Created by 何雷 on 2017/9/28.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController

@property (nonatomic ,strong) SignTeamMemberModel *currentMemberModel;   //当前显示的医生

@property (nonatomic ,strong) BSSignInfoRequest *signInfoRequest;   // 签约信息请求

- (void)pushSigningTeamHomeVC;

- (void)pushVerifiedSigningVC;

@end

