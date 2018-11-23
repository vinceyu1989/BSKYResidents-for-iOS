//
//  CallRadarIndicatorView.m
//  BskyResidents
//
//  Created by 何雷 on 2017/10/27.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "CallRadarIndicatorView.h"

@interface CallRadarIndicatorView()

@property (nonatomic ,strong) UIColor *themeColor;

@end

@implementation CallRadarIndicatorView

- (instancetype) initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.themeColor = Bsky_UIColorFromRGB(0x4e7dd3);
    }
    return self;
}

- (void) drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawArc:context];
}

//画大扇形
- (void) drawArc:(CGContextRef) context
{
    //将坐标轴移动到视图中心
    CGContextTranslateCTM(context, CGRectGetWidth(self.frame)/2.0, CGRectGetHeight(self.frame)/2.0);
    // 画中心圆点
    CGContextAddArc(context, 0, 0, 5, 0, 2*M_PI, 0); //添加一个圆
    CGContextSetFillColorWithColor(context, self.themeColor.CGColor);//填充颜色
    
    //设置扇形半径
    CGFloat radius = CGRectGetWidth(self.frame)/2.0;
    CGFloat single = M_PI / 180/2.0;//画图时，每次旋转的度数
    CGFloat colorAlpha = M_PI_2/90/4;
    CGFloat x = 0.0;
    for (int i = 0; i < 90 * 2; i ++) {
        
        //画小扇形
        CGContextMoveToPoint(context, 0, 0);
        CGContextAddArc(context, 0, 0, radius, 0, -single, 1);
        
        //设置填充颜色以及透明度
        x = x + colorAlpha;
        CGFloat alpha = sin(1-x);
        
        UIColor * color = Bsky_UIColorFromRGBA(0x4e7dd3, alpha);
        
        [color setFill];
        
        CGContextFillPath(context);
        [color setStroke];
        
        CGContextClosePath(context);
        CGContextDrawPath(context, kCGPathFillStroke); //绘制路径
        
        //逆时针旋转坐标轴
        CGContextRotateCTM(context, -single);
        
    }
    
}
- (void) start
{
    [self stop];
    [self setNeedsDisplay];
    CABasicAnimation * rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.toValue = @(2*M_PI);
    rotationAnimation.duration = 1.0;
    rotationAnimation.beginTime = 0.3;
    rotationAnimation.repeatCount = NSIntegerMax;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}
- (void) stop
{
    [self.layer removeAnimationForKey:@"rotationAnimation"];
}

@end
