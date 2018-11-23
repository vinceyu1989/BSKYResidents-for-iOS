//
//  BSNews.h
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/24.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <Foundation/Foundation.h>

//{
//    newsContent = "\U505a\U996d\U53d1\U751f\U5927\U5e45\U5ea6\U5730\U65b9";
//    newsTitleType = 01009001;
//    noticeId = 1;
//    publishDate = "2017-10-26 16:39:39";
//}

@interface BSNews : NSObject

@property (nonatomic, copy) NSString* newsContent;
@property (nonatomic, copy) NSString* newsTitleType;
@property (nonatomic, copy) NSString* publishDate;
@property (nonatomic, copy) NSString* noticeId;

@end
