//
//  BSNewsListRequest.m
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/24.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSNewsListRequest.h"

@interface BSNewsListRequest ()

@end

@implementation BSNewsListRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        self.pageNo = @"1";
        self.pageSize = @"10";
    }
    
    return self;
}

- (NSString*)bs_requestUrl {
    return [NSString stringWithFormat:@"/resident/news/list?userId=%@&type=%@&pageNo=%@&pageSize=%@", self.userId, self.type, self.pageNo, self.pageSize];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}
- (id)requestArgument {
    return @{};
}

- (void)requestCompleteFilter {
    [super requestCompleteFilter];
    
    NSMutableArray* temp = [NSMutableArray array];
    for (NSDictionary* item in self.ret) {
        BSNews* model = [BSNews mj_objectWithKeyValues:item];
        [temp addObject:model];
    }
    
    self.newsList = [NSArray arrayWithArray:temp];
}

- (void)requestFailedFilter {
    [super requestFailedFilter];
    
}

@end
