//
//  BSMessageViewController.m
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/17.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSMessageViewController.h"
#import "BSMessageCell.h"
#import "BSCategoryMessageViewController.h"
#import "NTESSessionViewController.h"

@interface BSMessageViewController ()

@property (nonatomic, strong) NSMutableArray* messageCategoryList;

@end

@implementation BSMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"BSMessageCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BSMessageCell"];
    self.messageCategoryList = [NSMutableArray array];
    [self setupView];
    [self loadData];
}
#pragma mark -

- (void)loadData {
    
    // 配置默认值
    [self.messageCategoryList removeAllObjects];
    NSArray *array = @[@"01007001",@"01007002",@"01007003"];
    for (int i = 0; i< array.count; i++) {
        BSNewsCategory *model = [[BSNewsCategory alloc]init];
        model.type = array[i];
        model.newsContent = @"暂无消息";
        [self.messageCategoryList addObject:model];
    }
    // 网络请求
    BSNewsTotalRequest* request = [BSNewsTotalRequest new];
    request.userId = [BSAppManager sharedInstance].currentUser.userId;
    Bsky_WeakSelf
    [MBProgressHUD showHud];
    [request startWithCompletionBlockWithSuccess:^(__kindof BSNewsTotalRequest * _Nonnull request) {
        [MBProgressHUD hideHud];
        Bsky_StrongSelf
        if (request.messageCategoryList.count > 0) {
            [self.messageCategoryList removeAllObjects];
            [self.messageCategoryList addObjectsFromArray:request.messageCategoryList];
        }
        [self.tableView reloadData];
    } failure:^(__kindof BSNewsTotalRequest * _Nonnull request) {
        [MBProgressHUD hideHud];
        [UIView makeToast:request.msg];
    }];
}

- (void)updateMessageStatus:(BSNewsCategory*)category {
    BSNewsUpdateRequest* request = [BSNewsUpdateRequest new];
    request.type = category.type;
    [request startWithCompletionBlockWithSuccess:^(__kindof BSNewsUpdateRequest * _Nonnull request) {
    } failure:^(__kindof BSNewsUpdateRequest * _Nonnull request) {
        [UIView makeToast:request.msg];
    }];
}

- (void)setupView {
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = Bsky_UIColorFromRGB(0x333333);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.text = @"消息中心";
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
}

#pragma mark --- UITableViewDataSource,UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [super numberOfSectionsInTableView:tableView] + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.messageCategoryList.count;
    }
    else
    {
        return [super tableView:tableView numberOfRowsInSection:section];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        BSMessageCell* cell = [tableView dequeueReusableCellWithIdentifier:@"BSMessageCell"];
        [cell bindData:self.messageCategoryList[indexPath.row]];
        return cell;
    }
    else
    {
       return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        BSNewsCategory* category = (BSNewsCategory*)self.messageCategoryList[indexPath.row];
        [self updateMessageStatus:category];
        BSCategoryMessageViewController* viewController = [[BSCategoryMessageViewController alloc]init];
        viewController.category = category;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else
    {
        [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 70.f;
    }
    else
    {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return NO;
    }
    else
    {
        return [super tableView:tableView canEditRowAtIndexPath:indexPath];
    }
}

- (void)onSelectedRecent:(NIMRecentSession *)recent atIndexPath:(NSIndexPath *)indexPath
{
    NTESSessionViewController *viewController = [[NTESSessionViewController alloc] initWithSession:recent.session];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
