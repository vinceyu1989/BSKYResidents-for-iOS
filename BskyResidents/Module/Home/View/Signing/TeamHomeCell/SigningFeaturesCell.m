//
//  SigningFeaturesCell.m
//  BskyResidents
//
//  Created by 何雷 on 2017/10/13.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "SigningFeaturesCell.h"

@interface SigningFeaturesCell()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (nonatomic ,copy) NSArray *titleArray;

@property (nonatomic ,copy) NSArray *iconArray;

@property (nonatomic ,copy) NSArray *feeArray;

@end

@implementation SigningFeaturesCell

static NSInteger const kSigningFeaturesCellBtnTag = 2100;

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.titleArray = @[@"图文咨询",@"延长处方",@"健康管理",@"体检预约"];
    self.iconArray = @[@"advisory_un_icon",@"prescription_un_icon",@"healthManage_un_icon",@"medical_un_icon"];
    
    self.pageControl.numberOfPages = (self.titleArray.count-1)/4+1;
    self.pageControl.hidden = YES;
    self.scrollView.delegate = self;
    self.scrollView.width = Bsky_SCREEN_WIDTH - 50;
    
    self.scrollView.contentSize = CGSizeMake(self.pageControl.numberOfPages*self.scrollView.width, self.scrollView.height);
    
    CGFloat width = self.scrollView.width/4;
    
    for (int i = 0; i< self.titleArray.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor whiteColor];
        btn.frame = CGRectMake(i*width , 0, width, self.scrollView.height);
        btn.tag = kSigningFeaturesCellBtnTag + i;
        [btn setImage:[UIImage imageNamed:self.iconArray[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:btn];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.textColor = Bsky_UIColorFromRGB(0x999999);
        titleLabel.text = self.titleArray[i];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [titleLabel sizeToFit];
        titleLabel.frame = CGRectMake(0, 0, btn.width, titleLabel.height);
        titleLabel.tag = 10;
        [btn addSubview:titleLabel];
        
        UILabel *feeLabel = [[UILabel alloc]init];
        feeLabel.font = [UIFont systemFontOfSize:14];
        feeLabel.textColor = Bsky_UIColorFromRGB(0x999999);
        feeLabel.text = @"- -";
        feeLabel.textAlignment = NSTextAlignmentCenter;
        [feeLabel sizeToFit];
        feeLabel.frame = CGRectMake(0, btn.height-feeLabel.height, btn.width,feeLabel.height );
        feeLabel.tag = 11;
        [btn addSubview:feeLabel];
        
    }
}
- (void)setIsRegistered:(BOOL)isRegistered
{
    _isRegistered = isRegistered;
    UIButton *btn = [self.scrollView viewWithTag:kSigningFeaturesCellBtnTag];
    UILabel *titleLabel = [btn viewWithTag:10];
    UILabel *feeLabel = [btn viewWithTag:11];
    if (_isRegistered) {
        titleLabel.textColor = Bsky_UIColorFromRGB(0x333333);
        [btn setImage:[UIImage imageNamed:@"advisory_icon"] forState:UIControlStateNormal];
        feeLabel.textColor = Bsky_UIColorFromRGB(0xff9000);
        feeLabel.text = @"免费";
    }
    else
    {
        titleLabel.textColor = Bsky_UIColorFromRGB(0x999999);
        [btn setImage:[UIImage imageNamed:@"advisory_un_icon"] forState:UIControlStateNormal];
        feeLabel.textColor = Bsky_UIColorFromRGB(0x999999);
        feeLabel.text = @"- -";
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
#pragma mark ---- UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int current = scrollView.contentOffset.x/scrollView.width;
    self.pageControl.currentPage = current;
}
#pragma mark ---- click

- (void)btnPressed:(UIButton *)sender
{
    if (sender.tag == kSigningFeaturesCellBtnTag && self.isRegistered) {
        if (self.selectedIndex) {
            self.selectedIndex(0);
        }
    }
    else
    {
        [UIView makeToast:@"该功能暂未开放，敬请期待"];
    }
}

@end
