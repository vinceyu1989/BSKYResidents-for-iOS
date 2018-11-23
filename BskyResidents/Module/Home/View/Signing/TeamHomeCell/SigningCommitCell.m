//
//  SigningCommitCell.m
//  BskyResidents
//
//  Created by 何雷 on 2017/10/13.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "SigningCommitCell.h"


@implementation SigningCommitCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.commitLabel = [[UILabel alloc]init];
        self.commitLabel.backgroundColor =Bsky_UIColorFromRGB(0x4e7dd3);
        self.commitLabel.textColor = [UIColor whiteColor];
        self.commitLabel.textAlignment = NSTextAlignmentCenter;
        self.commitLabel.text = @"提交绑定申请";
        self.commitLabel.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:self.commitLabel];
        [self.commitLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(Bsky_SCREEN_WIDTH));
            make.edges.equalTo(self.contentView);
            make.height.equalTo(@45);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
