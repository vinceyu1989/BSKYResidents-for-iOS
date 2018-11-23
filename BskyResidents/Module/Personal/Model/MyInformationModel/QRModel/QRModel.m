//
//  QRModel.m
//  BskyResidents
//
//  Created by 罗林轩 on 2017/11/21.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "QRModel.h"

@implementation QRModel
- (void )decryptCBCModel{
    self.zjhm = [self.zjhm decryptCBCStr];
    self.realName = [self.realName decryptCBCStr];
    self.lxdh = [self.lxdh decryptCBCStr];
    self.base64 = [self.base64 decryptCBCStr];
}
@end
