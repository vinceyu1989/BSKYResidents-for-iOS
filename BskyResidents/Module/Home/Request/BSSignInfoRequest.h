//
//  BSSignInfoRequest.h
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/24.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SignInfoModel.h"

@interface BSSignInfoRequest : BSBaseRequest

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic ,strong) SignInfoModel *model;

@end
