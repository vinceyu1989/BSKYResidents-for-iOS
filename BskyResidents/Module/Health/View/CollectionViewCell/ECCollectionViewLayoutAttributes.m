//
//  ECCollectionViewLayoutAttributes.m
//  BskyResidents
//
//  Created by 罗林轩 on 2017/10/12.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "ECCollectionViewLayoutAttributes.h"

@implementation ECCollectionViewLayoutAttributes
+ (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)decorationViewKind
                                                                withIndexPath:(NSIndexPath *)indexPath {
    
    ECCollectionViewLayoutAttributes *layoutAttributes = [super layoutAttributesForDecorationViewOfKind:decorationViewKind
                                                                                          withIndexPath:indexPath];
    if (indexPath.section == 0) {
        layoutAttributes.color = [UIColor colorWithHexString:@"507fd0"];
    } else {
        layoutAttributes.color = [UIColor whiteColor];
    }
    return layoutAttributes;
}
@end
