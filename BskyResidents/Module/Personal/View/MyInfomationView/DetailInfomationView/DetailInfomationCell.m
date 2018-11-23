//
//  DetailInfomationCell.m
//  BskyResidents
//
//  Created by 罗林轩 on 2017/10/18.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "DetailInfomationCell.h"
#import "DetailInformationWithStringModel.h"
#import "DetailInformationWithHeadImageModel.h"
#import "DetailInformationWithLabelModel.h"
#import "IdentificationView.h"
#import "BlueLabel.h"
#import "UITextField+Extension.h"
#import "UIImage+Extension.h"
@interface DetailInfomationCell()<UITextFieldDelegate>
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UITextField *contentFiled;
@property (strong, nonatomic) UIImageView *arrowImage;//箭头
@property (strong, nonatomic) DetailInformationWithStringModel *stringModel;
@property (strong, nonatomic) DetailInformationWithHeadImageModel *imageModel;
@property (assign, nonatomic) BOOL isHaveDian;//是否有小数点

@end

@implementation DetailInfomationCell


+(DetailInfomationCell *)showWithModel:(id)model{
    DetailInfomationCell *cell  = [[DetailInfomationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[DetailInfomationCell cellIdentifier]];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([model isKindOfClass:[DetailInformationWithStringModel class]]) {
        DetailInformationWithStringModel *strignModel = model;
        cell.stringModel = model;
        [cell setupWithStringModel:strignModel];
    }else if ([model isKindOfClass:[DetailInformationWithHeadImageModel class]]){
        DetailInformationWithHeadImageModel *headImageModel = model;
        cell.imageModel = model;
        [cell setupWithHeadImageModel:headImageModel];
    }else if ([model isKindOfClass:[DetailInformationWithLabelModel class]]){
        DetailInformationWithLabelModel *labelModel = model;
        [cell setupDetailInfomatinWithLabel:labelModel];
    }else{
        [cell setupSaveStyle];
    }
    return cell;
}

#pragma mark - 只包含字符串的Cell
- (void)setupWithStringModel:(DetailInformationWithStringModel *)stringModel{
    [self.contentView addSubview:self.titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    _titleLabel.text = stringModel.title;
    
    if (stringModel.showArrow == YES) {
        self.contentFiled.rightViewMode = UITextFieldViewModeAlways;
        self.contentFiled.rightView = self.arrowImage;
    }
    
    [self.contentView addSubview:self.contentFiled];
    [_contentFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        if (stringModel.showArrow == YES) {
            make.right.mas_equalTo(0);
        }else{
            make.right.mas_equalTo(-self.arrowImage.image.size.width * 2);
        }
//        if (stringModel.content.length == 0) {
            make.left.mas_equalTo(_titleLabel.mas_right);
//        }
        make.top.bottom.mas_equalTo(0);
    }];
//    if (stringModel.unit) {
//        _contentFiled.text = [NSString stringWithFormat:@"%@%@ ",stringModel.content,stringModel.unit];
//    }else{
    if ([stringModel.content isEqualToString:@"请填写身高"] || [stringModel.content isEqualToString:@"请填写体重"] || [stringModel.content isEqualToString:@"请输入详细地址"]) {
        _contentFiled.placeholder = stringModel.content;
    }else{
        _contentFiled.text = stringModel.content;
    }
//    }
    _contentFiled.userInteractionEnabled = stringModel.canEdit;
    
    //标记
//    IdentificationView *indentificationView = [IdentificationView show];
//    indentificationView.hidden = !stringModel.isNeedImg;
//    [self.contentView addSubview:indentificationView];
//
//    [indentificationView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(_contentFiled.mas_left).offset(-5);
//        make.height.mas_equalTo(15);
//        make.width.mas_equalTo(53);
//        make.centerY.mas_equalTo(_contentFiled.mas_centerY);
//    }];
    
    UILabel *bottomLine1 = [[UILabel alloc] init];
    bottomLine1.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
    [self.contentView addSubview:bottomLine1];
    [bottomLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(15);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-0.5f);
        make.height.mas_equalTo(0.5f);
    }];
}

#pragma mark - 包含标签的label
- (void)setupDetailInfomatinWithLabel:(DetailInformationWithLabelModel *)labelModel{
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.frame = CGRectMake(15, 0, 0, 49);
    self.titleLabel.text = labelModel.title;
    CGSize size = [self.titleLabel sizeThatFits:CGSizeZero];
    self.titleLabel.frame = CGRectMake(15, 0, size.width, 49);
    BlueLabel *lastLabel;
    for (int i = 0; i < labelModel.labels.count; i ++) {
        BlueLabel *label = [[BlueLabel alloc] init];
        label.text = labelModel.labels[i];
        CGSize labelSize = [label sizeThatFits:CGSizeZero];
        if (lastLabel) {
            CGFloat labelX;
            CGFloat labelY;
            if ((lastLabel.x + lastLabel.width + labelSize.width + 5) > Bsky_SCREEN_WIDTH) {
                labelY = lastLabel.y + lastLabel.height + 10;
                labelX = 15;
            }else{
                labelX = lastLabel.x + lastLabel.width + 5;
                labelY = lastLabel.y;
            }
            label.frame = CGRectMake(labelX, labelY, (labelSize.width + 10) > (Bsky_SCREEN_WIDTH - 30) ? (Bsky_SCREEN_WIDTH - 30) : (labelSize.width + 10), labelSize.height + 10);
        }else{
            label.frame = CGRectMake(15 , labelSize.height + 10 + 15,  (labelSize.width + 10) > (Bsky_SCREEN_WIDTH - 30) ? (Bsky_SCREEN_WIDTH - 30) : (labelSize.width + 10), labelSize.height + 10);
        }
        [self.contentView addSubview:label];
        lastLabel = label;
    }
    
    labelModel.cellH = lastLabel.y + lastLabel.height + 10 + 10 + (lastLabel ? 0 : 49);

    UILabel *bottomLabel1 = [[UILabel alloc] init];
    bottomLabel1.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
    [self.contentView addSubview:bottomLabel1];
    [bottomLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-0.5f);
        make.height.mas_equalTo(0.5f);
    }];
    
    UILabel *bottomLabel2 = [[UILabel alloc] init];
    bottomLabel2.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
    [self.contentView addSubview:bottomLabel2];
    [bottomLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(bottomLabel1.mas_top);
        make.height.mas_equalTo(10);
    }];
    
    UILabel *bottomLabel3 = [[UILabel alloc] init];
    bottomLabel3.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
    [self.contentView addSubview:bottomLabel3];
    [bottomLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(bottomLabel2.mas_top);
        make.height.mas_equalTo(0.5f);
    }];
}

#pragma mark - 包含头像的cell
- (void)setupWithHeadImageModel:(DetailInformationWithHeadImageModel *)headImageModel{
//    UILabel *topLine = [[UILabel alloc] init];
//    topLine.backgroundColor = [UIColor colorWithHexString:@"b3b3b3"];
//    [self.contentView addSubview:topLine];
//    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.right.mas_equalTo(0);
//        make.height.mas_equalTo(0.5f);
//    }];
    
    [self.contentView addSubview:self.titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(70);
    }];
    
//    UIImageView *arrowImage = [[UIImageView alloc] init];
//    [arrowImage setImage:[UIImage imageNamed:@"DetailInfomation_)-查看"]];
    [self.contentView addSubview:self.arrowImage];
    [_arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self.titleLabel.mas_centerY);
    }];
    
    [self.contentView addSubview:self.headVeiw];
    [_headVeiw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(50);
        make.right.mas_equalTo(_arrowImage.mas_left).offset(-8);
        make.centerY.mas_equalTo(_arrowImage.mas_centerY);
    }];
    if (headImageModel.head != nil) {
        [_headVeiw setImage:[UIImage imageWithSourceImage:headImageModel.head]];
    }
    
    UILabel *bottomLine1 = [[UILabel alloc] init];
    bottomLine1.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
    [self.contentView addSubview:bottomLine1];
    [bottomLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(_titleLabel.mas_bottom);
        make.height.mas_equalTo(0.5f);
    }];
    
    UILabel *bottomLine2 = [[UILabel alloc] init];
    bottomLine2.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
    [self.contentView addSubview:bottomLine2];
    [bottomLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(bottomLine1.mas_bottom).offset(0);
        make.height.mas_equalTo(10);
    }];
    
    UILabel *bottomLine3 = [[UILabel alloc] init];
    bottomLine3.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
    [self.contentView addSubview:bottomLine3];
    [bottomLine3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(bottomLine2.mas_bottom).offset(0);
        make.height.mas_equalTo(0.5f);
    }];
    
    _titleLabel.text = headImageModel.title;
}

#pragma mark - 保存
- (void)setupSaveStyle{
    UILabel *topLine1 = [[UILabel alloc] init];
    topLine1.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
    [self.contentView addSubview:topLine1];
    [topLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.height.mas_equalTo(0.5f);
    }];
    
    UILabel *topLine2 = [[UILabel alloc] init];
    topLine2.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
    [self.contentView addSubview:topLine2];
    [topLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(topLine1.mas_bottom).offset(0);
        make.height.mas_equalTo(10);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"保存";
    [self.contentView addSubview:label];
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"4e7dd3"];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.centerY.mas_equalTo(self.contentView.mas_centerY).mas_offset(5);
    }];
}


- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor colorWithHexString:@"666666"];
    }
    return _titleLabel;
}

- (UITextField *)contentFiled{
    if (!_contentFiled) {
        _contentFiled = [[UITextField alloc] init];
        _contentFiled.textAlignment = NSTextAlignmentRight;
        _contentFiled.textColor = [UIColor colorWithHexString:@"999999"];
        _contentFiled.font  = [UIFont systemFontOfSize:16];
        _contentFiled.delegate = self;
        _contentFiled.keyboardType = _stringModel.keyboardType;
    }
    return _contentFiled;
}

- (UIImageView *)arrowImage{
    if (!_arrowImage) {
        _arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@")"]];
        _arrowImage.bounds = CGRectMake(0, 0, _arrowImage.image.size.width * 4, _arrowImage.image.size.height * 2);
        _arrowImage.contentMode = UIViewContentModeCenter;
    }
    return _arrowImage;
}

- (UIImageView *)headVeiw{
    if(!_headVeiw){
        _headVeiw = [[UIImageView alloc] init];
//        _headVeiw.image = [UIImage imageWithSourceImage:[UIImage imageNamed:@"DetailInfomation_头像"]];
        [_headVeiw sd_setImageWithURL:[NSURL URLWithString:[BSAppManager sharedInstance].currentUser.realnameInfo.photourl]
                     placeholderImage:[UIImage cornerImage:[UIImage imageNamed:@"头像"] withParam:30 withSize:CGSizeMake(60,60)]
                              options:SDWebImageAllowInvalidSSLCertificates];
        _headVeiw.layer.cornerRadius = 25;
        _headVeiw.layer.masksToBounds = YES;
//        if (!_imageModel.head) {
//            NSString *urlStr = [BSAppManager sharedInstance].currentUser.realnameInfo.photourl;
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//                NSURL *url = [NSURL URLWithString:urlStr];
//                // NSURLRequestReloadIgnoringLocalAndRemoteCacheData 表示忽略本地和服务器的 缓存文件 直接从原始地址下载图片 缓存策略的一种
//                NSMutableURLRequest *re = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60];
//                [re addValue:[BSClientManager sharedInstance].tokenId forHTTPHeaderField:@"token"];
//                NSData *received = [NSURLConnection sendSynchronousRequest:re returningResponse:nil error:nil];
//                UIImage *overlayImage = [UIImage imageWithData:received];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    if (overlayImage) {
//                        _headVeiw.image = [UIImage imageWithSourceImage:overlayImage];
//                        NSLog(@"!!! %@",_headVeiw.image);
//                    }
//                });
//            });
//        }
        //        [_headVeiw sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"DetailInfomation_头像"]options:SDWebImageRefreshCached];
    }
    return _headVeiw;
}

#pragma mark - UITextFileDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    if (textField.keyboardType == UIKeyboardTypeDecimalPad ||textField.keyboardType == UIKeyboardTypeNumberPad) {
//        textField.text = [NSString stringWithFormat:@"%@ ",_stringModel.unit];
//        [textField start:UITextLayoutDirectionLeft];
//    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (_stringModel.keyboardType == UIKeyboardTypeDecimalPad ||_stringModel.keyboardType == UIKeyboardTypeNumberPad) {
        if ([textField.text floatValue] > 300 || [textField.text floatValue] <= 0) {
            [UIView makeToast:@"请输入正确的数值"];
//            textField.text = [NSString stringWithFormat:@"%@ %@",_stringModel.content,_stringModel.unit];
            textField.text = nil;
            textField.placeholder = _stringModel.defaultContent;
        }
        NSCharacterSet *setToRemove =[[ NSCharacterSet characterSetWithCharactersInString:@"0123456789.0123456789"]
                                      invertedSet ];
        NSString *newString =
        [[textField.text componentsSeparatedByCharactersInSet:setToRemove]
         componentsJoinedByString:@""];
        _stringModel.content = newString;
    }
    if (textField.text.length == 0 && _stringModel.keyboardType == UIKeyboardTypeDefault) {
        textField.placeholder = @"请输入详细地址";
    }
    _stringModel.content = textField.text;
}

//textField.text 输入之前的值         string 输入的字符
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(textField.keyboardType == UIKeyboardTypeDecimalPad ||textField.keyboardType == UIKeyboardTypeNumberPad){
        if ([textField.text rangeOfString:@"."].location==NSNotFound) {
            _isHaveDian=NO;
        }
        if ([string length]>0)
        {
            unichar single=[string characterAtIndex:0];//当前输入的字符
            if ((single >='0' && single<='9') || single=='.')//数据格式正确
            {
                //首字母不能为0和小数点
                if([textField.text length]==0){
                    if(single == '.'){
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                        
                    }
                    if (single == '0') {
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                        
                    }
                }
                if (single=='.')
                {
                    if(!_isHaveDian)//text中还没有小数点
                    {
                        _isHaveDian=YES;
                        return YES;
                    }else
                    {
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }
                else
                {
                    if (_isHaveDian)//存在小数点
                    {
                        //判断小数点的位数
                        NSRange ran=[textField.text rangeOfString:@"."];
                        NSInteger tt=range.location-ran.location;
                        if (tt <= 1){
                            return YES;
                        }else{
                            return NO;
                        }
                    }
                    else
                    {
                        return YES;
                    }
                }
            }else{//输入的数据格式不正确
                [textField.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
        }
        else
        {
            return YES;
        }
    }
    return YES;
}
@end
