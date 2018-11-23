//
//  BSCategoryMessageViewController.m
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/17.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSCategoryMessageViewController.h"
#import "BSCategoryMessageView.h"
#import "Placeholder.h"
@interface BSCategoryMessageViewController () <BSCategoryMessageViewDataSource>

@property (nonatomic, strong) BSCategoryMessageView* categoryMessageView;
@property (nonatomic, strong) NSArray* newsList;

@end

@implementation BSCategoryMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupView];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void)loadData {
    BSNewsListRequest* request = [BSNewsListRequest new];
    request.userId = [BSAppManager sharedInstance].currentUser.userId;
    request.type = self.category.type;
    [MBProgressHUD showHud];
    WS(weakSelf);
    [request startWithCompletionBlockWithSuccess:^(__kindof BSNewsListRequest * _Nonnull request) {
        [MBProgressHUD hideHud];
        weakSelf.newsList = request.newsList;
        if (weakSelf.newsList.count == 0) {
            Placeholder *place = [Placeholder showWithType:0];
            place.content.text = @"你没有任何消息";
            [weakSelf.view addSubview:place];
            [place mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(0);
            }];
        }
        [weakSelf.categoryMessageView reloadData];
    } failure:^(__kindof BSNewsListRequest * _Nonnull request) {
        [MBProgressHUD hideHud];
        [UIView makeToast:request.msg];
    }];
}

- (void)setupView {
//    self.title = @"服务消息";
    if ([_category.type isEqualToString:@"01007001"]) {
        self.title = @"服务消息";
    }else if ([_category.type isEqualToString:@"01007002"]) {
        self.title = @"用药提醒";
    }else if ([_category.type isEqualToString:@"01007003"]) {
        self.title = @"预警值提醒";
    }
    self.categoryMessageView = ({
        BSCategoryMessageView* view = [BSCategoryMessageView new];
        [self.view addSubview:view];
        view.dataSource = self;
        view.delegate = self;
        view;
    });
    
    [self.categoryMessageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - BSCategoryMessageViewDataSource

- (NSInteger)numberOfNewsInView:(BSCategoryMessageView*)view {
    return self.newsList.count;
}

- (BSNews*)newsForIndex:(NSInteger)index {
    return self.newsList[index];
}

#pragma mark - BSCategoryMessageViewDelegate

@end
