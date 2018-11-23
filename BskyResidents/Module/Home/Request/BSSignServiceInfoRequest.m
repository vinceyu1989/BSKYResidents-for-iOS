//
//  BSSignServiceInfoRequest.m
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/25.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSSignServiceInfoRequest.h"

@implementation BSSignServiceInfoRequest

- (NSString*)bs_requestUrl {
    return [NSString stringWithFormat:@"/resident/sign/service/info?servicePackId=%@&regionCode=%@", self.servicePackId, self.regionCode];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    return @{};
}

- (void)requestCompleteFilter {
    [super requestCompleteFilter];
    
    NSArray* result = self.ret[@"servicePackList"];
    NSMutableArray* temp = [NSMutableArray array];
    for (NSDictionary* item in result) {
        ServicePack* model = [ServicePack mj_objectWithKeyValues:item];
        [temp addObject:model];
    }
    self.servicePackList = [NSArray arrayWithArray:temp];
}

- (void)requestFailedFilter {
    [super requestFailedFilter];
    
}


@end
