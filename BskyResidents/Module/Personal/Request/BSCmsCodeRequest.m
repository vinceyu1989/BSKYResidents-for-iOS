//
//  BSCmsCodeRequest.m
//  BskyResidents
//
//  Created by 何雷 on 2017/10/19.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSCmsCodeRequest.h"

@implementation BSCmsCodeRequest

- (NSString*)bs_requestUrl {
    return @"/user/v1/cmsCode/checkPhone";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}
- (id)requestArgument {
    return @{@"randomCek":[NSString enctryptCBCKeyWithRSA],
             @"phone": [self.phone encryptCBCStr],
             @"type":[NSNumber numberWithInt:1],
             };
}

- (void)requestCompleteFilter {
    [super requestCompleteFilter];
}

- (void)requestFailedFilter {
    [super requestFailedFilter];
    
}

@end
