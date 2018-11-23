//
//  ChildrenCardEditViewController.h
//  BskyResidents
//
//  Created by vince on 2018/9/17.
//  Copyright © 2018年 罗林轩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChildrenListModel.h"

typedef enum : NSUInteger {
    ChildrenCardTypeBirthId,
    ChildrenCardTypeCardId,
    ChildrenCardTypeNoPaper,
} ChildrenCardType;

@interface ChildrenCardEditViewController : UIViewController
@property (nonatomic ,strong) ChildrenListModel *model;
@property (nonatomic ,assign) ChildrenCardType type;
@end
