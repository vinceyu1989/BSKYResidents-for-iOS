//
//  IdentificationView.m
//  BskyResidents
//
//  Created by 罗林轩 on 2017/10/18.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "IdentificationView.h"

@implementation IdentificationView
+(IdentificationView *)show{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
}
@end
