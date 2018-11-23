//
//  BSCmsCodeRequest.m
//  BskyResidents
//
//  Created by 何雷 on 2017/10/19.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "ChildrenCardEditCardIdRequest.h"

@implementation ChildrenCardEditCardIdRequest

- (NSString*)bs_requestUrl {
    return @"/resident/healthcard/applyCardId";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
- (YTKRequestSerializerType )requestSerializerType{
    return YTKRequestSerializerTypeJSON;
}
- (id)requestArgument {
    return self.form;
}

- (void)requestCompleteFilter {
    [super requestCompleteFilter];
}

- (void)requestFailedFilter {
    [super requestFailedFilter];
    
}

@end
