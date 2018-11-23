//
//  BSCmsCodeRequest.m
//  BskyResidents
//
//  Created by 何雷 on 2017/10/19.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "ChildrenCardEditNoPaperRequest.h"

@implementation ChildrenCardEditNoPaperRequest

- (NSString*)bs_requestUrl {
    return @"/resident/healthcard/applyNoPaper";
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
