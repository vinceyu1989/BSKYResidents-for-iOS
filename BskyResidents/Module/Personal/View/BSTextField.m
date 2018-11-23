//
//  BRTextField.m
//  BRPickerViewDemo
//
//  Created by 任波 on 2017/8/11.
//  Copyright © 2017年 renb. All rights reserved.
//

#import "BSTextField.h"

@interface BSTextField ()<UITextFieldDelegate>
@property (nonatomic, strong) UIView *tapView;

@end

@implementation BSTextField

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
    self.textColor = Bsky_UIColorFromRGBA(0x333333,1);
    self.moreIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"more_icon"]];
    [self.moreIcon sizeToFit];
    self.moreIcon.contentMode = UIViewContentModeRight;
    self.moreIcon.frame = CGRectMake(0, 0, self.moreIcon.width+5, self.moreIcon.height);
    self.rightView = self.moreIcon;
    self.rightViewMode = UITextFieldViewModeUnlessEditing;
    self.returnKeyType = UIReturnKeyDone;
    self.delegate = self;
}

- (void)setTapAcitonBlock:(BSTapAcitonBlock)tapAcitonBlock {
    _tapAcitonBlock = tapAcitonBlock;
    self.tapView.hidden = !_tapAcitonBlock;
}

- (void)setEndEditBlock:(BSEndEditBlock)endEditBlock {
    _endEditBlock = endEditBlock;
    [self addTarget:self action:@selector(didEndEditTextField:) forControlEvents:UIControlEventEditingDidEnd];
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

#pragma mark --- UITextFieldDelegate

- (void)didEndEditTextField:(UITextField *)textField {
    if (self.endEditBlock) {
        self.endEditBlock(textField.text);
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    return  self.tapAcitonBlock ? NO : YES;
}

@end
