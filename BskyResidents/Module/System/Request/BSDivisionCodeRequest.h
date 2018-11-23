//
//  BSDivisionCodeRequest.h
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/23.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSDivisionCodeRequest : BSBaseRequest

@property (nonatomic, copy) NSString* divisionCode;
@property (nonatomic, strong) NSArray* divisionList;    // {[BSDivision class], [BSDivision class]}

@end
