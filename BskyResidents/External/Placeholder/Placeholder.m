//
//  Placeholder.m
//  BskyResidents
//
//  Created by 罗林轩 on 2017/11/22.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "Placeholder.h"
@interface Placeholder()

@end

@implementation Placeholder

+ (instancetype)showWithType:(placeholderState)placeholderState{
    if (placeholderState == plactholderStateOnlyString) {
        return [[[NSBundle mainBundle]loadNibNamed:@"PlaceholderStateString" owner:self options:nil]firstObject];
    }
    return nil;
}

@end
