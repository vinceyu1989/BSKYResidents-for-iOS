//
//  BSDivisionRequest.m
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/23.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSDivisionRequest.h"

@implementation BSDivisionRequest

- (NSString*)bs_requestUrl {
    return [NSString stringWithFormat:@"/allreq/administrative/division/%@", self.divisionCode];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}
- (id)requestArgument {
    return @{};
}

- (void)requestCompleteFilter {
    [super requestCompleteFilter];
    
    NSDictionary* data = self.ret;
    self.divisionId = data[@"divisionId"];
}

- (void)requestFailedFilter {
    [super requestFailedFilter];
}

@end
