//
//  AlertViewController.h
//  medicine
//
//  Created by limengqing on 16/8/22.
//  Copyright © 2016年 罗林轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertViewController : UIAlertController
/**
 *  初始化方法
 *
 *  @param title          标题
 *  @param alertString    显示内容
 *  @param viewController 控制器
 */
+ (void)alertWithTitle:(NSString *)title String:(NSString *)alertString viewController:(UIViewController *)viewController;

+ (void)alertWithTitle:(NSString *)title String:(NSString *)alertString actionTitleArray:(NSArray *)actionTitleArray viewController:(UIViewController *)viewController preferredStyle:(UIAlertControllerStyle)preferredStyle selectedBlock:(void (^)(NSInteger selectedIndex))selectedBlock;

+ (void)alertWithTitle:(NSString *)title String:(NSString *)alertString textFiled:(void (^)(UITextField *textField))returnTextField actionTitleArray:(NSArray *)actionTitleArray viewController:(UIViewController *)viewController selectedBlock:(void (^)(NSInteger selectedIndex))selectedBlock;


/**
 选择器
 */
+ (void)alertSheetWithTitle:(NSString *)title titleArray:(NSArray *)titleArray message:(NSString *)message viewController:(UIViewController *)viewController selectedIndex:(void (^)(NSInteger selectedIndex))selectedIndexBlock;
@end
