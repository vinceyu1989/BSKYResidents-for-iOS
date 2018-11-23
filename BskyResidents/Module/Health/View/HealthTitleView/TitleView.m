

//
//  TitleView.m
//  BskyResidents
//
//  Created by 罗林轩 on 2017/10/16.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "TitleView.h"

@interface TitleView()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation TitleView
- (void)awakeFromNib{
    [super awakeFromNib];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back:)];
    [_titleLabel addGestureRecognizer:tap];
}

+ (TitleView *)loadNib{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
}

- (void)back:(UIGestureRecognizer *)tap{
//        [[NSNotificationCenter defaultCenter] postNotificationName:<#(nonnull NSNotificationName)#> object:<#(nullable id)#>]
}
@end
