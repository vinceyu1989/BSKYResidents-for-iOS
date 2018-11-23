//
//  BSSigningServiceCell.h
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/12.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSSigningServiceCell : UITableViewCell

@property (nonatomic, assign) BOOL expand;

@property (nonatomic, copy) void (^expandBlock)(BOOL expand);

- (void)bindData:(SignService*)data;

//是否展开
- (void)expand:(BOOL)isexpand;
@end
