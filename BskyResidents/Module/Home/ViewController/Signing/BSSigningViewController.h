//
//  BSSigningViewController.h
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/10.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSSigningViewController : UIViewController

@property (nonatomic, copy) void (^signCompleteBlock)();

@end
