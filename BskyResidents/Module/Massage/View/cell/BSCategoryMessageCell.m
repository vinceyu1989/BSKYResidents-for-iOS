//
//  BSSystemMailCell.m
//  BSKYDoctorPro
//
//  Created by LinfengYU on 2017/9/13.
//  Copyright © 2017年 ky. All rights reserved.
//

#import "BSCategoryMessageCell.h"

@interface BSCategoryMessageCell ()

@property (weak, nonatomic) IBOutlet UIView *bkView;
@property (weak, nonatomic) IBOutlet UIImageView *tipImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (nonatomic, strong) BSNews* news;

@end

@implementation BSCategoryMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bkView.layer.cornerRadius = 10;
    self.bkView.layer.masksToBounds = YES;
    
    self.tipImageView.layer.cornerRadius = 10;
    self.tipImageView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)bindData:(BSNews*)data {
    _news = data;
    
    if ([data.newsTitleType isEqualToString:@"01009001"]) {
        self.titleLabel.text = @"系统消息";
        self.tipImageView.image = [UIImage imageNamed:@"msg_system"];
    }else if ([data.newsTitleType isEqualToString:@"01009002"]) {
        self.titleLabel.text = @"服务消息";
        self.tipImageView.image = [UIImage imageNamed:@"msg_service"];
    }else if ([data.newsTitleType isEqualToString:@"01009003"]) {
        self.titleLabel.text = @"订单消息";
        self.tipImageView.image = [UIImage imageNamed:@"msg_order"];
    }
    self.contentLabel.text = data.newsContent;
}

@end
