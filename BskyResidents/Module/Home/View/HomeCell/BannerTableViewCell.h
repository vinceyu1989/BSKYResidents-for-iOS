//
//  BannerTableViewCell.h
//  BskyResidents
//
//  Created by 何雷 on 2017/9/29.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BannerTableViewCell : UITableViewCell
/** image数组 */
@property (nonatomic, copy) NSArray *imageArray;

- (void)setupData:(id)data;
@end
