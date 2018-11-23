//
//  ImmediatelySignedCell.m
//  BskyResidents
//
//  Created by 何雷 on 2017/9/29.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "ImmediatelySignedCell.h"

@interface ImmediatelySignedCell()

@property (weak, nonatomic) IBOutlet UIImageView *signedImageview;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *signBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelLeftConstraint;

@end

@implementation ImmediatelySignedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.signBtn setCornerRadius:self.signBtn.height/2];
    [self.signedImageview setCornerRadius:10];
    self.signedImageview.hidden = YES;
    self.type = FamilyDoctorSignTypeError;
    [self.signBtn addTarget:self action:@selector(signBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setType:(FamilyDoctorSignType)type
{
    _type = type;
    UIColor *bgColor = nil;
    UIColor *shadowColor = nil;
    switch (_type) {
        case FamilyDoctorSignTypeSuccess:
        {
            self.signedImageview.hidden = NO;
            self.titleLabel.text = @"免费签约服务";
            [self.signBtn setTitle:@"了解详情" forState:UIControlStateNormal];
            self.titleLabelLeftConstraint.constant = 15+60+20;
            bgColor = Bsky_UIColorFromRGB(0x4aaaf4);
            shadowColor = Bsky_UIColorFromRGB(0x54a1e9);
        }
            break;
        case FamilyDoctorSignTypeSubmitted:
        {
            self.signedImageview.hidden = YES;
            self.titleLabel.text = @"家庭医生签约申请";
            self.contentLabel.text = @"签约家庭医生，做您和您家庭的健康守门人！";
            [self.signBtn setTitle:@"申请中" forState:UIControlStateNormal];
            self.titleLabelLeftConstraint.constant = 15;
            bgColor = Bsky_UIColorFromRGB(0xcccccc);
            shadowColor = Bsky_UIColorFromRGB(0x999999);
        }
            break;
            
        default:
        {
            self.signedImageview.hidden = YES;
            self.titleLabel.text = @"家庭医生签约申请";
            self.contentLabel.text = @"签约家庭医生，做您和您家庭的健康守门人！";
            [self.signBtn setTitle:@"立即签约" forState:UIControlStateNormal];
            self.titleLabelLeftConstraint.constant = 15;
            bgColor = Bsky_UIColorFromRGB(0xff9d00);
            shadowColor = Bsky_UIColorFromRGB(0xff9d00);
        }
            break;
    }
    [self.signBtn setBackgroundColor:bgColor];
    [self.signBtn setCornerShadowColor:shadowColor opacity:0.5 offset:CGSizeZero blurRadius:3];
}
- (void)signBtnPressed:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(immediatelySignedCellBtnClick:)]) {
        [self.delegate immediatelySignedCellBtnClick:self];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
