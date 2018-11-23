//
//  BSFollowupListCell.m
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/16.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSFollowupListCell.h"

@interface BSFollowupListCell ()

@property (weak, nonatomic) IBOutlet UIView *bkView;
@property (nonatomic, strong) BSFollowup* followup;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *doctorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation BSFollowupListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.bkView.layer.cornerRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)bindData:(BSFollowup*)data {
    _followup = data;
    
    if ([data.followUpType isEqualToString:@"1"]) { // 高血压
        self.titleLabel.text = @"高血压随访";
        self.iconImageView.image = [UIImage imageNamed:@"followup_gxy"];
    }else if ([data.followUpType isEqualToString:@"2"]) {   // 糖尿病
        self.titleLabel.text = @"糖尿病随访";
        self.iconImageView.image = [UIImage imageNamed:@"followup_tnb"];
    }
    
    self.doctorNameLabel.text = data.doctorName;
    self.dateLabel.text = data.followUpDate;
}

@end
