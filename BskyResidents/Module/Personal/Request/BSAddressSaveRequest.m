//
//  BSAddressSave.m
//  BskyResidents
//
//  Created by 何雷 on 2017/10/24.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSAddressSaveRequest.h"

@implementation BSAddressSaveRequest

- (NSString*)bs_requestUrl {
    
    return @"/resident/address/save";
}

- (YTKRequestSerializerType)requestSerializerType {
    
    return YTKRequestSerializerTypeJSON;
}

- (YTKRequestMethod)requestMethod {
    
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return self.residentAddress;
}

- (void)requestCompleteFilter {
    [super requestCompleteFilter];
}

- (void)requestFailedFilter {
    [super requestFailedFilter];
    
}

@end
