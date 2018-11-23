//
//  BSServicePackCell.m
//  BskyResidents
//
//  Created by LinfengYU on 2017/11/10.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSServicePackCell.h"

@interface BSServicePackCell ()

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet BSInsetLabel *label3;

@end

@implementation BSServicePackCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    

    self.label3.backgroundColor = Bsky_UIColorFromRGBA(0xf3fbff,1);
//    self.label3.layer.cornerRadius = 3;
    self.label3.textInsets = UIEdgeInsetsMake(2.f, 5.f, 2.f, 5.f);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)bindData:(ServicePack*)data {
    self.label1.text = data.name;
    self.label2.text = data.remark;
    self.label3.text = data.freRemark;
    
    [self.label1 setLineSpace:8];
    [self.label2 setLineSpace:8];
    [self.label3 sizeToFit];
}

@end
