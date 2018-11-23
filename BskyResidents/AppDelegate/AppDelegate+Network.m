//
//  AppDelegate+Network.m
//  BskyResidents
//
//  Created by 何雷 on 2017/7/20.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "AppDelegate+Network.h"
#import "BAKit_WebView.h"
#import "BskyBaseNetConfig.h"

@implementation AppDelegate (Network)

- (void)setupNetworkWithType:(AppType)type {
//    [self deleteWebCache];//删除cookie
    switch (type) {
        case AppType_Dev:
            [BskyBaseNetConfig sharedInstance].type = SeverType_Dev;
            break;
        case AppType_Test:
            [BskyBaseNetConfig sharedInstance].type = SeverType_Test;
            break;
        case AppType_Release:
            [BskyBaseNetConfig sharedInstance].type = SeverType_Release;
            break;
        default:
            break;
    }
}

- (void)deleteWebCache {
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        
        NSSet *websiteDataTypes
        = [NSSet setWithArray:@[
                                
                                WKWebsiteDataTypeDiskCache,
                                
                                //WKWebsiteDataTypeOfflineWebApplicationCache,
                                
                                WKWebsiteDataTypeMemoryCache,
                                
                                //WKWebsiteDataTypeLocalStorage,
                                
                                //WKWebsiteDataTypeCookies,
                                
                                //WKWebsiteDataTypeSessionStorage,
                                
                                //WKWebsiteDataTypeIndexedDBDatabases,
                                
                                //WKWebsiteDataTypeWebSQLDatabases
                                
                                ]];
        
        //// All kinds of data
        
        //NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        
        //// Date from
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        //// Execute
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
            // Done
        }];
    } else {
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
        NSError *errors;
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
        }
}
@end
