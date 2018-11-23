//
//  BSGetHealthCardInfo.m
//  BskyResidents
//
//  Created by 罗林轩 on 2017/11/20.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSGetHealthCardInfo.h"

@implementation BSGetHealthCardInfo
- (NSString *)bs_requestUrl{
    return @"/resident/healthcard/info";
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}

- (YTKResponseSerializerType)responseSerializerType{
    return YTKResponseSerializerTypeJSON;
}

- (YTKRequestSerializerType)requestSerializerType{
    return YTKRequestSerializerTypeJSON;
}

- (void)requestCompleteFilter {
    [super requestCompleteFilter];
}

- (void)requestFailedFilter {
    [super requestFailedFilter];
}
@end
