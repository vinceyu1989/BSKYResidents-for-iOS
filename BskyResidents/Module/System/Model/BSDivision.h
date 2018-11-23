//
//  BSDivision.h
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/23.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <Foundation/Foundation.h>

//{"divisionName":"自贡市","divisionId":"51030200000000000000000000000048","divisionFullName":"四川省 >自贡市","children":[{"divisionName":"自流井区","divisionId":"51030200000000000000000000001448","divisionFullName":"四川省 >自贡市 > 自流井区","divisionCode":"510302"}],"divisionCode":"5103"}

@interface BSDivision : NSObject

@property (nonatomic, copy) NSString* divisionName;
@property (nonatomic, copy) NSString* divisionId;
@property (nonatomic, copy) NSString* divisionCode;
@property (nonatomic, copy) NSString* divisionFullName;
@property (nonatomic, copy) NSArray* children;

@end
