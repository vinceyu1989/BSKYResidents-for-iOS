//
//  ChildrenCardEditViewController.m
//  BskyResidents
//
//  Created by vince on 2018/9/17.
//  Copyright © 2018年 罗林轩. All rights reserved.
//

#import "ChildrenCardEditViewController.h"
#import "BSArchiveModel.h"
#import "ChildrenCardEditModel.h"
#import "ChildrenCardEditDataManager.h"
#import "ArchivePickerTableViewCell.h"
#import "ChildrenCardEditCardIdRequest.h"
#import "ChildrenCardEditBirthIdRequest.h"
#import "ChildrenCardEditNoPaperRequest.h"

@interface ChildrenCardEditViewController () <UITableViewDelegate ,UITableViewDataSource>
@property (nonatomic ,strong)UIButton *nextBtn;
@property (nonatomic ,strong)UITableView *contentTableView;
@property (nonatomic ,strong)ChildrenCardEditDataManager *dataManager;
@end

@implementation ChildrenCardEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatUI];
    Bsky_WeakSelf;
    
    [self.dataManager getBaseDataDicWithModel:self.model type:self.type action:^{
        Bsky_StrongSelf;
        [self.contentTableView reloadData];
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)creatUI{
    switch (_type) {
        case ChildrenCardTypeCardId:
        {
            self.title = @"儿童健康卡身份证申领";
        }
            break;
        case ChildrenCardTypeBirthId:
        {
            self.title = @"儿童健康卡出生证申领";
        }
            break;
        case ChildrenCardTypeNoPaper:
        {
            self.title = @"儿童健康卡无证申领";
        }
            break;
        default:
            break;
    }
    
    [self.view addSubview:self.contentTableView];
    [self.view addSubview:self.nextBtn];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.left.right.equalTo(@0);
        make.height.equalTo(@45);
    }];
    [self.contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.nextBtn.mas_top);
        make.left.right.equalTo(@0);
        make.top.equalTo(@0);
    }];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (UIButton *)nextBtn{
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextBtn setFrame:CGRectMake(0, self.contentTableView.bottom - 45, self.view.width, 45)];
        
        [_nextBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
        [_nextBtn setBackgroundColor:UIColorFromRGB(0x4e7dd3)];
    }
    return _nextBtn;
}
- (UITableView *)contentTableView{
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        _contentTableView.backgroundColor = UIColorFromRGB(0xf7f7f7);
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_contentTableView registerNib:[ArchivePickerTableViewCell nib] forCellReuseIdentifier:[ArchivePickerTableViewCell cellIdentifier]];
    }
    return _contentTableView;
    
}
- (ChildrenCardEditDataManager *)dataManager{
    if (!_dataManager) {
        _dataManager = [ChildrenCardEditDataManager dataManager];
    }
    return _dataManager;
}
- (void)nextAction{
    
    
    
    ChildrenCardEditModel *model = [self initlationChildrenCardEditModel];
    [self saveToServer:model];
}
- (BOOL )checkDataMode:(ChildrenCardEditModel *)model{
    BOOL sender = YES;
    NSString *message = nil;
    switch (_type) {
        case ChildrenCardTypeCardId:
        {
            if (!model.idNo.length) {
                message = message.length ? message : @"请输入身份证号码";
                sender = NO;
            }
            if (!model.name.length) {
                message = message.length ? message : @"请输入姓名";
                sender = NO;
            }
            if (!model.nation.length) {
                message = message.length ? message : @"请选择民族";
                sender = NO;
            }
        }
            break;
        case ChildrenCardTypeBirthId:
        {
            if (!model.birthday.length) {
                message = message.length ? message : @"请选择出生日期";
                sender = NO;
            }
            if (!model.idNo.length) {
                message = message.length ? message : @"请输入出生证号码";
                sender = NO;
            }
            if (!model.name.length) {
                message = message.length ? message : @"请输入姓名";
                sender = NO;
            }
            if (!model.nation.length) {
                message = message.length ? message : @"请选择民族";
                sender = NO;
            }
            if (!model.gender.length) {
                message = message.length ? message : @"请选择姓别";
                sender = NO;
            }
        }
            break;
        case ChildrenCardTypeNoPaper:
        {
            if (!model.birthday.length) {
                message = message.length ? message : @"请选择出生日期";
                sender = NO;
            }
            if (!model.nation.length) {
                message = message.length ? message : @"请选择民族";
                sender = NO;
            }
            if (!model.gender.length) {
                message = message.length ? message : @"请选择姓别";
                sender = NO;
            }
            if (!model.mqidno.length) {
                message = message.length ? message : @"请输入母亲身份证号码";
                sender = NO;
            }
            if (!model.mqname.length) {
                message = message.length ? message : @"请输入母亲姓名";
                sender = NO;
            }
        }
            break;
        default:
            break;
    }
    if (message.length) {
        [UIView makeToast:message];
    }
    return sender;
}
- (void)saveToServer:(ChildrenCardEditModel *)model{
    if (![self checkDataMode:model]) {
        return;
    }
    if (self.model.chcInfoId.length) {
        model.chcInfoId = self.model.chcInfoId;
    }
    [model encryptModel];
    switch (_type) {
        case ChildrenCardTypeCardId:
        {
            [self saveDataWithCard:model];
        }
            break;
        case ChildrenCardTypeBirthId:
        {
            [self saveDataWithBirthCard:model];
        }
            break;
        case ChildrenCardTypeNoPaper:
        {
            [self saveDataWithNoPapper:model];
        }
            break;
        default:
            break;
    }
}
- (void)saveDataWithBirthCard:(ChildrenCardEditModel *)model{
    ChildrenCardEditBirthIdRequest *request = [[ChildrenCardEditBirthIdRequest alloc] init];
    request.form = [model mj_keyValues];
    Bsky_WeakSelf;
    [MBProgressHUD showHud];
    [request startWithCompletionBlockWithSuccess:^(__kindof ChildrenCardEditBirthIdRequest * _Nonnull request) {
        Bsky_StrongSelf;
        [self.navigationController popViewControllerAnimated:YES];
        [UIView makeToast:@"保存成功"];
        [MBProgressHUD hideHud];
    } failure:^(__kindof ChildrenCardEditBirthIdRequest * _Nonnull request) {
        [UIView makeToast:request.msg];
        [MBProgressHUD hideHud];
    }];
}
- (void)saveDataWithCard:(ChildrenCardEditModel *)model{
    ChildrenCardEditCardIdRequest *request = [[ChildrenCardEditCardIdRequest alloc] init];
    request.form = [model mj_keyValues];
    Bsky_WeakSelf;
    [MBProgressHUD showHud];
    [request startWithCompletionBlockWithSuccess:^(__kindof ChildrenCardEditCardIdRequest * _Nonnull request) {
        Bsky_StrongSelf;
        [self.navigationController popViewControllerAnimated:YES];
        [UIView makeToast:@"保存成功"];
        [MBProgressHUD hideHud];
    } failure:^(__kindof ChildrenCardEditCardIdRequest * _Nonnull request) {
        [UIView makeToast:request.msg];
        [MBProgressHUD hideHud];
    }];
}
- (void)saveDataWithNoPapper:(ChildrenCardEditModel *)model{
    ChildrenCardEditNoPaperRequest *request = [[ChildrenCardEditNoPaperRequest alloc] init];
    request.form = [model mj_keyValues];
    Bsky_WeakSelf;
    [MBProgressHUD showHud];
    [request startWithCompletionBlockWithSuccess:^(__kindof ChildrenCardEditNoPaperRequest * _Nonnull request) {
        Bsky_StrongSelf;
        [self.navigationController popViewControllerAnimated:YES];
        [UIView makeToast:@"保存成功"];
        [MBProgressHUD hideHud];
    } failure:^(__kindof ChildrenCardEditNoPaperRequest * _Nonnull request) {
        [UIView makeToast:request.msg];
        [MBProgressHUD hideHud];
    }];
}
- (ChildrenCardEditModel *)initlationChildrenCardEditModel{
    ChildrenCardEditModel *model = [[ChildrenCardEditModel alloc] init];
    switch (_type) {
        case ChildrenCardTypeCardId:
        {
            for (BSArchiveModel *bsModel in self.dataManager.editModeCardId.content) {
                NSString *value = bsModel.value;
                if ([value length]) {
                    [model setValue:value forKey:bsModel.code];
                }
            }
        }
            break;
        case ChildrenCardTypeBirthId:
        {
            for (BSArchiveModel *bsModel in self.dataManager.editModeBirthId.content) {
                NSString *value = bsModel.value;
                if ([value length]) {
                    [model setValue:value forKey:bsModel.code];
                }
            }
        }
            break;
        case ChildrenCardTypeNoPaper:
        {
            for (BSArchiveModel *bsModel in self.dataManager.editModeNoPapper.baseInfo.content) {
                NSString *value = bsModel.value;;
                if ([value length]) {
                    [model setValue:value forKey:bsModel.code];
                }
            }
            for (BSArchiveModel *bsModel in self.dataManager.editModeNoPapper.mqInfo.content) {
                NSString *value = bsModel.value;;
                if ([value length]) {
                    [model setValue:value forKey:bsModel.code];
                }
            }
        }
            break;
        default:
            break;
    }
    return model;
}
- (void)requstWithSuccess:(BOOL )sender msg:(NSString *)msg{
    [MBProgressHUD hideHud];
    if (sender) {
        [UIView makeToast:msg];
    }else{
        [UIView makeToast:msg];
    }
    //    [self clearAddUIModel];
    //    [self removeFromSuperview];
}
#pragma mark ----- BackButtonHandlerProtocol
- (void)backAction{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"确定退出?" message:@"内容尚未保存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag = 1301;
    [alertView show];
        
    
}
-(BOOL)navigationShouldPopOnBackButton
{
    [self backAction];
    return NO;
}
#pragma mark ------ UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]] &&
        [otherGestureRecognizer isKindOfClass:NSClassFromString(@"UIScrollViewDelayedTouchesBeganGestureRecognizer")])
    {
        if (self.navigationController != nil) {
            [self backAction];
            return NO;
        }
        
        
    }
    return YES;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1301) {
        switch (buttonIndex) {
            case 0:
                break;
            default:
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
                break;
        }
    }
}
- (void)dealloc
{
    [ChildrenCardEditDataManager dellocManager];
    self.dataManager = nil;
}

- (BSArchiveModel *)getArchiveModelWithIndexPath:(NSIndexPath *)indexPath{
    BSArchiveModel *model = nil;
    if (_type == ChildrenCardTypeNoPaper) {
        if (indexPath.section == 0) {
            model = [self.dataManager.editModeNoPapper.baseInfo.content objectAtIndex:indexPath.row];
        }else{
            model = [self.dataManager.editModeNoPapper.mqInfo.content objectAtIndex:indexPath.row];
        }
    }else if (_type == ChildrenCardTypeCardId) {
        model = [self.dataManager.editModeCardId.content objectAtIndex:indexPath.row];
    }else{
        model = [self.dataManager.editModeBirthId.content objectAtIndex:indexPath.row];
    }
    
    
    return model;
}
- (UITableViewCell *)creatTableViewCellWithindexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    
    BSArchiveModel *model = [self getArchiveModelWithIndexPath:indexPath];
    if (model.type == ArchiveModelTypeCustomPicker || model.type == ArchiveModelTypeDatePicker || model.type == ArchiveModelTypeTextField || model.type == ArchiveModelTypeLabel || model.type == ArchiveModelTypeControllerPicker || model.type == ArchiveModelTypeCustomOptionsPicker) {
        cell = [self.contentTableView dequeueReusableCellWithIdentifier:[ArchivePickerTableViewCell cellIdentifier] forIndexPath:indexPath];
        ArchivePickerTableViewCell *tableCell = (ArchivePickerTableViewCell *)cell;
        tableCell.model = model;
        if ([model.code isEqualToString:@"RegionID"]) {
            Bsky_WeakSelf;
            tableCell.endBlock = ^(id model){
                Bsky_StrongSelf;
            };
        }else{
            
        }
    }
    if (!cell) {
        cell = [self.contentTableView dequeueReusableCellWithIdentifier:@"123"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"123"];
        }
    }
    
    
    return cell;
}
//- (void)reloadAddressCellWithModel:(ArchiveDivisionModel *)model indexPath:(NSIndexPath *)indexPath{
//    NSIndexPath *addressIndex = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
//    BSArchiveModel *uiModel = [self getArchiveModelWithIndexPath:addressIndex];
//    NSString *resultStr = [model.divisionFullName stringByReplacingOccurrencesOfString:@">" withString:@""];
//    resultStr = [resultStr stringByReplacingOccurrencesOfString:@" " withString:@""];
//    uiModel.contentStr = resultStr;
//    uiModel.value = resultStr;
//    [ArchiveFamilyDataManager dataManager].regionCode = model.divisionCode;
//    [self beginUpdates];
//    [self reloadRowAtIndexPath:addressIndex withRowAnimation:UITableViewRowAnimationNone];
//    [self endUpdates];
//}
#pragma mark talbeView Delegate && Datasource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self creatTableViewCellWithindexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (_type) {
        case ChildrenCardTypeCardId:
        {
            return self.dataManager.editModeCardId.content.count;
        }
            break;
        case ChildrenCardTypeBirthId:
        {
            return self.dataManager.editModeBirthId.content.count;
        }
            break;
        case ChildrenCardTypeNoPaper:
        {
            if (section == 0) {
                return self.dataManager.editModeNoPapper.baseInfo.content.count;
            }else{
                return self.dataManager.editModeNoPapper.mqInfo.content.count;
            }
        }
            break;
        default:
            return 0;
            break;
    }
}
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    if (_type == ChildrenCardTypeNoPaper) {
        return 2;
    }else{
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    view.backgroundColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth - 30, 30)];
    label.font = [UIFont systemFontOfSize:12];
    label.backgroundColor = [UIColor clearColor];
    [view addSubview:label];
    switch (_type) {
        case ChildrenCardTypeCardId:
        {
            label.text = self.dataManager.editModeCardId.contentStr;
        }
            break;
        case ChildrenCardTypeBirthId:
        {
            label.text = self.dataManager.editModeBirthId.contentStr;
        }
            break;
        case ChildrenCardTypeNoPaper:
        {
            if (section == 0) {
                label.text = self.dataManager.editModeNoPapper.baseInfo.contentStr;
            }else{
                label.text = self.dataManager.editModeNoPapper.mqInfo.contentStr;
            }
        }
            break;
        default:
            return 0;
            break;
    }
    return view;
}
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = UIColorFromRGB(0xf7f7f7);
    return view;
}
@end
