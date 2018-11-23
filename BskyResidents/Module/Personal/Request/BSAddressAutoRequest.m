//
//  BSAddressAutoRequest.m
//  BskyResidents
//
//  Created by 何雷 on 2017/10/24.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSAddressAutoRequest.h"

@implementation BSAddressAutoRequest

- (NSString*)bs_requestUrl {
    
//    return [NSString stringWithFormat:@"/resident/address/auto?userId=%@&addrId=%@",[self.userId encryptCBCStr],[self.addrId encryptCBCStr]];
    return @"/resident/address/auto";
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
             @"userId":[self.userId encryptCBCStr],
             };
}

- (void)requestCompleteFilter {
    [super requestCompleteFilter];
}

- (void)requestFailedFilter {
    [super requestFailedFilter];
    
}

@end
