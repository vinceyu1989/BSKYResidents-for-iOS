//
//  FamilyAccountCell.m
//  BskyResidents
//
//  Created by 何雷 on 2017/10/9.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "FamilyAccountCell.h"
@interface FamilyAccountCell()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;


@end

@implementation FamilyAccountCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.bgView setCornerRadius:10];
    [self.bgView setCornerShadowColor:Bsky_UIColorFromRGB(0x999999) opacity:0.2 offset:CGSizeZero blurRadius:3];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
