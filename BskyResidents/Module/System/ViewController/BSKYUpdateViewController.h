//
//  BSKYUpdateViewController.h
//  BskyResidents
//
//  Created by 罗林轩 on 2017/12/12.
//  Copyright © 2017年 罗林轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BSKYUpdateViewControllerDelegate<NSObject>
- (void)cancelUpdate;
@end

@interface BSKYUpdateViewController : UIViewController
@property (copy, nonatomic) NSString *info;
@property (assign, nonatomic) NSInteger mandatoryUpdate;
@property (copy, nonatomic) NSString *downloadUrl;

- (void)showUpdateView;
@end
