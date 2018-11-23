//
//  FunctionCollectionViewCell.h
//  BskyResidents
//
//  Created by 罗林轩 on 2017/10/12.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FunctionCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *topLine;
- (void)setModel:(id)data;
@end
