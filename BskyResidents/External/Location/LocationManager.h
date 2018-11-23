//
//  LocationManager.h
//  BskyResidents
//
//  Created by 罗林轩 on 2017/11/20.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void (^ currentLocationBlock)(NSString *state,NSString *city,NSString *subLocality,NSString *street);

@interface LocationManager : NSObject
@property (copy, nonatomic) NSString *state;
@property (copy, nonatomic) NSString *city;
@property (copy, nonatomic) NSString *subLocality;
@property (copy, nonatomic) NSString *street;
@property (strong, nonatomic) currentLocationBlock currentLocationBlock;
//初始化
+ (instancetype)locationShare;
//获取当前位置
- (void)currentLocationWithLoctionBlock:(currentLocationBlock)currentLocationBlock;
//检查当前位置
- (void)checkAuthorizationStatus;
@end
