//
//  AppDelegate+BSKYCheckAppVersion.m
//  BskyResidents
//
//  Created by 罗林轩 on 2017/12/12.
//  Copyright © 2017年 罗林轩. All rights reserved.
//

#import "AppDelegate+BSKYCheckAppVersion.h"
#import "BSAppVersionRequest.h"
#import "BSKYUpdateViewController.h"
#import "BSAuthPublicKeyRequest.h"
#import "BSNeedEncryption.h"
#import <SAMKeychain.h>

@implementation AppDelegate (BSKYCheckAppVersion)
- (void)chekAppVersionWithSuccesBlock:(void (^)(BOOL))succesBlock failBlock:(void (^)(void))failBlock{
#pragma mark --- 检查版本
    BSKYUpdateViewController *updateViewController = [[BSKYUpdateViewController alloc] init];
    self.window.rootViewController = updateViewController;
    [self.window makeKeyAndVisible];
    
    BSNeedEncryption *needRq = [[BSNeedEncryption alloc] init];
    Bsky_WeakSelf;
    [needRq startWithCompletionBlockWithSuccess:^(__kindof BSNeedEncryption * _Nonnull request) {
        Bsky_StrongSelf;
        [self publicKeyAndCheckVersionActionSuccesBlock:succesBlock failBlock:failBlock];
    } failure:^(__kindof BSNeedEncryption * _Nonnull request) {
        Bsky_StrongSelf;
        [self publicKeyAndCheckVersionActionSuccesBlock:succesBlock failBlock:failBlock];
    }];
    
    
    
}
- (void)publicKeyAndCheckVersionActionSuccesBlock:(void (^)(BOOL))succesBlock failBlock:(void (^)(void))failBlock{
    BSAuthPublicKeyRequest *q = [[BSAuthPublicKeyRequest alloc] init];
    [q startWithCompletionBlockWithSuccess:^(__kindof BSAuthPublicKeyRequest * _Nonnull q) {
        BSAppVersionRequest* request = [BSAppVersionRequest new];
        
        [request startWithCompletionBlockWithSuccess:^(__kindof BSAppVersionRequest * _Nonnull request) {
            NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
            NSInteger mandatoryUpdate = [request.ret[@"mandatoryUpdate"] integerValue];
            NSString *currentAppVersion = infoDic[@"CFBundleShortVersionString"];
            NSMutableString* versionNum = request.ret[@"versionNum"];
            if (mandatoryUpdate == 9) {
                succesBlock(NO);//不需要更新
                return;
            }
            if (mandatoryUpdate != 9 && [NSString compareVersion:versionNum to:currentAppVersion] == 1) {
                NSString* versionDesc = request.ret[@"versionDesc"];
                BSKYUpdateViewController *updateViewController = (BSKYUpdateViewController *)self.window.rootViewController;
                updateViewController.info = versionDesc;
                updateViewController.mandatoryUpdate = mandatoryUpdate;
                updateViewController.downloadUrl = request.ret[@"downloadUrl"];
                [updateViewController showUpdateView];
                //需要更新
                succesBlock(YES);
            }else{
                //不需要更新
                if(![self checkPublicKeyAndCBCKey:succesBlock failBlock:failBlock])return;
                succesBlock(NO);
            }
        } failure:^(__kindof BSAppVersionRequest * _Nonnull request) {
            if(![self checkPublicKeyAndCBCKey:succesBlock failBlock:failBlock])return;
            failBlock();//请求失败,按正常流程执行
        }];
    } failure:^(__kindof BSAuthPublicKeyRequest * _Nonnull q) {
        if(![self checkPublicKeyAndCBCKey:succesBlock failBlock:failBlock])return;
        failBlock();
    }];
}
- (BOOL )checkPublicKeyAndCBCKey:(void (^)(BOOL))succesBlock failBlock:(void (^)(void))failBlock{
    if (![BSAppManager sharedInstance].publicKey.length || ![BSAppManager sharedInstance].cbcKey.length || ![BSAppManager sharedInstance].needEncryption.length) {
        UIAlertController *alter = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
        alter.title = @"错误！";
        alter.message = @"系统初始化失败，请检查网络并重试或者联系客服！";
        Bsky_WeakSelf;
        UIAlertAction *resetAction = [UIAlertAction actionWithTitle:@"重试" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            Bsky_StrongSelf;
//            [self configCBCBSNeedEncryption];
            [self chekAppVersionWithSuccesBlock:succesBlock failBlock:failBlock];
        }];
        [alter addAction:resetAction];
        [self.window.rootViewController presentViewController:alter animated:YES completion:nil];
        return NO;
    }
    return YES;
}
@end
