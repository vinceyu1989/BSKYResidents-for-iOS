//
//  DetailInformationModel.h
//  BskyResidents
//
//  Created by 罗林轩 on 2017/10/18.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailInfomationModel.h"
@interface DetailInformationWithStringModel : DetailInfomationModel
@property (assign, nonatomic) BOOL isNeedImg;//是否显示已认证,默认NO
@property (assign, nonatomic) BOOL showArrow;//是否显示最右侧箭头
@property (assign, nonatomic) UIKeyboardType keyboardType;//键盘样式
@property (copy, nonatomic) NSString *defaultContent;//默认内容

//@property (copy, nonatomic) NSString *unit;//单位

@end
