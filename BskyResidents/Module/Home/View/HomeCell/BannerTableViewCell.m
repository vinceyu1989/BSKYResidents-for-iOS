//
//  BannerTableViewCell.m
//  BskyResidents
//
//  Created by 何雷 on 2017/9/29.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BannerTableViewCell.h"
#import "XRCarouselView.h"
#import "BannerModel.h"
@interface BannerTableViewCell() <XRCarouselViewDelegate>

@property (nonatomic ,strong) XRCarouselView *carouselView;
@property (strong, nonatomic) NSMutableArray *dataArray;//数据源

@end

@implementation BannerTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.carouselView];
        [self.carouselView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
            make.height.equalTo(@150);
        }];
    }
    return self;
}
- (XRCarouselView *)carouselView
{
    if (!_carouselView) {
        
        _carouselView = [XRCarouselView carouselViewWithImageArray:nil describeArray:nil];
        [_carouselView setPageColor:Bsky_UIColorFromRGB(0xcccccc) andCurrentPageColor:Bsky_UIColorFromRGB(0x4e7dd3)];
        _carouselView.time = 6.0;
        _carouselView.delegate = self;
        _carouselView.imageViewContentMode = UIViewContentModeScaleAspectFill;
    }
    return _carouselView;
}

- (void)setupData:(id)data{
    _dataArray = [NSMutableArray arrayWithArray:data];
    NSMutableArray *imageArray = [NSMutableArray array];
    for (BannerModel *model in _dataArray) {
        [imageArray addObject:model.href];
     
    }
    self.imageArray = imageArray;
}

- (void)setImageArray:(NSArray *)imageArray
{
    if (_imageArray == imageArray) {
        return;
    }
    _imageArray = imageArray;
    self.carouselView.imageArray = _imageArray;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}
#pragma mark - XRCarouselViewDelegate
- (void)carouselView:(XRCarouselView *)carouselView clickImageAtIndex:(NSInteger)index
{
    
}

@end
