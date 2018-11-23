//
//  MainTabBar.m
//  BskyResidents
//
//  Created by 何雷 on 2017/10/10.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "MainTabBar.h"
#import <objc/runtime.h>
#import "RadarView.h"

@interface MainTabBar ()

@property (nonatomic, strong) UIButton *showBtn;

@property (nonatomic ,strong) UIView *hideView;

@property (nonatomic, strong) UIImageView *roundImageView;

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) RadarView * radarView;

@end

@implementation MainTabBar

static CGFloat const kMainTabBarBorderWidth = 10.f;

//static CGFloat const kMainTabBarShowBtnWidth = 44.f;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        self.backgroundColor = Bsky_COLOR_RGB(255, 255, 255);
        [self setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(1,1)]];
        [self setShadowImage:[UIImage imageWithColor:Bsky_UIColorFromRGB(0xcccccc) size:CGSizeMake(1,1)]];
        
        self.showBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.showBtn.backgroundColor = [UIColor whiteColor];
        [self.showBtn addTarget:self action:@selector(plusBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        self.showBtn.layer.borderColor = Bsky_UIColorFromRGB(0xcccccc).CGColor;
        self.showBtn.layer.borderWidth = 1.0;
        [self addSubview:self.showBtn];
        
        self.hideView = [[UIView alloc]init];
        self.hideView.backgroundColor = [UIColor whiteColor];
        
        self.roundImageView = [[UIImageView alloc]init];
        self.roundImageView.image = [UIImage imageNamed:@"round_tab"];
        self.roundImageView.userInteractionEnabled = YES;
        [self.roundImageView sizeToFit];
        
        self.label = [[UILabel alloc]init];
        self.label.text = @"健康卡";
        self.label.textColor = Bsky_UIColorFromRGB(0xffffff);
        self.label.font = [UIFont systemFontOfSize:11];
        [self.label sizeToFit];
        [self.roundImageView addSubview:self.label];
        
        CGFloat width = self.roundImageView.height-7-5-self.label.height-7;
        self.radarView = [[RadarView alloc] initWithFrame:CGRectMake(0, 0,width, width)];
        [self.roundImageView addSubview:self.radarView];
//        [self.radarView radarScan];

        
        self.showBtn.frame = CGRectMake(0, 0, self.roundImageView.width+kMainTabBarBorderWidth, self.roundImageView.width+kMainTabBarBorderWidth);
        [self.showBtn setCornerRadius:self.showBtn.width/2];
        self.showBtn.center = CGPointMake(self.center.x, self.height - self.showBtn.height/2);
        self.hideView.frame =CGRectMake(self.showBtn.left-1, 0, self.showBtn.width+2, Bsky_TAB_BAR_HEIGHT);
        self.roundImageView.center = self.showBtn.center;
        self.label.center = CGPointMake(self.roundImageView.width/2, self.roundImageView.height-7-self.label.height/2);
        self.radarView.center = CGPointMake(self.roundImageView.width/2, 7+self.radarView.height/2);
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //系统自带的按钮类型是UITabBarButton，找出这些类型的按钮，然后重新排布位置，空出中间的位置
    Class class = NSClassFromString(@"UITabBarButton");
    
    int btnIndex = 0;
    for (UIView *btn in self.subviews) {//遍历tabbar的子控件
        if ([btn isKindOfClass:class]) {//如果是系统的UITabBarButton，那么就调整子控件位置，空出中间位置
            //每一个按钮的宽度==tabbar的三分之一
            btn.width = self.width / 5;
            
            btn.x = btn.width * btnIndex;
            
            btnIndex++;
            //如果是索引是2(从0开始的)，直接让索引++，目的就是让消息按钮的位置向右移动，空出来发布按钮的位置
            if (btnIndex == 2) {
                btnIndex++;
            }
        }
    }
    [self bringSubviewToFront:self.showBtn];
    [self insertSubview:self.hideView aboveSubview:self.showBtn];
    [self insertSubview:self.roundImageView aboveSubview:self.hideView];
}

//点击了发布按钮
- (void)plusBtnDidClick
{
    //如果tabbar的代理实现了对应的代理方法，那么就调用代理的该方法
    if ([self.delegate respondsToSelector:@selector(tabBarShowBtnClick:)]) {
        [self.myDelegate tabBarShowBtnClick:self];
    }
    
}
//重写hitTest方法，去监听发布按钮的点击，目的是为了让凸出的部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    //这一个判断是关键，不判断的话push到其他页面，点击发布按钮的位置也是会有反应的，这样就不好了
    //self.isHidden == NO 说明当前页面是有tabbar的，那么肯定是在导航控制器的根控制器页面
    //在导航控制器根控制器页面，那么我们就需要判断手指点击的位置是否在发布按钮身上
    //是的话让发布按钮自己处理点击事件，不是的话让系统去处理点击事件就可以了
    if (self.isHidden == NO) {
        
        //将当前tabbar的触摸点转换坐标系，转换到发布按钮的身上，生成一个新的点
        CGPoint newP = [self convertPoint:point toView:self.showBtn];
        
        //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
        if ( [self.showBtn pointInside:newP withEvent:event]) {
            return self.showBtn;
        }else{//如果点不在发布按钮身上，直接让系统处理就可以了
            
            return [super hitTest:point withEvent:event];
        }
    }
    else {//tabbar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
        return [super hitTest:point withEvent:event];
    }
}

@end
