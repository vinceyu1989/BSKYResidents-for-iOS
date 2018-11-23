//
//  ChildrenCardListCell.m
//  BskyResidents
//
//  Created by vince on 2018/9/17.
//  Copyright © 2018年 罗林轩. All rights reserved.
//

#import "ChildrenCardListCell.h"

@interface ChildrenCardListCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardLabel;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;

@end

@implementation ChildrenCardListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.layer.borderWidth = 0.5	;
    self.bgView.layer.borderColor = [UIColorFromRGB(0xc0ecb5) CGColor];
    self.bgView.backgroundColor = UIColorFromRGB(0xfbfff9);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)editAction:(id)sender {
    if (self.aciton) {
        self.aciton(self.model);
    }
}
- (void)setModel:(ChildrenListModel *)model{
    _model = model;
//    _model.idNo = @"1234567890";
//    _model.idType = @"08";
    self.nameLabel.text = self.model.name.length ? self.model.name : @"--";
    if ([self.model.idType containsString:@"01"]) {
        self.typeLabel.text = @"居民身份证";
        self.cardLabel.text = self.model.idNo.length ? [self.model.idNo secretStrFromIdentityCard] : @"--";
    }else if ([self.model.idType containsString:@"08"]) {
        self.typeLabel.text = @"出身证";
        self.cardLabel.text = self.model.idNo.length ? self.model.idNo : @"--";
    }else{
        self.typeLabel.text = @"--";
        self.cardLabel.text = self.model.idNo.length ? [self.model.idNo secretStrFromIdentityCard] : @"--";
    }
    
    if (self.model.idNo.length && [self.model.idType containsString:@"01"]) {
        self.editBtn.hidden = YES;
    }else{
        self.editBtn.hidden = NO;
    }
}
@end
