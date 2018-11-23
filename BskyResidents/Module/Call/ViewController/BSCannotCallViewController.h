//
//  BSCannotCallViewController.h
//  BskyResidents
//
//  Created by LinfengYU on 2017/11/7.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSCannotCallViewController : UIViewController

@property (nonatomic, assign) FamilyDoctorSignType status;

@property (nonatomic, copy) void (^signCompleteBlock)();

@end

