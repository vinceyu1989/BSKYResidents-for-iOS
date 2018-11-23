//
//  BSSigningServiceViewController.m
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/12.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSSigningServiceViewController.h"
#import "BSSigningServiceView.h"
#import "BSSigningContractViewController.h"

@interface BSSigningServiceViewController () <BSSigningServiceViewDataSource, BSSigningServiceViewDelegate>

@property (nonatomic, strong) BSSigningServiceView* signingServiceView;

@property (nonatomic, strong) NSArray* serviceList;

@end

@implementation BSSigningServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -

- (void)setupView {
    self.title = @"签约服务";
    
    self.signingServiceView = ({
        BSSigningServiceView* view = [BSSigningServiceView new];
        [self.view addSubview:view];
        view.dataSource = self;
        view.delegate = self;
        
        view;
    });
    
    [self.signingServiceView reloadData];
    
    [self.signingServiceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)setSignInfo:(SignInfoModel *)signInfo {
    _signInfo = signInfo;
    self.serviceList = signInfo.signInfo.servicelist;
}

#pragma mark - BSSigningServiceViewDataSource

- (NSInteger)numberOfServiceInSigningServiceView:(BSSigningServiceView*)signingServiceView {
    return self.serviceList.count;
}

- (SignService*)serviceAtIndex:(NSInteger)index {
    return self.serviceList[index];
}

- (SignInfoModel*)signInfoData {
    return self.signInfo;
}

#pragma mark - BSSigningServiceViewDelegate

- (void)didTouchContractInSigningServiceView:(BSSigningServiceView*)signingServiceView {
    BSSigningContractViewController* viewController = [BSSigningContractViewController viewControllerFromStoryboard];
    viewController.signInfo = self.signInfo;
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
