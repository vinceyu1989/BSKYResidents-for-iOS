//
//  BSChangeUserHead.h
//  BskyResidents
//
//  Created by 罗林轩 on 2017/11/1.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <BSKYCore/BSKYCore.h>

@interface BSChangeUserHead : BSBaseRequest
@property (copy, nonatomic) NSString *phone;
@property (copy, nonatomic) NSString *userId;
- (id)initWithImage:(UIImage *)image;

@end
