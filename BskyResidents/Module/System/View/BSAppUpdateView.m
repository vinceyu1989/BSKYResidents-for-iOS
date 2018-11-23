//
//  BSAppUpdateView.m
//  BSKYDoctorPro
//
//  Created by LinfengYU on 2017/9/22.
//  Copyright © 2017年 ky. All rights reserved.
//
#import "BSAppUpdateView.h"

@interface BSAppUpdateView ()

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *infoLabel;
@property (nonatomic, retain) UIButton *updateButton;
@property (nonatomic, retain) UIButton *closeButton;
@property (copy, nonatomic) NSString *downloadUrl;//下载地址

@end

@implementation BSAppUpdateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBA(0, 0, 0, 0.5);
        
        self.imageView = ({
            UIImageView* imageView = [UIImageView new];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.image = [UIImage imageNamed:@"update"];
            [self addSubview:imageView];
            
            imageView;
        });
        
        self.infoLabel = ({
            UILabel* label = [UILabel new];
            label.numberOfLines = 0;
            label.font = [UIFont systemFontOfSize:15];
            label.textColor = Bsky_UIColorFromRGBA(0x666666,1);
            [self addSubview:label];
            label;
        });
        
        self.updateButton = ({
            UIButton* button = [UIButton new];
            [button setTitle:@"立即更新" forState:UIControlStateNormal];
            [button setTitleColor:Bsky_UIColorFromRGBA(0xffffff,1) forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            [button setBackgroundColor:Bsky_UIColorFromRGBA(0xff9000,1)];
            button.layer.cornerRadius = 20;
            [button addTarget:self action:@selector(onUpdate:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            button;
        });
        
        self.closeButton = ({
            UIButton* button = [UIButton new];
            [button setImage:[UIImage imageNamed:@"call_close_icon"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(onClose:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            button;
        });
        
        [self setupFrame];
    }
    
    return self;
}

- (void)setInfo:(NSString *)info {
    _info = info;
    
    self.infoLabel.text = info;
}

- (void)setMandatoryUpdate:(BOOL)mandatoryUpdate {
    _mandatoryUpdate = mandatoryUpdate;
    
    if (mandatoryUpdate) {
        self.closeButton.hidden = YES;
    }else {
        self.closeButton.hidden = NO;
    }
}

#pragma mark -
- (void)setupFrame {
    [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-50);
        make.width.equalTo(@315);
        make.height.equalTo(@400);
    }];
    [self.infoLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_top).offset(225);
        make.left.equalTo(self.imageView.mas_left).offset(40);
        make.right.equalTo(self.imageView.mas_right).offset(-40);
    }];
    [self.updateButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.centerX.equalTo(self);
        make.width.equalTo(self.infoLabel).offset(10);
        make.bottom.equalTo(self.imageView.mas_bottom).offset(-15);
    }];
    [self.closeButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.imageView.mas_bottom).offset(30);
        make.width.and.height.equalTo(@27);
    }];
}

+ (BSAppUpdateView*)showInView:(UIView*)view animated:(BOOL)animated info:(NSString*)info mandatoryUpdate:(BOOL)mandatoryUpdate downloadUrl:(NSString *)downloadUrl delegate:(id<BSAppUpadteViewDelegate>)delegate{
    BSAppUpdateView* updateView = [[BSAppUpdateView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
    updateView.info = info;
    updateView.mandatoryUpdate = mandatoryUpdate;
    updateView.downloadUrl = downloadUrl;
    updateView.alpha = 0;
    updateView.delegate = delegate;
    [view addSubview:updateView];
    if (animated) {
        [UIView animateWithDuration:.3f animations:^{
            updateView.alpha = 1;
        } completion:^(BOOL finished) {
        }];
    }else {
        updateView.alpha = 1;
    }
   return updateView;
}

- (void)hide {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelUpdate)]) {
        [self.delegate cancelUpdate];
    }
    [UIView animateWithDuration:.3f animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - UI Actions 
- (void)onClose:(id)sender {
    [self hide];
}

- (void)onUpdate:(UIButton *)sender{
    NSString *appUrl = @"itms-apps://itunes.apple.com/cn/app/%E5%B7%B4%E8%9C%80%E5%BF%AB%E5%8C%BB/id1156036816?mt=8";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appUrl]];
}

@end
