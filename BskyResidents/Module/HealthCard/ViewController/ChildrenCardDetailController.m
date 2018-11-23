//
//  ChildrenCardDetailController.m
//  BskyResidents
//
//  Created by kykj on 2018/9/19.
//  Copyright © 2018年 罗林轩. All rights reserved.
//

#import "ChildrenCardDetailController.h"
#import "BSKYZYBigImage.h"

@interface ChildrenCardDetailController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardNumLabel;
@property (weak, nonatomic) IBOutlet UIImageView *scanImageView;

@end

@implementation ChildrenCardDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"健康卡";
    self.nameLabel.text = self.model.name;
    if ([self.model.idType containsString:@"01"]) {
        self.cardTypeLabel.text = @"居民身份证";
        self.cardNumLabel.text = self.model.idNo.length ? [self.model.idNo secretStrFromIdentityCard] : @"--";
    }else if ([self.model.idType containsString:@"08"]) {
        self.cardTypeLabel.text = @"出身证";
        self.cardNumLabel.text = self.model.idNo.length ? self.model.idNo : @"--";
    }else{
        self.cardTypeLabel.text = @"--";
        self.cardNumLabel.text = self.model.idNo.length ? [self.model.idNo secretStrFromIdentityCard] : @"--";
    }
//    self.cardTypeLabel.text = self.model.idType;
    
    
    UIImage *center = [UIImage imageNamed:@"scan_center"];
    UIImage *QRImage = [UIImage qrImageForString:self.model.ehealthCode centerImage:center];
    [self.scanImageView setImage:QRImage];
}

- (void)setModel:(ChildrenListModel *)model {
    _model = model;
}

- (IBAction)getureToScan:(UITapGestureRecognizer *)sender {
    [BSKYZYBigImage scanBigImageWithImageView:self.scanImageView alpha:0.6];
}

@end
