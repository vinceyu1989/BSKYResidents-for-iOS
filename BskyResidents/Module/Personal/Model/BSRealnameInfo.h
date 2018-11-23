//
//  BSRealnameInfo.h
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/23.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSRealnameInfo : NSObject

@property (nonatomic, copy) NSString* userId;
@property (nonatomic, copy) NSString* verifStatus; //实名认证状态，见字典auth_status（01006001未认证、01006002认证中、01006003认证成功、01006004认证失败）
@property (nonatomic, copy) NSString* photourl;
@property (nonatomic, copy) NSString* realName;
@property (nonatomic, copy) NSString* mobileNo;
@property (nonatomic, copy) NSString* documentNo;
@property (nonatomic, copy) NSString* sex;
@property (nonatomic, copy) NSString* age;
@property (nonatomic, copy) NSString* birthday;
@property (nonatomic, copy) NSString* height;
@property (nonatomic, copy) NSString* weight;
@property (nonatomic, copy) NSString* provinceId;
@property (nonatomic, copy) NSString* provinceName;
@property (nonatomic, copy) NSString* cityId;
@property (nonatomic, copy) NSString* cityName;
@property (nonatomic, copy) NSString* properId;
@property (nonatomic, copy) NSString* properName;
@property (nonatomic, copy) NSString* areaCode;
@property (nonatomic, copy) NSString* areaId;
@property (nonatomic, copy) NSString* areaName;
@property (nonatomic, copy) NSString* detailAddress;
@property (nonatomic, copy) NSString* signingLabel;
@property (nonatomic, copy) NSString* residentId;

@end
