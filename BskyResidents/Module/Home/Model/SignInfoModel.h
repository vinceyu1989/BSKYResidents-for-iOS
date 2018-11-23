//
//  SignInfoModel.h
//  BskyResidents
//
//  Created by 何雷 on 2017/10/25.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class SignDetailInfo;

@interface SignInfoModel : NSObject

@property (nonatomic, copy) NSString * noSignMsg;
@property (nonatomic, copy) NSString * resultStatus;    // 00:成功获取; 01:未实名认证; 02:签约申请已提交过; 03:该区域尚未开通服务; 04:已实名认证，且可申请签约; 10:请求phis接口出错
@property (nonatomic, strong) SignDetailInfo * signInfo;

@end

@class SignService;

@interface SignDetailInfo : NSObject

@property (nonatomic, copy) NSData * attachfile;
@property (nonatomic, copy) NSString * cardId;
@property (nonatomic, copy) NSString * channel;
@property (nonatomic, copy) NSString * contractId;
@property (nonatomic, copy) NSString * createEmp;
@property (nonatomic, copy) NSString * doctorName;
@property (nonatomic, copy) NSString * endTime;
@property (nonatomic, copy) NSString * fee;
@property (nonatomic, copy) NSString * othereMark;
@property (nonatomic, copy) NSString * personName;
@property (nonatomic, copy) NSString * phoneTel;
@property (nonatomic, copy) NSArray * servicelist;
@property (nonatomic, copy) NSString * startTime;
@property (nonatomic, assign) NSInteger status; // 1待审 2已通过 3未通过 4服务到期 5解约 6续约
@property (nonatomic, copy) NSString * tags;
@property (nonatomic, copy) NSString * teamId;
@property (nonatomic, copy) NSString * teamName;
@property (nonatomic, copy) NSString * signPerson;
@end

@interface SignService : NSObject

@property (nonatomic, copy) NSString * appObject;
@property (nonatomic, copy) NSString * categOry;
@property (nonatomic, copy) NSString * code;
@property (nonatomic, assign) CGFloat fee;
@property (nonatomic, copy) NSString * idField;
@property (nonatomic, copy) NSString * lev;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * remark;
@property (nonatomic, copy) NSString * startTime;
@property (nonatomic, copy) NSString * endTime;
@property (nonatomic, copy) NSString * id;
@property (assign, nonatomic) BOOL expand;//是否展开

@property (nonatomic, strong) NSArray* servicePackList;

@end

@interface ServicePack : NSObject

@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * remark;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * freNum;
@property (nonatomic, copy) NSString * freRemark;
@property (nonatomic, copy) NSString * servicePackId;
@property (nonatomic, copy) NSString * frecompare;

@end
