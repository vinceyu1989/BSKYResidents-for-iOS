//
//  ArchivePickerTableViewCell.h
//  BSKYDoctorPro
//
//  Created by 快医科技 on 2018/1/2.
//  Copyright © 2018年 ky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSTextField.h"
#import "BSArchiveModel.h"

typedef  void(^ArchiveEndEditBlock)(id model);

@protocol ArchivePickerTableViewCellDelegate <NSObject>
- (void)pickAction:(id )model;
@end

@interface ArchivePickerTableViewCell : UITableViewCell
@property (nonatomic ,strong)BSArchiveModel *model;
@property (nonatomic ,copy) ArchiveEndEditBlock endBlock;
@property (nonatomic ,weak) id <ArchivePickerTableViewCellDelegate> delegate;
@end
