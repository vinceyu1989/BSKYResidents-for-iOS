//
//  BSSigningServiceHeaderView.h
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/12.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSSigningServiceHeaderView : UIView

@property (nonatomic, copy) void (^touchBlock)();

- (void)bindData:(SignInfoModel*)data;

@end
