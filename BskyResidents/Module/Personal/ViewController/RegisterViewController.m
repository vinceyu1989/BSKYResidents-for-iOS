//
//  RegisterViewController.m
//  BskyResidents
//
//  Created by 何雷 on 2017/9/27.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginTextField.h"

@interface RegisterViewController ()
{
    int _timerNum;
}
@property (weak, nonatomic) IBOutlet LoginTextField *phoneTF;
@property (weak, nonatomic) IBOutlet LoginTextField *codeTF;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UIButton *protocolBtn;

@property (nonatomic ,strong) UIImageView *phoneIcon;
@property (nonatomic ,strong) UIImageView *codeIcon;
@property (nonatomic ,strong) UIButton *codeBtn;    // 获取验证码

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}
- (void)initView
{
    self.title = @"用户注册";
    self.phoneTF.maxNum = 11;
    self.phoneTF.keyboardType = UIKeyboardTypePhonePad;
    self.phoneTF.leftView = self.phoneIcon;
    self.phoneTF.leftViewMode = UITextFieldViewModeAlways;
    
    self.codeTF.maxNum = 6;
    self.codeTF.keyboardType = UIKeyboardTypeNumberPad;
    self.codeTF.leftView = self.codeIcon;
    self.codeTF.leftViewMode = UITextFieldViewModeAlways;
    self.codeTF.rightView = self.codeBtn;
    self.codeTF.rightViewMode =UITextFieldViewModeAlways;
    
    [self.nextBtn setCornerRadius:self.nextBtn.height/2];
    
    //创建NSMutableAttributedString
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:self.protocolBtn.titleLabel.text];
    //添加文字颜色
    [attrStr addAttribute:NSForegroundColorAttributeName value:Bsky_UIColorFromRGB(0x4e7dd3) range:NSMakeRange(self.protocolBtn.titleLabel.text.length-10, 10)];
    [self.protocolBtn setAttributedTitle:attrStr forState:UIControlStateNormal];
    self.protocolBtn.titleLabel.numberOfLines = 0;
}
#pragma mark --- Setter  Getter

- (UIImageView *)phoneIcon
{
    if (!_phoneIcon) {
        _phoneIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"phone_icon"]];
        [_phoneIcon sizeToFit];
    }
    return _phoneIcon;
}
- (UIImageView *)codeIcon
{
    if (!_codeIcon) {
        _codeIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"password_icon"]];
        [_codeIcon sizeToFit];
    }
    return _codeIcon;
}
- (UIButton *)codeBtn
{
    if (!_codeBtn) {
        _codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _codeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_codeBtn setTitleColor:Bsky_UIColorFromRGB(0x4e7dd3) forState:UIControlStateNormal];
        [_codeBtn addTarget:self action:@selector(codeBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_codeBtn sizeToFit];
    }
    return _codeBtn;
}
#pragma mark -----  click

- (void)codeBtnPressed:(UIButton *)sender
{
    [self startTimer];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (IBAction)nextBtnPressed:(UIButton *)sender {
    
}
- (IBAction)protocolBtnPressed:(UIButton *)sender {
    
}
#pragma mark  ----- timer

///启动定时器
-(void)startTimer
{
    self.codeBtn.enabled = NO;
    _timerNum = 60;
    NSString * strTitle = [NSString stringWithFormat:@"%.ds", _timerNum];
    [self.codeBtn setTitle:strTitle forState:UIControlStateNormal];
    [self.codeBtn sizeToFit];
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(funcTimer:) userInfo:nil repeats:YES];
}

-(void)funcTimer:(NSTimer *)timer
{
    _timerNum--;
    NSString * strTitle = [NSString stringWithFormat:@"%.ds", _timerNum];
    [self.codeBtn setTitle:strTitle forState:UIControlStateNormal];
    if(_timerNum == 0)
    {
        [timer invalidate];
        [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.codeBtn.enabled = YES;
    }
    [self.codeBtn sizeToFit];
}


@end
