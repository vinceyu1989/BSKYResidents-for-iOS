//
//  BskyCustomizeEnum.h
//  BskyResidents
//
//  Created by 何雷 on 2017/10/28.
//  Copyright © 2017年 何雷. All rights reserved.
//

#ifndef BskyCustomizeEnum_h
#define BskyCustomizeEnum_h
#import <Foundation/Foundation.h>

//  app部署环境
typedef NS_ENUM(NSUInteger, AppType) {
    
    AppType_Dev = 0,    // 开发
    
    AppType_Test,       // 测试
    
    AppType_Release     // 发布
};

//  实名认证状态类型
typedef NS_ENUM(NSUInteger, RealInfoVerifStatusType) {
    RealInfoVerifStatusTypeNot = 1006001,    // 未实名认证
    RealInfoVerifStatusTypeSubmitted = 1006002 ,        // 审核中
    RealInfoVerifStatusTypeSuccess = 1006003 ,        // 认证成功
    RealInfoVerifStatusTypeFailure = 1006004         //  认证失败
};


//  签约状态类型
typedef NS_ENUM(NSUInteger, FamilyDoctorSignType) {
    FamilyDoctorSignTypeSuccess = 0,    // 成功获取签约信息
    FamilyDoctorSignTypeNotVerified = 1,    // 未实名认证
    FamilyDoctorSignTypeSubmitted = 2 ,        //  签约申请已提交 审核中
    FamilyDoctorSignTypeAreaNonactivated = 3 ,        //  该区域未开通
    FamilyDoctorSignTypeVerified = 4 ,        //  已实名认证可申请
    FamilyDoctorSignTypeError = 10         //  接口出错
};

//  FamilyDoctorCell类型
typedef NS_ENUM(NSUInteger, FamilyDoctorCellType) {
    
    FamilyDoctorCellTypeDoctor = 1,    // 家庭医生
    
    FamilyDoctorCellTypeCommunity = 2        //  社区医院
};


//  签约服务状态
typedef NS_ENUM(NSInteger, BSSignStatus) {
    BSSignStatusPending = 1,  //1待审
    BSSignStatusPassed,     // 2已通过
    BSSignStatusReject,    // 3未通过
    BSSignStatusExpired,    // 4服务到期
    BSSignStatusSurrender,   // 5解约
    BSSignStatusRenew    // 6续约
};

//占位图
typedef NS_ENUM(NSInteger, placeholderState){
    plactholderStateOnlyString = 0,
    plactholderStateOnlyString2
};

typedef NS_ENUM(NSInteger, AuthenticateViewControllerState){
    doctorClientRegister,
    userClientRegister
};

#endif /* BskyCustomizeEnum_h */
