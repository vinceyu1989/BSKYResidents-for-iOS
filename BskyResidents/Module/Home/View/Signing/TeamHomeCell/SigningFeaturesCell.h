//
//  SigningFeaturesCell.h
//  BskyResidents
//
//  Created by 何雷 on 2017/10/13.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SigningFeaturesCell : UITableViewCell

@property (nonatomic ,copy) void (^selectedIndex)(NSInteger index);

@property (nonatomic ,assign) BOOL isRegistered;   // 是否是注册医生

@end
