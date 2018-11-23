//
//  AddressListVC.m
//  BskyResidents
//
//  Created by 何雷 on 2017/10/20.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "AddressListVC.h"
#import "AddressListCell.h"
#import "BlankTableViewCell.h"
#import "AddressDetailVC.h"

#import "BSAddressListRequest.h"
#import "BSAddressAutoRequest.h"
#import "BSAddressDeleteRequest.h"

@interface AddressListVC ()<UITableViewDelegate,UITableViewDataSource,AddressListCellDelegate>

@property (weak, nonatomic) IBOutlet UIView *emptyView;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (nonatomic ,strong) UITableView *tableView;
@property (strong, nonatomic) UIButton *addressBtn;

@property (nonatomic ,strong) BSAddressListRequest *listRequest;

@property (nonatomic ,assign) NSInteger currentPage;

@property (nonatomic ,strong) NSMutableArray *dataArray;

@property (nonatomic ,strong) BSAddressAutoRequest *autoRequest; // 修改默认

@property (nonatomic ,assign) BOOL isDelete;    // 是否进行删除操作

@end

@implementation AddressListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"地址列表";
    [self initData];
    @weakify(self);
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        self.currentPage++;
        [self loadData];
    }];
    [self.addBtn setCornerRadius:5];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.emptyView.hidden = YES;
    self.tableView.hidden = NO;
    self.currentPage = 0;
    [self.tableView.mj_footer beginRefreshing];
}
- (void)initData
{
    self.dataArray = [NSMutableArray array];
    self.isDelete = NO;
    
    self.listRequest = [[BSAddressListRequest alloc]init];
    self.listRequest.pageSize = @"10";
    self.listRequest.userId = [BSAppManager sharedInstance].currentUser.userId;
    
    self.autoRequest = [[BSAddressAutoRequest alloc]init];
    self.autoRequest.userId = [BSAppManager sharedInstance].currentUser.userId;
}
- (void)loadData
{
    self.listRequest.pageNo = [NSString stringWithFormat:@"%ld",(long)self.currentPage];
    @weakify(self);
    [self.listRequest startWithCompletionBlockWithSuccess:^(__kindof BSAddressListRequest * _Nonnull request) {
        @strongify(self);
        if (request.addressList.count < request.pageSize.integerValue) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        else
        {
            [self.tableView.mj_footer endRefreshing];
        }
        if (self.isDelete) {
            if (request.addressList.count == request.pageSize.integerValue) {
                [self.dataArray addObject:request.addressList.lastObject];
            }
            self.isDelete = NO;
        }
        else
        {
            if (self.currentPage == 1) {
                [self.dataArray removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:request.addressList];
            [self.tableView reloadData];
        }
        self.tableView.hidden = [self.dataArray isEmptyArray];
        self.addressBtn.hidden = [self.dataArray isEmptyArray];
        self.emptyView.hidden = ![self.dataArray isEmptyArray];
        
    } failure:^(__kindof BSAddressListRequest * _Nonnull request) {
        [UIView makeToast:request.msg];
        [self.tableView.mj_footer endRefreshing];
        self.tableView.hidden = [self.dataArray isEmptyArray];
        self.addressBtn.hidden = [self.dataArray isEmptyArray];
        self.emptyView.hidden = ![self.dataArray isEmptyArray];
        
    }];
    
}

#pragma mark ----- Getter Setter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Bsky_SCREEN_WIDTH, Bsky_SCREEN_HEIGHT-Bsky_TOP_BAR_HEIGHT-45) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 150;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [_tableView registerNib:[AddressListCell nib] forCellReuseIdentifier:[AddressListCell cellIdentifier]];
        [_tableView registerClass:[BlankTableViewCell class] forCellReuseIdentifier:[BlankTableViewCell cellIdentifier]];
        _tableView.hidden = YES;
        [self.view addSubview:_tableView];
        
        _addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addressBtn.frame = CGRectMake(0, _tableView.bottom, _tableView.width, 45);
        _addressBtn.backgroundColor = Bsky_UIColorFromRGB(0x4e7dd3);
        [_addressBtn setTitle:@"新增服务地址" forState:UIControlStateNormal];
        [_addressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _addressBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_addressBtn addTarget:self action:@selector(addressBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        _addressBtn.hidden = YES;
        [self.view addSubview:_addressBtn];
    }
    return _tableView;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count*2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row % 2 > 0) {
        BlankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BlankTableViewCell cellIdentifier] forIndexPath:indexPath];
        return cell;
    }
    AddressListCell *cell = [tableView dequeueReusableCellWithIdentifier:[AddressListCell cellIdentifier] forIndexPath:indexPath];
    if (!cell.delegate) {
        cell.delegate = self;
    }
    cell.model = self.dataArray[indexPath.row/2];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 > 0) {
        
        return 10;
    }
    else
    {
        return 150;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressDetailVC *vc = [[AddressDetailVC alloc]init];
    AddressListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    vc.upModel = cell.model;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark ---- click

- (IBAction)addBtnPressed:(UIButton *)sender {
    AddressDetailVC *vc = [[AddressDetailVC alloc]init];
    BSAddressModel *upModel = [[BSAddressModel alloc]init];
    upModel.userId = [BSAppManager sharedInstance].currentUser.userId;
    upModel.isAutoAddr = @"2";
    vc.upModel = upModel;
    vc.isNeedAuto = NO;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)addressBtnPressed:(UIButton *)sender {
    AddressDetailVC *vc = [[AddressDetailVC alloc]init];
    BSAddressModel *upModel = [[BSAddressModel alloc]init];
    upModel.userId = [BSAppManager sharedInstance].currentUser.userId;
    upModel.isAutoAddr = @"1";
    vc.upModel = upModel;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark ---- AddressListCellDelegate

- (void)addressListCell:(AddressListCell *)cell defaultBtnClick:(BOOL)isDefault
{
    self.autoRequest.addrId = cell.model.residentAddrId;
    @weakify(self);
    [self.autoRequest startWithCompletionBlockWithSuccess:^(__kindof BSAddressAutoRequest * _Nonnull request) {
        @strongify(self);
        for (BSAddressModel *model in self.dataArray) {
            if (model == cell.model) {
                cell.model.isAutoAddr =  cell.model.isAutoAddr.integerValue == 1 ? @"2" : @"1";
            }
            else
            {
                model.isAutoAddr = @"1";
            }
        }
        [self.tableView reloadData];
        
    } failure:^(__kindof BSAddressAutoRequest * _Nonnull request) {
        
    }];
    
}
- (void)addressListCellEditBtnClick:(AddressListCell *)cell
{
    AddressDetailVC *vc = [[AddressDetailVC alloc]init];
    vc.upModel = cell.model;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)addressListCellDeleteBtnClick:(AddressListCell *)cell
{
    BSAddressDeleteRequest *deleteRequest = [[BSAddressDeleteRequest alloc]init];
    deleteRequest.addrId = cell.model.residentAddrId;
    @weakify(self);
    [MBProgressHUD showHud];
    [deleteRequest startWithCompletionBlockWithSuccess:^(__kindof BSAddressDeleteRequest * _Nonnull request) {
        @strongify(self);
        [MBProgressHUD hideHud];
        [self.dataArray removeObject:cell.model];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        NSIndexPath *blankIndexPath = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:0];
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath,blankIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
         [self.tableView endUpdates];
        self.currentPage --;
        self.isDelete = YES;
        [self.tableView.mj_footer beginRefreshing];
        
    } failure:^(__kindof BSAddressDeleteRequest * _Nonnull request) {
        [MBProgressHUD hideHud];
        [UIView makeToast:request.msg];
    }];
}
@end
