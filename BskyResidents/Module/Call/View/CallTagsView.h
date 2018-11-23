//
//  CallTagsView.h
//  BskyResidents
//
//  Created by 何雷 on 2017/10/26.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CallTagsView : UIView

@property (nonatomic ,copy) void (^selectedIndex)(NSInteger index);

- (instancetype)initWithTags:(NSArray *)tags title:(NSString *)title;

- (void)show;

@end
