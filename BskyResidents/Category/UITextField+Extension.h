//
//  UITextField+Extension.h
//  BskyResidents
//
//  Created by 罗林轩 on 2017/11/24.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Extension)
- (void) setSelectedRange:(NSRange) range;
- (void)start:(UITextLayoutDirection)textLayoutDirection;
@end
