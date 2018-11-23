//
//  SignTeamMemberListModel.h
//  BskyResidents
//
//  Created by 何雷 on 2017/10/28.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SignTeamMemberModel;

@interface SignTeamMemberListModel : NSObject

@property (nonatomic, copy) NSArray * memberList;
@property (nonatomic, copy) NSString * noSignMsg;
@property (nonatomic, copy) NSString * resultStatus;

@end

@interface SignTeamMemberModel : NSObject

@property (nonatomic, copy) NSString * duty;
@property (nonatomic, copy) NSString * employeeId;
@property (nonatomic, copy) NSString * isExist;
@property (nonatomic, copy) NSString * memberName;
@property (nonatomic, copy) NSString * orgName;
@property (nonatomic, copy) NSString * phone;
@property (nonatomic, copy) NSString * photo;
@property (nonatomic, copy) NSString * professional;
@property (nonatomic, copy) NSString * remark;
@property (nonatomic, copy) NSString * teamMemberId;
- (void )decryptCBCModel;
@end
