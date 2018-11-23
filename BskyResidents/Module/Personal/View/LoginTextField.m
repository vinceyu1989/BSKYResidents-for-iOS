//
//  LoginTextField.m
//  BSKYDoctorPro
//
//  Created by 何雷 on 2017/8/22.
//  Copyright © 2017年 ky. All rights reserved.
//

#import "LoginTextField.h"

@interface LoginTextField ()<UITextFieldDelegate>

@property (nonatomic ,strong) UIView *shadowView;

@property (nonatomic ,strong) UIButton *clearBtn;

@property (nonatomic, strong) UIView *tapView;

@end

@implementation LoginTextField

static CGFloat const kLoginTextFieldLeftMargin = 15.f;

static CGFloat const kLoginTextFieldCenterMargin = 10.f;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initView];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initView];
}
- (void)initView
{
    self.maxNum = 10000000;
    
    self.backgroundColor = [UIColor whiteColor];
    if (Bsky_SCREEN_WIDTH < 370) {
        self.font = [UIFont systemFontOfSize:self.font.pointSize-2];
    }
    
    self.tintColor = Bsky_UIColorFromRGB(0xcccccc);
    self.textColor = Bsky_UIColorFromRGB(0x333333);
    self.delegate = self;
    self.layer.borderColor =Bsky_UIColorFromRGB(0xcccccc).CGColor;
    self.layer.borderWidth = 1.0;
    self.returnKeyType = UIReturnKeyDone;
    [self setCornerRadius:self.height/2];

    self.shadowView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.superview insertSubview:self.shadowView belowSubview:self];
    self.shadowView.layer.shadowColor = Bsky_UIColorFromRGB(0x4e7dd3).CGColor;
    self.shadowView.layer.shadowOffset = CGSizeZero;
    self.shadowView.layer.shadowOpacity = 0.9;
    self.shadowView.layer.shadowRadius = 3;
    self.shadowView.layer.masksToBounds = NO;
    self.shadowView.hidden = YES;
    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];

    self.clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.clearBtn setImage:[UIImage imageNamed:@"textField_delete"] forState:UIControlStateNormal];
    [self.clearBtn addTarget:self action:@selector(clearBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.clearBtn sizeToFit];
    self.clearBtn.height = self.height;
    self.clearBtn.hidden = YES;
    [self addSubview:self.clearBtn];
    
    [self layoutIfNeeded];
}
#pragma mark ---- setter getter

- (void)setTapAcitonBlock:(TextFieldTapAcitonBlock)tapAcitonBlock {
    _tapAcitonBlock = tapAcitonBlock;
    self.tapView.hidden = !_tapAcitonBlock;
}

- (UIView *)tapView {
    if (!_tapView) {
        _tapView = [[UIView alloc]initWithFrame:CGRectZero];
        _tapView.backgroundColor = [UIColor clearColor];
        [self addSubview:_tapView];
        [_tapView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        _tapView.userInteractionEnabled = YES;
        UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapTextField)];
        [_tapView addGestureRecognizer:myTap];
    }
    return _tapView;
}
- (void)didTapTextField {
    // 响应点击事件时，隐藏键盘
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow endEditing:YES];
    if (self.tapAcitonBlock) {
        self.tapAcitonBlock();
    }
}

#pragma mark ---- UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    self.shadowView.hidden = NO;
    self.layer.borderColor =Bsky_UIColorFromRGB(0x4e7dd3).CGColor;
    if (!self.shadowView.layer.shadowPath) {
        self.shadowView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.shadowView.bounds cornerRadius:self.shadowView.height/2].CGPath;
    }
    if (self.tapAcitonBlock) {
        [self performSelector:@selector(didTapTextField) withObject:nil afterDelay:0.1];
        return;
    }
    if (textField.text.length > 0) {
        self.clearBtn.hidden = NO;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.clearBtn.hidden = YES;
    self.shadowView.hidden = YES;
    self.layer.borderColor =Bsky_UIColorFromRGB(0xcccccc).CGColor;
    if (self.endEditBlock) {
        self.endEditBlock(textField.text);
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self resignFirstResponder];
    return YES;
}

#pragma mark ---- pressed

- (void)clearBtnPressed
{
    self.text = @"";
    self.clearBtn.hidden = YES;
}
#pragma mark - Noti Event

-(void)didChange:(NSNotification*)noti
{
    self.clearBtn.hidden = self.text.length <= 0;
    
    if (self.text.length >= self.maxNum) {
        self.text = [self.text substringToIndex:self.maxNum];
    }
}
#pragma mark ---- UI

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat x = self.rightView ? self.rightView.x : self.width;
    
    self.clearBtn.center = CGPointMake(x-self.clearBtn.width/2-10, self.height/2);
}
- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += kLoginTextFieldLeftMargin;
    return iconRect;
}
- (CGRect)rightViewRectForBounds:(CGRect)bounds
{
    CGRect iconRect = [super rightViewRectForBounds:bounds];
    iconRect.origin.x -= kLoginTextFieldLeftMargin;
    return iconRect;
}
- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect textRect = [super textRectForBounds:bounds];
    if (self.leftView) {
        textRect.origin.x = self.leftView.right+ kLoginTextFieldCenterMargin;
    }
    else
    {
        textRect.origin.x = kLoginTextFieldLeftMargin;
    }
    textRect.size.width = self.clearBtn.left-textRect.origin.x;
    return textRect;
}
- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    CGRect textRect = [super placeholderRectForBounds:bounds];
    if (self.leftView) {
        textRect.origin.x = self.leftView.right+ kLoginTextFieldCenterMargin;
    }
    else
    {
        textRect.origin.x = kLoginTextFieldLeftMargin;
    }
    textRect.size.width = self.clearBtn.left-textRect.origin.x;
    return textRect;
}
- (CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect textRect = [super editingRectForBounds:bounds];
    if (self.leftView) {
        textRect.origin.x = self.leftView.right+ kLoginTextFieldCenterMargin;
    }
    else
    {
        textRect.origin.x = kLoginTextFieldLeftMargin;
    }
    textRect.size.width = self.clearBtn.left-textRect.origin.x;
    return textRect;
}
- (CGRect)borderRectForBounds:(CGRect)bounds
{
    CGRect textRect = [super borderRectForBounds:bounds];
    if (self.leftView) {
        textRect.origin.x = self.leftView.right+ kLoginTextFieldCenterMargin;
    }
    else
    {
        textRect.origin.x = kLoginTextFieldLeftMargin;
    }
    return textRect;
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (CGRectContainsPoint(self.clearBtn.frame, point)) {
        return self.clearBtn;
    }
    UIView *hitView = [super hitTest:point withEvent:event];
    return hitView;
}

@end
