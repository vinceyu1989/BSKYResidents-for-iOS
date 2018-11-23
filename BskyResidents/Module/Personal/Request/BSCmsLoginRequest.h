//
//  BSCmsLoginRequest.h
//  
//
//  Created by LinfengYU on 2017/10/18.
//

#import <Foundation/Foundation.h>

@interface BSCmsLoginRequest : BSBaseRequest

@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *cmsCode;

@end
