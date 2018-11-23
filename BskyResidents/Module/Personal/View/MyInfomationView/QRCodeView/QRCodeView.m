






//
//  QRCodeView.m
//  BskyResidents
//
//  Created by 罗林轩 on 2017/10/19.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "QRCodeView.h"
#import "GrayLabel.h"
@implementation QRCodeView

+ (QRCodeView *)showWithModel:(id)model{
    QRCodeView *view = [[QRCodeView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 4;
    view.layer.masksToBounds = YES;
    
    //头像
    UIImageView *headView = [[UIImageView alloc] init];
    [headView setImage:[UIImage imageNamed:@"DetailInfomation_头像"]];//测试

    NSString *urlStr = [BSAppManager sharedInstance].currentUser.realnameInfo.photourl;
    
    __block UIImage *overlayImage = [UIImage imageWithSourceImage:[UIImage imageNamed:@"DetailInfomation_头像"]];
    __block UIImageView *QRView;
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableURLRequest *re = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60];
        [re addValue:[BSClientManager sharedInstance].tokenId forHTTPHeaderField:@"token"];
        NSData *received = [NSURLConnection sendSynchronousRequest:re returningResponse:nil error:nil];
        overlayImage = [UIImage imageWithData:received];
        if (!overlayImage) {
            overlayImage = [UIImage imageWithSourceImage:[UIImage imageNamed:@"DetailInfomation_头像"]];
        }else{
            UIImage *QRImage = [UIImage qrImageForString:@"myInfomation_二维码" centerImage:overlayImage];
            [QRView setImage:QRImage];
            [headView setImage:[UIImage imageWithSourceImage:overlayImage]];
        }
    });
    [view addSubview:headView];

    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(70);
        make.left.top.mas_equalTo(20);
    }];
    
    //姓名
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.font = [UIFont systemFontOfSize:17];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.text = [BSAppManager sharedInstance].currentUser.realnameInfo.realName;
    [view addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headView.mas_right).mas_offset(10);
        make.top.mas_equalTo(headView.mas_top);
    }];
    
    //手机号
    UILabel *phoneNumLabel = [[UILabel alloc] init];
    phoneNumLabel.textAlignment = NSTextAlignmentLeft;
    phoneNumLabel.font = [UIFont systemFontOfSize:14];
    phoneNumLabel.textColor = [UIColor colorWithHexString:@"808080"];
    
    phoneNumLabel.text =  [NSString stringWithFormat:@"手机号码 %@",[[BSAppManager sharedInstance].currentUser.realnameInfo.mobileNo stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"]];
    [view addSubview:phoneNumLabel];
    [phoneNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLabel.mas_left);
        make.top.mas_equalTo(nameLabel.mas_bottom).mas_offset(17);
    }];
    
    //签约标签
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment =  NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor colorWithHexString:@"808080"];
    label.text = @"签约标签";
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLabel.mas_left);
        make.top.mas_equalTo(phoneNumLabel.mas_bottom).mas_offset(10);
    }];
    
    [view setNeedsLayout];
    [view layoutIfNeeded];
    //标签
    NSArray *labels = [model componentsSeparatedByString:@","];
    if (labels.count == 1) {
        NSString *str = [labels firstObject];
        if (str.length == 0)labels = nil;
    }
    if (labels.count == 0) {
        label.hidden = YES;//暂时隐藏
    }
    GrayLabel *lastLabel;
     for (int  i  = 0; i < labels.count; i ++) {
        GrayLabel *grayLabel = [[GrayLabel alloc] init];
        grayLabel.text = labels[i];
        CGSize labelSize = [grayLabel sizeThatFits:CGSizeZero];
        if (lastLabel) {
            CGFloat labelX;
            CGFloat labelY;
            if ((lastLabel.x + lastLabel.width + labelSize.width + 85 + 7.5f) > Bsky_SCREEN_WIDTH) {
                labelY = lastLabel.y + lastLabel.height + 10;
                labelX = label.x;
            }else {
                labelX = lastLabel.x + lastLabel.width + 7.5f;
                labelY = lastLabel.y;
            }
            
            grayLabel.frame = CGRectMake(labelX, labelY, (labelSize.width + 5) > (Bsky_SCREEN_WIDTH - label.x - 50) ?  (Bsky_SCREEN_WIDTH - label.x - 50) : (labelSize.width + 5), labelSize.height + 5);
        }else{
            grayLabel.frame = CGRectMake(label.x + label.width + 7.5f, label.y, (labelSize.width + 5) > (Bsky_SCREEN_WIDTH - label.x - label.width - 100) ? (Bsky_SCREEN_WIDTH - label.x - label.width - 100)  : (labelSize.width + 5), labelSize.height + 5);
        }
        lastLabel = grayLabel;
        [view addSubview:grayLabel];
    }
    
    //二维码
    QRView = [[UIImageView alloc] initWithFrame:CGRectMake(42.5f, ((lastLabel.y + lastLabel.height) == 0 ? (label.y + label.height) : (lastLabel.y + lastLabel.height)) + 40, Bsky_SCREEN_WIDTH - 125, Bsky_SCREEN_WIDTH - 125)];
    
    UIImage *QRImage = [UIImage qrImageForString:@"myInfomation_二维码" centerImage:overlayImage];
    [QRView setImage:QRImage];
    [view addSubview:QRView];
    
    view.height = ((lastLabel.y + lastLabel.height) == 0 ? (label.y + label.height) : (lastLabel.y + lastLabel.height)) + 40 + QRView.width + 42.5;
    return view;
}


@end
