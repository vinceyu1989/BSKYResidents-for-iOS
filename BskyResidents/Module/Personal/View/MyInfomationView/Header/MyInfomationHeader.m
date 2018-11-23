//
//  MyInfomationHeader.m
//  BskyResidents
//
//  Created by 罗林轩 on 2017/10/9.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "MyInfomationHeader.h"
#import "MyInfomationNotifier.h"
#import "BottomBar.h"
@interface MyInfomationHeader()
@property (weak, nonatomic) IBOutlet UIImageView *head;//头像
@property (weak, nonatomic) IBOutlet UILabel *phoneNum;//电话号码
@property (weak, nonatomic) IBOutlet UILabel *identification;//认证信息
@property (strong, nonatomic) BottomBar *BottomBar;
@property (weak, nonatomic) IBOutlet UIView *indentifierImg;//审核图标
@end

@implementation MyInfomationHeader
- (void)awakeFromNib{
    [super awakeFromNib];
    BSUser *user = [BSAppManager sharedInstance].currentUser;
    _phoneNum.text = [[BSAppManager sharedInstance].currentUser.realnameInfo.verifStatus isEqualToString:@"01006003"] == YES ? [BSAppManager sharedInstance].currentUser.realnameInfo.realName : [BSAppManager sharedInstance].currentUser.realnameInfo.mobileNo;
    _indentifierImg.hidden = ![[BSAppManager sharedInstance].currentUser.realnameInfo.verifStatus isEqualToString:@"01006003"];
    _identification.hidden = [[BSAppManager sharedInstance].currentUser.realnameInfo.verifStatus isEqualToString:@"01006003"];
#warning 审核未使用功能
//    NSArray *names =@[@"收藏",@"关注",@"家人",@"二维码",@"健康卡"];
    NSArray *names =@[@"二维码",@"健康卡"];
//    NSArray *icons = @[@"Mico1",@"Mico2",@"Mico3",@"Mico4",@"Mico5"];
    NSArray *icons = @[@"Mico4",@"Mico5"];
    _BottomBar = [BottomBar showWithNames:names icons:icons];
    _head.layer.cornerRadius = _head.frame.size.height / 2;
    _head.clipsToBounds = YES;
//    [_head sd_setImageWithURL:[NSURL URLWithString:[BSAppManager sharedInstance].currentUser.photourl] placeholderImage:[UIImage imageNamed:@"头像"]options:SDWebImageRefreshCached];
    [self addSubview:_BottomBar];
    
    NSString *urlStr = [BSAppManager sharedInstance].currentUser.realnameInfo.photourl;
    [self setImageViewUrl:urlStr];
}

- (void)update{
        _head.image = [UIImage cornerImage:[UIImage imageNamed:@"头像"] withParam:30 withSize:CGSizeMake(60,60)];
    _phoneNum.text = [[BSAppManager sharedInstance].currentUser.realnameInfo.verifStatus isEqualToString:@"01006003"] == YES ? [BSAppManager sharedInstance].currentUser.realnameInfo.realName : [BSAppManager sharedInstance].currentUser.realnameInfo.mobileNo;
    _indentifierImg.hidden = ![[BSAppManager sharedInstance].currentUser.realnameInfo.verifStatus isEqualToString:@"01006003"];
    _identification.hidden = [[BSAppManager sharedInstance].currentUser.realnameInfo.verifStatus isEqualToString:@"01006003"];
    NSString *urlStr = [BSAppManager sharedInstance].currentUser.realnameInfo.photourl;
    [self setImageViewUrl:urlStr];
}

- (void)setImageViewUrl:(NSString *)urlStr{
    [self.head sd_setImageWithURL:[NSURL URLWithString:urlStr]
                 placeholderImage:[UIImage cornerImage:[UIImage imageNamed:@"头像"] withParam:30 withSize:CGSizeMake(60,60)]
                          options:SDWebImageAllowInvalidSSLCertificates];
}
@end
