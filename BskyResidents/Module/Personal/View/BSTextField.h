//
//  BRTextField.h
//  BRPickerViewDemo
//
//  Created by 任波 on 2017/8/11.
//  Copyright © 2017年 renb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BSTapAcitonBlock)();
typedef void(^BSEndEditBlock)(NSString *text);

@interface BSTextField : UITextField
/** textField 的点击回调 */
@property (nonatomic, copy) BSTapAcitonBlock tapAcitonBlock;
/** textField 结束编辑的回调 */
@property (nonatomic, copy) BSEndEditBlock endEditBlock;
@property (nonatomic ,strong) UIImageView *moreIcon;
@end
