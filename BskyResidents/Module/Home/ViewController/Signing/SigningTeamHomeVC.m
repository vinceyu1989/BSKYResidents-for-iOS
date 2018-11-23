//
//  SigningTeamHomeVC.m
//  BskyResidents
//
//  Created by 何雷 on 2017/10/12.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "SigningTeamHomeVC.h"
#import "TameHomeAvatarCell.h"
#import "DoctorExpertCell.h"
#import "BlankTableViewCell.h"
#import "SigningFeaturesCell.h"
#import "SigningTeamCell.h"
#import "SigningCommitCell.h"
#import "NTESSessionViewController.h"

@interface SigningTeamHomeVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,assign) BOOL isExpertCellExpansion;

@property (nonatomic ,assign) BOOL isTeamExpansion;

@end

@implementation SigningTeamHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}
- (void)initView
{
    self.title = @"签约团队主页";
    self.isExpertCellExpansion = NO;
    self.isTeamExpansion = NO;
    self.tableView.backgroundColor = Bsky_UIColorFromRGB(0xf7f7f7);
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight=UITableViewAutomaticDimension;
    [self.tableView registerNib:[TameHomeAvatarCell nib] forCellReuseIdentifier:[TameHomeAvatarCell cellIdentifier]];
    [self.tableView registerClass:[DoctorExpertCell class] forCellReuseIdentifier:[DoctorExpertCell cellIdentifier]];
    [self.tableView registerClass:[BlankTableViewCell class] forCellReuseIdentifier:[BlankTableViewCell cellIdentifier]];
    [self.tableView registerNib:[SigningFeaturesCell nib] forCellReuseIdentifier:[SigningFeaturesCell cellIdentifier]];
    [self.tableView registerNib:[SigningTeamCell nib] forCellReuseIdentifier:[SigningTeamCell cellIdentifier]];
    [self.tableView registerClass:[SigningCommitCell class] forCellReuseIdentifier:[SigningCommitCell cellIdentifier]];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
//    switch (self.type) {
//        case FamilyDoctorCellTypeDoctor:
//
//            break;
//        default:
//            return 8;
//            break;
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    switch (indexPath.row) {
        case 0:
        {
             cell = [tableView dequeueReusableCellWithIdentifier:[TameHomeAvatarCell cellIdentifier] forIndexPath:indexPath];
            TameHomeAvatarCell *tableCell = (TameHomeAvatarCell *)cell;
            tableCell.memberModel = self.currentMemberModel;
        }
            break;
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:[DoctorExpertCell cellIdentifier] forIndexPath:indexPath];
            DoctorExpertCell *tableCell = (DoctorExpertCell *)cell;
            [tableCell setDesString:self.currentMemberModel.remark expansion:self.isExpertCellExpansion];
            @weakify(self);
            tableCell.expansion = ^(BOOL isExpansion)
            {
                @strongify(self);
                self.isExpertCellExpansion = isExpansion;
            };
           
        }
            break;
        case 2:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:[BlankTableViewCell cellIdentifier] forIndexPath:indexPath];
        }
            break;
        case 3:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:[SigningFeaturesCell cellIdentifier] forIndexPath:indexPath];
            SigningFeaturesCell *tableCell = (SigningFeaturesCell *)cell;
            tableCell.isRegistered = self.currentMemberModel.isExist.integerValue == 1;
            @weakify(self);
            tableCell.selectedIndex = ^(NSInteger index) {
                if (index == 0) {
                    @strongify(self);
                    NIMSession *session = [NIMSession session:self.currentMemberModel.phone type:NIMSessionTypeP2P];
                    NTESSessionViewController *viewController = [[NTESSessionViewController alloc] initWithSession:session];
                    [self.navigationController pushViewController:viewController animated:YES];
                }
            };

        }
            break;
        case 4:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:[BlankTableViewCell cellIdentifier] forIndexPath:indexPath];
        }
            break;
        case 5:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:[SigningTeamCell cellIdentifier] forIndexPath:indexPath];
            SigningTeamCell *tableCell = (SigningTeamCell *)cell;
            tableCell.teamModel = self.teamModel;
            tableCell.memberListModel = self.memberListModel;
            tableCell.isExpansion = self.isTeamExpansion;
            @weakify(self);
            tableCell.expansion = ^(BOOL isExpansion)
            {
                @strongify(self);
                self.isTeamExpansion = isExpansion;
                NSIndexPath *index = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
                [tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationFade];
            };
            tableCell.selectedIndex = ^(NSInteger index) {
                @strongify(self);
                self.currentMemberModel = self.memberListModel.memberList[index];
                if (self.selectMemberBlock) {
                    self.selectMemberBlock(self.currentMemberModel);
                }
                [self.tableView reloadData];
            };
        }
            break;
        case 6:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:[BlankTableViewCell cellIdentifier] forIndexPath:indexPath];
        }
            break;
        case 7:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:[SigningCommitCell cellIdentifier] forIndexPath:indexPath];
        }
            break;
            
    }
    return cell;
}

@end
