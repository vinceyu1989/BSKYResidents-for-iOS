//
//  BSSignTeamMemberRequest.h
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/24.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SignTeamMemberListModel.h"

@interface BSSignTeamMemberRequest : BSBaseRequest

@property (nonatomic, copy) NSString* teamId;

@property (nonatomic ,strong) SignTeamMemberListModel *model;

@end
