//
//  SignTeamModel.h
//  BskyResidents
//
//  Created by 何雷 on 2017/10/28.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SignTeam;

@interface SignTeamModel : NSObject

@property (nonatomic, copy) NSString * noSignMsg;
@property (nonatomic, copy) NSString * resultStatus;
@property (nonatomic, strong) SignTeam * team;

@end

@interface SignTeam : NSObject

@property (nonatomic, copy) NSString * orgName;
@property (nonatomic, copy) NSString * quantity;
@property (nonatomic, copy) NSString * remark;
@property (nonatomic, copy) NSString * teamId;
@property (nonatomic, copy) NSString * teamName;
@property (nonatomic, copy) NSString * teamType;

@end
