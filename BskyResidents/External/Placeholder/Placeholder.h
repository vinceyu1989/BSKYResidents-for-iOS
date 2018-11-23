//
//  Placeholder.h
//  BskyResidents
//
//  Created by 罗林轩 on 2017/11/22.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Placeholder : UIView
+ (instancetype)showWithType:(placeholderState)placeholderState;
@property (weak, nonatomic) IBOutlet UILabel *content;
@end
