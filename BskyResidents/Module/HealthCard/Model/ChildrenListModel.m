//
//  ChildrenListModel.m
//  BskyResidents
//
//  Created by vince on 2018/9/17.
//  Copyright © 2018年 罗林轩. All rights reserved.
//

#import "ChildrenListModel.h"

@implementation ChildrenListModel
- (void)decryptModel{
    self.name = [self.name decryptCBCStr];
    self.idNo = [self.idNo decryptCBCStr];
    self.mqname = [self.mqname decryptCBCStr];
    self.mqidno = [self.mqidno decryptCBCStr];
    self.ehealthCode = [self.ehealthCode decryptCBCStr];
}
@end
