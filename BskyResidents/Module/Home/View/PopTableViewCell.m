//
//  PopTableViewCell.m
//  BskyResidents
//
//  Created by 何雷 on 2017/10/11.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "PopTableViewCell.h"

@implementation PopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.height.equalTo(@45);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
