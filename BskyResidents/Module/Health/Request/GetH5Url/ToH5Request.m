//
//  ToH5Request.m
//  BskyResidents
//
//  Created by 罗林轩 on 2017/11/3.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "ToH5Request.h"

@interface ToH5Request()
@property (copy, nonatomic) NSString *type;
@property (nonatomic, copy) NSNumber *needToken;
@property (copy, nonatomic) NSString *urlString;
@end

@implementation ToH5Request
- (NSString *)bs_requestUrl{
    return @"/user/v1/toH5";
}

- (instancetype)initWithType:(H5RequestType)h5RequestType needToken:(BOOL)isNeedToken{
    self = [super init];
    if(self){
        if (isNeedToken) {
            _needToken = @(isNeedToken);
        } else {
            _needToken = @(NO);
        }
        
        switch (h5RequestType) {
            case reTnbsf:
                _type = @"reTnbsf";
                break;
            case reGxysf:
                _type = @"reGxysf";
                break;
            case reArchives:
                _type = @"reArchives";
                break;
            case reProtocol:
                _type = @"reProtocol";
                break;
            case toCmbWallet:
                _type = @"toCmbWallet";
                break;
            case cmdSign:
                _type = @"cmdSign";
                break;
            default:
                break;
        }
    }
    return self;
}

- (YTKRequestSerializerType)requestSerializerType{
    return YTKRequestSerializerTypeJSON;
}

- (YTKResponseSerializerType)responseSerializerType{
    return YTKResponseSerializerTypeJSON;
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}

- (id)requestArgument{
    return @{@"needToken":_needToken,
             @"type" : _type
             };
}

- (void)requestCompleteFilter {
    [super requestCompleteFilter];
    //h5
   _url = self.responseObject[@"data"];
}

- (void)requestFailedFilter {
    [super requestFailedFilter];
    
}

@end
