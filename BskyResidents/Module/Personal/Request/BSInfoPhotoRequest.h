//
//  BSInfoPhotoRequest.h
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/25.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface BSInfoPhotoRequest : BSBaseRequest

@property (nonatomic, copy) NSString* userId;       // 用户ID
@property (nonatomic, copy) NSString* phone;        // 手机号，修改头像时必填
@property (nonatomic, strong) UIImage* avatar;      // 头像

@end
