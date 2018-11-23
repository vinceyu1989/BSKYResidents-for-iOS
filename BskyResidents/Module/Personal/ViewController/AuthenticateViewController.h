//
//  AuthenticateViewController.h
//  BskyResidents
//
//  Created by 何雷 on 2017/9/27.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthenticateViewController : UIViewController

@property (nonatomic, copy) void (^authCompleteBlock)(BOOL succeed);

@end

