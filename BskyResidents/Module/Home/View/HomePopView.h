//
//  HomePopView.h
//  BskyResidents
//
//  Created by 何雷 on 2017/10/11.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePopView : UIView

+ (void)sharedInstanceoOriginFrame:(CGRect)originFrame
                           toFrame:(CGRect)finishFrame
                        completion:(void(^)(NSInteger index))completion;

@end
