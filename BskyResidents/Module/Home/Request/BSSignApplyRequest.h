//
//  BSSignApplyRequest.h
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/18.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <Foundation/Foundation.h>

//{
//    areaCode (string, optional): 区划编码（乡、镇、街道、办事处一级） ,
//    areaId (string, optional): 区划ID（乡、镇、街道、办事处一级） ,
//    birthCertificateNo (string, optional): 出身证号 ,
//    crowdTags (string, optional): 所属人群，见字典crowd_tags（普通人群、60岁以上、孕产妇、残疾人、儿童） ,
//    diseaseLabel (string, optional): 疾病标签，见字典disease_label（高血压、糖尿病、严重精神障碍、无疾病） ,
//    signingIdcard (string, optional): 身份证号 ,
//    signingMobileNo (string, optional): 手机号 ,
//    signingName (string, optional): 签约人真实姓名 ,
//    userId (string, optional): 用户ID
//}

@interface BSSignApplyRequest : BSBaseRequest

@property (nonatomic, copy) NSString* areaCode;
@property (nonatomic, copy) NSString* areaId;
@property (nonatomic, copy) NSString* birthCertificateNo;
@property (nonatomic, copy) NSString* crowdTags;
@property (nonatomic, copy) NSString* diseaseLabel;
@property (nonatomic, copy) NSString* signingIdcard;
@property (nonatomic, copy) NSString* signingMobileNo;
@property (nonatomic, copy) NSString* signingName;
@property (nonatomic, copy) NSString* userId;

@end
