//
//  SigningTeamCell.h
//  BskyResidents
//
//  Created by 何雷 on 2017/10/13.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignTeamMemberListModel.h"
#import "SignTeamModel.h"

@interface SigningTeamCell : UITableViewCell

@property (nonatomic ,copy) void (^selectedIndex)(NSInteger index);

@property (nonatomic ,copy) void(^expansion)(BOOL expansion);

@property (nonatomic ,strong)SignTeamModel *teamModel;

@property (nonatomic ,strong)SignTeamMemberListModel *memberListModel;

@property (nonatomic ,assign)BOOL isExpansion;

@end
