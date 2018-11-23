//
//  UITextField+Extension.m
//  BskyResidents
//
//  Created by 罗林轩 on 2017/11/24.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "UITextField+Extension.h"

@implementation UITextField (Extension)
/**
 *  光标选择的范围
 *
 *  @return 获取光标选择的范围
 */
- (NSRange)selectedRange{
    //开始位置
    UITextPosition* beginning = self.beginningOfDocument;
    //光标选择区域
    UITextRange* selectedRange = self.selectedTextRange;
    //选择的开始位置
    UITextPosition* selectionStart = selectedRange.start;
    //选择的结束位置
    UITextPosition* selectionEnd = selectedRange.end;
    //选择的实际位置
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    //选择的长度
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    return NSMakeRange(location, length);
}

/**
 *  设置光标选择的范围
 *
 *  @param range 光标选择的范围
 */
- (void) setSelectedRange:(NSRange) range
{
    UITextPosition* beginning = self.beginningOfDocument;
    UITextPosition* startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition* endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange* selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}

- (void)start:(UITextLayoutDirection)textLayoutDirection{
    UITextRange *range = self.selectedTextRange;
    UITextPosition* start = [self positionFromPosition:range.start inDirection:textLayoutDirection offset:self.text.length];
    if (start){
        [self setSelectedTextRange:[self textRangeFromPosition:start toPosition:start]];
    }
}

@end
