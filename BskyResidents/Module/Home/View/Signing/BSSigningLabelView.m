//
//  BSSigningLabelView.m
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/10.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSSigningLabelView.h"
#import "BSSigningLabelCell.h"

@interface BSSigningLabelView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UICollectionView* collectionView;
@property (nonatomic, retain) NSMutableArray *selectedDataList;

@end

@implementation BSSigningLabelView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self initView];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    
    return self;
}

- (void)initView {
    self.titleLabel = ({
        UILabel* label = [UILabel new];
        label.textColor = Bsky_UIColorFromRGBA(0x666666,1);
        label.font = [UIFont systemFontOfSize:14];
        [self.titleLabel sizeToFit];
        [self addSubview:label];
        
        label;
    });
    
    self.collectionView = ({
        UICollectionViewFlowLayout* layout = [UICollectionViewFlowLayout new];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        if (!LESS_IOS8_2) {
            layout.estimatedItemSize = CGSizeMake(20, 30);
        }
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        UICollectionView* collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0,Bsky_SCREEN_WIDTH, Bsky_SCREEN_HEIGHT) collectionViewLayout:layout];
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.allowsMultipleSelection = YES;
        collectionView.backgroundColor = Bsky_UIColorFromRGBA(0xffffff,1);
        [collectionView registerClass:[BSSigningLabelCell class] forCellWithReuseIdentifier:@"BSSigningLabelCell"];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.scrollEnabled = NO;
        [self addSubview:collectionView];
        collectionView;
    });
    
    self.selectedDataList = [NSMutableArray array];
    
    [self setupFrame];

}

- (void)setupFrame {
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(15);
        make.left.equalTo(self.mas_left).offset(15);
    }];
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

- (void)reloadData {
    self.titleLabel.text = [self.dataSource titleForView:self];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataSource numberOfLabelsInView:self];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BSSigningLabelCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BSSigningLabelCell" forIndexPath:indexPath];
    NSString* text = [self.dataSource signingLabelView:self labelTitleForIndex:indexPath.row];
    cell.text = text;
    if ([self.selectedDataList containsObject:text]) {
        cell.selected = YES;
    }else {
        cell.selected = NO;
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (LESS_IOS8_2) { // FIXME
        NSString* text = [self.dataSource signingLabelView:self labelTitleForIndex:indexPath.row];
        CGRect frame = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 21) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13]} context:nil];
        return CGSizeMake(frame.size.width + 15, 30);
    }
    return CGSizeMake(50, 30);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(15, 15, 15, 15);
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    if (self.selectedDataList.count >= 5) {
//        [collectionView deselectItemAtIndexPath:indexPath animated:NO];
//        return;
//    }
    NSString* text = [self.dataSource signingLabelView:self labelTitleForIndex:indexPath.row];
    [self.selectedDataList addObject:text];
    if ([self.delegate respondsToSelector:@selector(signingLabelView:didChangeSelectedList:)]) {
        [self.delegate signingLabelView:self didChangeSelectedList:[NSArray arrayWithArray:self.selectedDataList]];
    }
    
    if ([text isEqualToString:@"无疾病"] || [self.selectedDataList containsObject:@"无疾病"]) {
        for (NSIndexPath *otherIndexPath in collectionView.indexPathsForSelectedItems) {
            if (indexPath != otherIndexPath) {
                BSSigningLabelCell *cell = (BSSigningLabelCell *)[self.collectionView cellForItemAtIndexPath:otherIndexPath];
                cell.selected = NO;
                [collectionView deselectItemAtIndexPath:otherIndexPath animated:YES];
                [self collectionView:collectionView didDeselectItemAtIndexPath:otherIndexPath];
            }
        }
    }
//    else if ([self.selectedDataList containsObject:@"无疾病"] ){
//        for (NSIndexPath *otherIndexPath in collectionView.indexPathsForSelectedItems) {
//            if (indexPath != otherIndexPath) {
//                BSSigningLabelCell *cell = (BSSigningLabelCell *)[self.collectionView cellForItemAtIndexPath:otherIndexPath];
//                cell.selected = NO;
//                [collectionView deselectItemAtIndexPath:otherIndexPath animated:YES];
//                [self collectionView:collectionView didDeselectItemAtIndexPath:otherIndexPath];
//            }
//        }
//    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString* text = [self.dataSource signingLabelView:self labelTitleForIndex:indexPath.row];
    [self.selectedDataList removeObject:text];
  
    if ([self.delegate respondsToSelector:@selector(signingLabelView:didChangeSelectedList:)]) {
        [self.delegate signingLabelView:self didChangeSelectedList:[NSArray arrayWithArray:self.selectedDataList]];
    }
}

- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority {
    [self.collectionView reloadData];
    [self.collectionView setNeedsLayout];
    [self.titleLabel sizeToFit];
    [self.collectionView layoutIfNeeded];
    CGSize size = self.collectionView.collectionViewLayout.collectionViewContentSize;
    return CGSizeMake(size.width, size.height + 15 + self.titleLabel.bounds.size.height);
}

@end
