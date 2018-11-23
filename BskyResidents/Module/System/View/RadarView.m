//
//  RadarView.m
//  雷达扫描动画
//
//  Created by Apple on 16/9/21.
//  Copyright © 2016年 xuqigang. All rights reserved.
//

#import "RadarView.h"

@implementation RadarView
- (instancetype) initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
//        [self setCornerRadius:frame.size.width/2];
//        self.layer.borderColor = [UIColor whiteColor].CGColor;
//        self.layer.borderWidth = 1;
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        imageView.image = [UIImage imageNamed:@"ico_home_card"];
        [imageView sizeToFit];
        imageView.center = self.center;
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
    }
    return self;
}

- (void) drawRect:(CGRect)rect {
    [super drawRect:rect];
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [self drawCircle:context];
}

- (RadarIndicatorView *) radarIndicatorView {
    if (!_radarIndicatorView) {
        _radarIndicatorView = [[RadarIndicatorView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _radarIndicatorView.center = self.center;
    }
    return _radarIndicatorView;
}

- (void) drawCircle:(CGContextRef ) context
{
    //将坐标轴移动到视图中心
    CGContextTranslateCTM(context, CGRectGetWidth(self.frame)/2.0, CGRectGetHeight(self.frame)/2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    
    CGContextMoveToPoint(context, self.width/3.5, 0);
    CGContextAddArc(context, 0, 0, self.width/3.5, 0, M_PI * 2, 0);
    CGContextSetLineWidth(context, 0.5);
    CGContextStrokePath(context);
    
//    CGContextMoveToPoint(context, self.width/2-1, 0);
//    CGContextAddArc(context, 0, 0, self.width/2-1, 0, M_PI * 2, 0);
//    CGContextSetLineWidth(context, 1);
//    CGContextStrokePath(context);
    
}
//开始扫描
- (void) radarScan {
//    [self.radarIndicatorView start];
}

@end
