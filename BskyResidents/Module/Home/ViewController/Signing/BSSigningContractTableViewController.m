//
//  BSSigningContractTableViewController.m
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/12.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSSigningContractTableViewController.h"

@interface BSSigningContractTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *signPersonValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagsValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *empValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *channelValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *startTimeValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *feeValueLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contractImageView;
@property (weak, nonatomic) IBOutlet UILabel *serviceListValueLabel;

@property (weak, nonatomic) IBOutlet UILabel *remarksValueLabel;

@end

@implementation BSSigningContractTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupView];
    
    SignDetailInfo* info = self.signInfo.signInfo;
    self.nameValueLabel.text = info.personName;
    self.teamValueLabel.text = info.teamName;
    self.signPersonValueLabel.text = info.signPerson;
    self.tagsValueLabel.text = info.tags;
    self.empValueLabel.text = info.createEmp;
    self.channelValueLabel.text = info.channel;
    self.startTimeValueLabel.text = info.startTime;
    self.endTimeValueLabel.text = info.endTime;
    
    // 服务包
    NSMutableString* servicListString = [NSMutableString string];
    for (SignService* item in info.servicelist) {
        [servicListString appendString:item.name];
        [servicListString appendString:@"、"];
    }
    self.serviceListValueLabel.text = [servicListString substringToIndex:servicListString.length-1];
    
    self.feeValueLabel.text = info.fee;
    self.contractImageView.image = [UIImage imageWithData:info.attachfile];
    self.remarksValueLabel.text = info.othereMark;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void)setupView {
    self.tableView.backgroundColor = Bsky_UIColorFromRGBA(0xededed,1);
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0);
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.remarksValueLabel setLineSpace:7];
    
}

- (void)setSignInfo:(SignInfoModel *)signInfo {
    _signInfo = signInfo;
}

#pragma mark - UITableViewDataSoource

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

@end
