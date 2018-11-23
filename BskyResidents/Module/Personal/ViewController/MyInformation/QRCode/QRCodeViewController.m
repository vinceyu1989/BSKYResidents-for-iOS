//
//  QRCodeViewController.m
//  BskyResidents
//
//  Created by 罗林轩 on 2017/10/19.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "QRCodeViewController.h"
#import "QRCodeView.h"
@interface QRCodeViewController ()

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"333333"];
    [self setupSubViews];
}

- (void)setupSubViews{
    QRCodeView *QRView = [QRCodeView showWithModel:[[BSAppManager sharedInstance]currentUser].tag];
    QRView.contentSize = CGSizeMake(Bsky_SCREEN_WIDTH - 40, QRView.height);
    [self.view addSubview:QRView];

    [QRView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(40);
        make.height.mas_equalTo((QRView.height + 40) > (Bsky_SCREEN_HEIGHT - Bsky_TOP_BAR_HEIGHT) ? (Bsky_SCREEN_HEIGHT - Bsky_TOP_BAR_HEIGHT - 80) : QRView.height);
    }];
    NSLog(@"123");
}
@end
