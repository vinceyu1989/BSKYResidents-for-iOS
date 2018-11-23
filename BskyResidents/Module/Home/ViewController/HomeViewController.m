//
//  HomeViewController.m
//  BskyResidents
//
//  Created by 何雷 on 2017/9/28.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "HomeViewController.h"
#import "BannerTableViewCell.h"
#import "ImmediatelySignedCell.h"
#import "BlankTableViewCell.h"
#import "FamilyDoctorCell.h"
#import "FamilyAccountCell.h"
#import "HealthDataCell.h"
#import "SectionTitleCell.h"
#import "GeneralServiceCell.h"
#import "ServicePackCell.h"
#import "BSSigningViewController.h"
#import "HomePopView.h"
#import "BSSigningServiceViewController.h"
#import "BSFollowupListViewController.h"
#import "SigningTeamHomeVC.h"
#import "BSFeedbackViewController.h"
#import "AuthenticateViewController.h"
#import "QRCodeViewController.h"
#import "NTESSessionViewController.h"

#import "HomeBannerRequest.h"
#import "BSSignInfoRequest.h"
#import "BSSignTeamRequest.h"
#import "BSSignTeamMemberRequest.h"
#import "BSWebViewController.h"
#import "LocationManager.h"
#import "ScanViewController.h"
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,FamilyDoctorCellDelegate,ImmediatelySignedCellDelegate>

@property (nonatomic ,strong) UITableView *tableView;

@property (nonatomic ,strong) HomeBannerRequest *bannerRequest;

@property (nonatomic ,strong) BSSignTeamRequest *teamRequest;

@property (nonatomic ,strong) BSSignTeamMemberRequest *teamMemberRequest;

@property (strong, nonatomic) UILabel *titleLabel;
@property (assign, nonatomic) BOOL isChange;//是否切换到健康汶川
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginLoadData) name:LoginSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getInfoLoadData) name:GetRealnameAuthenticateInfoSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(logoutClearData) name:LogoutNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectedSerive:) name:HomeSeriveNotificaton object:nil];

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = Bsky_UIColorFromRGB(0x4e7dd3);
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [self.tableView.mj_header beginRefreshing];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:Bsky_UIColorFromRGB(0x333333),NSForegroundColorAttributeName, [UIFont systemFontOfSize:18],NSFontAttributeName, nil]];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)initView
{    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:18];
    _titleLabel.text = @"巴蜀快医";
    [_titleLabel sizeToFit];
    self.navigationItem.titleView = _titleLabel;
    
    UIButton *serviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [serviceBtn setImage:[UIImage imageNamed:@"customerService_icon"] forState:UIControlStateNormal];
    [serviceBtn addTarget:self action:@selector(serviceBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [serviceBtn sizeToFit];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:serviceBtn];
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setImage:[UIImage imageNamed:@"add_icon"] forState:UIControlStateNormal];
    moreBtn.imageView.contentMode = UIViewContentModeCenter;
    moreBtn.imageView.clipsToBounds = NO;
    [moreBtn addTarget:self action:@selector(moreBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [moreBtn sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:moreBtn];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Bsky_SCREEN_WIDTH, Bsky_SCREEN_HEIGHT-Bsky_NAVIGATION_BAR_HEIGHT-Bsky_TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    self.tableView.backgroundColor = Bsky_UIColorFromRGB(0xf7f7f7);
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight=UITableViewAutomaticDimension;
    [self.tableView registerClass:[BannerTableViewCell class] forCellReuseIdentifier:[BannerTableViewCell cellIdentifier]];
    [self.tableView registerNib:[ImmediatelySignedCell nib] forCellReuseIdentifier:[ImmediatelySignedCell cellIdentifier]];
    [self.tableView registerClass:[BlankTableViewCell class] forCellReuseIdentifier:[BlankTableViewCell cellIdentifier]];
    [self.tableView registerNib:[FamilyDoctorCell nib] forCellReuseIdentifier:[FamilyDoctorCell cellIdentifier]];
    [self.tableView registerNib:[FamilyAccountCell nib] forCellReuseIdentifier:[FamilyAccountCell cellIdentifier]];
    [self.tableView registerNib:[HealthDataCell nib] forCellReuseIdentifier:[HealthDataCell cellIdentifier]];
    [self.tableView registerNib:[SectionTitleCell nib] forCellReuseIdentifier:[SectionTitleCell cellIdentifier]];
    [self.tableView registerClass:[GeneralServiceCell class] forCellReuseIdentifier:[GeneralServiceCell cellIdentifier]];
    [self.tableView registerNib:[ServicePackCell nib] forCellReuseIdentifier:[ServicePackCell cellIdentifier]];
    [self.view addSubview:self.tableView];
    
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self loadData];
    }];
    [self.tableView.mj_header beginRefreshing];
}
- (void)logoutClearData
{
    self.signInfoRequest = nil;
    self.teamRequest = nil;
    self.teamMemberRequest = nil;
    self.currentMemberModel = nil;
    [self.tableView reloadData];
}
- (void)loginLoadData
{
    if ([BSAppManager sharedInstance].currentUser.realnameInfo.verifStatus.integerValue != RealInfoVerifStatusTypeSuccess ) {
        [self.tableView.mj_header beginRefreshing];
    }
}
- (void)getInfoLoadData
{
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadData
{
    [self logoutClearData];//清除缓存数据
    if (!self.signInfoRequest) {
        self.signInfoRequest = [[BSSignInfoRequest alloc]init];
    }
    if (!self.teamRequest) {
        self.teamRequest = [[BSSignTeamRequest alloc]init];
    }
    if (!self.teamMemberRequest) {
        self.teamMemberRequest = [[BSSignTeamMemberRequest alloc]init];
    }
    // banner
    @weakify(self);
    LocationManager *locationManager = [LocationManager locationShare];
    __weak typeof(self) weak_self = self;
    __block BOOL banner = NO;
    [locationManager currentLocationWithLoctionBlock:^(NSString *state, NSString *city, NSString *subLocality, NSString *street) {
//        subLocality = @"汶川县";
//        locationManager.subLocality = @"汶川县";
        if ([subLocality isEqualToString:@"汶川县"] && weak_self.isChange == NO) {
            //            //切换到健康汶川
            [UIView makeToast:@"检测到您在汶川,将切换到健康汶川"];
            [weak_self changeToHealthWenChuan];
        }
        if (banner) {
            return ;
        }else{
            banner = YES;
        }
        self.bannerRequest.divisionAddr = locationManager.subLocality;
        [weak_self.bannerRequest startWithCompletionBlockWithSuccess:^(__kindof HomeBannerRequest * _Nonnull request) {
            [MBProgressHUD hideHud];
            [weak_self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        } failure:^(__kindof HomeBannerRequest * _Nonnull request) {
            NSLog(@"请求失败,%@",request.msg);
            [MBProgressHUD hideHud];
        }];
    }];
    
    
    [self updateSignInfo];
    
}
- (void)updateSignInfo{
    //  先获取获取签约信息
    @weakify(self);
    [self.signInfoRequest startWithCompletionBlockWithSuccess:^(__kindof BSSignInfoRequest * _Nonnull request) {
        @strongify(self);
        // 再获取签约团队和成员信息
        
        self.teamRequest.teamId = request.model.signInfo.teamId;
        self.teamMemberRequest.teamId = request.model.signInfo.teamId;
        [[BSAppManager sharedInstance] currentUser].tag = request.model.signInfo.tags;
        
        if (!request.model.signInfo.teamId.length) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
            return;
        }
        YTKBatchRequest *batchRequest = [[YTKBatchRequest alloc] initWithRequestArray:@[self.teamRequest,self.teamMemberRequest]];
        @weakify(self);
        [batchRequest startWithCompletionBlockWithSuccess:^(YTKBatchRequest *batchRequest) {
            @strongify(self);
            if (self.currentMemberModel) {
                
            }
            else if(self.teamMemberRequest.model && self.teamMemberRequest.model.memberList.count > 0 ){
                self.currentMemberModel = self.teamMemberRequest.model.memberList[0];
            }
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
            
        } failure:^(YTKBatchRequest *batchRequest) {
            @strongify(self);
            [self.tableView.mj_header endRefreshing];
            [UIView makeToast:@"网络出错"];
        }];
        
    } failure:^(__kindof BSSignInfoRequest * _Nonnull request) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [UIView makeToast:request.msg];
    }];
}
#pragma mark - 切换到健康汶川
- (void)changeToHealthWenChuan{
    _isChange = YES;
    _titleLabel.text = @"健康汶川";
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7+2+2+2+2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    switch (indexPath.row) {
        case 0:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:[BannerTableViewCell cellIdentifier] forIndexPath:indexPath];
            BannerTableViewCell *tableCell = (BannerTableViewCell *)cell;
            if (_bannerRequest.bannerModels.count > 0) {
                [tableCell setupData:_bannerRequest.bannerModels];
            }else{
                tableCell.imageArray  = @[@"banner2",@"banner1"];
            }
        }
            break;
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:[ImmediatelySignedCell cellIdentifier] forIndexPath:indexPath];
            ImmediatelySignedCell *tableCell = (ImmediatelySignedCell *)cell;
            tableCell.type = FamilyDoctorSignTypeError;
            if (self.signInfoRequest.model) {
                tableCell.type = self.signInfoRequest.model.resultStatus.integerValue;
                if (tableCell.type == FamilyDoctorSignTypeSuccess) {
                    tableCell.contentLabel.text = [NSString stringWithFormat:@"%@您好！您已签约%@卫生服务中心",self.signInfoRequest.model.signInfo.personName,self.signInfoRequest.model.signInfo.teamName];
                }
            }
            if (!tableCell.delegate) {
                tableCell.delegate = self;
            }
        }
            break;
        case 2:
            cell = [tableView dequeueReusableCellWithIdentifier:[BlankTableViewCell cellIdentifier] forIndexPath:indexPath];
            break;
        case 3:    // 家庭医生
        {
            cell = [tableView dequeueReusableCellWithIdentifier:[FamilyDoctorCell cellIdentifier] forIndexPath:indexPath];
            FamilyDoctorCell *tableCell = (FamilyDoctorCell *)cell;
            tableCell.type = FamilyDoctorCellTypeDoctor;
            tableCell.memberModel = self.currentMemberModel;
            if (!tableCell.delegate) {
                tableCell.delegate = self;
            }
        }
            break;
        case 4:
            cell = [tableView dequeueReusableCellWithIdentifier:[BlankTableViewCell cellIdentifier] forIndexPath:indexPath];
            break;
        case 5:   //  社区医院
        {
            cell = [tableView dequeueReusableCellWithIdentifier:[FamilyDoctorCell cellIdentifier] forIndexPath:indexPath];
            FamilyDoctorCell *tableCell = (FamilyDoctorCell *)cell;
            tableCell.type = FamilyDoctorCellTypeCommunity;
            tableCell.teamModel = self.teamRequest.model;
            if (!tableCell.delegate) {
                tableCell.delegate = self;
            }
        }
            break;
        case 6:
            cell = [tableView dequeueReusableCellWithIdentifier:[BlankTableViewCell cellIdentifier] forIndexPath:indexPath];
            break;
        case 7:   // 家庭账户
            cell = [tableView dequeueReusableCellWithIdentifier:[FamilyAccountCell cellIdentifier] forIndexPath:indexPath];
            break;
        case 8:
            cell = [tableView dequeueReusableCellWithIdentifier:[HealthDataCell cellIdentifier] forIndexPath:indexPath];
            break;
        case 9:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:[SectionTitleCell cellIdentifier] forIndexPath:indexPath];
            SectionTitleCell *tableCell = (SectionTitleCell *)cell;
            tableCell.titleLabel.text = @"综合服务";
        }
            break;
        case 10:
            cell = [tableView dequeueReusableCellWithIdentifier:[GeneralServiceCell cellIdentifier] forIndexPath:indexPath];
            break;
        case 11:
            cell = [tableView dequeueReusableCellWithIdentifier:[BlankTableViewCell cellIdentifier] forIndexPath:indexPath];
            break;
        case 12:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:[SectionTitleCell cellIdentifier] forIndexPath:indexPath];
            SectionTitleCell *tableCell = (SectionTitleCell *)cell;
            tableCell.titleLabel.text = @"机构收费服务包";
        }
            break;
        default:
            cell = [tableView dequeueReusableCellWithIdentifier:[ServicePackCell cellIdentifier] forIndexPath:indexPath];
            ServicePackCell *serviceCell = (ServicePackCell *)cell;
            NSArray *data = @[
                                   @{
                                       @"image" : @[@"home_慢阻肺",@"home_针灸"],
                                       @"title" : @[@"COPD慢阻肺康复管理",@"中医针灸理疗服务"]
                                       },
                                   @{
                                       @"image" : @[@"home_高血压糖尿病",@"home_老年人"],
                                       @"title" : @[@"高血压糖尿病管理",@"老年人健康监护服务"]
                                       }
                       ];
            [serviceCell setModel:data[indexPath.row - 13]];
            break;
    }
    
    return cell;
}

- (void)pushSigningTeamHomeVC
{
    if (self.currentMemberModel) {
        SigningTeamHomeVC *vc = [[SigningTeamHomeVC alloc]init];
        vc.type = FamilyDoctorCellTypeDoctor;
        vc.teamModel = self.teamRequest.model;
        vc.memberListModel = self.teamMemberRequest.model;
        vc.currentMemberModel = self.currentMemberModel;
        Bsky_WeakSelf
        vc.selectMemberBlock = ^(SignTeamMemberModel *currentMemberModel) {
            Bsky_StrongSelf
            self.currentMemberModel = currentMemberModel;
            [self.tableView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark --- click
- (void)selectedSerive:(NSNotification *)notifier{
    UIButton *btn = notifier.object;
    switch (btn.tag - 1000) {
        case 0:
            //一键呼医
            break;
        case 1:
            //预约挂号
        {
            NSString *realName = [BSAppManager sharedInstance].currentUser.realnameInfo.realName;
            NSString *cardId = [BSAppManager sharedInstance].currentUser.realnameInfo.documentNo;
            NSString *phone = [BSAppManager sharedInstance].currentUser.realnameInfo.mobileNo;
            if (realName.length && cardId.length && phone.length) {
                BSWebViewController *bsWebView = [[BSWebViewController alloc] init];
                NSString *urlStr = [NSString stringWithFormat:@"http://appcomweb.jkscw.com.cn/common/register/hospitalList?channel=bskyreg&patientname=%@&patientidcardno=%@&patienttelephone=%@",realName,cardId,phone];

                [bsWebView ba_web_loadURL:[NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
                bsWebView.showNavigationBar = YES;
                [self.navigationController pushViewController:bsWebView animated:YES];
            }else{
                [UIView makeToast:@"需要实名认证后才能使用该功能!"];
                AuthenticateViewController *vc = [[AuthenticateViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }
            break;
        case 2:
            //健康自测
            break;
        case 3:
            //专家咨询
            break;
        case 4:
            //中医频道
            break;
        case 5:
            //心理频道
            break;
        default:
            break;
    }
}

- (void)serviceBtnPressed:(UIButton *)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://400-800-1335"]];
}

- (void)moreBtnPressed:(UIButton *)sender
{
    [UIView animateWithDuration:0.2f animations:^{
        sender.imageView.transform = CGAffineTransformMakeRotation(-M_PI-M_PI_4);
    }];
    WS(weakSelf);
    [HomePopView sharedInstanceoOriginFrame:CGRectMake(Bsky_SCREEN_WIDTH-15, Bsky_TOP_BAR_HEIGHT+5, 0, 0) toFrame:CGRectMake(Bsky_SCREEN_WIDTH-15-150, Bsky_TOP_BAR_HEIGHT+5, 150, 136) completion:^(NSInteger index) {
        [UIView animateWithDuration:0.2f animations:^{
            sender.imageView.transform = CGAffineTransformMakeRotation(0);
            
        }];
        if (index == 0) { // 扫一扫
            ScanViewController *scan = [[ScanViewController alloc] init];
            // 1、 获取摄像设备
            AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
            if (device) {
                scan.block = ^(ScanViewController *vc, NSString *scanCode) {
                    NSLog(@"====== 二维码 = %@  =====",scanCode);
                    [vc.navigationController popViewControllerAnimated:NO];
                    if ([scanCode containsString:@"http"]) {
                        BSWebViewController *bsWebView = [[BSWebViewController alloc] init];
                        bsWebView.ba_web_progressTintColor = Bsky_UIColorFromRGBA(0x599dff,1);
                        bsWebView.ba_web_progressTrackTintColor = [UIColor whiteColor];
                        [bsWebView ba_web_loadURLString:scanCode];
                        bsWebView.showNavigationBar = YES;
                        [weakSelf.navigationController pushViewController:bsWebView animated:YES];
                    }
                };
            }
            [weakSelf.navigationController pushViewController:scan animated:YES];

        }else if (index == 1) { // 用药提醒
            
        }else if (index == 2) { // 个人二维码
            if (self.signInfoRequest.model.resultStatus.integerValue == FamilyDoctorSignTypeNotVerified)
            {
                AuthenticateViewController *vc = [[AuthenticateViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            else
            {
                QRCodeViewController *QRCodeVC = [[QRCodeViewController alloc] init];
                QRCodeVC.title = @"我的二维码";
                [self.navigationController pushViewController:QRCodeVC animated:YES];
            }
        }
    }];
}
#pragma mark --- FamilyDoctorCellDelegate
- (void)familyDoctorCellAvatarImageClick:(FamilyDoctorCell *)cell
{
    if (cell.type == FamilyDoctorCellTypeDoctor && cell.memberModel){
       
        [self pushSigningTeamHomeVC];
    }
}

- (void)familyDoctorCellFunctionalFirstBtnClick:(FamilyDoctorCell *)cell
{
    if (cell.type == FamilyDoctorCellTypeDoctor && cell.memberModel) {
        [self pushSigningTeamHomeVC];
    }
    else if (cell.type == FamilyDoctorCellTypeCommunity && cell.teamModel)
    {
        
    }
}
- (void)familyDoctorCellFunctionalSecondBtnClick:(FamilyDoctorCell *)cell
{
    NIMSession *session = [NIMSession session:self.currentMemberModel.phone type:NIMSessionTypeP2P];
    NTESSessionViewController *viewController = [[NTESSessionViewController alloc] initWithSession:session];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark ----- ImmediatelySignedCellDelegate

- (void)immediatelySignedCellBtnClick:(ImmediatelySignedCell *)cell
{
    switch (cell.type) {
        case FamilyDoctorSignTypeSuccess: // 成功获取签约信息
        {
            BSSigningServiceViewController* viewController = [BSSigningServiceViewController new];
            viewController.signInfo = self.signInfoRequest.model;
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case FamilyDoctorSignTypeNotVerified:  // 未实名认证
        {
            AuthenticateViewController *vc = [[AuthenticateViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case FamilyDoctorSignTypeSubmitted:  //  签约申请已提交 审核中
        {
            [UIView makeToast:@"您的签约申请正在审核中\n请耐心等待"];
        }
            break;
        case FamilyDoctorSignTypeAreaNonactivated:  //  该区域未开通
        {
            [UIView makeToast:@"您所在区域暂未开通业务\n敬请期待"];
        }
            break;
        case FamilyDoctorSignTypeVerified:   //  已实名认证可申请
        {
             [self pushVerifiedSigningVC];
        }
            break;
        case FamilyDoctorSignTypeError:  //  接口出错
        {
            [UIView makeToast:@"获取信息失败"];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - get
- (HomeBannerRequest *)bannerRequest{
    if (!_bannerRequest) {
        _bannerRequest = [[HomeBannerRequest alloc] init];
    }
    return _bannerRequest;
}


- (void)pushVerifiedSigningVC
{
    BSSigningViewController* viewController = [BSSigningViewController viewControllerFromStoryboard];
    Bsky_WeakSelf
    viewController.signCompleteBlock = ^{
        Bsky_StrongSelf
        [self.tableView.mj_header beginRefreshing];
    };
    [self.navigationController pushViewController:viewController animated:YES];
}


@end
