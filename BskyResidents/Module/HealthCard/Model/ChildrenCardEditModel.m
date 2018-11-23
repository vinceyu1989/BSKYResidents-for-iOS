//
//  ChildrenCardEditModel.m
//  BskyResidents
//
//  Created by vince on 2018/9/17.
//  Copyright © 2018年 罗林轩. All rights reserved.
//

#import "ChildrenCardEditModel.h"

@implementation ChildrenCardEditModel
- (void)encryptModel{
    self.idNo = self.idNo.length ? [self.idNo encryptCBCStr] : nil;
    self.name = self.name.length ? [self.name encryptCBCStr] : nil;
    self.mqidno = self.mqidno.length ? [self.mqidno encryptCBCStr] : nil;
    self.mqname = self.mqname.length ? [self.mqname encryptCBCStr] : nil;
}
@end
