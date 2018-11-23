//
//  BottomBar.m
//  BskyResidents
//
//  Created by 罗林轩 on 2017/10/11.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BottomBar.h"
#import "TopImgBottomTextBtn.h"
#import "MyInfomationHeader.h"
#import "MyInfomationNotifier.h"
static CGFloat const bottomBarHeight = 60;

@interface BottomBar()

@end;

@implementation BottomBar
+ (BottomBar *)showWithNames:(NSArray *)names icons:(NSArray *)icons{
    BottomBar *bottomBar = [[BottomBar alloc] initWithFrame:CGRectMake(0, 140, CGRectGetWidth([UIScreen mainScreen].bounds), bottomBarHeight)];
    bottomBar.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.1];
    [bottomBar setBtnsNames:names icons:icons];
   return bottomBar;
}

- (void)setBtnsNames:(NSArray *)names icons:(NSArray *)icons{
     CGFloat const btnW = (CGRectGetWidth([UIScreen mainScreen].bounds) / names.count);
    for (int i = 0; i < names.count; i ++) {
        TopImgBottomTextBtn *btn = [TopImgBottomTextBtn buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:icons[i]] forState:UIControlStateNormal];
        [btn setTitle:names[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.frame = CGRectMake(i * btnW, 0, btnW, 60);
        btn.tag = 1000 + i;
        btn.adjustsImageWhenHighlighted = NO;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}

- (void)clickBtn:(UIButton *)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:clickBtnNotifier object:sender];
}
@end
