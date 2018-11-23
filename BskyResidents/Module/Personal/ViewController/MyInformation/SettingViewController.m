//
//  SettingViewController.m
//  BSKYDoctorPro
//
//  Created by 何雷 on 2017/8/31.
//  Copyright © 2017年 ky. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableViewCell.h"
#import "BSAboutViewController.h"
#import "BSWebViewController.h"

@interface SettingViewController ()

@property (nonatomic ,copy) NSArray *dataArray;

@property (nonatomic ,strong) UIButton *logoutBtn;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";

    self.tableView.backgroundColor = Bsky_UIColorFromRGBA(0xf7f7f7,1);
    [self.tableView registerNib:[SettingTableViewCell nib] forCellReuseIdentifier:[SettingTableViewCell cellIdentifier]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
#warning 审核未使用功能
//    self.dataArray = [NSArray arrayWithObjects:@"重置密码",@"联系我们",@"清除缓存",@"关于巴蜀快医", nil];
    self.dataArray = [NSArray arrayWithObjects:@"隐私政策",@"关于巴蜀快医", nil];
    [self.tableView addSubview:self.logoutBtn];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
#pragma mark - UITableViewDataSource UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[SettingTableViewCell cellIdentifier]];
    cell.titleLabel.text = self.dataArray[indexPath.row];
    if (indexPath.row == self.dataArray.count-1) {
        [cell.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(cell);
            make.height.equalTo(@(0.5));
        }];
    }
    else
    {
        [cell.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(cell);
            make.left.equalTo(cell.mas_left).offset(15);
            make.height.equalTo(@(0.5));
        }];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [SettingTableViewCell cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
#warning 审核未使用功能
    switch (indexPath.row) {
//        case 0:
//        {
//            [UIView makeToast:@"该功能暂未开放"];
//        }
//            break;
//        case 1:
//        {
//            [UIView makeToast:@"该功能暂未开放"];
//        }
//            break;
//        case 2:
//        {
//            [UIView makeToast:@"该功能暂未开放"];
//        }
//            break;
        case 0:
        {
            BSWebViewController *web = [[BSWebViewController alloc] init];
            web.showNavigationBar = YES;
            web.ba_web_progressTintColor = UIColorFromRGB(0x599dff);
            web.ba_web_progressTrackTintColor = [UIColor whiteColor];
            NSString *url = @"https://apissl.jkscw.com.cn/bskyH5/PrivacyPolicy/PrivacyPolicy.html";
            [web ba_web_loadURLString:url];
            [self.navigationController pushViewController:web animated:YES];
        }
            break;
        case 1:
        {
            BSAboutViewController* viewController = [BSAboutViewController viewControllerFromStoryboard];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
            
        default:
        break;
    }
}
#pragma mark ----- logoutBtn

- (UIButton *)logoutBtn
{
    if (!_logoutBtn) {
        _logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _logoutBtn.frame = CGRectMake(0, self.tableView.height-45-10-Bsky_TOP_BAR_HEIGHT, self.tableView.width, 45);
        _logoutBtn.backgroundColor = [UIColor whiteColor];
         [_logoutBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] size:_logoutBtn.bounds.size] forState:UIControlStateNormal];
        [_logoutBtn setBackgroundImage:[UIImage imageWithColor:Bsky_UIColorFromRGBA(0xededed,1) size:_logoutBtn.bounds.size] forState:UIControlStateHighlighted];
        [_logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [_logoutBtn setTitleColor:Bsky_UIColorFromRGBA(0xff2a2a,1) forState:UIControlStateNormal];
        _logoutBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        _logoutBtn.layer.borderColor = Bsky_UIColorFromRGBA(0xededed,1).CGColor;
        _logoutBtn.layer.borderWidth = 0.5;
        [_logoutBtn addTarget:self action:@selector(logoutBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logoutBtn;
}
- (void)logoutBtnPressed
{
    WS(weakSelf);
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:@"确定退出登录?" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"确定", nil];;
    [actionSheet setCompletionBlock:^(UIActionSheet* actionSheet, NSInteger index){
        if (index == 0) {
            [MBProgressHUD showHud];
            BSLogoutRequest* request = [BSLogoutRequest new];
            [request startWithCompletionBlockWithSuccess:^(BSLogoutRequest* request) {
                [weakSelf.navigationController popToRootViewControllerAnimated:NO];
                [[NSNotificationCenter defaultCenter] postNotificationName:LogoutNotification object:nil];
                [MBProgressHUD hideHud];
            } failure:^(BSLogoutRequest* request) {
                [MBProgressHUD hideHud];
            }];
        }
    }];
    
    [actionSheet showInView:self.view];
}

@end
