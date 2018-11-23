//
//  GFAddressPicker.h
//  地址选择器
//
//  Created by 1暖通商城 on 2017/5/10.
//  Copyright © 2017年 1暖通商城. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSDivision.h"

@interface GFAddressPicker : UIView

@property (nonatomic ,copy) void (^selected)(BSDivision *province,BSDivision *city, BSDivision *area);

- (void)updateArea:(BSDivision *)area;

/** 内容字体 */
@property (nonatomic, strong) UIFont *font;

- (instancetype)initWithDataArray:(NSArray *)dataArray;

- (void)show;



@end
