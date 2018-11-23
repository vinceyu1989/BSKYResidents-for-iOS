//
//  BSCmsLoginRequest.m
//  
//
//  Created by LinfengYU on 2017/10/18.
//

#import "BSCmsLoginRequest.h"
#import "BSRealnameInfoRequest.h"
#import "IMAccTokenRequest.h"
#import "RSA.h"

@implementation BSCmsLoginRequest

- (NSString*)bs_requestUrl {
//    NSString *phoneKey = (NSString *) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)[self.phone encryptCBCStr],NULL,(CFStringRef)@"!*'();:@&=+ $,/?%#[]",kCFStringEncodingUTF8));
//    NSString *cmsCodeKey = (NSString *) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)[self.cmsCode encryptCBCStr],NULL,(CFStringRef)@"!*'();:@&=+ $,/?%#[]",kCFStringEncodingUTF8));
//    NSString *randomCekKey = (NSString *) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)[RSA encryptString:[BSAppManager sharedInstance].cbcKey publicKey:[BSAppManager sharedInstance].publicKey],NULL,(CFStringRef)@"!*'();:@&=+ $,/?%#[]",kCFStringEncodingUTF8));
//    return [NSString stringWithFormat:@"/resident/v1/residentCmsLogin?phone=%@&cmsCode=%@&randomCek=%@", phoneKey,cmsCodeKey,randomCekKey];
    return @"/resident/v1/residentCmsLogin";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
- (NSDictionary*)requestHeaderFieldValueDictionary {
    return @{@"Content-Type": @"application/x-www-form-urlencoded",
             @"headMode": [[BSClientManager sharedInstance] headMode],
             @"token": [BSClientManager sharedInstance].tokenId};
}
- (YTKRequestSerializerType )requestSerializerType{
    return YTKRequestSerializerTypeHTTP;
}
- (id)requestArgument {
    return @{
             @"phone":[self.phone encryptCBCStr],
             @"cmsCode":[self.cmsCode encryptCBCStr],
             @"randomCek":[NSString enctryptCBCKeyWithRSA],
             };
}

- (void)requestCompleteFilter {
    [super requestCompleteFilter];
    if (self.code != 200) {
        return;
    }
    [BSClientManager sharedInstance].userId = [self.ret[@"userId"] decryptCBCStr];
    [BSClientManager sharedInstance].loginMark = self.ret[@"loginMark"];
    [BSClientManager sharedInstance].regCode = [self.ret[@"regCode"] decryptCBCStr];
    [BSClientManager sharedInstance].tokenId = self.ret[@"token"];
    [BSClientManager sharedInstance].lastUsername = self.phone;
    
    [BSAppManager sharedInstance].currentUser = [BSUser mj_objectWithKeyValues:self.ret];
    [[BSAppManager sharedInstance].currentUser decryptCBCModel];
    BSUser *user = [BSAppManager sharedInstance].currentUser;
    // 获取实名认证信息
//    if ([BSAppManager sharedInstance].currentUser.verifStatus.integerValue == RealInfoVerifStatusTypeSuccess) {
//        
//        BSRealnameInfoRequest* request = [[BSRealnameInfoRequest alloc]init];
//        [request startWithCompletionBlockWithSuccess:^(__kindof BSRealnameInfoRequest * _Nonnull request) {
//            
//        } failure:^(__kindof BSRealnameInfoRequest * _Nonnull request) {
//            [UIView makeToast:request.msg];
//        }];
//        
//    }
        // 登录网易云信
        NSString* account = [BSClientManager sharedInstance].lastUsername;
        NSString* token = [BSAppManager sharedInstance].currentUser.accToken;
        [[[NIMSDK sharedSDK] loginManager] login:account token:token completion:^(NSError * _Nullable error) {
            if (error) {
                NSLog(@"%@", error);
                if (error.code == 302) {   // 用户在app端登录IM失败时如果返回码是302(token错误)
                    [[[IMAccTokenRequest alloc]init] startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                    }];
                }
            }else {
                NSLog(@"登录成功");
            }
        }];
        
        // 处理SDWebImage HttpHeader
        SDWebImageDownloader *sdmanager = [SDWebImageManager sharedManager].imageDownloader;
        [sdmanager setValue:[BSClientManager sharedInstance].tokenId forHTTPHeaderField:@"token"];
        
        [self postNotification:LoginSuccessNotification];
//    } failure:^(BSAuthLicenseRequest* q) {
//        [UIView makeToast:q.msg];
//    }];
    
}

- (void)requestFailedFilter {
    [super requestFailedFilter];    
}

@end
