//
//  AddressListCell.h
//  BskyResidents
//
//  Created by 何雷 on 2017/10/20.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSAddressModel.h"

@class AddressListCell;

@protocol AddressListCellDelegate <NSObject>

- (void)addressListCell:(AddressListCell *)cell defaultBtnClick:(BOOL)isDefault;  // 默认

- (void)addressListCellEditBtnClick:(AddressListCell *)cell;  // 编辑

- (void)addressListCellDeleteBtnClick:(AddressListCell *)cell;  // 删除

@end


@interface AddressListCell : UITableViewCell

@property (nonatomic ,weak) id<AddressListCellDelegate> delegate;

@property (nonatomic ,strong) BSAddressModel *model;

@end
