//
//  BSWebViewController.m
//  BSKYDoctorPro
//
//  Created by LinfengYU on 2017/8/23.
//  Copyright © 2017年 ky. All rights reserved.
//

#import "BSWebViewController.h"
#import "BAKit_WebView.h"

@interface BSWebViewController () <WKScriptMessageHandler>

@property(nonatomic, strong) WKWebView *webView;
@property(nonatomic, strong) WKWebViewConfiguration *webConfig;
@property(nonatomic, strong) UIProgressView *progressView;

@property(nonatomic, strong) NSURL *ba_web_currentUrl;

@end

@implementation BSWebViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.showNavigationBar) {
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.leftItemsSupplementBackButton = YES;
    }
    [self.navigationController setNavigationBarHidden:!self.showNavigationBar animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)setupUI
{
    self.view.backgroundColor = BAKit_Color_White_pod;
    self.webView.hidden = NO;
    if (_webCanGoBack) {
        [self configBackItem];
    }
    
    
    BAKit_WeakSelf;
    self.webView.ba_web_didStartBlock = ^(WKWebView *webView, WKNavigation *navigation) {
        NSLog(@"开始加载网页");
    };
    
    self.webView.ba_web_didFinishBlock = ^(WKWebView *webView, WKNavigation *navigation) {
        BAKit_StrongSelf;
        if (self.ocTojsStr && self.ocTojsStr.length > 0) {
            [webView ba_web_stringByEvaluateJavaScript:self.ocTojsStr completionHandler:^(id  _Nullable result, NSError * _Nullable error) {
                
            }];
        }

        
    };
    
    self.webView.ba_web_isLoadingBlock = ^(BOOL isLoading, CGFloat progress) {
        
        BAKit_StrongSelf
        [self ba_web_progressShow];
        self.progressView.progress = progress;
        if (self.progressView.progress == 1.0f)
        {
            [self ba_web_progressHidder];
        }
    };
    
//    self.webView.ba_web_getTitleBlock = ^(NSString *title) {
//        
//        BAKit_StrongSelf
//        // 获取当前网页的 title
//        self.title = title;
//    };
    
    self.webView.ba_web_getCurrentUrlBlock = ^(NSURL * _Nonnull currentUrl) {
        BAKit_StrongSelf
        self.ba_web_currentUrl = currentUrl;
    };
}

#pragma mark - 修改 navigator.userAgent
- (void)changeNavigatorUserAgent
{
    BAKit_WeakSelf
    [self.webView ba_web_stringByEvaluateJavaScript:@"navigator.userAgent" completionHandler:^(id  _Nullable result, NSError * _Nullable error) {
        BAKit_StrongSelf
        NSLog(@"old agent ----- :%@", result);
        NSString *userAgent = result;
        
        NSString *customAgent = @" native_iOS";
        if ([userAgent hasSuffix:customAgent])
        {
            NSLog(@"navigator.userAgent已经修改过了");
        }
        else
        {
            NSString *customUserAgent = [userAgent stringByAppendingString:[NSString stringWithFormat:@"%@", customAgent]]; // 这里加空格是为了好看
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:customUserAgent, @"UserAgent", nil];
            [BAKit_NSUserDefaults registerDefaults:dictionary];
            [BAKit_NSUserDefaults synchronize];
            
            if ([self.webView respondsToSelector:@selector(setCustomUserAgent:)]) {
                [self.webView setCustomUserAgent:customUserAgent];
            }
            
            [self.webView ba_web_reload];
        }
    }];
}

- (void)ba_reload
{
    [self.webView ba_web_reload];
    [self changeNavigatorUserAgent];
}

- (void)ba_web_progressShow
{
    // 开始加载网页时展示出progressView
    self.progressView.hidden = NO;
    // 开始加载网页的时候将progressView的Height恢复为1.5倍
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    // 防止progressView被网页挡住
    [self.navigationController.view bringSubviewToFront:self.progressView];
}

- (void)ba_web_progressHidder
{
    /*
     *添加一个简单的动画，将progressView的Height变为1.4倍，在开始加载网页的代理中会恢复为1.5倍
     *动画时长0.25s，延时0.3s后开始动画
     *动画结束后将progressView隐藏
     */
    [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
    } completion:^(BOOL finished) {
        self.progressView.hidden = YES;
        
    }];
}

/**
 *  加载一个 webview
 *
 *  @param request 请求的 NSURL URLRequest
 */
- (void)ba_web_loadRequest:(NSURLRequest *)request
{
    [self.webView ba_web_loadRequest:request];
}

/**
 *  加载一个 webview
 *
 *  @param URL 请求的 URL
 */
- (void)ba_web_loadURL:(NSURL *)URL
{
    [self.webView ba_web_loadURL:URL];
}

/**
 *  加载一个 webview
 *
 *  @param URLString 请求的 URLString
 */
- (void)ba_web_loadURLString:(NSString *)URLString
{
    [self.webView ba_web_loadURLString:URLString];
}

/**
 *  加载本地网页
 *
 *  @param htmlName 请求的本地 HTML 文件名
 */
- (void)ba_web_loadHTMLFileName:(NSString *)htmlName
{
    [self.webView ba_web_loadHTMLFileName:htmlName];
}

/**
 *  加载本地 htmlString
 *
 *  @param htmlString 请求的本地 htmlString
 */
- (void)ba_web_loadHTMLString:(NSString *)htmlString
{
    [self.webView ba_web_loadHTMLString:htmlString];
}

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
- (void)ba_web_stringByEvaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))completionHandler
{
    [self.webView ba_web_stringByEvaluateJavaScript:javaScriptString completionHandler:completionHandler];
}

#pragma mark - custom Method

#pragma mark 导航栏的返回按钮
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer
                                      *)gestureRecognizer{
    return NO; //YES：允许右滑返回 NO：禁止右滑返回
}
- (void)configBackItem
{
//    return ;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    UIImage *backImage = [UIImage imageNamed:@"nav_back"];
    backImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:backImage];
    [backImageView sizeToFit];
    UIButton *backBtn = [[UIButton alloc] init];
    //    [backBtn setTintColor:BAKit_ColorOrange];
//    [backBtn setBackgroundImage:backImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setFrame:CGRectMake(0, 0, 40, 30)];
    backImageView.center = CGPointMake(5, 15);
    [backBtn addSubview:backImageView];
//    [backBtn sizeToFit];
//    UIButton *doneBtn = [[UIButton alloc] init];
//    //    [backBtn setTintColor:BAKit_ColorOrange];
//    //    [backBtn setBackgroundImage:backImage forState:UIControlStateNormal];
//    [doneBtn addTarget:self action:@selector(closeBtnAcion:) forControlEvents:UIControlEventTouchUpInside];
//    [doneBtn setFrame:CGRectMake(0, 0, 40, 30)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(closeBtnAcion:)];
    
    UIBarButtonItem *spaceButton1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceButton1.width = -5;
//
    UIBarButtonItem *colseItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItems = @[spaceButton1, colseItem];
    if (self.webView.canGoForward && self.webView.canGoBack)
    {
        //        若为可返回状态，则显示返回、关闭两个按钮
//        self.navigationItem.leftBarButtonItems = @[self.backBtn,self.closeBtn];
    }else{
//        self.navigationItem.leftBarButtonItems = @[self.backBtn];
    }
    [self.navigationItem setHidesBackButton:YES];
//    self.navigationItem.leftBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:backBtn]];
    
}

#pragma mark - 按钮点击事件
#pragma mark 返回按钮点击
- (void)closeBtnAcion:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)backBtnAction:(UIButton *)sender
{
    if (self.webView.ba_web_canGoBack)
    {
        [self.webView ba_web_goBack];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (self.showNavigationBar) {
        self.webView.frame = CGRectMake(0, 0, BAKit_SCREEN_WIDTH, BAKit_SCREEN_HEIGHT-Bsky_TOP_BAR_HEIGHT-SafeAreaBottomHeight);
        self.progressView.frame = CGRectMake(0, Bsky_TOP_BAR_HEIGHT, BAKit_SCREEN_WIDTH, 20);
    } else {
        self.webView.frame = CGRectMake(0, 0, BAKit_SCREEN_WIDTH, BAKit_SCREEN_HEIGHT-SafeAreaBottomHeight);
        self.progressView.frame = CGRectMake(0, 0, BAKit_SCREEN_WIDTH, 20);
    }
}

#pragma mark - setter / getter

- (WKWebView *)webView
{
    if (!_webView)
    {
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:self.webConfig];
        //  添加 WKWebView 的代理，注意：用此方法添加代理
        BAKit_WeakSelf
        [self.webView ba_web_initWithDelegate:weak_self.webView uIDelegate:weak_self.webView];
        
        self.webView.multipleTouchEnabled = YES;
        self.webView.autoresizesSubviews = YES;
        
        [self.view addSubview:self.webView];
        
        [self changeNavigatorUserAgent];
    }
    return _webView;
}

- (WKWebViewConfiguration *)webConfig
{
    if (!_webConfig) {
        
        // 创建并配置WKWebView的相关参数
        // 1.WKWebViewConfiguration:是WKWebView初始化时的配置类，里面存放着初始化WK的一系列属性；
        // 2.WKUserContentController:为JS提供了一个发送消息的通道并且可以向页面注入JS的类，WKUserContentController对象可以添加多个scriptMessageHandler；
        // 3.addScriptMessageHandler:name:有两个参数，第一个参数是userContentController的代理对象，第二个参数是JS里发送postMessage的对象。添加一个脚本消息的处理器,同时需要在JS中添加，window.webkit.messageHandlers.<name>.postMessage(<messageBody>)才能起作用。
        
        _webConfig = [[WKWebViewConfiguration alloc] init];
        _webConfig.allowsInlineMediaPlayback = YES;
        
        //        _webConfig.allowsPictureInPictureMediaPlayback = YES;
        
        // 通过 JS 与 webView 内容交互
        // 注入 JS 对象名称 senderModel，当 JS 通过 senderModel 来调用时，我们可以在WKScriptMessageHandler 代理中接收到
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        [userContentController addScriptMessageHandler:self name:@"BSClose"];
        //window.webkit.messageHandlers.BSClose.postMessage({});
        _webConfig.userContentController = userContentController;
        
        // 初始化偏好设置属性：preferences
        _webConfig.preferences = [WKPreferences new];
        // The minimum font size in points default is 0;
        //        _webConfig.preferences.minimumFontSize = 40;
        // 是否支持 JavaScript
        _webConfig.preferences.javaScriptEnabled = YES;
        // 不通过用户交互，是否可以打开窗口
        //        _webConfig.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    }
    return _webConfig;
}

#pragma mark - WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"BSClose"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (UIProgressView *)progressView
{
    if (!_progressView)
    {
        _progressView = [UIProgressView new];
        _progressView.tintColor = Bsky_UIColorFromRGBA(0x000000,1);
        _progressView.trackTintColor = Bsky_UIColorFromRGBA(0x000000,1);
        _progressView.progressTintColor = Bsky_UIColorFromRGBA(0xff0000,1);
        
        self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
        
        [self.view addSubview:_progressView];
    }
    return _progressView;
}

- (void)setBa_web_progressTintColor:(UIColor *)ba_web_progressTintColor
{
    _ba_web_progressTintColor = ba_web_progressTintColor;
    
    self.progressView.progressTintColor = ba_web_progressTintColor;
}

- (void)setBa_web_progressTrackTintColor:(UIColor *)ba_web_progressTrackTintColor
{
    _ba_web_progressTrackTintColor = ba_web_progressTrackTintColor;
    
    self.progressView.trackTintColor = ba_web_progressTrackTintColor;
}

- (void)dealloc
{
    [self.webView removeFromSuperview];
    [self.progressView removeFromSuperview];
    self.webView = nil;
    self.webConfig = nil;
    self.progressView = nil;
    self.ba_web_currentUrl = nil;
}

- (BOOL)willDealloc
{
    return NO;
}

@end
