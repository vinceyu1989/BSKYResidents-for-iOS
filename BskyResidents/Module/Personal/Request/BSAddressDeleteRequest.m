//
//  BSAddressDeleteRequest.m
//  BskyResidents
//
//  Created by 何雷 on 2017/10/25.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSAddressDeleteRequest.h"

@implementation BSAddressDeleteRequest

- (NSString*)bs_requestUrl {
    
//    return [NSString stringWithFormat:@"/resident/address/delete?addrId=%@",[self.addrId encryptCBCStr]];
    return @"/resident/address/delete";
}


- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSDictionary*)requestHeaderFieldValueDictionary {
    return @{@"Content-Type": @"application/x-www-form-urlencoded",
             @"headMode": [[BSClientManager sharedInstance] headMode],
             @"token": [BSClientManager sharedInstance].tokenId};
}
- (YTKRequestSerializerType )requestSerializerType{
    return YTKRequestSerializerTypeHTTP;
}
- (id)requestArgument {
    
    return @{
             @"addrId":[self.addrId encryptCBCStr],
             };
}

- (void)requestCompleteFilter {
    [super requestCompleteFilter];
}

- (void)requestFailedFilter {
    [super requestFailedFilter];
    
}

@end
