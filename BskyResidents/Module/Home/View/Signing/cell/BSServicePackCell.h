//
//  BSServicePackCell.h
//  BskyResidents
//
//  Created by LinfengYU on 2017/11/10.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSServicePackCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *bkView;

- (void)bindData:(ServicePack*)data;

@end
