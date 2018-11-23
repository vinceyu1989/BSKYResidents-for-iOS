//
//  BSSigningServiceCell.m
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/12.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSSigningServiceCell.h"

@interface BSSigningServiceCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UIView *bkView;
@property (weak, nonatomic) IBOutlet UIButton *expandButton;

@property (nonatomic, strong) SignService* signService;

@end

@implementation BSSigningServiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    self.bkView.layer.cornerRadius = 5;
//    self.bkView.layer.masksToBounds = YES;
    self.expandButton.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);

    [self.expandButton setTitleColor:Bsky_UIColorFromRGBA(0x4e7dd3,1) forState:UIControlStateNormal];
    self.expandButton.tintColor = Bsky_UIColorFromRGBA(0x4e7dd3,1);
}

- (void)setExpand:(BOOL)expand{
    _expand = expand;
    if (_expand) {
        [self.expandButton setImage:[[UIImage imageNamed:@"(-收起"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        [self.expandButton setTitle:@"收起" forState:UIControlStateNormal];
    }else {
        self.bkView.layer.cornerRadius = 5;
        [self.expandButton setImage:[[UIImage imageNamed:@"(-展开"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        [self.expandButton setTitle:@"展开" forState:UIControlStateNormal];
    }
}

- (IBAction)onExpand:(id)sender {
    _expand = !_expand;
    self.bkView.layer.cornerRadius = 0;
    if (self.expandBlock) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.expandBlock(_expand);
        });
    }
}

- (void)bindData:(SignService*)data {
    _signService = data;
    
    self.titleLabel.text = data.name;
    self.dateLabel.text = [NSString stringWithFormat:@"有效期：%@ 至 %@", data.startTime, data.endTime];
    self.priceLabel.text = [NSString stringWithFormat:@"¥%.2f", data.fee];
    if ((NSInteger)data.fee == 0) {
        self.priceLabel.text = @"免费";
    }
}

@end
