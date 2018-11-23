//
//  AlertViewController.m
//  medicine
//
//  Created by limengqing on 16/8/22.
//  Copyright © 2016年 罗林轩. All rights reserved.
//

#import "AlertViewController.h"
#import "AppDelegate.h"
@interface AlertViewController ()

@end

@implementation AlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+ (void)alertWithTitle:(NSString *)title String:(NSString *)alertString viewController:(UIViewController *)viewController
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:alertString preferredStyle:UIAlertControllerStyleAlert];
    [viewController presentViewController:alertController animated:YES completion:^{
        
    }];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    
    [alertController addAction:action];
}


+ (void)alertWithTitle:(NSString *)title String:(NSString *)alertString actionTitleArray:(NSArray *)actionTitleArray viewController:(UIViewController *)viewController preferredStyle:(UIAlertControllerStyle)preferredStyle selectedBlock:(void (^)(NSInteger))selectedBlock{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:alertString preferredStyle:preferredStyle];
    [viewController presentViewController:alertController animated:YES completion:^{
        
    }];

    for (int i = 0; i < actionTitleArray.count; i ++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitleArray[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            selectedBlock(i);
        }];
        [alertController addAction:action];
    }
}

+ (void)alertWithTitle:(NSString *)title String:(NSString *)alertString textFiled:(void (^)(UITextField *))returnTextField  actionTitleArray:(NSArray *)actionTitleArray viewController:(UIViewController *)viewController selectedBlock:(void (^)(NSInteger))selectedBlock
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:alertString preferredStyle:UIAlertControllerStyleAlert];
  
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"点击输入";
        returnTextField(textField);
    }];
    
    for (int i = 0; i < actionTitleArray.count; i ++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitleArray[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            selectedBlock(i);
        }];
        [alertController addAction:action];
    }
    
    [viewController presentViewController:alertController animated:YES completion:^{
        
    }];
}

//获得所有变量
+ (NSArray *)getAllIvar:(id)object
{
    NSMutableArray *array = [NSMutableArray array];
    
    unsigned int count;
    Ivar *ivars = class_copyIvarList([object class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *keyChar = ivar_getName(ivar);
        NSString *keyStr = [NSString stringWithCString:keyChar encoding:NSUTF8StringEncoding];
        @try {
            id valueStr = [object valueForKey:keyStr];
            NSDictionary *dic = nil;
            if (valueStr) {
                dic = @{keyStr : valueStr};
            } else {
                dic = @{keyStr : @"值为nil"};
            }
            [array addObject:dic];
        }
        @catch (NSException *exception) {}
    }
    return [array copy];
}

+ (UIImage *)getImageFromView:(UIView *)view{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//获得所有属性
+ (NSArray *)getAllProperty:(id)object
{
    NSMutableArray *array = [NSMutableArray array];
    
    unsigned int count;
    objc_property_t *propertys = class_copyPropertyList([object class], &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = propertys[i];
        const char *nameChar = property_getName(property);
        NSString *nameStr = [NSString stringWithCString:nameChar encoding:NSUTF8StringEncoding];
        [array addObject:nameStr];
    }
    return [array copy];
}

 + (void)alertSheetWithTitle:(NSString *)title titleArray:(NSArray *)titleArray message:(NSString *)message viewController:(UIViewController *)viewController selectedIndex:(void (^)(NSInteger))selectedIndexBlock
{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i = 0; i < titleArray.count; i ++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:titleArray[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            selectedIndexBlock(i);
        }];
        [alertC addAction:action];
    }
    [alertC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [viewController presentViewController:alertC animated:YES completion:^{
        
    }];
}
@end
