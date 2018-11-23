//
//  HomeBannerRequest.m
//  BskyResidents
//
//  Created by 何雷 on 2017/10/25.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "HomeBannerRequest.h"

@implementation HomeBannerRequest

- (NSString*)bs_requestUrl {
    return @"/resident/banner/addr";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    return @{@"divisionAddr" : [_divisionAddr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
             @"scope": @"02019001"
             };
}

- (void)requestCompleteFilter {
    [super requestCompleteFilter];
    _bannerModels = [BannerModel mj_objectArrayWithKeyValuesArray:self.ret];
}

- (void)requestFailedFilter {
    [super requestFailedFilter];
}
@end
