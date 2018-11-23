//
//  BSRealnameAuthRequest.m
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/18.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSRealnameAuthRequest.h"

@implementation BSRealnameAuthRequest

- (NSString*)bs_requestUrl {
    return @"/resident/v1/realnameauth";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}

- (id)requestArgument {
    NSDictionary* params = @{
                                @"areaCode": self.areaCode,
                                @"areaId": self.areaId,
                                @"cityId": self.cityId,
                                @"documentNo": [self.documentNo encryptCBCStr],
                                @"properId": self.properId,
                                @"provinceId": self.provinceId,
                                @"realName": [self.realName encryptCBCStr],
                                @"userId": [self.userId encryptCBCStr],
                            };

    return params;
}

- (void)requestCompleteFilter {
    [super requestCompleteFilter];
#warning 暂时设置为,框架可能有问题
    if (self.code != 200) {
        return;
    }
    self.resultStatus = ((NSString *)self.ret[@"resultStatus"]).integerValue;
    self.noSignMsg = self.ret[@"noSignMsg"];
    [self postNotification:RealnameAuthenticateSuccessNotification];
}

- (void)requestFailedFilter {
    [super requestFailedFilter];
    
}

@end
