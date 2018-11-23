//
//  BSNewsListRequest.h
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/24.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <Foundation/Foundation.h>

//01007001服务消息、01007002用药提醒、01007003预警值提醒

@interface BSNewsListRequest : BSBaseRequest

@property (nonatomic, copy) NSString* userId;
@property (nonatomic, copy) NSString* type;
@property (nonatomic, copy) NSString* pageSize;
@property (nonatomic, copy) NSString* pageNo;

@property (nonatomic, strong) NSArray* newsList;

@end
