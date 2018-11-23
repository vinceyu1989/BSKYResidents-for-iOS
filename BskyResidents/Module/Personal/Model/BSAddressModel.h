//
//  BSAddressUpModel.h
//  BskyResidents
//
//  Created by 何雷 on 2017/10/24.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSAddressModel : NSObject

@property (nonatomic, copy) NSString * areaId;
@property (nonatomic, copy) NSString * areaName;
@property (nonatomic, copy) NSString * cityId;
@property (nonatomic, copy) NSString * cityName;
@property (nonatomic, copy) NSString * contractName;
@property (nonatomic, copy) NSString * detailAddr;
@property (nonatomic, copy) NSString * isAutoAddr;   //1否、2是
@property (nonatomic, copy) NSString * mobileNo;
@property (nonatomic, copy) NSString * properId;
@property (nonatomic, copy) NSString * properName;
@property (nonatomic, copy) NSString * provinceId;
@property (nonatomic, copy) NSString * provinceName;
@property (nonatomic, copy) NSString * residentAddrId;
@property (nonatomic, copy) NSString * userId;
@property (copy, nonatomic) NSString *areaCode;

@property (nonatomic, strong) NSNumber * xaxis;
@property (nonatomic, strong) NSNumber * yaxis;
- (BSAddressModel *)encryptCBCSModel;
@end
