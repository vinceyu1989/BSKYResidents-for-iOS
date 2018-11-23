//
//  AddressDetailTextInputCell.m
//  BSKYDoctorPro
//
//  Created by 何雷 on 2017/9/4.
//  Copyright © 2017年 ky. All rights reserved.
//

#import "AddressDetailTextInputCell.h"

@interface AddressDetailTextInputCell() <UITextFieldDelegate>

@end

@implementation AddressDetailTextInputCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.topLine.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
