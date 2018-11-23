//
//  ECCollectionReusableView.m
//  BskyResidents
//
//  Created by 罗林轩 on 2017/10/12.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "ECCollectionReusableView.h"
#import "ECCollectionViewLayoutAttributes.h"

@implementation ECCollectionReusableView
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    //设置背景颜色
    ECCollectionViewLayoutAttributes *ecLayoutAttributes = (ECCollectionViewLayoutAttributes*)layoutAttributes;
    self.backgroundColor = ecLayoutAttributes.color;
}
@end
