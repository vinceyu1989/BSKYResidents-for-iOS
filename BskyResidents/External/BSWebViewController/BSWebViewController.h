//
//  BSWebViewController.h
//  BSKYDoctorPro
//
//  Created by LinfengYU on 2017/8/23.
//  Copyright © 2017年 ky. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "Macro.h"

@interface BSWebViewController : UIViewController

@property(nonatomic, strong) UIColor * _Nullable ba_web_progressTintColor;
@property(nonatomic, strong) UIColor * _Nullable ba_web_progressTrackTintColor;

@property (nonatomic, assign) BOOL showNavigationBar;
@property (nonatomic, assign) BOOL webCanGoBack;
@property (nonatomic ,copy) NSString * _Nonnull  ocTojsStr;   // oc 传值给js

/**
 *  加载一个 webview
 *
 *  @param request 请求的 NSURL URLRequest
 */
- (void)ba_web_loadRequest:(NSURLRequest *_Nullable)request;

/**
 *  加载一个 webview
 *
 *  @param URL 请求的 URL
 */
- (void)ba_web_loadURL:(NSURL *_Nullable)URL;

/**
 *  加载一个 webview
 *
 *  @param URLString 请求的 URLString
 */
- (void)ba_web_loadURLString:(NSString *_Nullable)URLString;

/**
 *  加载本地网页
 *
 *  @param htmlName 请求的本地 HTML 文件名
 */
- (void)ba_web_loadHTMLFileName:(NSString *_Nullable)htmlName;

/**
 *  加载本地 htmlString
 *
 *  @param htmlString 请求的本地 htmlString
 */
- (void)ba_web_loadHTMLString:(NSString *_Nullable)htmlString;

/**
 *  加载 js 字符串，例如：高度自适应获取代码：
 // webView 高度自适应
 [self ba_web_stringByEvaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
 // 获取页面高度，并重置 webview 的 frame
 self.ba_web_currentHeight = [result doubleValue];
 CGRect frame = webView.frame;
 frame.size.height = self.ba_web_currentHeight;
 webView.frame = frame;
 }];
 *
 *  @param javaScriptString js 字符串
 */
- (void)ba_web_stringByEvaluateJavaScript:(NSString *_Nullable)javaScriptString completionHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))completionHandler;

@end
