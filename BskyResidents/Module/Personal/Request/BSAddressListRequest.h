//
//  BSAddressListRequest.h
//  BskyResidents
//
//  Created by 何雷 on 2017/10/24.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <BSKYCore/BSKYCore.h>

@interface BSAddressListRequest : BSBaseRequest

@property (nonatomic ,copy) NSString *userId;
@property (nonatomic ,copy) NSString *pageSize;
@property (nonatomic ,copy) NSString *pageNo;

@property (nonatomic ,copy) NSArray *addressList;

@end
