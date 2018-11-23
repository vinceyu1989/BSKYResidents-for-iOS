//
//  BskyMacroDefinition.h
//  BSKYResidents
//
//  Created by 何雷 on 2017/7/18.
//  Copyright © 2017年 何雷. All rights reserved.
//

#ifndef BskyMacroDefinition_h
#define BskyMacroDefinition_h


//-------------------获取设备大小-------------------------
// NavigationBar高度
#define Bsky_NAVIGATION_BAR_HEIGHT 44

// Tabbar高度
#define Bsky_TAB_BAR_HEIGHT 49



// StatusBar高度
#define Bsky_STATUS_BAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height
//
// NavigationBar + StatusBar 高度
#define Bsky_TOP_BAR_HEIGHT (Bsky_NAVIGATION_BAR_HEIGHT + Bsky_STATUS_BAR_HEIGHT)

// 获取屏幕宽度和高度
#define Bsky_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define Bsky_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

// UI标准图
#define Bsky_UI_SCREEN_WIDTH 375
#define Bsky_UI_SCREEN_HEIGHT 667

// iPhone X底部高度
#define SafeAreaBottomHeight (Bsky_SCREEN_HEIGHT == 812.0 ? 34 : 0)

//------------------单例写法-------------------

#define Bsky_SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(__CLASSNAME__)	\
\
+ (__CLASSNAME__*) sharedInstance;	\


#define Bsky_SYNTHESIZE_SINGLETON_FOR_CLASS(__CLASSNAME__)	\
\
static __CLASSNAME__ *instance = nil;   \
\
+ (__CLASSNAME__ *)sharedInstance{ \
static dispatch_once_t onceToken;   \
dispatch_once(&onceToken, ^{    \
if (nil == instance){   \
instance = [[__CLASSNAME__ alloc] init];    \
}   \
}); \
\
return instance;   \
}   \


//-------------------打印日志----------------------------
// DEBUG模式下打印日志,当前行
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

// DEBUG模式下打印日志,当前行、并弹出一个警告
#ifdef DEBUG
#define ULog(fmt, ...)  { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }
#else
#   define ULog(...)
#endif
//-------------------打印日志----------------------------


//-------------------重写NSLog--------------------------
//// 重写NSLog,Debug模式下打印日志和当前行数
//#if DEBUG
//#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
//#else
//#define NSLog(FORMAT, ...) nil
//#endif
//-------------------重写NSLog--------------------------


//----------------------系统----------------------------
// 获取系统版本
#define Bsky_IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]     //浮点型
#define Bsky_CURRENT_SYSTEM_VERSION [[UIDevice currentDevice] systemVersion]       //字符串型

// 获取当前语言
#define Bsky_CURRENT_LANGUAGE ([[NSLocale preferredLanguages] objectAtIndex:0])


//----------------------图片----------------------------
// 读取本地图片
#define Bsky_LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

// 读取本地图片
#define Bsky_IMAGE_WITH_NAME(name) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:name]]

// 定义UIImage对象
#define Bsky_IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

// 定义UIImage对象
#define Bsky_ImageNamed(_pointer) [UIImage imageNamed:_pointer]


//----------------------颜色类---------------------------
#define NAV_BAR_COLOE [UIColor colorWithRed:30/255.0 green:160.0/255.0 blue:255.0/255.0 alpha:1.0]
// RGB颜色转换（16进制->10进制）
#define Bsky_UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// RGB颜色转换（16进制->10进制）带alpha
#define Bsky_UIColorFromRGBA(rgbValue, A) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:A]

// 带有RGBA的颜色设置
#define Bsky_COLOR_RGBA(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

// 带有RGB的颜色设置
#define Bsky_COLOR_RGB(R, G, B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.f]

// 带有RGBA的颜色设置
#define RGBA(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

// 带有RGB的颜色设置
#define RGB(R, G, B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.f]

//----------------------其他----------------------------
// 应用代理
#define Bsky_APP ((AppDelegate*)[UIApplication sharedApplication].delegate)

// 系统字体定义
#define Bsky_SystemFONT(F) [UIFont systemFontOfSize:F]

// 系统粗体
#define Bsky_BoldSystemFONT(F) [UIFont boldSystemFontOfSize:F]

// GCD
#define Bsky_BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define Bsky_MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

// NSUserDefaults实例化
#define Bsky_USER_DEFAULT [NSUserDefaults standardUserDefaults]

// NSUserDefaults Key
#define KEY_IN_USERDEFAULT(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]

// 弱引用
#define Bsky_WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#ifndef    weakify

#define weakify(x) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __weak __typeof__(x) __weak_##x##__ = x; \
_Pragma("clang diagnostic pop")

#endif

#ifndef    strongify

#define strongify(x) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
try{} @finally{} __typeof__(x) x = __weak_##x##__; \
_Pragma("clang diagnostic pop")

#endif

#define Bsky_WeakSelf        @weakify(self);
#define Bsky_StrongSelf      @strongify(self);


#define IOS8                        ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0)
#define LESS_IOS8_2                 ([[[UIDevice currentDevice] systemVersion] doubleValue] <= 8.2)
#define IOS9                        ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 9.0 && [[[UIDevice currentDevice] systemVersion] doubleValue] < 10.0)
#define IOS11                       ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 11.0 && [[[UIDevice currentDevice] systemVersion] doubleValue] < 12.0)
#define UIScreenWidth                              [UIScreen mainScreen].bounds.size.width
#define UIScreenHeight                             [UIScreen mainScreen].bounds.size.height
#define UISreenWidthScale   UIScreenWidth / 320


#pragma mark - Notification 通知#########################################################################################################
#define LoginSuccessNotification              @"LoginSuccessNotification"               // 登录成功

#define RealnameAuthenticateSuccessNotification      @"RealnameAuthenticateSuccessNotification"       // 实名认证成功
#define GetRealnameAuthenticateInfoSuccessNotification      @"GetRealnameAuthenticateInfoSuccessNotification"       // 获取实名认证信息成功

#define LogoutNotification                     @"LogoutNotification"     // 退出
#define LoginNotification                       @"LoginNotification"
#define HomeSeriveNotificaton              @"HomeSeriveNotificaton"  //首页服务点击通知
#define CancelUpdate                             @"CancelUpdate"    //取消更新
#define LoginFailedTime                     @"LoginFailedTime"   //记录连续三次验证码登录失败时间
#pragma mark - ###################################################################################################################################################

#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO) //判断是否为iphonex

#endif

