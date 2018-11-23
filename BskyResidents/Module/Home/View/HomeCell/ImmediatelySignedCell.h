//
//  ImmediatelySignedCell.h
//  BskyResidents
//
//  Created by 何雷 on 2017/9/29.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImmediatelySignedCell;

@protocol ImmediatelySignedCellDelegate <NSObject>

- (void)immediatelySignedCellBtnClick:(ImmediatelySignedCell *)cell;  // 点击按钮

@end

@interface ImmediatelySignedCell : UITableViewCell

@property (nonatomic ,assign) FamilyDoctorSignType type;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (nonatomic ,weak) id<ImmediatelySignedCellDelegate> delegate;

@end
