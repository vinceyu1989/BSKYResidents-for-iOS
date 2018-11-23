//
//  AddressDetailVC.h
//  BskyResidents
//
//  Created by 何雷 on 2017/10/20.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSAddressModel.h"

@interface AddressDetailVC : UITableViewController

@property (nonatomic ,strong) BSAddressModel *upModel;

@property (nonatomic ,assign) BOOL isNeedAuto;   // 是否要显示默认选择栏

@end
