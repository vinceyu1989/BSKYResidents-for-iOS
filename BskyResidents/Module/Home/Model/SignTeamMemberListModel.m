//
//  SignTeamMemberListModel.m
//  BskyResidents
//
//  Created by 何雷 on 2017/10/28.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "SignTeamMemberListModel.h"

@implementation SignTeamMemberListModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"memberList"  : @"SignTeamMemberModel"};
}
@end

@implementation SignTeamMemberModel
- (void )decryptCBCModel{
    self.employeeId = [self.employeeId decryptCBCStr];
    self.memberName = [self.memberName decryptCBCStr];
    self.orgName = [self.orgName decryptCBCStr];
    self.phone = [self.phone decryptCBCStr];
    self.teamMemberId = [self.teamMemberId decryptCBCStr];
}
@end
