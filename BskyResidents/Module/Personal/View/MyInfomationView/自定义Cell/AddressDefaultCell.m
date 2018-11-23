//
//  AddressDefaultCell.m
//  BskyResidents
//
//  Created by 何雷 on 2017/10/20.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "AddressDefaultCell.h"

@implementation AddressDefaultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
