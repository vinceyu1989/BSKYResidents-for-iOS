//
//  BSInfoUpdateRequest.h
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/24.
//  Copyright © 2017年 何雷. All rights reserved.
//
//  更新用户信息

#import <Foundation/Foundation.h>

@interface BSInfoUpdateRequest : BSBaseRequest

@property (nonatomic, copy) NSString* areaCode;     // 区划编码（乡、镇、街道、办事处一级）
@property (nonatomic, copy) NSString* areaId;       // 乡、镇、街道、办事处一级Id
@property (nonatomic, copy) NSString* cityId;       // 市州ID
@property (nonatomic, copy) NSString* properId;     // 区县ID
@property (nonatomic, copy) NSString* provinceId;   // 省份ID
@property (nonatomic, copy) NSString* residentId;   // 居民ID
@property (nonatomic, copy) NSString* userId;       // 用户ID
@property (nonatomic, copy) NSString* phone;        // 手机号，修改头像时必填
@property (nonatomic, copy) NSString* height;       // 身高
@property (nonatomic, copy) NSString* weight;       // 体重
@property (nonatomic, copy) NSString* signingLabel; // 签约标签
@property (nonatomic, copy) NSString* detailAddress;// 详细地址

@end
