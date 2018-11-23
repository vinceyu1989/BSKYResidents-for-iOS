//
//  AddressDetailVC.m
//  BskyResidents
//
//  Created by 何雷 on 2017/10/20.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "AddressDetailVC.h"
#import "BlankTableViewCell.h"
#import "AddressDetailTextInputCell.h"
#import "AddressDefaultCell.h"
#import "GFAddressPicker.h"
#import "TeamPickerView.h"

#import "BSDivisionRequest.h"
#import "BSDivisionCodeRequest.h"
#import "BSDivisionIdRequest.h"
#import "BSAddressSaveRequest.h"    // 新增地址
#import "BSAddressUpdateRequest.h"  // 更新地址

#import "BSAddressModel.h"  // 保存数据

@interface AddressDetailVC ()

@property (nonatomic ,copy) NSArray *titleArray;
@property (nonatomic ,strong) BSDivision *area;
@property (nonatomic ,copy) NSArray *divisionArray;
@property (nonatomic ,copy) NSArray *streetArray;

@end

@implementation AddressDetailVC
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isNeedAuto = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"地址详情";
    self.titleArray = @[@"联系人",@"手机号",@"所在地区",@"街道",@"详细地址"];
    self.tableView.backgroundColor = Bsky_UIColorFromRGB(0xf7f7f7);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 50;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerClass:[BlankTableViewCell class] forCellReuseIdentifier:[BlankTableViewCell cellIdentifier]];
    [self.tableView registerNib:[AddressDetailTextInputCell nib] forCellReuseIdentifier:[AddressDetailTextInputCell cellIdentifier]];
    [self.tableView registerNib:[AddressDefaultCell nib] forCellReuseIdentifier:[AddressDefaultCell cellIdentifier]];
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(0, self.tableView.height-44-45, self.tableView.width, 45);
    saveBtn.backgroundColor = Bsky_UIColorFromRGB(0x4e7dd3);
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [saveBtn addTarget:self action:@selector(saveBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:saveBtn];
    
    if (self.upModel.properId.length > 0) {
        self.area = [[BSDivision alloc]init];
        self.area.divisionId = self.upModel.properId;
        self.area.divisionFullName =  [NSString stringWithFormat:@"%@ %@ %@",self.upModel.provinceName,self.upModel.cityName,self.upModel.properName];
        [self getStreetData];
    }
    [self initData];
}
- (void)initData
{
    BSDivisionRequest *divisionRequest = [[BSDivisionRequest alloc]init];
    divisionRequest.divisionCode = @"51";
    BSDivisionCodeRequest *divisionCodeRequest = [[BSDivisionCodeRequest alloc]init];
    divisionCodeRequest.divisionCode = @"51";
    
    [MBProgressHUD showHud];
    @weakify(self);
    YTKBatchRequest *batchRequest = [[YTKBatchRequest alloc] initWithRequestArray:@[divisionRequest, divisionCodeRequest]];
    [batchRequest startWithCompletionBlockWithSuccess:^(YTKBatchRequest *batchRequest) {
        [MBProgressHUD hideHud];
        @strongify(self);
        NSArray *requests = batchRequest.requestArray;
        BSDivisionRequest *aRequest = (BSDivisionRequest *)requests[0];
        BSDivisionCodeRequest *bRequest = (BSDivisionCodeRequest *)requests[1];
        BSDivision *province = [[BSDivision alloc]init];
        province.divisionName = @"四川";
        province.divisionCode = @"51";
        province.divisionId = aRequest.divisionId;
        province.children = bRequest.divisionList;
        self.divisionArray = [NSArray arrayWithObject:province];
        
    } failure:^(YTKBatchRequest *batchRequest) {
        [MBProgressHUD hideHud];
        [UIView makeToast:@"获取区划信息失败"];
    }];
}

- (void)getStreetData
{
    BSDivisionIdRequest *divisionIdRequest = [[BSDivisionIdRequest alloc]init];
    divisionIdRequest.divisionId = self.area.divisionId;
    [MBProgressHUD showHud];
    @weakify(self);
    [divisionIdRequest startWithCompletionBlockWithSuccess:^(__kindof BSDivisionIdRequest * _Nonnull request) {
        [MBProgressHUD hideHud];
        @strongify(self);
        self.streetArray = request.divisionList;

    } failure:^(__kindof BSDivisionIdRequest * _Nonnull request) {
        [MBProgressHUD hideHud];
        [UIView makeToast:request.msg];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.isNeedAuto ? 7 : 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    switch (indexPath.row) {
        case 0:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:[BlankTableViewCell cellIdentifier] forIndexPath:indexPath];
        }
            break;
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:[AddressDetailTextInputCell cellIdentifier] forIndexPath:indexPath];
            AddressDetailTextInputCell *tableCell = (AddressDetailTextInputCell *)cell;
            tableCell.titleLabel.text = self.titleArray[indexPath.row -1];
            tableCell.topLine.hidden = NO;
            tableCell.contentTF.rightViewMode = UITextFieldViewModeNever;
            tableCell.contentTF.text = self.upModel.contractName;
            @weakify(self);
            tableCell.contentTF.endEditBlock = ^(NSString *str){
                @strongify(self);
                self.upModel.contractName = str;
            };
        }
            break;
        case 2:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:[AddressDetailTextInputCell cellIdentifier] forIndexPath:indexPath];
            AddressDetailTextInputCell *tableCell = (AddressDetailTextInputCell *)cell;
            tableCell.titleLabel.text = self.titleArray[indexPath.row -1];
            tableCell.contentTF.rightViewMode = UITextFieldViewModeNever;
            tableCell.contentTF.keyboardType = UIKeyboardTypePhonePad;
            tableCell.contentTF.text = self.upModel.mobileNo;
            @weakify(self);
            tableCell.contentTF.endEditBlock = ^(NSString *str){
                @strongify(self);
                self.upModel.mobileNo = str;
            };
            
        }
            break;
        case 3:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:[AddressDetailTextInputCell cellIdentifier] forIndexPath:indexPath];
            AddressDetailTextInputCell *tableCell = (AddressDetailTextInputCell *)cell;
            tableCell.titleLabel.text = self.titleArray[indexPath.row -1];
            tableCell.contentTF.placeholder = @"请选择";
            if ([self.upModel.provinceName isNotEmpty]) {
                tableCell.contentTF.text = [NSString stringWithFormat:@"%@ %@ %@",self.upModel.provinceName,self.upModel.cityName,self.upModel.properName];
            }
            @weakify(self);
            tableCell.contentTF.tapAcitonBlock = ^{
                @strongify(self);
                if (self.divisionArray.count < 1) {
                    [UIView makeToast:@"正在获取区划信息"];
                    return;
                }
                GFAddressPicker *picker = [[GFAddressPicker alloc]initWithDataArray:self.divisionArray];
                [picker updateArea:self.area];
                picker.selected = ^(BSDivision *province,BSDivision *city, BSDivision *area)
                {
                    if (!self.area || ![self.area.divisionFullName isEqualToString:area.divisionFullName])
                    {
                        self.area = area;
                        
                        self.upModel.areaId = nil;
                        self.upModel.areaName = nil;
                        
                        self.upModel.provinceId = province.divisionId;
                        self.upModel.provinceName = province.divisionName;
                        
                        self.upModel.cityId = city.divisionId;
                        self.upModel.cityName = city.divisionName;
                        
                        self.upModel.properId = area.divisionId;
                        self.upModel.properName = area.divisionName;
                        [self.tableView reloadData];
                        [self getStreetData];
                    }
                };
                [picker show];
            };
        }
            break;
        case 4:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:[AddressDetailTextInputCell cellIdentifier] forIndexPath:indexPath];
            AddressDetailTextInputCell *tableCell = (AddressDetailTextInputCell *)cell;
            tableCell.titleLabel.text = self.titleArray[indexPath.row -1];
            tableCell.contentTF.placeholder = @"请选择";
            tableCell.contentTF.text = self.upModel.areaName;
            @weakify(self);
            tableCell.contentTF.tapAcitonBlock = ^{
                @strongify(self);
                if (!self.upModel.provinceId || self.upModel.provinceId.length < 1) {
                    [UIView makeToast:@"请先选择地区"];
                    return;
                }
                TeamPickerView *picker = [[TeamPickerView alloc]init];
                NSMutableArray *array = [NSMutableArray array];
                for (BSDivision *model in self.streetArray) {
                    [array addObject:model.divisionName];
                }
                if (array.count < 1) {
                    [UIView makeToast:@"街道信息有误"];
                    return;
                }
                [picker setItems:array title:nil defaultStr:self.upModel.areaName];
                picker.selectedIndex = ^(NSInteger index) {
                    BSDivision *street = self.streetArray[index];
                    self.upModel.areaId = street.divisionId;
                    self.upModel.areaName = street.divisionName;
                    [self.tableView reloadData];
                };
                [picker show];
            };
        }
            break;
        case 5:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:[AddressDetailTextInputCell cellIdentifier] forIndexPath:indexPath];
            AddressDetailTextInputCell *tableCell = (AddressDetailTextInputCell *)cell;
            tableCell.titleLabel.text = self.titleArray[indexPath.row -1];
            tableCell.contentTF.rightViewMode = UITextFieldViewModeNever;
            tableCell.contentTF.text = self.upModel.detailAddr;
            @weakify(self);
            tableCell.contentTF.endEditBlock = ^(NSString *str){
                @strongify(self);
                self.upModel.detailAddr = str;
            };
        }
            break;
        case 6:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:[AddressDefaultCell cellIdentifier] forIndexPath:indexPath];
            AddressDefaultCell *tableCell = (AddressDefaultCell *)cell;
            NSString *img = [self.upModel.isAutoAddr isEqualToString:@"1"] ?  @"address_normal": @"address_selected";
            tableCell.selectImageView.image = [UIImage imageNamed:img];
        }
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 6) {
        self.upModel.isAutoAddr = [self.upModel.isAutoAddr isEqualToString:@"1"] ? @"2":@"1";
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}
#pragma mark ---- click

- (void)saveBtnPressed:(UIButton *)sender
{
   
    if(!self.upModel.contractName || self.upModel.contractName.length < 1) {
        [UIView makeToast:@"请输入联系人"];
        return;
    }
    if (![self.upModel.mobileNo isPhoneNumber]) {
        [UIView makeToast:@"请输入正确手机号码"];
        return;
    }
    if (!self.upModel.provinceId || [self.upModel.provinceId isEmpty] || [self.upModel.cityId isEmpty] || [self.upModel.properId isEmpty]) {
        [UIView makeToast:@"请选择地区"];
        return;
    }
    if (!self.upModel.areaId || self.upModel.areaId.length < 1) {
        [UIView makeToast:@"请选择街道"];
        return;
    }
    if (!self.upModel.detailAddr || self.upModel.detailAddr.length < 1) {
        [UIView makeToast:@"请输入详细地址"];
        return;
    }
    self.upModel.areaName = nil;
    self.upModel.cityName = nil;
    self.upModel.properName = nil;
    self.upModel.provinceName = nil;
    if ([self.upModel.residentAddrId isNotEmpty]) {
        BSAddressUpdateRequest *updateRequest = [[BSAddressUpdateRequest alloc]init];
        BSAddressModel *model = [self.upModel encryptCBCSModel];
        updateRequest.residentAddress = [model mj_keyValues];
        [MBProgressHUD showHud];
        @weakify(self);
        [updateRequest startWithCompletionBlockWithSuccess:^(__kindof BSAddressUpdateRequest * _Nonnull request) {
            @strongify(self);
            [MBProgressHUD hideHud];
            [UIView makeToast:request.msg];
            [self.navigationController popViewControllerAnimated:YES];
            
        } failure:^(__kindof BSAddressUpdateRequest * _Nonnull request) {
            [MBProgressHUD hideHud];
            [UIView makeToast:request.msg];
        }];
    }
    else
    {
        BSAddressSaveRequest *saveRequest = [[BSAddressSaveRequest alloc]init];
        BSAddressModel *model = [self.upModel encryptCBCSModel];
        saveRequest.residentAddress = [model mj_keyValues];
        [MBProgressHUD showHud];
        @weakify(self);
        [saveRequest startWithCompletionBlockWithSuccess:^(__kindof BSAddressSaveRequest * _Nonnull request) {
            @strongify(self);
            [MBProgressHUD hideHud];
            [UIView makeToast:request.msg];
            [self.navigationController popViewControllerAnimated:YES];
            
        } failure:^(__kindof BSAddressSaveRequest * _Nonnull request) {
            [MBProgressHUD hideHud];
            [UIView makeToast:request.msg];
        }];
    }
    
    
}


@end
