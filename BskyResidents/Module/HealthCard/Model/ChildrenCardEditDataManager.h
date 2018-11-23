//
//  ChildrenCardEditDataManager.h
//  BskyResidents
//
//  Created by vince on 2018/9/18.
//  Copyright © 2018年 罗林轩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSArchiveModel.h"
#import "ChildrenListModel.h"
#import "ChildrenCardEditViewController.h"

typedef void(^DicConfig)();

@interface ChildrenCardNoPapperUI : NSObject
@property (nonatomic ,strong) ArchiveModel *baseInfo;
@property (nonatomic ,strong) ArchiveModel *mqInfo;
@end

@interface ChildrenCardEditDataManager : NSObject
@property (nonatomic ,strong) ArchiveModel *editModeCardId;
@property (nonatomic ,strong) ArchiveModel *editModeBirthId;
@property (nonatomic ,strong) ChildrenCardNoPapperUI *editModeNoPapper;

+ (ChildrenCardEditDataManager *)dataManager;
- (void)getBaseDataDicWithModel:(ChildrenListModel *)model type:(ChildrenCardType )type action:(DicConfig )block;
+ (void)dellocManager;
@end

