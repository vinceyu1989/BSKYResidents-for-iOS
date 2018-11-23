//
//  QRCodeView.h
//  BskyResidents
//
//  Created by 罗林轩 on 2017/10/19.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QRCodeView : UIScrollView
@property (assign, nonatomic) CGFloat height;//高度


+ (QRCodeView *)showWithModel:(id)model;

@end
