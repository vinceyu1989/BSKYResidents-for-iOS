//
//  BSSignTeamRequest.m
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/24.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSSignTeamRequest.h"

@implementation BSSignTeamRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pageIndex = 1;
        self.pageSize = 10;
    }
    return self;
}

- (NSString*)bs_requestUrl {
    return [NSString stringWithFormat:@"/resident/sign/team?pageIndex=%ld&pageSize=%ld&teamId=%@", self.pageIndex, self.pageSize, self.teamId];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    return @{};
}

- (void)requestCompleteFilter {
    [super requestCompleteFilter];
    self.model = [SignTeamModel mj_objectWithKeyValues:self.ret];
    self.model.team.orgName = [self.model.team.orgName decryptCBCStr];
}

- (void)requestFailedFilter {
    [super requestFailedFilter];
    
}

@end
