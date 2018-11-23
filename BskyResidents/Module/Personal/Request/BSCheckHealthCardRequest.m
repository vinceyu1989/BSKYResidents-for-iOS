//
//  BSCheckHealthCardRequest.m
//  BskyResidents
//
//  Created by kykj on 2018/4/20.
//  Copyright © 2018年 罗林轩. All rights reserved.
//

#import "BSCheckHealthCardRequest.h"

@implementation BSCheckHealthCardRequest

- (NSString *)bs_requestUrl{
    return @"/doctor/healthcard/healthcardState";
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    return @{
             @"phone":[self.phone encryptCBCStr]
             };
}

- (void)requestCompleteFilter {
    [super requestCompleteFilter];
}

- (void)requestFailedFilter {
    [super requestFailedFilter];
}

@end
