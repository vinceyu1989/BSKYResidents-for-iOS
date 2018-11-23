//
//  BSUser.h
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/23.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSUser : NSObject

@property (nonatomic, copy) NSString * accToken; // 云信token
@property (nonatomic, copy) NSString * isChooseAD;  // 是否完善了区划，1未完善(默认) 2已完善
@property (nonatomic, assign) BOOL isExist;   // 是否已经在数据库存在，true:已经注册过的，false:初次注册的账号
@property (nonatomic, copy) NSString * loginMark;  // 登录成功标示
@property (nonatomic, copy) NSString * photourl;  // 用户头像图片地址
@property (nonatomic, copy) NSString * realName;  // 登录用户真实姓名
@property (nonatomic, copy) NSString * regCode;   // 注册code，用于获取cek
@property (nonatomic, copy) NSString * reqDigest;
@property (nonatomic, copy) NSString * token;  // 登录用户访问许可认证，默认长期有效；调用基卫需要的token(有一定有效期)通过另外接口获取
@property (nonatomic, copy) NSString * userId;   // 登录用户id
@property (nonatomic, copy) NSString * verifStatus; // 实名认证状态，见字典auth_status（01006001未认证、01006002认证中、01006003认证成功、01006004认证失败）
@property (nonatomic, copy) NSString * tag;

@property (nonatomic, strong) BSRealnameInfo * realnameInfo;
- (void)decryptCBCModel;
@end
