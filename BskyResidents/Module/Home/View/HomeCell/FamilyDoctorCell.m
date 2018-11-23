//
//  FamilyDoctorCell.m
//  BskyResidents
//
//  Created by 何雷 on 2017/10/9.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "FamilyDoctorCell.h"

@interface FamilyDoctorCell()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagFirstLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagSecondLabel;
@property (weak, nonatomic) IBOutlet UIButton *functionalFirstBtn;
@property (weak, nonatomic) IBOutlet UIButton *functionalSecondBtn;


@end

@implementation FamilyDoctorCell


- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}
- (void)initView
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.avatarImageView setCornerRadius:10];
    [self.functionalFirstBtn setTitleColor:[UIColor colorWithHexString:@"4e7dd3"] forState:UIControlStateSelected];
    [self.functionalSecondBtn setTitleColor:[UIColor colorWithHexString:@"4e7dd3"]  forState:UIControlStateSelected];
    
    self.tagFirstLabel.layer.borderColor = Bsky_UIColorFromRGB(0x27d08e).CGColor;
    self.tagFirstLabel.layer.borderWidth = 0.5;
    [self.tagFirstLabel setCornerRadius:3];
    
    self.tagSecondLabel.layer.borderColor = Bsky_UIColorFromRGB(0x27d08e).CGColor;
    self.tagSecondLabel.layer.borderWidth = 0.5;
    [self.tagSecondLabel setCornerRadius:3];
    
    //对avatarImageView添加点击响应
    UITapGestureRecognizer *sigleTapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(avatarTapGesture)];
    sigleTapRecognizer.numberOfTapsRequired = 1;
    [self.avatarImageView addGestureRecognizer:sigleTapRecognizer];
    
}
- (void)setType:(FamilyDoctorCellType)type
{
    _type = type;
    self.tagFirstLabel.text = nil;
    self.tagSecondLabel.text = nil;
    self.functionalFirstBtn.selected = YES;
    self.functionalSecondBtn.selected = YES;
    switch (_type) {
        case FamilyDoctorCellTypeDoctor:
        {
            self.avatarImageView.image = [UIImage imageNamed:@"doctor_icon"];
            self.nameLabel.text = @"家庭医生";
            [self.functionalFirstBtn setImage:[UIImage imageNamed:@"signTeam_icon"] forState:UIControlStateNormal];
            [self.functionalFirstBtn setTitle:@"签约团队" forState:UIControlStateNormal];
            [self.functionalSecondBtn setImage:[UIImage imageNamed:@"consultInquiry_icon"] forState:UIControlStateNormal];
            [self.functionalSecondBtn setTitle:@"问诊咨询" forState:UIControlStateNormal];
        }
            break;
            
        default:
        {
            self.avatarImageView.image = [UIImage imageNamed:@"community_icon"];
            self.nameLabel.text = @"社区医院";
            [self.functionalFirstBtn setImage:[UIImage imageNamed:@"communityNoti_icon"] forState:UIControlStateNormal];
            [self.functionalFirstBtn setTitle:@"社区通知" forState:UIControlStateNormal];
            [self.functionalSecondBtn setImage:[UIImage imageNamed:@"feedback_icon"] forState:UIControlStateNormal];
            [self.functionalSecondBtn setTitle:@"意见反馈" forState:UIControlStateNormal];
        }
            break;
    }
    
}
- (void)setMemberModel:(SignTeamMemberModel *)memberModel
{
    _memberModel = memberModel;
    if (!memberModel) {
        return;
    }
    UIImage *decodedImage = [UIImage imageWithBase64Str:_memberModel.photo];
    if (decodedImage) {
        self.avatarImageView.image = decodedImage;
    }
    self.nameLabel.text = _memberModel.memberName;
    self.functionalFirstBtn.selected = !(_memberModel.teamMemberId.length > 0);
    self.functionalSecondBtn.selected = !(_memberModel.isExist.integerValue == 1);
    if (_memberModel.duty && _memberModel.duty.length > 0) {
        self.tagFirstLabel.text = [NSString stringWithFormat:@" %@ ", _memberModel.duty];
    }
    if (_memberModel.professional && _memberModel.professional.length > 0) {
        self.tagSecondLabel.text = [NSString stringWithFormat:@" %@ ", _memberModel.professional];
    }
}
- (void)setTeamModel:(SignTeamModel *)teamModel
{
        _teamModel = teamModel;
    if (!teamModel) {
        return;
    }
    self.functionalFirstBtn.selected = YES;
    self.functionalSecondBtn.selected = YES;
    //    self.avatarImageView.image = [UIImage imageNamed:@"doctor_icon"];
    if (_teamModel.team.orgName && _teamModel.team.orgName.length > 0) {
        self.nameLabel.text = _teamModel.team.orgName;
    }
    self.functionalSecondBtn.enabled = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
#pragma mark --- click

- (void)avatarTapGesture
{
    if (!self.memberModel) {
        [UIView makeToast:@"您还没有申请签约家庭医生哦!"];
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(familyDoctorCellAvatarImageClick:)]) {
        
        [self.delegate familyDoctorCellAvatarImageClick:self];
        
    }
}
- (IBAction)functionalFirstBtnPressed:(UIButton *)sender {
    if (sender.selected) {
        if (self.type == FamilyDoctorCellTypeDoctor) {
            [UIView makeToast:@"您还没有申请签约家庭医生哦!"];
        }else{
            [UIView makeToast:@"抱歉,功能尚未开放"];
        }
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(familyDoctorCellFunctionalFirstBtnClick:)]) {
        [self.delegate familyDoctorCellFunctionalFirstBtnClick:self];
    }
}
- (IBAction)functionalSecondBtnPressed:(UIButton *)sender {
    if (sender.selected) {
        if (self.type == FamilyDoctorCellTypeDoctor) {
            if (_memberModel.isExist.integerValue != 1 && _memberModel.teamMemberId.length > 0) {
                [UIView makeToast:@"该医生尚未开通咨询服务，请咨询其他医生"];
            }else{
                [UIView makeToast:@"您还没有申请签约家庭医生哦!"];
            }
        }else{
        [UIView makeToast:@"抱歉,功能尚未开放"];
        }
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(familyDoctorCellFunctionalSecondBtnClick:)]) {
        
        [self.delegate familyDoctorCellFunctionalSecondBtnClick:self];
        
    }
}

@end
