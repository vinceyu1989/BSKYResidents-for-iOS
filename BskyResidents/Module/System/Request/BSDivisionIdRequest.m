//
//  BSDivisionIdRequest.m
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/23.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSDivisionIdRequest.h"

@implementation BSDivisionIdRequest

- (NSString*)bs_requestUrl {
    return [NSString stringWithFormat:@"/allreq/administrative/parent/%@", self.divisionId];
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
    NSMutableArray* temp = [NSMutableArray array];
    for (NSDictionary* item in data) {
        BSDivision* model = [BSDivision mj_objectWithKeyValues:item];
        [temp addObject:model];
    }
    self.divisionList = [NSArray arrayWithArray:temp];
}

- (void)requestFailedFilter {
    [super requestFailedFilter];
}

@end
