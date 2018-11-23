//
//  MyInfomationCell.h
//  BskyResidents
//
//  Created by 罗林轩 on 2017/10/9.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyInfomationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *topLine;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;
- (void)setWithName:(NSString *)name icon:(NSString *)icon;

@end
