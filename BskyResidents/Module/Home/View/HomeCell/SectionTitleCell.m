//
//  SectionTitleCell.m
//  BskyResidents
//
//  Created by 何雷 on 2017/10/9.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "SectionTitleCell.h"

@implementation SectionTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
