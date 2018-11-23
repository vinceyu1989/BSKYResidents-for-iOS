//
//  DetailInfomationModel.h
//  BskyResidents
//
//  Created by 罗林轩 on 2017/10/18.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailInfomationModel : NSObject
@property (assign, nonatomic) CGFloat bottomLineH;//默认0.5
@property (assign, nonatomic) CGFloat cellH;//默认49
@property (assign, nonatomic) BOOL canEdit;//是否能编辑,默认NO
@property (copy, nonatomic) NSString *title;//标题
@property (copy, nonatomic) NSString *content;//内容
@end
