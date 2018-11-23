//
//  BSNewsTotalRequest.m
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/24.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSNewsTotalRequest.h"

@implementation BSNewsTotalRequest

- (NSString*)bs_requestUrl {
    return [NSString stringWithFormat:@"/resident/news/total?userId=%@", self.userId];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}
- (id)requestArgument {
    return @{};
}

- (void)requestCompleteFilter {
    [super requestCompleteFilter];
    self.messageCategoryList = [BSNewsCategory mj_objectArrayWithKeyValuesArray:self.ret];
}

- (void)requestFailedFilter {
    [super requestFailedFilter];
    
}

@end
