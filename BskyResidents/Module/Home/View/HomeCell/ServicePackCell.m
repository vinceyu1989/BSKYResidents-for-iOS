//
//  ServicePackCell.m
//  BskyResidents
//
//  Created by 何雷 on 2017/10/9.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "ServicePackCell.h"

@interface ServicePackCell()
@property (weak, nonatomic) IBOutlet UIView *firstItemView;
@property (weak, nonatomic) IBOutlet UIView *secondItemView;

#pragma mark - 左侧View
@property (weak, nonatomic) IBOutlet UIImageView *firstItemImage;//图片
@property (weak, nonatomic) IBOutlet UILabel *firstItemTitle;//标题
@property (weak, nonatomic) IBOutlet UILabel *firstItemCollectionNum;//收藏数
@property (weak, nonatomic) IBOutlet UILabel *firstBuyNum;//购买数
@property (weak, nonatomic) IBOutlet UILabel *firstItemSellingPrice;//售价
@property (weak, nonatomic) IBOutlet UILabel *firstServicePeople;//服务对象
@property (weak, nonatomic) IBOutlet UILabel *firstItemServiceMode;//服务方式
@property (weak, nonatomic) IBOutlet UILabel *firstItemServiceProduct;//服务提供方

#pragma mark - 右侧View
@property (weak, nonatomic) IBOutlet UILabel *secondItemTitle;//标题
@property (weak, nonatomic) IBOutlet UILabel *secondItemCollectionNum;//收藏数
@property (weak, nonatomic) IBOutlet UILabel *secondBuyNum;//购买数
@property (weak, nonatomic) IBOutlet UILabel *secondItemSellingPrice;//售价
@property (weak, nonatomic) IBOutlet UILabel *secondServicePeople;//服务对象
@property (weak, nonatomic) IBOutlet UILabel *secondItemServiceMode;//服务方式
@property (weak, nonatomic) IBOutlet UIImageView *secondItemImage;
@property (weak, nonatomic) IBOutlet UILabel *secondItemServiceProduct;//服务提供方

@end

@implementation ServicePackCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

- (void)setModel:(id)model{
    NSDictionary *data = model;
    _firstItemImage.image = [UIImage imageNamed:data[@"image"][0]];
    _secondItemImage.image = [UIImage imageNamed:data[@"image"][1]];
    _firstItemTitle.text = data[@"title"][0];
    _secondItemTitle.text = data[@"title"][1];
    _firstServicePeople.text = [NSString stringWithFormat:@"服务对象:%@",data[@"title"][0]];
    _secondServicePeople.text = [NSString stringWithFormat:@"服务对象:%@",data[@"title"][1]];
}

- (void)initView
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.height.equalTo(self.firstItemView.mas_height).offset(10);
    }];
    [self.firstItemView setCornerRadius:5];
    [self.firstItemView setCornerShadowColor:Bsky_UIColorFromRGB(0x333333) opacity:0.2 offset:CGSizeZero blurRadius:3];
    [self.secondItemView setCornerRadius:5];
    [self.secondItemView setCornerShadowColor:Bsky_UIColorFromRGB(0x333333) opacity:0.2 offset:CGSizeZero blurRadius:3];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
