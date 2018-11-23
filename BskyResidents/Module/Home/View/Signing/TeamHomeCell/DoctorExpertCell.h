//
//  DoctorExpertCell.h
//  BskyResidents
//
//  Created by 何雷 on 2017/10/12.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoctorExpertCell : UITableViewCell

- (void)setDesString:(NSString *)desString  expansion:(BOOL) isExpansion;

@property (nonatomic ,copy) void(^expansion)(BOOL expansion);

@end
