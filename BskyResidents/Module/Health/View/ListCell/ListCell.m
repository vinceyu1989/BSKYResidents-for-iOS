//
//  ListCell.m
//  BskyResidents
//
//  Created by 罗林轩 on 2017/10/12.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "ListCell.h"
#import "FunctionCellFlowLayout.h"
#import "FunctionCollectionViewCell.h"
#import "HeathDataCollectionViewCell.h"
#import "ListDataModel.h"
#import "HealthNotifier.h"

@interface ListCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *datas;//数据源
@property (strong, nonatomic) NSMutableArray *title;//标题源
@end

@implementation ListCell
- (void)awakeFromNib{
    [super awakeFromNib];
    _datas = [NSMutableArray array];
    _title  = [NSMutableArray arrayWithArray:@[@"血糖记录",@"血压记录",@"用药记录",@"睡眠记录"]];
    NSArray *functionNames = @[@"健康档案",@"健康计划",@"健康报告",@"体检报告",@"住院记录",@"随访记录",@"费用清单",@"报告查询"];
    for (int  i  = 0; i < 8; i ++) {
        NSString *imageName = [NSString stringWithFormat:@"health_ico%d",i + 1];
        ListDataModel *cellModel = [[ListDataModel alloc] init];
        cellModel.imgName = imageName;
        cellModel.functionName = functionNames[i];
        [_datas addObject:cellModel];
    }
    [self setupSubViews];
}

- (void)setupSubViews{
    FunctionCellFlowLayout *flowLayout = [[FunctionCellFlowLayout alloc] init];
    [_collectionView setCollectionViewLayout:flowLayout];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HeathDataCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([HeathDataCollectionViewCell class])];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([FunctionCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([FunctionCollectionViewCell class])];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        HeathDataCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HeathDataCollectionViewCell class]) forIndexPath:indexPath];
        cell.dataName.text = _title[indexPath.item];
        return cell;
    }else{
        FunctionCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FunctionCollectionViewCell class]) forIndexPath:indexPath];
        if (indexPath.section == 2) {
            cell.topLine.hidden = NO;
            [cell setModel:_datas[indexPath.row + 4]];
        }else{
            [cell setModel:_datas[indexPath.row]];
        }
        return cell;
    }
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [[NSNotificationCenter defaultCenter] postNotificationName:healthyNotifier object:indexPath userInfo:nil];
}


////item大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    return CGSizeMake(([UIScreen mainScreen].bounds.size.width - 31)/4,80);
//}
//
////定义每个Section的四边间距
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    if (section == 2) {
//        return UIEdgeInsetsMake(1, 15, 0, 0);
//    }
//    return UIEdgeInsetsMake(0, 15, 0, 0);//分别为上、左、下、右
//}

////这个是两行cell之间的间距（上下行cell的间距）
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//    return CGFLOAT_MIN;
//}
//
////两个cell之间的间距（同一行的cell的间距）
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    return CGFLOAT_MIN;
//}



@end
