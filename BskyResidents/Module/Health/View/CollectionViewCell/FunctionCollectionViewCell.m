//
//  FunctionCollectionViewCell.m
//  BskyResidents
//
//  Created by 罗林轩 on 2017/10/12.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "FunctionCollectionViewCell.h"
#import "ListDataModel.h"
@interface FunctionCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *functionName;
@end

@implementation FunctionCollectionViewCell

- (void)setModel:(id)data{
    ListDataModel *listModel = data;
    [_icon setImage:[UIImage imageNamed:listModel.imgName]];
    _functionName.text = listModel.functionName;
}

@end
