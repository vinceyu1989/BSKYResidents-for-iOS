//
//  BSCmsCodeRequest.m
//  BskyResidents
//
//  Created by 何雷 on 2017/10/19.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "ChildrenCardListRequest.h"
#import "ChildrenListModel.h"

@implementation ChildrenCardListRequest

- (NSString*)bs_requestUrl {
    return @"/resident/healthcard/findHealthCardList";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}
- (id)requestArgument {
    return @{@"cardId":[self.cardId encryptCBCStr]};
}

- (void)requestCompleteFilter {
    [super requestCompleteFilter];
    self.listArray = [ChildrenListModel mj_objectArrayWithKeyValuesArray:self.ret];
    [self.listArray decryptArray];
}

- (void)requestFailedFilter {
    [super requestFailedFilter];
    
}

@end
