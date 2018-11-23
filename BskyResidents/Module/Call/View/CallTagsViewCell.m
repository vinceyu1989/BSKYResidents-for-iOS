//
//  SDCollectionTagsViewCell.m
//  SDTagsView
//
//  Created by slowdony on 2017/9/9.
//  Copyright © 2017年 slowdony. All rights reserved.
//

#import "CallTagsViewCell.h"

@implementation CallTagsViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
-(void)setupUI
{
    [self.contentView setCornerRadius:15];
    self.contentView.layer.borderWidth = 0.5;
    self.contentView.layer.borderColor = Bsky_UIColorFromRGB(0x4e7dd3).CGColor;

    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textColor = Bsky_UIColorFromRGB(0x4e7dd3);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(8);
        make.right.equalTo(self.contentView.mas_right).offset(-8);
        make.top.bottom.equalTo(self.contentView);
    }];
}
- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        self.contentView.backgroundColor = Bsky_UIColorFromRGB(0x4e7dd3);
        self.titleLabel.textColor = [UIColor whiteColor];
    }
    else
    {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.titleLabel.textColor = Bsky_UIColorFromRGB(0x4e7dd3);
    }
   
}

@end
