//
//  ChildrenCardEditDataManager.m
//  BskyResidents
//
//  Created by vince on 2018/9/18.
//  Copyright © 2018年 罗林轩. All rights reserved.
//

#import "ChildrenCardEditDataManager.h"
#import "BSFormsDicRequest.h"
#import "BSDictModel.h"

@implementation ChildrenCardNoPapperUI
@end

@implementation ChildrenCardEditDataManager
static ChildrenCardEditDataManager *_instance;

+ (ChildrenCardEditDataManager *)dataManager{
    if (_instance == nil) {
        _instance = [[ChildrenCardEditDataManager alloc] init];
    }
    
    return _instance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initDataModel];
//        [self getBaseDataDic];
//        [self getDivisionId];
    }
    return  self;
}
- (void)initDataModel{
    NSString *pathStr = [[NSBundle mainBundle] pathForResource:@"ChildrenEditCardId" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:pathStr];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    self.editModeCardId = [ArchiveModel mj_objectWithKeyValues:dic];
    
    NSString *pathStr1 = [[NSBundle mainBundle] pathForResource:@"ChildrenEditBirthId" ofType:@"json"];
    NSData *data1 = [NSData dataWithContentsOfFile:pathStr1];
    NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingMutableContainers error:nil];
    self.editModeBirthId = [ArchiveModel mj_objectWithKeyValues:dic1];
    
    NSString *pathStr2 = [[NSBundle mainBundle] pathForResource:@"ChildrenEditNoPapper" ofType:@"json"];
    NSData *data2 = [NSData dataWithContentsOfFile:pathStr2];
    NSDictionary *dic2 = [NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableContainers error:nil];
    self.editModeNoPapper = [ChildrenCardNoPapperUI mj_objectWithKeyValues:dic2];
}
- (void)getBaseDataDicWithModel:(ChildrenListModel *)model type:(ChildrenCardType )type action:(DicConfig )block{
    NSDictionary *dic = [BSAppManager sharedInstance].dataDic;
    if (dic.count) {
        BSArchiveModel *bsModel = [self.editModeCardId.content objectAtIndex:2];
        BSArchiveModel *bsModel1 = [self.editModeBirthId.content objectAtIndex:4];
        BSArchiveModel *bsModel2 = [self.editModeNoPapper.baseInfo.content objectAtIndex:2];
        [self updatePick:bsModel option:[dic objectForKey:@"nation"]];
        [self updatePick:bsModel1 option:[dic objectForKey:@"nation"]];
        [self updatePick:bsModel2 option:[dic objectForKey:@"nation"]];
        [self dataToUIData:model type:type];
        if (block) {
            block();
        }
    }else{
        BSFormsDicRequest *infoAllRequest = [[BSFormsDicRequest alloc]init];
        infoAllRequest.dictTypes = @[@"nation"];
        [MBProgressHUD showHud];
        Bsky_WeakSelf;
        [infoAllRequest startWithCompletionBlockWithSuccess:^(__kindof BSFormsDicRequest * _Nonnull request) {
            Bsky_StrongSelf;
            for (BSDictModel *model in request.dictArray) {
                [[BSAppManager sharedInstance].dataDic setObject:model.dictList forKey:model.type];
            }
            BSArchiveModel *bsModel = [self.editModeCardId.content objectAtIndex:2];
            BSArchiveModel *bsModel1 = [self.editModeBirthId.content objectAtIndex:4];
            BSArchiveModel *bsModel2 = [self.editModeNoPapper.baseInfo.content objectAtIndex:2];
            [self updatePick:bsModel option:[dic objectForKey:@"nation"]];
            [self updatePick:bsModel1 option:[dic objectForKey:@"nation"]];
            [self updatePick:bsModel2 option:[dic objectForKey:@"nation"]];
            [self dataToUIData:model type:type];
            if (block) {
                block();
            }
            [MBProgressHUD hideHud];
        } failure:^(__kindof BSFormsDicRequest * _Nonnull request) {
            [UIView makeToast:request.msg];
            [MBProgressHUD hideHud];
        }];
    }
    
}
- (void)updatePick:(BSArchiveModel *)bsModel option:(NSArray *)array{
    ArchivePickerModel *pick = bsModel.pickerModel;
    if (!pick) {
        pick = [[ArchivePickerModel alloc] init];
    }
    pick.options = array;
    bsModel.pickerModel = pick;
    if (array.count) {
        ArchiveSelectOptionModel *option = array.firstObject;
        bsModel.value = option.value;
        bsModel.contentStr = option.lebel;
    }
    
}
- (void)dataToUIData:(ChildrenListModel *)model type:(ChildrenCardType )type{
    switch (type) {
        case ChildrenCardTypeCardId:
        {
            for (BSArchiveModel *bsModel in self.editModeCardId.content) {
                
                NSString *value = [model.mj_keyValues objectForKey:bsModel.code];
                [self updateBSUIModelValeWithDataModel:bsModel value:value];
            }
        }
        break;
        case ChildrenCardTypeBirthId:
        {
            for (BSArchiveModel *bsModel in self.editModeBirthId.content) {
                NSString *value = [model.mj_keyValues objectForKey:bsModel.code];
                [self updateBSUIModelValeWithDataModel:bsModel value:value];
            }
        }
        break;
        case ChildrenCardTypeNoPaper:
        {
            for (BSArchiveModel *bsModel in self.editModeNoPapper.baseInfo.content) {
                NSString *value = [model.mj_keyValues objectForKey:bsModel.code];
                [self updateBSUIModelValeWithDataModel:bsModel value:value];
            }
            for (BSArchiveModel *bsModel in self.editModeNoPapper.mqInfo.content) {
                NSString *value = [model.mj_keyValues objectForKey:bsModel.code];
                [self updateBSUIModelValeWithDataModel:bsModel value:value];
            }
        }
        break;
        default:
        break;
    }
}
- (void)updateBSUIModelValeWithDataModel:(BSArchiveModel *)bsModel value:(NSString *)value{
    if ([value length]) {
        if (bsModel.type == ArchiveModelTypeTextField) {
            bsModel.value = value;
            bsModel.contentStr = value;
        }else if (bsModel.type == ArchiveModelTypeCustomPicker){
            if ([bsModel.code isEqualToString:@"gender"]){
                bsModel.value = value;
                bsModel.contentStr = [self getOptionLabelWithArray:bsModel.pickerModel.options value:value];
            }else if ([bsModel.code isEqualToString:@"nation"]){
                bsModel.value = value;
                bsModel.contentStr = [self getOptionLabelWithArray:bsModel.pickerModel.options value:value];
            }
        }else if (bsModel.type == ArchiveModelTypeDatePicker){
            if ([bsModel.code isEqualToString:@"birthday"]) {
                bsModel.value = value;
                bsModel.contentStr = value;
            }
        }
        
    }else{
        if (bsModel.type == ArchiveModelTypeCustomPicker){
            if ([bsModel.code isEqualToString:@"gender"]){
                ArchiveSelectOptionModel *option = bsModel.pickerModel.options.firstObject;
                bsModel.value = option.value;
                bsModel.contentStr = option.lebel;
            }else if ([bsModel.code isEqualToString:@"nation"]){
                ArchiveSelectOptionModel *option = bsModel.pickerModel.options.firstObject;
                bsModel.value = option.value;
                bsModel.contentStr = option.lebel;
            }
        }else if (bsModel.type == ArchiveModelTypeDatePicker){
            if ([bsModel.code isEqualToString:@"birthday"]) {
                NSDate *date = [NSDate date];
                NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];//创建一个日期格式化器
                dateFormatter.dateFormat=@"yyyy-MM-dd";
                NSString *dateStr = [dateFormatter stringFromDate:date];
                bsModel.value = dateStr;
                bsModel.contentStr = dateStr;
            }
        }
    }
}
- (NSString *)getOptionLabelWithArray:(NSArray *)array value:(NSString *)value{
    NSString *label = nil;
    for (ArchiveSelectOptionModel *option in array) {
        if ([option.value isEqualToString:value]) {
            label = option.lebel;
            return label;
        }
    }
    return label;
}
+ (void)dellocManager{
    _instance = nil;
}
@end
