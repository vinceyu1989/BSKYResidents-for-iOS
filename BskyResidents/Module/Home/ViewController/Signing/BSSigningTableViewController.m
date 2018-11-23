//
//  BSSigningTableViewController.m
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/10.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSSigningTableViewController.h"
#import "BSSigningLabelView.h"

@implementation BSSigningViewModel
@end

@interface BSSigningTableViewController () <BSSigningLabelViewDataSource, BSSigningLabelViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *detailLabel;
@property (weak, nonatomic) IBOutlet BSSigningLabelView *roleLabelView;
@property (weak, nonatomic) IBOutlet BSSigningLabelView *symptomLabelView;
@property (weak, nonatomic) IBOutlet UITableViewCell *roleLabelCell;

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *identityField;
@property (weak, nonatomic) IBOutlet UITextField *districtField;
@property (weak, nonatomic) IBOutlet UITextField *addressField;

@property (nonatomic, strong) NSArray* roleList;
@property (nonatomic, strong) NSArray* symptomList;

@end

@implementation BSSigningTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}
#pragma mark -
- (void)setupView {    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorColor = Bsky_UIColorFromRGBA(0xededed,1);
    self.tableView.backgroundColor = Bsky_UIColorFromRGBA(0xf7f7f7,1);
    self.roleList = @[@"普通人群", @"贫困人群",@"计生特殊家庭",@"残疾人",@"0-6岁儿童",@"65岁以上老年人",@"建档立卡贫困人口", @"孕产妇"];
    self.symptomList = @[@"高血压", @"糖尿病",@"严重精神障碍", @"结核病",@"COPD（慢阻肺）",@"无疾病",@"其他"];
//        self.roleList = @[@"普通人群", @"贫困人群"];
//        self.symptomList = @[@"高血压", @"糖尿病"];

    BSUser *user = [BSAppManager sharedInstance].currentUser;
    self.nameField.text = user.realnameInfo.realName;
    self.phoneField.text = [user.realnameInfo.mobileNo stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    self.identityField.text =  [user.realnameInfo.documentNo stringByReplacingCharactersInRange:NSMakeRange(3, 11) withString:@"**********"];
    self.districtField.text = [NSString stringWithFormat:@"%@-%@-%@-%@",user.realnameInfo.provinceName,user.realnameInfo.cityName,user.realnameInfo.properName,user.realnameInfo.areaName];
    if (user.realnameInfo.detailAddress.length > 0) {
        self.addressField.text = user.realnameInfo.detailAddress;
        self.addressField.userInteractionEnabled = NO;
    }
    self.roleLabelView.dataSource = self;
    self.roleLabelView.delegate = self;
    self.symptomLabelView.dataSource = self;
    self.symptomLabelView.delegate = self;
    self.detailLabel.layer.cornerRadius = 17;
    self.detailLabel.layer.borderColor = Bsky_UIColorFromRGBA(0xffffff,1).CGColor;
    self.detailLabel.layer.borderWidth = 1;
    
    [self.roleLabelView layoutIfNeeded];
    [self.symptomLabelView layoutIfNeeded];
    [self.tableView layoutIfNeeded];
    [self.roleLabelView reloadData];
    [self.symptomLabelView reloadData];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            CGSize size = [self.roleLabelView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
            NSLog(@"row %ld 高度%f",(long)indexPath.row,size.height);
            return size.height;
//            return 172;
        }else if (indexPath.row == 1) {
            CGSize size = [self.symptomLabelView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
            NSLog(@"row %ld 高度%f",(long)indexPath.row,size.height);
            return size.height;
//            return 172;
        }
    }
    
    return 50.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 50.f;
    }
    return 10.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2) {
        return 10.f;
    }
    
    return CGFLOAT_MIN;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* view = ({
        UIView* view = [UIView new];
        view.backgroundColor = Bsky_UIColorFromRGBA(0xf7f7f7,1);
        
        if (section == 0) {
            UILabel* label = [UILabel new];
            label.text = @"签约人申请表";
            label.font = [UIFont systemFontOfSize:16];
            label.textColor = Bsky_UIColorFromRGBA(0x333333,1);
            label.textAlignment = NSTextAlignmentCenter;
            [view addSubview:label];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(view);
            }];
        }
        
        view;
    });
    
    return view;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - BSSigningLabelViewDataSource

- (NSString*)titleForView:(BSSigningLabelView*)view {
    if (view == self.roleLabelView) {
        return @"所属人群";
    }
    
    return @"是否患有以下疾病";
}

- (NSInteger)numberOfLabelsInView:(BSSigningLabelView*)view {
    if (view == self.roleLabelView) {
        return self.roleList.count;
    }
    return self.symptomList.count;
}

- (NSString*)signingLabelView:(BSSigningLabelView*)view labelTitleForIndex:(NSInteger)index {
    if (view == self.roleLabelView) {
        return self.roleList[index];
    }
    return self.symptomList[index];
}

#pragma mark - BSSigningLabelViewDelegate

- (void)signingLabelView:(BSSigningLabelView*)view didChangeSelectedList:(NSArray*)selectedList {
    if (view == self.roleLabelView) {
        self.viewModel.roleList = selectedList;
    }else {
        self.viewModel.symptomList = selectedList;
    }
}


@end
