//
//  AddressListCell.m
//  BskyResidents
//
//  Created by 何雷 on 2017/10/20.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "AddressListCell.h"
@interface AddressListCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *morenBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;

@end

@implementation AddressListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.morenBtn setTitleColor:Bsky_UIColorFromRGB(0x4e7dd3) forState:UIControlStateSelected];
    [self.morenBtn setImage:[UIImage imageNamed:@"address_selected"] forState:UIControlStateSelected];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setModel:(BSAddressModel *)model
{
    _model = model;
    self.nameLabel.text = _model.contractName;
    self.phoneLabel.text = _model.mobileNo;
    self.addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@%@",_model.provinceName,_model.cityName,_model.properName,_model.areaName,_model.detailAddr];
    self.morenBtn.selected = _model.isAutoAddr.integerValue == 2 ? YES : NO;
}
- (IBAction)moreBtnPressed:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(addressListCell:defaultBtnClick:)]) {
        [self.delegate addressListCell:self defaultBtnClick:sender.selected];
    }
}

- (IBAction)editBtnPressed:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(addressListCellEditBtnClick:)]) {
        [self.delegate addressListCellEditBtnClick:self];
    }
}
- (IBAction)deleteBtnPressed:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(addressListCellDeleteBtnClick:)]) {
        [self.delegate addressListCellDeleteBtnClick:self];
    }
}

@end
