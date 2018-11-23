//
//  BSFollowupListViewController.m
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/16.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSFollowupListViewController.h"
#import "BSFollowupListCell.h"
#import "Placeholder.h"

@interface BSFollowupListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray* followupList;

@property (nonatomic, copy) NSString* tangniaobingUrl;
@property (nonatomic, copy) NSString* gaoxueyaUrl;

@end

@implementation BSFollowupListViewController

+ (instancetype)viewControllerFromStoryboard {
    return [[UIStoryboard storyboardWithName:@"Health" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:NSStringFromClass(self)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupView];
    
    [self loadData];
    
    WS(weakSelf);
    [self loadUrlWithType:reTnbsf completion:^(NSString *url) {
        weakSelf.tangniaobingUrl = url;
    }];
    [self loadUrlWithType:reGxysf completion:^(NSString *url) {
        weakSelf.gaoxueyaUrl = url;
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tangniaobingUrl = nil;
    self.gaoxueyaUrl = nil;
}
#pragma mark -

- (void)setupView {
    self.title = @"随访记录";
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, CGFLOAT_MIN)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, CGFLOAT_MIN)];
    self.tableView.backgroundColor = Bsky_UIColorFromRGBA(0xf7f7f7,1);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    WS(weakSelf);
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        sleep(2);
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)loadData {
    BSFollowupListRequest* request = [BSFollowupListRequest new];
    WS(weakSelf);
    [MBProgressHUD showHud];
    [request startWithCompletionBlockWithSuccess:^(__kindof BSFollowupListRequest * _Nonnull request) {
        [MBProgressHUD hideHud];
        weakSelf.followupList = request.followupList;
        if (weakSelf.followupList.count == 0) {
            Placeholder *placeholder = [Placeholder showWithType:plactholderStateOnlyString];
            placeholder.content.text = @"抱歉，暂无随访数据";
            placeholder.frame = self.tableView.frame;
            [self.view addSubview:placeholder];
        }
        [weakSelf.tableView reloadData];
    } failure:^(__kindof BSFollowupListRequest * _Nonnull request) {
        [MBProgressHUD hideHud];
//        [UIView makeToast:request.msg];
        Placeholder *placeholder = [Placeholder showWithType:plactholderStateOnlyString];
        placeholder.content.text = request.msg;
        placeholder.frame = self.tableView.frame;
        [self.view addSubview:placeholder];
    }];
}

- (void)loadUrlWithType:(H5RequestType)type completion:(void (^)(NSString* url))completion {
    ToH5Request *requet = [[ToH5Request alloc] initWithType:type needToken:YES];
    [MBProgressHUD showHud];
    [requet startWithCompletionBlockWithSuccess:^(__kindof ToH5Request * _Nonnull request) {
        [MBProgressHUD hideHud];
        if (completion) {
            completion(request.url);
        }
    } failure:^(__kindof ToH5Request * _Nonnull request) {
        [MBProgressHUD hideHud];
        if (completion) {
            completion(nil);
        }
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.followupList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BSFollowupListCell* cell = [tableView dequeueReusableCellWithIdentifier:@"BSFollowupListCell"];
    
    BSFollowup* item = self.followupList[indexPath.section];
    [cell bindData:item];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:@"BSFollowupListCell" configuration:^(BSFollowupListCell* cell) {
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 15.f;
    }
    return 10.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, 20)];
    view.backgroundColor = Bsky_UIColorFromRGBA(0xf7f7f7,1);
    return view;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, CGFLOAT_MIN)];
    view.backgroundColor = Bsky_UIColorFromRGBA(0xf7f7f7,1);
    return view;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BSFollowup* item = self.followupList[indexPath.section];
    if ([item.followUpType isEqualToString:@"1"]) { // 高血压
        if (self.gaoxueyaUrl) {
            [self jumpUrl:self.gaoxueyaUrl followupId:item.id];
        }else {
            WS(weakSelf);
            [self loadUrlWithType:reGxysf completion:^(NSString *url) {
                [weakSelf jumpUrl:url followupId:item.id];
            }];
        }
    }else if ([item.followUpType isEqualToString:@"2"]) {   // 糖尿病
        if (self.tangniaobingUrl) {
            [self jumpUrl:self.tangniaobingUrl followupId:item.id];
        }else {
            WS(weakSelf);
            [self loadUrlWithType:reTnbsf completion:^(NSString *url) {
                [weakSelf jumpUrl:url followupId:item.id];
            }];
        }
    }
}

- (void)jumpUrl:(NSString*)url followupId:(NSString*)followupId {
    BSWebViewController *webVC = [[BSWebViewController alloc]init];
    webVC.ba_web_progressTintColor = Bsky_UIColorFromRGBA(0x599dff,1);
    webVC.ba_web_progressTrackTintColor = [UIColor whiteColor];
    
//    NSString * jsStr = [NSString stringWithFormat:@"UserIos('%@','%@','%@')",followupId,[BSClientManager sharedInstance].tokenId,[BSAppManager sharedInstance].currentUser.realnameInfo.areaCode];
//    webVC.ocTojsStr = jsStr;
    NSString * urlStr = [NSString stringWithFormat:@"%@&followId=%@",url,followupId];
     [webVC ba_web_loadURLString:urlStr];
//    [webVC ba_web_loadURLString:url];
    [self.navigationController pushViewController:webVC animated:YES];
}

@end
