

//
//  BSRegisterHealthCard.m
//  BskyResidents
//
//  Created by 罗林轩 on 2017/11/20.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSRegisterHealthCard.h"

@implementation BSRegisterHealthCard
- (NSString *)bs_requestUrl{
    return @"/resident/healthcard/applyV2";
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

//- (YTKRequestSerializerType)requestSerializerType{
//    return YTKRequestSerializerTypeJSON;
//}
//
//- (YTKResponseSerializerType)responseSerializerType{
//    return YTKResponseSerializerTypeJSON;
//}

- (void)requestCompleteFilter {
    [super requestCompleteFilter];
}

- (void)requestFailedFilter {
    [super requestFailedFilter];
}
@end
