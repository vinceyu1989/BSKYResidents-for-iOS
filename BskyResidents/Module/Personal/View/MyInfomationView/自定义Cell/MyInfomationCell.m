//
//  MyInfomationCell.m
//  BskyResidents
//
//  Created by 罗林轩 on 2017/10/9.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "MyInfomationCell.h"
@interface MyInfomationCell()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIImageView *arrows;

@end
@implementation MyInfomationCell
- (void)setWithName:(NSString *)name icon:(NSString *)icon{
    _content.text = name;
    [_icon setImage:[UIImage imageNamed:icon]];
}
@end
