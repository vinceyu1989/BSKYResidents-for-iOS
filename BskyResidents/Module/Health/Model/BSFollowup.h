//
//  BSFollowup.h
//  BskyResidents
//
//  Created by LinfengYU on 2017/11/3.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <Foundation/Foundation.h>

//doctorName = "\U674e\U6d77\U9633";
//followUpDate = "3939-01-01";
//followUpType = 2;
//id = 31C79495120948B8A83653500D431A39;
//regionCode = 510411106;

@interface BSFollowup : NSObject

@property (nonatomic, copy) NSString* doctorName;
@property (nonatomic, copy) NSString* followUpDate;
@property (nonatomic, copy) NSString* followUpType;
@property (nonatomic, copy) NSString* id;
@property (nonatomic, copy) NSString* regionCode;

@end
