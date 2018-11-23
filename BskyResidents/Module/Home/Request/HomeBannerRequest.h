//
//  HomeBannerRequest.h
//  BskyResidents
//
//  Created by 何雷 on 2017/10/25.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <BSKYCore/BSKYCore.h>
#import "BannerModel.h"

@interface HomeBannerRequest : BSBaseRequest
@property (copy, nonatomic) NSString *divisionAddr;//区域地址
@property (copy, nonatomic) NSString *scope;//作用域

@property (strong, nonatomic) NSArray <BannerModel *>*bannerModels;

@end
