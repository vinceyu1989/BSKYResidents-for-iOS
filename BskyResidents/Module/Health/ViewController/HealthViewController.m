//
//  HealthViewController.m
//  BskyResidents
//
//  Created by 罗林轩 on 2017/10/12.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "HealthViewController.h"
#import "ListCell.h"
#import "BMICell.h"
#import "TitleView.h"
#import "HealthNotifier.h"
#import "BSFollowupListViewController.h"
#import "ToH5Request.h"
#import "AuthenticateViewController.h"
@interface HealthViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *functionDatas;
@property (strong, nonatomic) TitleView *titleView;

@end

@implementation HealthViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar addSubview:self.titleView];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.titleView removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickBtn:) name:healthyNotifier object:nil];
    [self initSubView];
}

- (void)initSubView{
    self.view.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
    [self.view addSubview:self.tableView];
    
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [backBtn setTitle:@"7月24日 周一" forState:UIControlStateNormal];
//    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [backBtn setImage:[UIImage imageNamed:@"health_(-日期"] forState:UIControlStateNormal];
   
}

- (TitleView *)titleView{
    if (!_titleView) {
        _titleView = [TitleView loadNib];
        _titleView.frame = CGRectMake(0, 0, Bsky_SCREEN_WIDTH, 44);
    }
    return _titleView;
}


#pragma mark - get
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -40, CGRectGetWidth(self.view.frame), CGRectGetHeight([UIScreen mainScreen].bounds) - Bsky_TAB_BAR_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[ListCell nib] forCellReuseIdentifier:[ListCell cellIdentifier]];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:[UITableViewCell cellIdentifier]];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ListCell *cell = [tableView dequeueReusableCellWithIdentifier:[ListCell cellIdentifier]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
//        BMICell *cell = [tableView dequeueReusableCellWithIdentifier:[BMICell cellIdentifier]];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell cellIdentifier]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImage *image = [UIImage imageNamed:@"health_图层0"];
        UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
        [cell.contentView addSubview:imageview];
        [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.mas_equalTo(0);
        }];
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    UIViewController *vc = [[UIViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellH = 0;
    switch (indexPath.row) {
        case 0:
            cellH = 250;
            break;
        case 1:{
            UIImage *image = [UIImage imageNamed:@"health_健康"];
            CGSize imageSize = image.size;
            CGFloat imageH = Bsky_SCREEN_WIDTH / imageSize.width * imageSize.height;
            
            cellH = imageH;
        }
           
        default:
            break;
    }
    return cellH;
}

#pragma mark - notifier
- (void)clickBtn:(NSNotification *)notifier{
    NSIndexPath *indexPath = notifier.object;
    if([[BSAppManager sharedInstance].currentUser.realnameInfo.verifStatus isEqualToString:@"01006003"] == NO || [[BSAppManager sharedInstance].currentUser.isChooseAD integerValue] == 1){
        AuthenticateViewController *authenticate = [[AuthenticateViewController alloc]init];
        [self.navigationController pushViewController:authenticate animated:YES];
        return;
    }
    if (indexPath.section == 0) {
        switch (indexPath.item) {
            case 0:
                break;
                
            default:
                break;
        }
    }else if (indexPath.section == 1){
            switch (indexPath.item) {
                case 0:
                    //健康档案
                {
                    BSWebViewController *webVC = [[BSWebViewController alloc]init];
                    webVC.ba_web_progressTintColor = Bsky_UIColorFromRGBA(0x599dff,1);
                    webVC.ba_web_progressTrackTintColor = [UIColor whiteColor];
//                    健康档案需求为：
//                    1.身份证号码
//                    2.区划编码
//                    3.token
//                    NSString * jsStr = [NSString stringWithFormat:@"UserIos('%@','%@','%@')",[BSAppManager sharedInstance].currentUser.realnameInfo.documentNo,[BSClientManager sharedInstance].tokenId,[BSAppManager sharedInstance].currentUser.realnameInfo.areaCode];
//                    webVC.ocTojsStr = jsStr;
                    [self getH5:reArchives returnBlock:^(NSString *url) {
                        NSString *cardId = [BSAppManager sharedInstance].currentUser.realnameInfo.documentNo;
                        NSString *string = [NSString stringWithFormat:@"%@&cardId=%@&headMode=%@",url,cardId,[[BSClientManager sharedInstance].headMode urlencode]];
                        [webVC ba_web_loadURL:[NSURL URLWithString:string]];
                        [self.navigationController pushViewController:webVC animated:YES];
                    }];
                }
                    break;
                    
                default:
                    break;
            }
    }
    else{
        switch (indexPath.item) {
            case 0:
                //*住院记录*//
                
                break;
            case 1:
                //*随访记录*//
            {
                BSFollowupListViewController *followList = [BSFollowupListViewController viewControllerFromStoryboard];
                [self.navigationController pushViewController:followList animated:YES];
            }
                break;
            case 2:
                //*费用清单*//
                
                break;
            case 3:
                //*报告查询*//
           
            default:
                break;
        }
    }
}

#pragma mark - H5地址
- (void)getH5:(H5RequestType)type returnBlock:(void (^) (NSString * url))returnWithUrl{
    ToH5Request *requet = [[ToH5Request alloc] initWithType:type needToken:YES];
    [MBProgressHUD showHud];
    [requet startWithCompletionBlockWithSuccess:^(__kindof ToH5Request * _Nonnull request) {
        returnWithUrl(requet.url);
        [MBProgressHUD hideHud];
    } failure:^(__kindof ToH5Request * _Nonnull request) {
        [MBProgressHUD hideHud];
        NSLog(@"%@",requet.error);
        [UIView makeToast:requet.msg];
    }];
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:healthyNotifier object:nil];
}
@end
