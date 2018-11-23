//
//  BSChangePersonInformationRequest.m
//  BskyResidents
//
//  Created by 罗林轩 on 2017/11/1.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSChangePersonInformationRequest.h"

@implementation BSChangePersonInformationRequest
- (NSString*)bs_requestUrl {
    return @"/resident/info/update";
}

- (YTKRequestSerializerType)requestSerializerType{
    return YTKRequestSerializerTypeJSON;
}

- (YTKResponseSerializerType)responseSerializerType{
    return YTKResponseSerializerTypeJSON;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument{
    NSDictionary *parm = @{
                           @"areaCode" : _areaCode,
                           @"areaId" : _areaId,
                           @"cityId" : _cityId,
                           @"detailAddress" : [_detailAddress encryptCBCStr],
                           @"height" : _height,
                           @"weight" : _weight,
                           @"phone" : [_phone encryptCBCStr],
                           @"properId" : _properId,
                           @"provinceId" : _provinceId,
                           @"signingLabel" : _signingLabel,
                           @"userId" : [_userId encryptCBCStr],
                           @"residentId" : [_residentId encryptCBCStr]
                           };
        return parm;
}

- (void)requestCompleteFilter {
    [super requestCompleteFilter];
}

- (void)requestFailedFilter {
    [super requestFailedFilter];
}
@end
