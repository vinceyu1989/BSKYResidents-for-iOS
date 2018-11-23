//
//  BSCategoryMessageView.h
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/17.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSCategoryMessageView;

@protocol BSCategoryMessageViewDataSource <NSObject>

@required

- (NSInteger)numberOfNewsInView:(BSCategoryMessageView*)view;

- (BSNews*)newsForIndex:(NSInteger)index;

@end

@protocol BSCategoryMessageViewDelegate <NSObject>

@end

@interface BSCategoryMessageView : UIView

@property (nonatomic, weak) id<BSCategoryMessageViewDataSource> dataSource;
@property (nonatomic, weak) id<BSCategoryMessageViewDelegate> delegate;

- (void)reloadData;

@end
