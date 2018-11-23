//
//  BSChangeUserHead.m
//  BskyResidents
//
//  Created by 罗林轩 on 2017/11/1.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSChangeUserHead.h"

@interface BSChangeUserHead()
@property (strong, nonatomic) UIImage *image;
@end

@implementation BSChangeUserHead
- (id)initWithImage:(UIImage *)image {
    self = [super init];
    if (self) {
        _image = image;
    }
    return self;
}

- (YTKRequestSerializerType)requestSerializerType{
    return YTKRequestSerializerTypeJSON;
}

- (YTKResponseSerializerType)responseSerializerType{
    return YTKResponseSerializerTypeJSON;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

//- (id)requestArgument{
//    return @{
//             @"phone" : self.phone,
//             @"userId" : self.userId
//             };
//}

- (NSString *)bs_requestUrl{
    NSString *urlStr = [NSString stringWithFormat:@"/resident/info/photo?phone=%@",[[self.phone encryptCBCStr] urlencode]];
    return urlStr;
}

- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        NSData *data = UIImageJPEGRepresentation(_image, 0.9);
        NSString *name = @"photoUrl.jpeg";
        NSString *formKey = @"photoUrl";
        NSString *type = @"image/jpeg";
        [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
    };
}

@end;
