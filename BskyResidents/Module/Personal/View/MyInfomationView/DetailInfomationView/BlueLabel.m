//
//  BlueLabel.m
//  BskyResidents
//
//  Created by 罗林轩 on 2017/10/19.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BlueLabel.h"

@implementation BlueLabel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setting];
    }
    return self;
}

- (void)setting{
    self.backgroundColor = [UIColor colorWithHexString:@"4e7dd3"];
    self.layer.cornerRadius = 6;
    self.layer.masksToBounds = YES;
    self.textColor = [UIColor whiteColor];
    self.textAlignment = NSTextAlignmentCenter;
}
@end
