//
//  BSCmsCodeRequest.m
//  BskyResidents
//
//  Created by 何雷 on 2017/10/19.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "ChildrenCardEditBirthIdRequest.h"

@implementation ChildrenCardEditBirthIdRequest

- (NSString*)bs_requestUrl {
    return @"/resident/healthcard/applyBirthId";
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
