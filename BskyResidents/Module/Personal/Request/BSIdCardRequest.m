//
//  BSIdCardRequest.m
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/18.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSIdCardRequest.h"

@implementation BSIdCardRequest

- (NSString*)bs_requestUrl {
    return @"/resident/v1/idcard";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    return @{};
}

- (void)requestCompleteFilter {
    [super requestCompleteFilter];
    
    NSDictionary* data = self.ret;
//    {
//        age = "";
//        areaCode = "";
//        areaId = "";
//        areaName = "";
//        birthday = "";
//        cityId = "";
//        cityName = "";
//        detailAddress = "";
//        documentNo = "";
//        height = "";
//        mobileNo = 18368194001;
//        photourl = "";
//        properId = "";
//        properName = "";
//        provinceId = "";
//        provinceName = "";
//        realName = "";
//        sex = "";
//        signingLabel = "";
//        userId = 156;
//        verifStatus = 01006001;
//        weight = "";
//    }

}

- (void)requestFailedFilter {
    [super requestFailedFilter];
    
}

@end
