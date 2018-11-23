//
//  GeneralServiceCell.m
//  BskyResidents
//
//  Created by 何雷 on 2017/10/9.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "GeneralServiceCell.h"

@interface GeneralServiceCell()

@property (nonatomic ,strong) UIView *topLine;

@property (nonatomic ,strong) NSMutableArray *titleArray;

@property (nonatomic ,strong) NSMutableArray *imageArray;

@property (nonatomic ,strong) UIView *bottomLine;

@end

@implementation GeneralServiceCell

static CGFloat const kGeneralServiceCellMargin = 15;    // 边距

static NSInteger const kGeneralServiceCellColumnCount = 4;    // 列

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    
    self.titleArray = [NSMutableArray arrayWithObjects:@"一键呼医",@"预约挂号",@"健康自测",@"专家咨询",@"中医频道",@"心理频道", nil];
//    self.userInteractionEnabled = NO;
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.topLine = [[UIView alloc]init];
    self.topLine.backgroundColor = Bsky_UIColorFromRGB(0xededed);
    [self.contentView addSubview:self.topLine];
    
    self.bottomLine = [[UIView alloc]init];
    self.bottomLine.backgroundColor = Bsky_UIColorFromRGB(0xededed);
    [self.contentView addSubview:self.bottomLine];
    
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.equalTo(@0.5);
    }];
    
    NSInteger width = (Bsky_SCREEN_WIDTH - 2*kGeneralServiceCellMargin)/kGeneralServiceCellColumnCount;
    
    for (int i = 0; i<self.titleArray.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageWithColor:Bsky_UIColorFromRGBA(0xededed,1) size:CGSizeMake(1, 1)] forState:UIControlStateHighlighted];
        [self.contentView addSubview:btn];
        btn.tag = 1000 + i;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"ico%d",i+1]];
        imageView.userInteractionEnabled = NO;
        [imageView sizeToFit];
        [btn addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.centerX.equalTo(btn);
        }];
        UILabel *label = [[UILabel alloc]init];
        label.textColor = Bsky_UIColorFromRGB(0x333333);
        label.font = [UIFont systemFontOfSize:13];
        label.text = self.titleArray[i];
        [label sizeToFit];
        [btn addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageView.mas_bottom).offset(3);
            make.centerX.bottom.equalTo(btn);
        }];
        
        NSInteger row = i/kGeneralServiceCellColumnCount;
        NSInteger height = imageView.height+label.height+3;
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView.mas_left).offset(kGeneralServiceCellMargin + width*(i%kGeneralServiceCellColumnCount));
        make.top.equalTo(self.contentView.mas_top).offset(kGeneralServiceCellMargin*(row+1)+height*row);
            make.width.equalTo(@(width));
            make.height.equalTo(@(height));
        }];
        if (i == self.titleArray.count -1) {
            [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(btn.mas_bottom).offset(kGeneralServiceCellMargin);
                make.bottom.left.right.equalTo(self.contentView);
                make.height.equalTo(@0.5);
            }];
        }
    }
}

- (void)clickBtn:(UIButton *)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:HomeSeriveNotificaton object:sender];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
