//
//  HealthCardInfomationView.m
//  BskyResidents
//
//  Created by 罗林轩 on 2017/11/22.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "HealthCardInfomationView.h"

@interface TitleLabel : UIView
@property (copy, nonatomic) NSString *text;
@property (strong, nonatomic) UILabel *label;
@end

@implementation TitleLabel
- (instancetype)init
{
    self = [super init];
    if (self) {
        UIImageView *imageView  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"person_0"]];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.width.height.mas_equalTo(4);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        [self addSubview:self.label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imageView.mas_right).offset(7.5);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.top.mas_equalTo(0);
        }];
    }
    return self;
}

- (void)setText:(NSString *)text{
    _text  = text;
    _label.text = text;
}

- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.textColor = [UIColor colorWithHexString:@"000000"];
        _label.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        _label.numberOfLines = 0;
        _label.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _label;
}
@end


@interface HealthCardInfomationView ()
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) UILabel *detailLabel;
@end

@implementation HealthCardInfomationView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申领电子健康卡";
    _dataArray = @[@"1、获取电子居民健康卡（试用）的渠道有哪些？",@"巴蜀快医作为四川省卫生和计划生育委员会卡管中心授权发放电子居民健康卡（试用）的官方渠道，实现从实名认证、绑定激活和服务应用一体化功能。电子健康卡（试用）是居民健康卡实体卡的有效补充，居民可以只有实体健康卡，也可以同时具有实体健康卡和电子健康卡（试用）。",@"2、发放居民健康卡（试用）能为居民带来哪些方便 ? ",@"居民健康卡是国家卫生计生委统一规划实施的统一标准的“就诊卡”，主要实现跨医疗机构跨地域医疗健康服务“一卡通”，方便群众就医和自我健康管理。",@"如何在巴蜀快医上领取、绑定激活电子居民健康卡（试用）？",@"居民通过手机号注册成为巴蜀快医用户并通过实名身份认证后自动获取一张唯一的二维码电子健康卡（试用）。",@"4、如何使用电子居民健康卡（试用）？",@"居民在巴蜀快医获取电子卡（试用）后，在进行医疗健康服务、身份识别和金融支付时，点击“个人中心-健康卡”并出示打开后的“二维码”电子卡进行扫码识别、应用和支付。 "];
    [self setup];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)setup{
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsMake(1,1,1,1));
    }];
    
    [self.scrollView addSubview:self.detailLabel];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.scrollView.mas_centerX);
        make.top.mas_equalTo(self.scrollView.mas_top).mas_offset(20);
        make.height.mas_equalTo(21);
    }];
    
    TitleLabel *rowLabel;
    UILabel *label;
    UIView *lastView;
    for (int i = 0; i < _dataArray.count; i ++) {
        if (i % 2 == 0) {
            rowLabel = [[TitleLabel alloc] init];
            rowLabel.text = _dataArray[i];
            [self.scrollView addSubview:rowLabel];
            [rowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                if (lastView) {
                    make.left.mas_equalTo(lastView.mas_left).mas_offset(-10);
                    make.right.mas_equalTo(self.view.mas_right).offset(-50);
                    make.top.mas_equalTo(lastView.mas_bottom).mas_offset(30);
                }else{
                    make.left.mas_equalTo(25);
                    make.right.mas_equalTo(self.view.mas_right).offset(-50);
                    make.top.mas_equalTo(_detailLabel.mas_bottom).mas_offset(20);
                }
                make.height.mas_equalTo([self getAttributeSizeWithText:_dataArray[i] fontSize:14 width:Bsky_SCREEN_WIDTH - 120]);
            }];
            lastView = rowLabel;
        }else{
            label = [[UILabel alloc] init];
            label.text = _dataArray[i];
            label.numberOfLines = 0;
            label.textColor = [UIColor colorWithHexString:@"666666"];
            label.font  = [UIFont systemFontOfSize:14];
            label.lineBreakMode = NSLineBreakByWordWrapping;
            [self.scrollView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(lastView.mas_left).mas_offset(10);
                make.right.mas_equalTo(self.view.mas_right).offset(-50);
                make.top.mas_equalTo(lastView.mas_bottom).mas_offset(15);
                make.height.mas_equalTo([self getAttributeSizeWithText:_dataArray[i] fontSize:14 width:Bsky_SCREEN_WIDTH - 120]);
            }];
            lastView = label;
        }
    }
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(lastView.mas_bottom).mas_offset(15);
    }];
}

#pragma mark - 获取文字高度
- (CGFloat) getAttributeSizeWithText:(NSString *)text fontSize:(int)fontSize width:(CGFloat)width{
    CGSize titleSize = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
    return titleSize.height;
}

#pragma mark - get
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.layer.cornerRadius = 5;
        _scrollView.layer.masksToBounds = YES;
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.contentSize = CGSizeMake(0, MAXFLOAT);
    }
    return _scrollView;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.text = @"- 电子健康卡(试用)说明 -";
        _detailLabel.font = [UIFont systemFontOfSize:14];
        _detailLabel.textColor = [UIColor colorWithHexString:@"6aadff"];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _detailLabel;
}
@end
