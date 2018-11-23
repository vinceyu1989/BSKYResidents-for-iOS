//
//  BSNewsTotalRequest.h
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/24.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSNewsTotalRequest : BSBaseRequest

@property (nonatomic, copy) NSString* userId;

@property (nonatomic, strong) NSArray* messageCategoryList;

@end
