//
//  BSSignServiceInfoRequest.h
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/25.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSSignServiceInfoRequest : BSBaseRequest

@property (nonatomic, copy) NSString* servicePackId;
@property (nonatomic, copy) NSString* regionCode;

@property (nonatomic, strong) NSArray* servicePackList;

@end
