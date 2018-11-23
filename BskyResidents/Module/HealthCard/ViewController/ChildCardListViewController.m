//
//  ChildCardListViewController.m
//  BskyResidents
//
//  Created by vince on 2018/9/17.
//  Copyright © 2018年 罗林轩. All rights reserved.
//

#import "ChildCardListViewController.h"
#import "ChildrenCardListRequest.h"
#import "ChildrenCardListCell.h"
#import "ChildrenCardDetailController.h"
#import "ChildrenCardEditViewController.h"

@interface ChildCardListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *contentTableView;
@property (nonatomic ,strong)NSMutableArray *dataArray;
@property (nonatomic ,strong)UIButton *addBtn;
@end

@implementation ChildCardListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatUI];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self refreshData];
}
- (void)creatUI{
    self.title = @"健康卡列表";
    
    [self.view addSubview:self.contentTableView];
    [self.view addSubview:self.addBtn];
    
    [self.contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.right.equalTo(@0);
        make.bottom.equalTo(self.addBtn.mas_top);
    }];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.mas_equalTo(45);
        make.bottom.equalTo(@0);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)refreshData{
    ChildrenCardListRequest *request = [[ChildrenCardListRequest alloc] init];
    request.cardId = [BSAppManager sharedInstance].currentUser.realnameInfo.documentNo;
    [MBProgressHUD showHud];
    
    Bsky_WeakSelf;
    [request startWithCompletionBlockWithSuccess:^(__kindof ChildrenCardListRequest * _Nonnull request) {
        Bsky_StrongSelf;
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:request.listArray];
        [self.contentTableView reloadData];
        
        if(self.contentTableView.mj_header.refreshing)
        {
            [self.contentTableView.mj_header endRefreshing];
        }
        
//        if ([self.dataArray count]) {
//            NSIndexPath* indexPat = [NSIndexPath indexPathForRow:0 inSection:0];
//            [self.contentTableView scrollToRowAtIndexPath:indexPat atScrollPosition:UITableViewScrollPositionTop animated:YES];
//        }
        [MBProgressHUD hideHud];
    } failure:^(__kindof ChildrenCardListRequest * _Nonnull request) {
        [UIView makeToast:request.msg];
        [MBProgressHUD hideHud];
        [self.contentTableView.mj_header endRefreshing];
    }];
}
- (void)addAction{
    [self showAlterViewWith:nil title:@"新增"];
}
- (void)showAlterViewWith:(ChildrenListModel *)model title:(NSString *)title{
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    Bsky_WeakSelf;
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"无证申请" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        Bsky_StrongSelf;
        [self pusthEditContollerWithModel:model type:ChildrenCardTypeNoPaper];
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"出生证申请" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        Bsky_StrongSelf;
        [self pusthEditContollerWithModel:model type:ChildrenCardTypeBirthId];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"身份证申请" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        Bsky_StrongSelf;
        [self pusthEditContollerWithModel:model type:ChildrenCardTypeCardId];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [vc addAction:action3];
    [vc addAction:action2];
    [vc addAction:action1];
    [vc addAction:action];
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)pusthEditContollerWithModel:(ChildrenListModel *)model type:(ChildrenCardType )type{
    ChildrenCardEditViewController *vc = [[ChildrenCardEditViewController alloc] init];
    vc.type = type;
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark 懒加载
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
- (UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setFrame:CGRectMake(0, self.contentTableView.bottom - 45, self.view.width, 45)];
        
        [_addBtn setTitle:@"+新增" forState:UIControlStateNormal];
        
        
        [_addBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
        [_addBtn setBackgroundColor:UIColorFromRGB(0x4e7dd3)];
    }
    return _addBtn;
}
- (UITableView *)contentTableView{
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - self.navigationController.navigationBar.bottom) style:UITableViewStylePlain];
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        _contentTableView.backgroundColor = [UIColor clearColor];
        _contentTableView.backgroundView = nil;
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        Bsky_WeakSelf;
        _contentTableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
            Bsky_StrongSelf;
            [self refreshData];
        }];
        [_contentTableView registerNib:[ChildrenCardListCell nib] forCellReuseIdentifier:[ChildrenCardListCell cellIdentifier]];
    }
    return _contentTableView;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark TableViewDelegate and DataSource
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray count];
}
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChildrenCardListCell *cell = [tableView dequeueReusableCellWithIdentifier:[ChildrenCardListCell cellIdentifier] forIndexPath:indexPath];
    ChildrenListModel *model = [self.dataArray objectAtIndex:indexPath.row];
    Bsky_WeakSelf;
    cell.aciton = ^(ChildrenListModel *model) {
        Bsky_StrongSelf;
        [self showAlterViewWith:model title:@"修改"];
    };
    [cell setModel:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ChildrenListModel *model = [self.dataArray objectAtIndex:indexPath.row];
    if (!model.ehealthCode.length) {
        [UIView makeToast:@"没有二维码!"];
        return;
    }
    ChildrenCardDetailController *vc = [[ChildrenCardDetailController alloc] init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return UITableViewAutomaticDimension;
//}
- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 123;
}
@end
