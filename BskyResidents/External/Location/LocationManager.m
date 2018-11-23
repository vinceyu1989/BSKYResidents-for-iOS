//
//  LocationManager.m
//  BskyResidents
//
//  Created by 罗林轩 on 2017/11/20.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "LocationManager.h"
@interface LocationManager()<CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *location;

@end

@implementation LocationManager
+ (instancetype)locationShare{
    static LocationManager *locaionManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        locaionManager = [[self alloc] init];
    });
    return locaionManager;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _location = [[CLLocationManager alloc] init];
        _location.delegate = self;
        //期望的经度
        _location.desiredAccuracy = kCLLocationAccuracyBest;
        // 设置定位距离过滤参数 (当本次定位和上次定位之间的距离大于或等于这个值时，调用代理方法)
        _location.distanceFilter = 100;
        if ([[UIDevice currentDevice] systemVersion].doubleValue > 8.0) {//如果iOS是8.0以上版本
            if([_location respondsToSelector:@selector(requestWhenInUseAuthorization)]){
                [_location requestWhenInUseAuthorization];
            }
//            if([_location respondsToSelector:@selector(requestAlwaysAuthorization)]){
//                [_location requestAlwaysAuthorization];
//            }
        }
    }
    return self;
}

#pragma mark - 开始定位
- (void)checkAuthorizationStatus{
    UIViewController *rootVc = [UIApplication sharedApplication].delegate.window.rootViewController;
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse  || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)) {
        //定位功能可用,初始化定位
        [_location startUpdatingLocation];
    }else{
//        定位不能用
//        [AlertViewController alertWithTitle:@"巴蜀快医想要打开定位"  String:@"跳转到设置界面打开定位" actionTitleArray:@[@"取消",@"好的"] viewController:rootVc preferredStyle:UIAlertControllerStyleAlert selectedBlock:^(NSInteger selectedIndex) {
//            if (selectedIndex == 1) {
//                NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//                if([[UIApplication sharedApplication] canOpenURL:url]) {
//                    NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
//                    [[UIApplication sharedApplication] openURL:url];
//                }
//            }
//         }];
    }
}

- (void)currentLocationWithLoctionBlock:(currentLocationBlock)currentLocationBlock{
    _currentLocationBlock = currentLocationBlock;
    [self checkAuthorizationStatus];
}

#pragma mark - CLLocationManagerDelegate
//获取经纬度和详细地址
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *location = [locations lastObject];
    NSLog(@"定位成功");
    NSLog(@"latitude === %g  longitude === %g",location.coordinate.latitude, location.coordinate.longitude);
    //反向地理编码
    CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];
    CLLocation *cl = [[CLLocation alloc] initWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
    [clGeoCoder reverseGeocodeLocation:cl completionHandler: ^(NSArray *placemarks,NSError *error) {
        for (CLPlacemark *placeMark in placemarks) {
            NSDictionary *addressDic = placeMark.addressDictionary;
            _state =[[addressDic objectForKey:@"State"] length] == 0 ? @"未获取到数据" : [addressDic objectForKey:@"State"];
            _city= [[addressDic objectForKey:@"City"]length] == 0 ? @"未获取到数据" : [addressDic objectForKey:@"City"];
            _subLocality=[[addressDic objectForKey:@"SubLocality"] length] == 0 ? @"未获取到数据" : [addressDic objectForKey:@"SubLocality"];
            _street=[[addressDic objectForKey:@"Street"] length] == 0 ? @"未获取到数据" : [addressDic objectForKey:@"Street"];
            if (_currentLocationBlock) {
                _currentLocationBlock(_state,_city,_subLocality,_street);
            }
            [_location stopUpdatingLocation];
        }
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if ([error code] == kCLErrorDenied){
        //访问被拒绝
    }
    if ([error code] == kCLErrorLocationUnknown) {
        //无法获取位置信息
    }
}

@end
