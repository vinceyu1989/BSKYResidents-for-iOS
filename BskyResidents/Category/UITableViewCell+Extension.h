//
//  UITableView+Extension.h
//  Bizaia
//
//  Created by mac on 2017/3/3.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell(Extension)

+ (UINib *)nib;

+ (NSString *)cellIdentifier;

+ (CGFloat)cellHeight;

@end
