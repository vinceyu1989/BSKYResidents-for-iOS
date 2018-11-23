//
//  BSRealnameInfoRequest.m
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/18.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSRealnameInfoRequest.h"

@implementation BSRealnameInfoRequest

- (NSString*)bs_requestUrl {
    return @"/resident/info/v20171206";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    return @{};
}

- (void)requestCompleteFilter {
    [super requestCompleteFilter];
    BSRealnameInfo *realnameInfo = [BSRealnameInfo mj_objectWithKeyValues:self.ret];
    realnameInfo.userId = [realnameInfo.userId decryptCBCStr];
    realnameInfo.photourl = [realnameInfo.photourl decryptCBCStr];
    realnameInfo.realName = [realnameInfo.realName decryptCBCStr];
    realnameInfo.mobileNo = [realnameInfo.mobileNo decryptCBCStr];
    realnameInfo.documentNo = [realnameInfo.documentNo decryptCBCStr];
    realnameInfo.birthday = [realnameInfo.birthday decryptCBCStr];
    realnameInfo.detailAddress = [realnameInfo.detailAddress decryptCBCStr];
    [BSAppManager sharedInstance].currentUser.realnameInfo = realnameInfo;
    BSUser *user = [BSAppManager sharedInstance].currentUser;
    
    for (NSString *userStr in user.attributeList) {
        if ([realnameInfo.attributeList containsObject:userStr]) {
            [user setValue:[realnameInfo valueForKey:userStr] forKey:userStr];
        }
    }
    NSString *pattern = @"";
    switch ([BSNetConfig sharedInstance].type) {
        case SeverType_Test:
            pattern = @"bsky-app-test";
            break;
        case SeverType_Dev:
            pattern = @"bsky-app";
            break;
        case SeverType_Release:
            pattern = @"bsky-app";
            break;
        default:
            break;
    }
    [self postNotification:GetRealnameAuthenticateInfoSuccessNotification];
}

- (void)requestFailedFilter {
    [super requestFailedFilter];
    
}

@end
