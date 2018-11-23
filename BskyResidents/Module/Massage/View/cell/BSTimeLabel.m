//
//  BSTimeLabel.m
//  BSKYDoctorPro
//
//  Created by LinfengYU on 2017/9/13.
//  Copyright © 2017年 ky. All rights reserved.
//

#import "BSTimeLabel.h"

@interface BSTimeLabel ()

@end

@implementation BSTimeLabel

+ (BSTimeLabel*)labelWithTagString:(NSString*)tagString {
    BSTimeLabel* tagLabel = [BSTimeLabel new];
    tagLabel.text = tagString;
    
    return tagLabel;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.font = [UIFont systemFontOfSize:12];
        self.layer.cornerRadius = 10.f;
        self.backgroundColor = Bsky_UIColorFromRGBA(0xcccccc,1);

        self.textColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:12];
        self.layer.cornerRadius = 10.f;
        self.backgroundColor = Bsky_UIColorFromRGBA(0xcccccc,1);
        
        self.textColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setTextColor:(UIColor *)textColor {
    [super setTextColor:textColor];
}

- (void)drawTextInRect:(CGRect)rect {
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(2, 10, 2, 10))];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    UIEdgeInsets insets = {2, 10, 2, 10};
    CGRect rect = [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, insets)
                    limitedToNumberOfLines:numberOfLines];
    
    rect.origin.x    -= insets.left;
    rect.origin.y    -= insets.top;
    rect.size.width  += (insets.left + insets.right);
    rect.size.height += (insets.top + insets.bottom);
    
    return rect;
}

@end
