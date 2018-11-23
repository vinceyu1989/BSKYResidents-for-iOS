//
//  BSAddressUpModel.m
//  BskyResidents
//
//  Created by 何雷 on 2017/10/24.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSAddressModel.h"

@implementation BSAddressModel
- (BSAddressModel *)encryptCBCSModel{
    BSAddressModel *model = [BSAddressModel mj_objectWithKeyValues:[self mj_keyValues]];
    model.contractName = [model.contractName encryptCBCStr];
    model.detailAddr = [model.detailAddr encryptCBCStr];
    model.mobileNo = [model.mobileNo encryptCBCStr];
    model.userId = [model.userId encryptCBCStr];
    return model;
    
}
@end
