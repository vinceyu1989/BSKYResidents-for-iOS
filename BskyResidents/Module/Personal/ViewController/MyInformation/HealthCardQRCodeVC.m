//
//  HealthCard&QRCodeVC.m
//  BskyResidents
//
//  Created by 罗林轩 on 2017/11/20.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "HealthCardQRCodeVC.h"
#import "HealthCardInfomationView.h"
#import "BSCheckHealthCardRequest.h"

@interface HealthCardQRCodeVC ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeight;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *phoneNum;
@property (weak, nonatomic) IBOutlet UILabel *IDCard;
@property (weak, nonatomic) IBOutlet UIImageView *QRCodeImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width;

@end

@implementation HealthCardQRCodeVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (kDevice_Is_iPhoneX) {
        _topHeight.constant = 57;
    }
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    BSCheckHealthCardRequest *check_request = [[BSCheckHealthCardRequest alloc] init];
//    check_request.phone = [BSAppManager sharedInstance].currentUser.realnameInfo.mobileNo;
//    Bsky_WeakSelf
//    [check_request startWithCompletionBlockWithSuccess:^(__kindof BSCheckHealthCardRequest * _Nonnull request) {
//        Bsky_StrongSelf
//        NSInteger type = [request.ret integerValue];
//        if (type == 3) {
//            [self.contentLabel setTitle:@"已绑定银行卡" forState:UIControlStateNormal];
//        } else if (type == 2) {
//            [self.contentLabel setTitle:@"未绑定银行卡" forState:UIControlStateNormal];
//        } else if (type == 1) {
//            [self.contentLabel setTitle:@"未申领健康卡" forState:UIControlStateNormal];
//        }
//    } failure:^(__kindof BSCheckHealthCardRequest * _Nonnull request) {
//        [UIView makeToast:request.msg];
//        Bsky_StrongSelf
//        [self.contentLabel setTitle:@"未申领健康卡" forState:UIControlStateNormal];
//    }];
}

- (void)viewDidLayoutSubviews {
    self.width.constant = self.height.constant = 218*Bsky_SCREEN_WIDTH/375.f;
}

- (void)setModel:(QRModel *)model{
    [self.view layoutIfNeeded];
    _model = model;
    NSString *replacePhoneNum = [_model.lxdh stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    
    _name.text = model.realName;
    _phoneNum.text = replacePhoneNum;
    NSString *replaceIDNum = [_model.zjhm stringByReplacingCharactersInRange:NSMakeRange(3, 11) withString:@"***********"];
    _IDCard.text = replaceIDNum;
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:model.base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *image = [UIImage imageWithData:data];
    if (image == nil) {
        UIImage *center = [UIImage imageNamed:@"scan_center"];
        UIImage *QRImage = [UIImage qrImageForString:self.model.base64 centerImage:center];
        [_QRCodeImage setImage:QRImage];

    }else{
        [_QRCodeImage setImage:image];
    }
    
    [_QRCodeImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(kScreenWidth * (float)3/4);
    }];
    [self.view layoutIfNeeded];
}

- (IBAction)useInformation:(UIButton *)sender {
    HealthCardInfomationView *useInformation = [[HealthCardInfomationView alloc] init];
    [self.navigationController pushViewController:useInformation animated:YES];
}

#pragma mark - 退回
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 选项
//- (IBAction)options:(id)sender {
//    [AlertViewController alertWithTitle:nil String:nil actionTitleArray:@[@"支付管理",@"用卡记录",@"取消"] viewController:self preferredStyle:UIAlertControllerStyleActionSheet selectedBlock:^(NSInteger selectedIndex) {
//
//    }];
//}

#pragma mark - 绑定银行卡
//- (IBAction)binding:(id)sender {
//
//}

@end
