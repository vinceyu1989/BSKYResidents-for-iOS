//
//  HealthCardViewController.m
//  BskyResidents
//
//  Created by 罗林轩 on 2017/10/19.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "HealthCardViewController.h"
#import "HealthCardInfomationView.h"
#import "RegisterHealthCard.h"
#import "BSGetHealthCardInfo.h"
#import "HealthCardQRCodeVC.h"
#import "BSCheckHealthCardRequest.h"
#import "BSFollowupListViewController.h"
#import "ChildCardListViewController.h"

@interface HealthCardViewController () {
    CGFloat _multiply;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *cardImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *IDCardLabel;
@property (weak, nonatomic) IBOutlet UIButton *introduceLabel;

@property (weak, nonatomic) IBOutlet UILabel *roundLLabel;
@property (weak, nonatomic) IBOutlet UILabel *roundRLabel;
@property (weak, nonatomic) IBOutlet UIImageView *QRCode;

@property (nonatomic, assign) BOOL isCash;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *updateHeight;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation HealthCardViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (kDevice_Is_iPhoneX) {
        _topConstraint.constant = 57;
    }
    [self checkHealthBankCardType];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
 - (void)viewDidLayoutSubviews{
    self.scrollView.contentSize = CGSizeMake(Bsky_SCREEN_WIDTH, self.updateHeight.constant+25.f);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
}

- (void)initData {
    _multiply = Bsky_SCREEN_WIDTH/375.f;
    self.isCash = NO;
    [self.backView setCornerRadius:5];
    [self.roundLLabel setCornerRadius:12.5f];
    [self.roundRLabel setCornerRadius:12.5f];
    self.cardImageView.bounds = CGRectMake(0, 0, 315.f*_multiply, 187.5f*_multiply);
}

- (void)initView {
    self.nameLabel.text = self.model.realName;
    NSString *replaceIDNum = [self.model.zjhm stringByReplacingCharactersInRange:NSMakeRange(3, 11) withString:@"***********"];
    self.IDCardLabel.text = replaceIDNum;
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self.model.base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *image = [UIImage imageWithData:data];
//    [self.QRCode setImage:image];
    if (image == nil) {
        UIImage *center = [UIImage imageNamed:@"scan_center"];
        UIImage *QRImage = [UIImage qrImageForString:self.model.base64 centerImage:center];
        [self.QRCode setImage:QRImage];
    }else{
        [self.QRCode setImage:image];
    }
    
    [self.view setNeedsLayout];
}
//*<检查健康卡关联银行卡状态 >/
- (void)checkHealthBankCardType {
    BSCheckHealthCardRequest *check_request = [[BSCheckHealthCardRequest alloc] init];
    check_request.phone = [BSAppManager sharedInstance].currentUser.realnameInfo.mobileNo;
    Bsky_WeakSelf
    [check_request startWithCompletionBlockWithSuccess:^(__kindof BSCheckHealthCardRequest * _Nonnull request) {
        Bsky_StrongSelf
        NSInteger type = [request.ret integerValue];
        if (type == 3) {
            self.isCash = YES;
        } else {
            self.isCash = NO;
        }
    } failure:^(__kindof BSCheckHealthCardRequest * _Nonnull request) {
        [UIView makeToast:request.msg];
        Bsky_StrongSelf
        self.isCash = NO;
    }];
}

- (void)setModel:(QRModel *)model{
    _model = model;
}

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

#pragma mark - button press

- (IBAction)gestureToQRVC:(UITapGestureRecognizer *)sender {
    HealthCardQRCodeVC *qr_vc = [[HealthCardQRCodeVC alloc] init];
    qr_vc.model = self.model;
    [self.navigationController pushViewController:qr_vc animated:YES];
}

- (IBAction)respondToBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
//*<健康卡说明 >/
- (IBAction)respondToIntroduce:(id)sender {
    HealthCardInfomationView *useInformation = [[HealthCardInfomationView alloc] init];
    [self.navigationController pushViewController:useInformation animated:YES];
}
//*<健康档案 >/
- (IBAction)respondToHeathRecord:(id)sender {
    BSWebViewController *webVC = [[BSWebViewController alloc]init];
    webVC.ba_web_progressTintColor = Bsky_UIColorFromRGBA(0x599dff,1);
    webVC.ba_web_progressTrackTintColor = [UIColor whiteColor];
//  健康档案需求为：
//  1.身份证号码
//  2.区划编码
//  3.token
//    NSString * jsStr = [NSString stringWithFormat:@"UserIos('%@','%@','%@')",[BSAppManager sharedInstance].currentUser.realnameInfo.documentNo,[BSClientManager sharedInstance].tokenId,[BSAppManager sharedInstance].currentUser.realnameInfo.areaCode];
//    webVC.ocTojsStr = jsStr;
    [self getH5:reArchives returnBlock:^(NSString *url) {
        NSString *cardId = [BSAppManager sharedInstance].currentUser.realnameInfo.documentNo;
        NSString *string = [NSString stringWithFormat:@"%@&cardId=%@&headMode=%@",url,cardId,[[BSClientManager sharedInstance].headMode urlencode]];
        [webVC ba_web_loadURL:[NSURL URLWithString:string]];
        [self.navigationController pushViewController:webVC animated:YES];
    }];
}
//*<随访记录 >/
- (IBAction)respondToFollowup:(id)sender {
    BSFollowupListViewController *followList = [BSFollowupListViewController viewControllerFromStoryboard];
    [self.navigationController pushViewController:followList animated:YES];
}
//*<我的钱包 >/
- (IBAction)respondToCash:(id)sender {
    //判断钱包是否存在
    if (self.isCash) {
        ToH5Request *requet = [[ToH5Request alloc] initWithType:toCmbWallet needToken:YES];
        [MBProgressHUD showHud];
        Bsky_WeakSelf
        [requet startWithCompletionBlockWithSuccess:^(__kindof ToH5Request * _Nonnull request) {
            [MBProgressHUD hideHud];
            Bsky_StrongSelf
            BSWebViewController *webVC = [[BSWebViewController alloc]init];
            webVC.showNavigationBar = YES;
            webVC.title = @"我的钱包";
            webVC.ba_web_progressTintColor = Bsky_UIColorFromRGBA(0x599dff,1);
            webVC.ba_web_progressTrackTintColor = [UIColor whiteColor];
            [webVC ba_web_loadURLString:request.url];
            [self.navigationController pushViewController:webVC animated:YES];
        } failure:^(__kindof ToH5Request * _Nonnull request) {
            [MBProgressHUD hideHud];
            [UIView makeToast:requet.msg];
        }];
    } else {
        ToH5Request *requet = [[ToH5Request alloc] initWithType:cmdSign needToken:YES];
        [MBProgressHUD showHud];
        Bsky_WeakSelf
        [requet startWithCompletionBlockWithSuccess:^(__kindof ToH5Request * _Nonnull request) {
            [MBProgressHUD hideHud];
            Bsky_StrongSelf
            BSWebViewController *webVC = [[BSWebViewController alloc]init];
            webVC.showNavigationBar = YES;
            webVC.title = @"银行卡激活";
            webVC.ba_web_progressTintColor = Bsky_UIColorFromRGBA(0x599dff,1);
            webVC.ba_web_progressTrackTintColor = [UIColor whiteColor];
            [webVC ba_web_loadURLString:[request.url stringByAppendingFormat:@"&userId=%@",[BSAppManager sharedInstance].currentUser.realnameInfo.userId]];
            [self.navigationController pushViewController:webVC animated:YES];
        } failure:^(__kindof ToH5Request * _Nonnull request) {
            [MBProgressHUD hideHud];
            [UIView makeToast:requet.msg];
        }];
    }
}
//*<门诊挂号 >/
- (IBAction)respondToRegistate:(id)sender {
    NSLog(@"//*<门诊挂号 >/");
    [UIView makeToast:@"该功能暂未开放"];
}
//*<儿童健康卡 >/
- (IBAction)respondToPayment:(id)sender {
    NSLog(@"//*<儿童健康卡 >/");
    ChildCardListViewController *vc = [[ChildCardListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
//*<疫苗记录 >/
- (IBAction)respondToInquire:(id)sender {
    NSLog(@"//*<疫苗记录 >/");
    BSWebViewController *webVC = [[BSWebViewController alloc]init];
    webVC.showNavigationBar = YES;
    webVC.title = @"疫苗记录查询";
    webVC.webCanGoBack = YES;
    [webVC ba_web_loadURL:[NSURL URLWithString:@"https://apissl.jkscw.com.cn/bskyH5/BskyM/CheckVaccine/CheckVaccine.html"]];
    
    [self.navigationController pushViewController:webVC animated:YES];
}

@end
