//
//  QRModel.h
//  BskyResidents
//
//  Created by 罗林轩 on 2017/11/21.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QRModel : NSObject
@property (copy, nonatomic) NSString *zjhm;//证件号码
@property (copy, nonatomic) NSString *realName;//姓名
@property (copy, nonatomic) NSString *sex;//性别，1男2女0未知9未说明 ,
@property (copy, nonatomic) NSString *lxdh;//联系电话
@property (copy, nonatomic) NSString *base64;//base64图片
- (void )decryptCBCModel;
@end
