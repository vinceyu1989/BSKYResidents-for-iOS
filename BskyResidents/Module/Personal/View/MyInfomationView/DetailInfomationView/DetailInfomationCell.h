//
//  DetailInfomationCell.h
//  BskyResidents
//
//  Created by 罗林轩 on 2017/10/18.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailInfomationCell : UITableViewCell
@property (copy, nonatomic) NSString *title;//标题
@property (copy, nonatomic) NSString *content;//内容
@property (strong, nonatomic) UIImageView *headVeiw;
+ (DetailInfomationCell *)showWithModel:(id)model;
@end
