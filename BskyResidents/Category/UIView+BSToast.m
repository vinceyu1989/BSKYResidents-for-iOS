//
//  UIView+BSToast.m
//  BSKYDoctorPro
//
//  Created by LinfengYU on 2017/8/18.
//  Copyright © 2017年 ky. All rights reserved.
//

#import "UIView+BSToast.h"
#import <Toast/UIView+Toast.h>

@implementation UIView (BSToast)

+ (void)makeToast:(NSString*)message {
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    
    CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
    
    style.messageColor = [UIColor whiteColor];
    style.backgroundColor = Bsky_COLOR_RGBA(0, 0, 0, .6);
    style.cornerRadius = 5;
    style.messageFont = [UIFont systemFontOfSize:14. weight:UIFontWeightRegular];
    style.messageAlignment = NSTextAlignmentCenter;
    
    [window hideToasts];
    [window makeToast:message
             duration:2.
             position:[NSValue valueWithCGPoint:CGPointMake(UIScreenWidth / 2., UIScreenHeight / 2. - 40)]
                style:style];
    
    [CSToastManager setSharedStyle:style];
    [CSToastManager setTapToDismissEnabled:YES];
    [CSToastManager setQueueEnabled:YES];}

@end
