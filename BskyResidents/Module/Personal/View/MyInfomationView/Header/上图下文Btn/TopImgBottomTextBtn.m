//
//  TopImgBottomTextBtn.m
//  BskyResidents
//
//  Created by 罗林轩 on 2017/10/11.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "TopImgBottomTextBtn.h"
//图片宽
static CGFloat const imgW = 20;
//图片高
static CGFloat const imgH = 18;

@implementation TopImgBottomTextBtn
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat w = contentRect.size.width;
    return CGRectMake((w - imgW) / 2, 12.5, imgW, imgH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat w = contentRect.size.width;
    CGFloat h  = contentRect.size.height;
    return CGRectMake(0, imgH + 7, w, h - imgH - 7);
}
@end
