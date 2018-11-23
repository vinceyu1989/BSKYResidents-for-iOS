//
//  UITableView+Extension.m
//  Bizaia
//
//  Created by mac on 2017/3/3.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "UITableViewCell+Extension.h"

@implementation UITableViewCell(Extension)

+ (UINib *)nib {
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}
+(NSString *)cellIdentifier
{
    return NSStringFromClass([self class]);
}
+(CGFloat)cellHeight
{
    return 0;
}


@end
