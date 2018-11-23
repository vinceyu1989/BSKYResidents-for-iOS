//
//  ChildrenCardListCell.h
//  BskyResidents
//
//  Created by vince on 2018/9/17.
//  Copyright © 2018年 罗林轩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChildrenListModel.h"

typedef void(^EditAction)(ChildrenListModel *model);

@interface ChildrenCardListCell : UITableViewCell
@property (nonatomic ,strong) ChildrenListModel *model;
@property (nonatomic ,copy) EditAction aciton;
@end

