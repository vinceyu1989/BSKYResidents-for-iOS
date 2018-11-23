//
//  LoginTextField.h
//  BSKYDoctorPro
//
//  Created by 何雷 on 2017/8/22.
//  Copyright © 2017年 ky. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TextFieldTapAcitonBlock)();
typedef void(^TextFieldEndEditBlock)(NSString *text);

@interface LoginTextField : UITextField

@property (nonatomic ,assign) NSInteger maxNum;    // 限制输入字数

/** textField 的点击回调 */
@property (nonatomic, copy) TextFieldTapAcitonBlock tapAcitonBlock;
/** textField 结束编辑的回调 */
@property (nonatomic, copy) TextFieldEndEditBlock endEditBlock;

@end
