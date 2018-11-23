//
//  BSFollowupListRequest.m
//  BskyResidents
//
//  Created by LinfengYU on 2017/11/3.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSFollowupListRequest.h"

@implementation BSFollowupListRequest

- (NSString*)bs_requestUrl {
    return @"/resident/followup/list";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    return @{};
}

- (void)requestCompleteFilter {
    [super requestCompleteFilter];
    
    NSArray* data = self.ret;
    if (!data || [data isKindOfClass:[NSNull class]]) {
        return;
    }
    
    NSMutableArray* temp = [NSMutableArray array];
    for (NSDictionary* item in self.ret) {
        BSFollowup* model = [BSFollowup mj_objectWithKeyValues:item];
        [temp addObject:model];
    }
    self.followupList = [NSArray arrayWithArray:temp];
}

- (void)requestFailedFilter {
    [super requestFailedFilter];
    
}

@end
