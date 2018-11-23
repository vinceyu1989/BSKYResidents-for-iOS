//
//  BSAppManager.m
//  BSKYDoctorPro
//
//  Created by LinfengYU on 2017/9/12.
//  Copyright © 2017年 ky. All rights reserved.
//

#import "BSAppManager.h"

@interface BSAppManager ()

@end

@implementation BSAppManager

+ (instancetype)sharedInstance {
    static BSAppManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        sharedInstance.currentUser = [[BSUser alloc]init];
    });
    return sharedInstance;
}
- (NSMutableDictionary *)dataDic{
    if (!_dataDic) {
        _dataDic = [[NSMutableDictionary alloc] init];
    }
    return _dataDic;
}
@end
