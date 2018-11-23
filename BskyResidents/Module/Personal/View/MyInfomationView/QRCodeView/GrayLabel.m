


//
//  GrayLabel.m
//  BskyResidents
//
//  Created by 罗林轩 on 2017/10/19.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "GrayLabel.h"

@implementation GrayLabel
- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = [UIColor colorWithHexString:@"999999"];
        self.font = [UIFont systemFontOfSize:11];
        self.layer.cornerRadius = 4;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 0.5f;
        self.layer.borderColor = [UIColor colorWithHexString:@"999999"].CGColor;
    }
    return self;
}
@end
