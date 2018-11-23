//
//  CallViewController.m
//  BskyResidents
//
//  Created by 何雷 on 2017/10/26.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "CallViewController.h"
#import "CallTagsView.h"
#import "CallRadarView.h"
#import "SigningTeamHomeVC.h"

@interface CallViewController ()
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIImageView *segmentImageView;
@property (weak, nonatomic) IBOutlet UIButton *callBtn;
@property (weak, nonatomic) IBOutlet UIButton *generalBtn;
@property (weak, nonatomic) IBOutlet UIButton *specialistBtn;
@property (nonatomic ,strong) UIView *segmentView;
@property (nonatomic ,strong) CallRadarView *callRadarView;

@end

@implementation CallViewController

static CGFloat const kCallVCSegmentViewMargin = 3.f;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"一键呼医";
    [self initView];
}
- (void)initView
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [backBtn setTitle:@"        " forState:UIControlStateNormal];
    [backBtn sizeToFit];
    backBtn.frame = CGRectMake(0, 0, backBtn.width, 44);
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    self.bottomView.layer.shadowColor = Bsky_UIColorFromRGB(0x000000).CGColor;
    self.bottomView.layer.shadowOpacity = 0.15f;
    self.bottomView.layer.shadowRadius = 10.f;
    self.bottomView.layer.shadowOffset = CGSizeMake(0,0);
    
    [self.generalBtn setTitleColor:Bsky_UIColorFromRGB(0x5784d5) forState:UIControlStateSelected];
    [self.generalBtn setImage:[UIImage imageNamed:@"call_general_select"] forState:UIControlStateSelected];
    
    self.generalBtn.selected = YES;
    
    [self.specialistBtn setTitleColor:Bsky_UIColorFromRGB(0x5784d5) forState:UIControlStateSelected];
    [self.specialistBtn setImage:[UIImage imageNamed:@"call_specialist_select"] forState:UIControlStateSelected];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIImageView *callDocImage = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,self.callBtn.width+10, self.callBtn.height+10)];
        callDocImage.center = self.callBtn.center;
        callDocImage.image = [UIImage imageNamed:@"call_rotation"];
        [self.view addSubview:callDocImage];
        
        CABasicAnimation* rotationAnimation;
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
        rotationAnimation.duration = 2.0;
        rotationAnimation.cumulative = YES;
        rotationAnimation.repeatCount = CGFLOAT_MAX;
        rotationAnimation.removedOnCompletion = NO;
        [callDocImage.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        
        self.segmentView = [[UIView alloc]initWithFrame:CGRectMake(kCallVCSegmentViewMargin, kCallVCSegmentViewMargin, self.segmentImageView.width/2-kCallVCSegmentViewMargin*2, self.segmentImageView.height-kCallVCSegmentViewMargin*2)];
        self.segmentView.backgroundColor = [UIColor whiteColor];
        self.segmentView.layer.borderColor = Bsky_COLOR_RGB(232, 232, 232).CGColor;
        self.segmentView.layer.borderWidth = 0.5;
        [self.segmentView setCornerRadius:7];
        [self.segmentImageView addSubview:self.segmentView];
    });
}
- (CallRadarView *)callRadarView
{
    if (!_callRadarView) {
        
        _callRadarView = [[CallRadarView alloc]initWithFrame:self.view.bounds];
        _callRadarView.hidden = YES;
        [self.view addSubview:_callRadarView];
    }
    return _callRadarView;
}
#pragma mark ----- click

- (void)back
{
    if (!self.callRadarView.hidden) {
        self.callRadarView.hidden = YES;
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (IBAction)callBtnPressed:(UIButton *)sender {
    NSArray *tags = nil;
    NSString *title = @"";
    if (self.generalBtn.selected) {
        title = @"所属人群";
        tags = @[@"普通人群",@"60岁以上的老年人",@"孕产妇",@"0-6周岁儿童",@"妇女",@"糖尿病人群",@"高血压人群",@"慢阻肺人群",@"结核病人群"];
    }
    else
    {
        title = @"选择病种";
        tags = @[@"高血压",@"糖尿病",@"冠心病",@"皮肤病",@"脑血管疾病",@"心血管疾病",@"呼吸系统常见疾病",@"消化系统常见疾病",@"内分泌系统常见疾病",@"风湿免疫系统常见疾病",@"血液系统常见疾病",@"外科常见疾病",@"神经系统常见疾病",@"骨科常见疾病",@"泌尿系统常见疾病",@"胸外科常见疾病",@"肛肠科常见疾病",@"妇科常见疾病",@"产前保健",@"产后护理",@"助产士咨询"];
    }
    CallTagsView *tagsView = [[CallTagsView alloc]initWithTags:tags title:title];
    Bsky_WeakSelf
    tagsView.selectedIndex = ^(NSInteger index) {
        Bsky_StrongSelf;
        [self.view bringSubviewToFront:self.callRadarView];
        self.callRadarView.hidden = NO;
        [self.callRadarView radarScan];
        [self performSelector:@selector(dismissRadarScan) withObject:nil afterDelay:2.0];
    };
    [tagsView show];
}

- (IBAction)generalBtnPressed:(UIButton *)sender {

    self.generalBtn.selected = YES;
    self.specialistBtn.selected = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.segmentView.left = kCallVCSegmentViewMargin;
    } completion:^(BOOL finished) {
    }];
}
- (IBAction)specialistBtnPressed:(UIButton *)sender {
    self.generalBtn.selected = NO;
    self.specialistBtn.selected = YES;
    [UIView animateWithDuration:0.2 animations:^{
        self.segmentView.right = self.segmentImageView.width - kCallVCSegmentViewMargin;
    } completion:^(BOOL finished) {
    }];
}
- (void)dismissRadarScan
{
    [self.callRadarView stop];
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
    Bsky_WeakSelf
    [self.navigationController dismissViewControllerAnimated:NO completion:^{
        Bsky_StrongSelf;
        if (self.dismissCompleteBlock) {
            self.dismissCompleteBlock();
        }
    }];
}


@end
