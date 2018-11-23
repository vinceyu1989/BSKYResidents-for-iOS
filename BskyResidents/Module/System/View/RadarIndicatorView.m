//
//  RadarIndicatorView.m
//  雷达扫描动画
//
//  Created by Apple on 16/9/22.
//  Copyright © 2016年 xuqigang. All rights reserved.
//

#import "RadarIndicatorView.h"
@interface RadarIndicatorView()<CAAnimationDelegate>

@end

@implementation RadarIndicatorView

- (instancetype) initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
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
    CGContextAddArc(context, 0, 0, 1, 0, 2*M_PI, 0); //添加一个圆
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);//填充颜色
    
    //设置扇形半径
    CGFloat radius = CGRectGetWidth(self.frame)/2.0;
    CGFloat single = M_PI / 180/2.0;//画图时，每次旋转的度数
    CGFloat colorAlpha = M_PI_2/90 /2;
    CGFloat x = 0.0;
    NSInteger count = 180;
    for (int i = 0; i < count; i ++) {
        
        //画小扇形
        CGContextMoveToPoint(context, 0, 0);
        CGContextAddArc(context, 0, 0, radius, - M_PI_2, - M_PI_2 - single, 1);
   
        //设置填充颜色以及透明度
        x = x + colorAlpha;
        CGFloat alpha = sin(1-x);
        UIColor * color = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:alpha];
        [color setFill];
        CGContextClosePath(context);

        CGContextFillPath(context);
        [color setStroke];
        
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
//    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.fromValue = @0;
    rotationAnimation.delegate = self;
    rotationAnimation.toValue = @(2*M_PI);
    rotationAnimation.duration = 3.0;
    rotationAnimation.beginTime = CACurrentMediaTime() + 1.0;
//    rotationAnimation.repeatCount = NSIntegerMax;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

//动画结束时
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //方法中的flag参数表明了动画是自然结束还是被打断,比如调用了removeAnimationForKey:方法或removeAnimationForKey方法，flag为NO，如果是正常结束，flag为YES。
    [self start];
}

- (void) stop
{
    [self.layer removeAnimationForKey:@"rotationAnimation"];
}


@end
