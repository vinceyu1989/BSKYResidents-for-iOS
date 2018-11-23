//
//  CallRadarView.m
//  BskyResidents
//
//  Created by 何雷 on 2017/10/27.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "CallRadarView.h"
#import "CallRadarIndicatorView.h"

@interface CallRadarView()

@property (nonatomic, strong) CallRadarIndicatorView * radarIndicatorView;

@end


@implementation CallRadarView

- (instancetype) initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        [self initView];
    }
    return self;
}
- (void)initView
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.bounds];
    imageView.image = [UIImage imageNamed:@"call_map_bg"];
    imageView.userInteractionEnabled = YES;
    [self addSubview:imageView];
    
    UILabel *label = [[UILabel alloc]init];
    label.textColor = Bsky_UIColorFromRGB(0x333333);
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"正在为您匹配医生资源\n\n请稍后...";
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
    label.frame = CGRectMake(0, self.height - label.height - 80 , self.width, label.height);
    [self addSubview:label];
    
    [self addCircles];
    
    [self addSubview:self.radarIndicatorView];
}
- (void)addCircles
{
    CGFloat margin = (self.width - 70)/4;
    
    for (int i = 0; i< 4; i++) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width -70 - i*margin, self.width -70 - i*margin)];
        line.center = self.radarIndicatorView.center;
        line.backgroundColor = [UIColor clearColor];
        CGFloat alpha = 0.3+i*0.2;
        line.layer.borderColor = Bsky_UIColorFromRGBA(0x4e7dd3,alpha).CGColor;
        line.layer.borderWidth = 1.0;
        [line setCornerRadius:line.width/2];
        [self addSubview:line];
    }
}
- (CallRadarIndicatorView *) radarIndicatorView
{
    if (!_radarIndicatorView) {
        
        _radarIndicatorView = [[CallRadarIndicatorView alloc] initWithFrame:CGRectMake(35, 70, self.width-70, self.width-35)];
    }
    return _radarIndicatorView;
    
}

//开始扫描
- (void) radarScan
{
    [self.radarIndicatorView start];
}
- (void)stop
{
     [self.radarIndicatorView stop];
}

@end
