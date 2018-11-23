//
//  ToAgreementH5Request.m
//  BskyResidents
//
//  Created by 何雷 on 2018/5/7.
//  Copyright © 2018年 罗林轩. All rights reserved.
//

#import "ToAgreementH5Request.h"

@implementation ToAgreementH5Request

- (NSString*)bs_requestUrl{
    
    return @"/user/v1/toH5NoToken";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    
    return @{@"type":@"reProtocol"};
}

- (void)requestCompleteFilter {
    
    [super requestCompleteFilter];
    self.urlString = self.responseObject[@"data"];
}

- (void)requestFailedFilter {
    [super requestFailedFilter];
    
}

@end
