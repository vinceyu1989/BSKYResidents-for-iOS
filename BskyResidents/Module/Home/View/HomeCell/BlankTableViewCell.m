//
//  BlankTableViewCell.m
//  BskyResidents
//
//  Created by 何雷 on 2017/10/9.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BlankTableViewCell.h"

@interface BlankTableViewCell()

@property (nonatomic ,strong) UIView *emptyView;

@end

@implementation BlankTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.emptyView = [[UIView alloc]init];
        self.emptyView.backgroundColor = Bsky_UIColorFromRGB(0xf7f7f7);
        [self addSubview:self.emptyView];
        [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
            make.height.equalTo(@10);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
