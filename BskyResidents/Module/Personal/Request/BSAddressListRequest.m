//
//  BSAddressListRequest.m
//  BskyResidents
//
//  Created by 何雷 on 2017/10/24.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSAddressListRequest.h"
#import "BSAddressModel.h"

@implementation BSAddressListRequest

- (NSString*)bs_requestUrl {
    return @"/resident/address/list";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}
- (id)requestArgument {
    return @{@"userId": self.userId,
             @"pageSize": self.pageSize,
             @"pageNo": self.pageNo
             };
}

- (void)requestCompleteFilter {
    [super requestCompleteFilter];
    self.addressList = [BSAddressModel mj_objectArrayWithKeyValuesArray:self.ret];
    for (BSAddressModel *model in self.addressList) {
//        model.userId = [model.userId decryptCBCStr];
        model.contractName = [model.contractName decryptCBCStr];
        model.mobileNo = [model.mobileNo decryptCBCStr];
        model.detailAddr = [model.detailAddr decryptCBCStr];
    }
}

- (void)requestFailedFilter {
    [super requestFailedFilter];
    
}

@end
