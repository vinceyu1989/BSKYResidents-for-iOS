//
//  BSInfoPhotoRequest.m
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/25.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSInfoPhotoRequest.h"

@interface BSInfoPhotoRequest ()

@property (nonatomic, strong) NSData* avatarData;

@end

@implementation BSInfoPhotoRequest

- (NSString*)bs_requestUrl {
    return [NSString stringWithFormat:@"/resident/info/photo?userId=%@&phone=%@", [self.userId encryptCBCStr], [self.phone encryptCBCStr]];
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (void)setAvatar:(UIImage *)avatar {
    _avatar = avatar;
    _avatarData = UIImageJPEGRepresentation(avatar, 0.7);
}

- (id)requestArgument {
    WS(weakSelf);
    [self setConstructingBodyBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data = weakSelf.avatarData;
        NSString *name = @"photoUrl";
        NSString *formKey = @"photoUrl";
        NSString *type = @"image/jpeg";
        
        [formData appendPartWithFileData:data
                                    name:formKey
                                fileName:name
                                mimeType:type];
    }];
    
    return @{};
}

- (void)requestCompleteFilter {
    [super requestCompleteFilter];
}

- (void)requestFailedFilter {
    [super requestFailedFilter];
    
}

@end
