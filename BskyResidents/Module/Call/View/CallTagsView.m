//
//  CallTagsView.m
//  BskyResidents
//
//  Created by 何雷 on 2017/10/26.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "CallTagsView.h"
#import "CallTagsViewCell.h"
#import "SDCollectionTagsFlowLayout.h"

@interface CallTagsView()
<UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>

@property (nonatomic ,strong) UIView *contentView;

@property (nonatomic ,strong) UICollectionView *collectionView;

@property (nonatomic ,strong) UIButton *closeBtn;

@property (nonatomic ,copy) NSArray *tags;

@property (nonatomic ,copy) NSString *title;

@property (nonatomic ,assign) NSInteger index;

@end

@implementation CallTagsView

static CGFloat const kCallTagsViewDuration = 0.3;    // 动画时间

- (instancetype)initWithTags:(NSArray *)tags title:(NSString *)title
{
    self = [super init];
    if (self) {
        self.tags = tags;
        self.title = title;
        [self initView];
    }
    return self;
}
- (void)dealloc
{
    NSLog(@"%@---- 释放了",NSStringFromClass([self class]));
}
- (void)initView
{
    self.frame = CGRectMake(0, 0,Bsky_SCREEN_WIDTH, Bsky_SCREEN_HEIGHT);
    self.backgroundColor = Bsky_COLOR_RGBA(0, 0, 0, 0);
    
    self.contentView = [[UIView alloc]initWithFrame:CGRectMake(15, -(self.height-190), self.width-30, self.height-190)];
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView setCornerRadius:10];
    [self addSubview:self.contentView];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = self.title;
    titleLabel.textColor = Bsky_UIColorFromRGB(0x333333);
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.equalTo(@50);
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = Bsky_UIColorFromRGB(0xdedede);
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(titleLabel.mas_bottom);
        make.height.equalTo(@0.5);
    }];
    
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(line);
        make.top.equalTo(line.mas_bottom).offset(20);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
    }];
    
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeBtn setImage:[UIImage imageNamed:@"call_close_icon"] forState:UIControlStateNormal];
    [self.closeBtn sizeToFit];
    self.closeBtn.center = CGPointMake(self.width/2, self.height+100);
    [self.closeBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.closeBtn];
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        SDCollectionTagsFlowLayout *flowLayout = [[SDCollectionTagsFlowLayout alloc]initWthType:TagsTypeWithCenter];
        flowLayout.betweenOfCell = 10;
        flowLayout.minimumLineSpacing = 15;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        //注册
        [_collectionView registerClass:[CallTagsViewCell class] forCellWithReuseIdentifier:NSStringFromClass([CallTagsViewCell class])];
    }
    return _collectionView;
}
#pragma mark --- UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.tags.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = self.tags[indexPath.row];
    CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(Bsky_SCREEN_WIDTH-50-20, 30)];
    return CGSizeMake(size.width+20,30);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CallTagsViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CallTagsViewCell class]) forIndexPath:indexPath];
    cell.titleLabel.text = self.tags[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.index = indexPath.row;
    [self hide];
}
#pragma mark --- 动画
- (void)show
{
    [self.collectionView layoutIfNeeded];
    CGFloat height = self.collectionView.contentSize.height+20*2+51;
    if (height < Bsky_SCREEN_HEIGHT - 190 ) {
        self.contentView.height = height;
    }
    self.index = -1;
    [[UIApplication sharedApplication].keyWindow addSubview:self];

    [UIView animateWithDuration:kCallTagsViewDuration
                     animations:^{
                         self.backgroundColor = Bsky_COLOR_RGBA(0, 0, 0, 0.5);
                         self.contentView.center = CGPointMake(self.width/2, self.height/2);
                         self.closeBtn.center = CGPointMake(self.width/2, self.height-47);
                     }
                     completion:nil];
}

- (void)hide
{
    [UIView animateWithDuration:kCallTagsViewDuration animations:^{
        self.backgroundColor = Bsky_COLOR_RGBA(0, 0, 0, 0);
        self.contentView.top = -(self.height-190);
        self.closeBtn.center = CGPointMake(self.width/2, self.height+100);
    } completion:^(BOOL finished) {
        WS(weakSelf);
        if (self.selectedIndex) {
            if (self.index >= 0) {
                self.selectedIndex(weakSelf.index);
            }
            self.selectedIndex = nil;
        }
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
        [self removeFromSuperview];
    }];
}


@end
