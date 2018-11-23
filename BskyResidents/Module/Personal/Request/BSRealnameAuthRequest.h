//
//  BSRealnameAuthRequest.h
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/18.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSRealnameAuthRequest : BSBaseRequest

@property (nonatomic, copy, nonnull) NSString* areaCode;     // 区划编码（乡、镇、街道、办事处一级）
@property (nonatomic, copy, nonnull) NSString* areaId;       // 区划ID（乡、镇、街道、办事处一级）
@property (nonatomic, copy, nonnull) NSString* cityId;       // 市州ID
@property (nonatomic, copy, nonnull) NSString* documentNo;   // 身份证号
@property (nonatomic, copy, nonnull) NSString* properId;     // 区县ID
@property (nonatomic, copy, nonnull) NSString* provinceId;   // 省份ID
@property (nonatomic, copy, nonnull) NSString* realName;     // 用户姓名
@property (nonatomic, copy, nonnull) NSString* userId;       // 用户ID，登录后得到的值

// 返回结果
@property (nonatomic, assign) FamilyDoctorSignType resultStatus;       //  返回值类型。00:成功获取; 01:未实名认证; 02:签约申请已提交过; 03:该区域尚未开通服务; 04:已实名认证，且可申请签约; 10:请求phis接口出错，具体见返回码
@property (nonatomic, copy) NSString * _Nullable noSignMsg;

@end
