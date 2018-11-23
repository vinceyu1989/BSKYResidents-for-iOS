//
//  BSFeedbackViewController.m
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/16.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSFeedbackViewController.h"
#import "CATPlaceHolderTextView.h"

@interface BSFeedbackViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet CATPlaceHolderTextView *contentTextView;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@end

@implementation BSFeedbackViewController

+ (instancetype)viewControllerFromStoryboard {
    return [[UIStoryboard storyboardWithName:@"Home" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:NSStringFromClass(self)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void)setupView {
    self.title = @"意见反馈";
    
    self.contentTextView.placeholder = @"请输入您的宝贵意见或建议，不超过200字";
    self.contentTextView.layer.cornerRadius = 7;
    self.contentTextView.layer.borderColor = Bsky_UIColorFromRGBA(0xcccccc,1).CGColor;
    self.contentTextView.layer.borderWidth = .5f;
    self.contentTextView.textContainerInset = UIEdgeInsetsMake(15, 10, 10, 10);
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (range.length == 0) {
        if (range.location >= 200 || textView.text.length >= 200) {
            return NO;
        }
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    NSInteger length = textView.text.length;
    self.numberLabel.text = [NSString stringWithFormat:@"%ld/200", length];
}

@end
