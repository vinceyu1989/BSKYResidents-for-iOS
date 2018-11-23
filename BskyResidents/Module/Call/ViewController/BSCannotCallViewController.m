//
//  BSCannotCallViewController.m
//  BskyResidents
//
//  Created by LinfengYU on 2017/11/7.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSCannotCallViewController.h"

@interface BSCannotCallViewController ()

@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIButton *homeButton;
@property (weak, nonatomic) IBOutlet UIButton *homeButton2;
@property (weak, nonatomic) IBOutlet UIButton *signButton;

@end

@implementation BSCannotCallViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.status = FamilyDoctorSignTypeError;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)setupView {
    
    switch (self.status) {
            
            //            FamilyDoctorSignTypeSuccess = 0,    // 成功获取签约信息
            //            FamilyDoctorSignTypeNotVerified = 1,    // 未实名认证
            //            FamilyDoctorSignTypeSubmitted = 2 ,        //  签约申请已提交 审核中
            //            FamilyDoctorSignTypeAreaNonactivated = 3 ,        //  该区域未开通
            //            FamilyDoctorSignTypeVerified = 4 ,        //  已实名认证可申请
            //            FamilyDoctorSignTypeError = 10        //  接口出错
            
        case FamilyDoctorSignTypeSubmitted:
        {
            self.tipLabel.text = @"您的家庭医生团队正在申请中，暂无法一键呼叫您的家庭医生！";
            self.homeButton2.hidden = YES;
            self.signButton.hidden = YES;
        }
            break;
        case FamilyDoctorSignTypeAreaNonactivated:
        {
            self.tipLabel.text = @"您所在的区域暂未开通家庭医生服务，暂无法一键呼叫您的家庭医生！";
            self.homeButton2.hidden = YES;
            self.signButton.hidden = YES;
        }
            break;
        case FamilyDoctorSignTypeVerified:
        {
            self.tipLabel.text = @"您当前尚未绑定家庭医生，暂无法一键呼叫您的家庭医生！";
            self.homeButton.hidden = YES;
        }
            break;
            
        default:
        {
            self.tipLabel.text = @"暂无法一键呼叫您的家庭医生！";
            self.homeButton2.hidden = YES;
            self.signButton.hidden = YES;
        }
            break;
    }
    
    self.homeButton.layer.borderWidth = 1;
    self.homeButton.layer.cornerRadius = 5;
    self.homeButton.layer.borderColor = Bsky_UIColorFromRGBA(0x4e7dd3,1).CGColor;
    
    self.homeButton2.layer.borderWidth = 1;
    self.homeButton2.layer.cornerRadius = 5;
    self.homeButton2.layer.borderColor = Bsky_UIColorFromRGBA(0x4e7dd3,1).CGColor;
    
    [self.signButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.signButton.backgroundColor = Bsky_UIColorFromRGBA(0x4e7dd3,1);
    self.signButton.layer.masksToBounds = YES;
    self.signButton.layer.cornerRadius = 5;
}
#pragma mark - UI Action

- (IBAction)onHome:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)signBtnPressed:(UIButton *)sender {
    
    Bsky_WeakSelf
    [self.navigationController dismissViewControllerAnimated:NO completion:^{
        Bsky_StrongSelf;
        if (self.signCompleteBlock) {
            self.signCompleteBlock();
        }
    }];
}


@end

