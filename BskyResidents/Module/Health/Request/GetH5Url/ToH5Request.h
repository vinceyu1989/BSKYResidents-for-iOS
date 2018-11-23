//
//  ToH5Request.h
//  BskyResidents
//
//  Created by 罗林轩 on 2017/11/3.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <BSKYCore/BSKYCore.h>

/**
 H5Type
 - reTnbsf: 居民端糖尿病随访H5页面
 - reGxysf: 居民端高血压随访H5页面
 - reArchives: 居民端健康档案
 - reProtocol: 用户协议
 - toCmbWallet:招行跳转钱包
 */
typedef NS_ENUM(NSInteger,H5RequestType){
    reTnbsf,
    reGxysf,
    reArchives,
    reProtocol,
    toCmbWallet,
    cmdSign
};
@interface ToH5Request : BSBaseRequest
- (instancetype)initWithType:(H5RequestType)h5RequestType needToken:(BOOL)isNeedToken;
@property (copy, nonatomic) NSString *url;
@end
