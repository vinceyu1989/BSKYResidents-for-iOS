//
//  BSCmsCodeRequest.h
//  BskyResidents
//
//  Created by 何雷 on 2017/10/19.
//  Copyright © 2017年 何雷. All rights reserved.
//
//  OK

#import <BSKYCore/BSKYCore.h>

@interface ChildrenCardListRequest : BSBaseRequest

@property (nonatomic, copy) NSString *cardId;
@property (nonatomic, strong) NSArray *listArray;
@end
