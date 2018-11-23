//
//  BSAppManager.h
//  BSKYDoctorPro
//
//  Created by LinfengYU on 2017/9/12.
//  Copyright © 2017年 ky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSAppManager : NSObject

@property (nonatomic, strong) BSUser *currentUser;
@property (nonatomic ,copy) NSString *publicKey;
@property (nonatomic ,copy) NSString *cbcKey;
@property (nonatomic ,copy) NSString *needEncryption;
@property (nonatomic ,strong) NSMutableDictionary *dataDic;
+ (instancetype)sharedInstance;

@end
