//
//  SigningTeamHomeVC.h
//  BskyResidents
//
//  Created by 何雷 on 2017/10/12.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignTeamModel.h"
#import "SignTeamMemberListModel.h"

@interface SigningTeamHomeVC : UITableViewController

@property (nonatomic ,assign) FamilyDoctorCellType type;

@property (nonatomic ,strong) SignTeamModel *teamModel;   // 团队

@property (nonatomic ,strong) SignTeamMemberListModel *memberListModel;  // 医生列表

@property (nonatomic ,strong) SignTeamMemberModel *currentMemberModel;   // 当前显示的医生

@property (nonatomic, copy) void (^selectMemberBlock)(SignTeamMemberModel *currentMemberModel);

@end
