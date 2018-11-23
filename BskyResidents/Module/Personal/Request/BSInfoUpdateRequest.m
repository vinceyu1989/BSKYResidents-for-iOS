//
//  BSInfoUpdateRequest.m
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/24.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSInfoUpdateRequest.h"

@implementation BSInfoUpdateRequest

- (NSString*)bs_requestUrl {
    return @"/resident/info/update";
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    WS(weakSelf);

    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    params[@"userId"] = self.userId;
    if (self.areaCode) {
        params[@"areaCode"] = self.areaCode;
    }
    if (self.areaId) {
        params[@"areaId"] = self.areaId;
    }
    if (self.cityId) {
        params[@"cityId"] = self.cityId;
    }
    if (self.detailAddress) {
        params[@"detailAddress"] = self.detailAddress;
    }
    if (self.height) {
        params[@"height"] = self.height;
    }
    if (self.phone) {
        params[@"phone"] = self.phone;
    }
    if (self.properId) {
        params[@"properId"] = self.properId;
    }
    if (self.provinceId) {
        params[@"provinceId"] = self.provinceId;
    }
    if (self.residentId) {
        params[@"residentId"] = self.residentId;
    }
    if (self.signingLabel) {
        params[@"signingLabel"] = self.signingLabel;
    }
    if (self.weight) {
        params[@"weight"] = self.weight;
    }
    
    return @{};
}

- (void)requestCompleteFilter {
    [super requestCompleteFilter];
}

- (void)requestFailedFilter {
    [super requestFailedFilter];
    
}

@end
