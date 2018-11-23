//
//  BSUser.m
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/23.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSUser.h"

@implementation BSUser

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.realnameInfo = [[BSRealnameInfo alloc]init];
    }
    return self;
}
- (void)decryptCBCModel{
//    self.loginMark = [self.loginMark decryptCBCStr];
    self.photourl = [self.photourl decryptCBCStr];
    self.realName = [self.realName decryptCBCStr];
    self.regCode = [self.regCode decryptCBCStr];
//    self.token = [self.token decryptCBCStr];
    self.userId = [self.userId decryptCBCStr];
}
@end
