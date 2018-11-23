

//
//  FunctionCellFlowLayout.m
//  BskyResidents
//
//  Created by 罗林轩 on 2017/10/12.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "FunctionCellFlowLayout.h"
#import "ECCollectionViewLayoutAttributes.h"
#import "ECCollectionReusableView.h"
static CGFloat const itemH = 80;//高

@implementation FunctionCellFlowLayout
+ (Class)layoutAttributesClass{
    return [ECCollectionViewLayoutAttributes class];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    //根据自己的需求设置宽高
    CGFloat  itemW = ([UIScreen mainScreen].bounds.size.width - 31)/4;//宽
    self.itemSize = CGSizeMake(itemW, itemH);
//    内边距，列、行间距
    self.sectionInset = UIEdgeInsetsMake(0, 15, 0, 0);
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    [self registerClass:[ECCollectionReusableView class] forDecorationViewOfKind:@"decorationAttributes"];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    NSMutableArray *allAttributes = [NSMutableArray arrayWithArray:attributes];
    
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        // 查找一行的第一个item
        if (attribute.representedElementKind == UICollectionElementCategoryCell
            && attribute.frame.origin.x == self.sectionInset.left) {
            // 创建decoration属性、
            ECCollectionViewLayoutAttributes *decorationAttributes =
            [ECCollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:@"decorationAttributes"
                                                                        withIndexPath:attribute.indexPath];
            // 让decoration view占据整行
            decorationAttributes.frame =
            CGRectMake(0,
                       attribute.frame.origin.y-(self.sectionInset.top),
                       self.collectionViewContentSize.width,
                       self.itemSize.height+(self.minimumLineSpacing+self.sectionInset.top+self.sectionInset.bottom));
            // 设置zIndex，表示在item的后面
            decorationAttributes.zIndex = attribute.zIndex-1;
            
            // 添加属性到集合
            [allAttributes addObject:decorationAttributes];
        }
    }
    
    
    for(int i = 1; i < [attributes count]; ++i) {
        //当前attributes
        UICollectionViewLayoutAttributes *currentLayoutAttributes = attributes[i];
        NSLog(@"%lu",currentLayoutAttributes.indexPath.section);
        //上一个attributes
        UICollectionViewLayoutAttributes *prevLayoutAttributes = attributes[i - 1];
        //我们想设置的最大间距，可根据需要改
        NSInteger maximumSpacing = 0;
        //前一个cell的最右边
        NSInteger origin = CGRectGetMaxX(prevLayoutAttributes.frame);
        //如果当前一个cell的最右边加上我们想要的间距加上当前cell的宽度依然在contentSize中，我们改变当前cell的原点位置
        //不加这个判断的后果是，UICollectionView只显示一行，原因是下面所有cell的x值都被加到第一行最后一个元素的后面了
        if (i % 4 != 0) {
            if(origin + maximumSpacing + currentLayoutAttributes.frame.size.width < self.collectionViewContentSize.width) {
                CGRect frame = currentLayoutAttributes.frame;
                frame.origin.x = origin + maximumSpacing;
                currentLayoutAttributes.frame = frame;
            }
        }
    }
    return allAttributes;
}
@end
