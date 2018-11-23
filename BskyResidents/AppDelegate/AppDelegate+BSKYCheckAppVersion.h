//
//  AppDelegate+BSKYCheckAppVersion.h
//  BskyResidents
//
//  Created by 罗林轩 on 2017/12/12.
//  Copyright © 2017年 罗林轩. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (BSKYCheckAppVersion)
- (void)chekAppVersionWithSuccesBlock:(void (^)(BOOL isUpdate))succesBlock failBlock:(void (^)(void))failBlock;
@end
