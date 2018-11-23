//
//  BSSessionListCell.m
//  BSKYDoctorPro
//
//  Created by LinfengYU on 2017/8/22.
//  Copyright © 2017年 ky. All rights reserved.
//

#import "BSMessageCell.h"

@interface BSMessageCell ()

@property (nonatomic, strong) BSNewsCategory* category;

@end

@implementation BSMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
    self.selectedBackgroundView.backgroundColor = Bsky_UIColorFromRGBA(0xededed,1);
    
    UIImage* image = [UIImage imageNamed:@"msg_system"];
    self.avatarImageView.image = [image yy_imageByRoundCornerRadius:5.f];
    
    // for test
    self.avatarImageView.badge.badgeValue = 16;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)bindData:(id)data {
    _category = data;
    
    if ([data isKindOfClass:[BSNewsCategory class]]) {
        BSNewsCategory* category = (BSNewsCategory*)data;
        
        if ([category.type isEqualToString:@"01007001"]) {
            self.nameLabel.text = @"服务消息";
            self.avatarImageView.image = [UIImage imageNamed:@"msg_service"];
        }else if ([category.type isEqualToString:@"01007002"]) {
            self.nameLabel.text = @"用药提醒";
            self.avatarImageView.image = [UIImage imageNamed:@"msg_drug"];
        }else if ([category.type isEqualToString:@"01007003"]) {
            self.nameLabel.text = @"预警值提醒";
            self.avatarImageView.image = [UIImage imageNamed:@"msg_warning"];
        }
        
        self.contentLabel.text = category.newsContent;
        self.dateTimeLabel.text = category.publishDate;
        self.avatarImageView.badge.badgeValue = category.total;
    }else if ([data isKindOfClass:[NIMRecentSession class]]) {
        NIMRecentSession* message = (NIMRecentSession*)data;
        if (message.session.sessionType == NIMSessionTypeTeam) {
            NIMTeam *team = [[NIMSDK sharedSDK].teamManager teamById:message.session.sessionId];
            self.nameLabel.text = team.teamName;
            [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:team.avatarUrl] placeholderImage:[UIImage imageNamed:@"msg_doctor"]];
        }
        else
        {
            NIMUser *user = [[NIMSDK sharedSDK].userManager userInfo:message.session.sessionId];
            self.nameLabel.text = user.userInfo.nickName;
            [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:user.userInfo.avatarUrl] placeholderImage:[UIImage imageNamed:@"msg_doctor"]];
        }
        self.contentLabel.text = message.lastMessage.text;
        NSDate* date = [NSDate dateWithTimeIntervalSince1970:message.lastMessage.timestamp];
        self.dateTimeLabel.text = [NSString convertNewsTime:date];
        self.avatarImageView.badge.badgeValue = message.unreadCount;
    }
}

@end
