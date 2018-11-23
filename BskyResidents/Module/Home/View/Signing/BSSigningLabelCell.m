//
//  BSSigningLabelCell.m
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/10.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSSigningLabelCell.h"

@interface BSSigningLabelCell ()

@property (nonatomic, retain) UILabel *label;

@end

@implementation BSSigningLabelCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.label = ({
            UILabel* label = [UILabel new];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = Bsky_UIColorFromRGBA(0x4e7dd3,1);
            label.layer.cornerRadius = 15;
            label.layer.borderColor = Bsky_UIColorFromRGBA(0x4e7dd3,1).CGColor;
            label.layer.borderWidth = 1.0f;
            label.layer.masksToBounds = YES;
            label.font = [UIFont systemFontOfSize:14 weight:UIFontWeightLight];
            if (LESS_IOS8_2) {
                label.font = [UIFont systemFontOfSize:13];
            }
            
            [self.contentView addSubview:label];
            
            label;
        });
        
        
        [self setupFrame];
    }
    
    return self;
}

- (void)setText:(NSString *)text {
    if (IOS9) {
        _text = [NSString stringWithFormat:@"%@  ", text];
    }else {
        _text = text;
    }
    
    self.label.text = _text;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    if (selected) {
        self.label.backgroundColor = Bsky_UIColorFromRGBA(0x4e7dd3,1);
        self.label.textColor = Bsky_UIColorFromRGBA(0xffffff,1);
    }else {
        self.label.backgroundColor = Bsky_UIColorFromRGBA(0xffffff,1);
        self.label.textColor = Bsky_UIColorFromRGBA(0x4e7dd3,1);
    }
}

#pragma mark -

- (void)setupFrame {
    [self.label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (UICollectionViewLayoutAttributes*)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    UICollectionViewLayoutAttributes *attributes = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
    CGRect frame = [self.text boundingRectWithSize:CGSizeMake(1000, self.label.bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.label.font} context:nil];
    frame.size.height = 30;
    frame.size.width += 20;
//    frame.size.width = frame.size.width < 78 ? 78 : frame.size.width;
    attributes.frame = frame;
    return attributes;
}

@end
