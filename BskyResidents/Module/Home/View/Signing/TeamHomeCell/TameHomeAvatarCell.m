//
//  TameHomeAvatarCell.m
//  BskyResidents
//
//  Created by 何雷 on 2017/10/12.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "TameHomeAvatarCell.h"

@interface TameHomeAvatarCell()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *teamTagLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstTagLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondTagLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamLabel;



@end

@implementation TameHomeAvatarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.avatarImageView setCornerRadius:self.avatarImageView.height/2];
    [self.teamTagLabel setCornerRadius:2];
    
    self.firstTagLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    self.firstTagLabel.layer.borderWidth = 0.5;
    [self.firstTagLabel setCornerRadius:3];
    
    self.secondTagLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    self.secondTagLabel.layer.borderWidth = 0.5;
    [self.secondTagLabel setCornerRadius:3];
}

- (void)setMemberModel:(SignTeamMemberModel *)memberModel
{
    _memberModel = memberModel;
    UIImage *decodedImage = [UIImage imageWithBase64Str:_memberModel.photo];
    if (decodedImage) {
        self.avatarImageView.image = decodedImage;
    }
//    self.teamTagLabel.text = _memberModel.duty;
    self.nameLabel.text = _memberModel.memberName;
    if (_memberModel.professional && _memberModel.professional.length > 0) {
        self.firstTagLabel.text = [NSString stringWithFormat:@" %@ ",_memberModel.professional];
        self.secondTagLabel.text = [NSString stringWithFormat:@" %@ ",_memberModel.duty];
    }
    self.teamLabel.text = _memberModel.orgName;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
