//
//  FamilyDoctorCell.h
//  BskyResidents
//
//  Created by 何雷 on 2017/10/9.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignTeamModel.h"
#import "SignTeamMemberListModel.h"

@class FamilyDoctorCell;

@protocol FamilyDoctorCellDelegate <NSObject>

- (void)familyDoctorCellAvatarImageClick:(FamilyDoctorCell *)cell;  // 点击头像

- (void)familyDoctorCellFunctionalFirstBtnClick:(FamilyDoctorCell *)cell;  // 点击第一个功能按钮

- (void)familyDoctorCellFunctionalSecondBtnClick:(FamilyDoctorCell *)cell;  // 点击第二个功能按钮

@end

@interface FamilyDoctorCell : UITableViewCell

@property (nonatomic ,assign) FamilyDoctorCellType type;

@property (nonatomic ,strong) SignTeamMemberModel *memberModel;

@property (nonatomic ,strong) SignTeamModel *teamModel;

@property (nonatomic, weak) id<FamilyDoctorCellDelegate> delegate;

@end
