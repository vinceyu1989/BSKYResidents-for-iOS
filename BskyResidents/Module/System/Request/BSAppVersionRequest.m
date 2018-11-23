//
//  BSAppVersionRequest.m
//  BSKYDoctorPro
//
//  Created by LinfengYU on 2017/9/22.
//  Copyright © 2017年 ky. All rights reserved.
//

#import "BSAppVersionRequest.h"

@implementation BSAppVersionRequest

- (NSString*)bs_requestUrl {
    return [NSString stringWithFormat:@"/user/v1/appversion/v20171207"];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    return @{
             @"clientType" : @"2",//1.医护端 2.居民端
             };
}

- (void)requestCompleteFilter {
    [super requestCompleteFilter];
}

- (void)requestFailedFilter {
    [super requestFailedFilter];
}

@end
