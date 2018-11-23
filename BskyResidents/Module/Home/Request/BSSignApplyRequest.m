//
//  BSSignApplyRequest.m
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/18.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSSignApplyRequest.h"

@implementation BSSignApplyRequest

- (NSString*)bs_requestUrl {
    return @"/resident/v1/sign/apply";
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
                                 @"birthCertificateNo": @"",
                                 @"crowdTags": self.crowdTags,
                                 @"diseaseLabel": self.diseaseLabel,
                                 @"signingIdcard": [self.signingIdcard encryptCBCStr],
                                 @"signingMobileNo": [self.signingMobileNo encryptCBCStr],
                                 @"signingName": [self.signingName encryptCBCStr],
                                 @"userId": [self.userId encryptCBCStr],
                             };
    
    return params;
}

- (void)requestCompleteFilter {
    [super requestCompleteFilter];
}

- (void)requestFailedFilter {
    [super requestFailedFilter];
    
}

@end
