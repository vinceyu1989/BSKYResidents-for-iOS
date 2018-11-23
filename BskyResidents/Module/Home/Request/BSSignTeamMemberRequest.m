//
//  BSSignTeamMemberRequest.m
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/24.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSSignTeamMemberRequest.h"

@implementation BSSignTeamMemberRequest

- (NSString*)bs_requestUrl {
    return [NSString stringWithFormat:@"/resident/sign/team/member?teamId=%@", self.teamId];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    return @{};
}

- (void)requestCompleteFilter {
    [super requestCompleteFilter];
    self.model = [SignTeamMemberListModel mj_objectWithKeyValues:self.ret];
    for (SignTeamMemberModel *member in self.model.memberList) {
       [member decryptCBCModel];
    }
}

- (void)requestFailedFilter {
    [super requestFailedFilter];
    
}

@end
