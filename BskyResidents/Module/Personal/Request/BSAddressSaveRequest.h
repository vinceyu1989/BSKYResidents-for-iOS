//
//  BSAddressSaveRequest.h
//  BskyResidents
//
//  Created by 何雷 on 2017/10/24.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <BSKYCore/BSKYCore.h>

@interface BSAddressSaveRequest : BSBaseRequest

@property (nonatomic ,copy) NSDictionary *residentAddress;    // 保存的json

@end
