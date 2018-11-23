//
//  BSSigningServiceHeaderView.m
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/12.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSSigningServiceHeaderView.h"

@interface BSSigningServiceHeaderView()

@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* startDateLabel;
@property (nonatomic, strong) UILabel* endDateLabel;
@property (nonatomic, strong) UILabel* teamLabel;
@property (nonatomic, strong) UILabel* startDateValueLabel;
@property (nonatomic, strong) UILabel* endDateValueLabel;
@property (nonatomic, strong) UILabel* teamValueLabel;
@property (nonatomic, strong) UILabel* doctorLabel;
@property (nonatomic, strong) UILabel* doctorValueLabel;

@property (nonatomic, strong) UIImageView* signingImageView;
@property (nonatomic, strong) UIImageView* rightImageView;

@property (nonatomic, strong) UIButton* button;

@end

@implementation BSSigningServiceHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = Bsky_UIColorFromRGBA(0xffffff,1);
        self.titleLabel = ({
            UILabel* label = [UILabel new];
            label.font = [UIFont systemFontOfSize:15];
            label.textColor = Bsky_UIColorFromRGBA(0x333333,1);
            label.text = @"家庭医生签约合同";
            [self addSubview:label];
            
            label;
        });
        
        self.startDateLabel = ({
            UILabel* label = [UILabel new];
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = Bsky_UIColorFromRGBA(0x808080,1);
            label.text = @"起始日期：";
            [self addSubview:label];

            label;
        });
        
        self.endDateLabel = ({
            UILabel* label = [UILabel new];
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = Bsky_UIColorFromRGBA(0x808080,1);
            label.text = @"截止日期：";
            [self addSubview:label];

            label;
        });

        self.teamLabel = ({
            UILabel* label = [UILabel new];
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = Bsky_UIColorFromRGBA(0x808080,1);
            label.text = @"签约团队：";
            [self addSubview:label];

            label;
        });
        self.doctorLabel = ({
            UILabel* label = [UILabel new];
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = Bsky_UIColorFromRGBA(0x808080,1);
            label.text = @"责任医生：";
            label.hidden = YES;//暂时隐藏
            [self addSubview:label];

            label;
        });
        
        self.startDateValueLabel = ({
            UILabel* label = [UILabel new];
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = Bsky_UIColorFromRGBA(0x333333,1);
            label.text = @"2017-08-01";
            [self addSubview:label];

            label;
        });
        
        self.endDateValueLabel = ({
            UILabel* label = [UILabel new];
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = Bsky_UIColorFromRGBA(0x333333,1);
            label.text = @"2018-08-01";
            [self addSubview:label];

            label;
        });
        
        self.teamValueLabel = ({
            UILabel* label = [UILabel new];
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = Bsky_UIColorFromRGBA(0x333333,1);
            label.text = @"苏坡社区慢病管理团队";
            [self addSubview:label];

            label;
        });
        self.doctorValueLabel = ({
            UILabel* label = [UILabel new];
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = Bsky_UIColorFromRGBA(0x333333,1);
            label.text = @"张晓华";
            [self addSubview:label];
            
            label;
        });
        
        self.signingImageView = ({
            UIImageView* imageView = [UIImageView new];
            imageView.contentMode = UIViewContentModeCenter;
            imageView.image = [UIImage imageNamed:@"signing"];
            [self addSubview:imageView];
            
            imageView;
        });
        
        self.rightImageView = ({
            UIImageView* imageView = [UIImageView new];
            imageView.contentMode = UIViewContentModeCenter;
            imageView.image = [UIImage imageNamed:@"more_icon"];
            [self addSubview:imageView];

            imageView;
        });
        
        self.button = ({
            UIButton* button = [UIButton new];
            [button addTarget:self action:@selector(onButton:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            
            button;
        });
        
        [self setupFrame];
    }
    
    return self;
}

#pragma mark -

- (void)setupFrame {
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(12);
        make.left.equalTo(self.mas_left).offset(25);
    }];
    [self.startDateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(12);
    }];
    [self.endDateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.startDateLabel.mas_bottom).offset(7);
    }];
    [self.teamLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.endDateLabel.mas_bottom).offset(7);
    }];
    [self.doctorLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.teamLabel.mas_bottom).offset(7);
    }];
    [self.startDateValueLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.startDateLabel.mas_right).offset(5);
        make.centerY.equalTo(self.startDateLabel);
    }];
    [self.endDateValueLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.endDateLabel.mas_right).offset(5);
        make.centerY.equalTo(self.endDateLabel);
    }];
    [self.teamValueLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.teamLabel.mas_right).offset(5);
        make.centerY.equalTo(self.teamLabel);
    }];
    [self.doctorValueLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.doctorLabel.mas_right).offset(5);
        make.centerY.equalTo(self.doctorLabel);
    }];
    [self.signingImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.mas_right).offset(-50);
    }];
    [self.rightImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-10);
        
    }];
    [self.button mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark -

- (void)onButton:(id)sender {
    if (self.touchBlock) {
        self.touchBlock();
    }
}

- (void)bindData:(SignInfoModel*)data {
    SignDetailInfo* info = data.signInfo;
    
    self.startDateValueLabel.text = info.startTime;
    self.endDateValueLabel.text = info.endTime;
    self.teamValueLabel.text = info.teamName;
    self.doctorValueLabel.text = info.doctorName;
}

@end
