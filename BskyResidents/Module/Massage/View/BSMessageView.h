//
//  BSMessageView.h
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/17.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSMessageView;

@protocol BSMessageViewDataSource <NSObject>

@required
- (NSInteger)numberOfMessageCategoryInMessageView:(BSMessageView*)messageView;
- (id)categoryForIndex:(NSInteger)index;

@end

@protocol BSMessageViewDelegate <NSObject>

@required
- (void)didSelectSystemMailInMessageView:(BSMessageView*)messageView index:(NSInteger)index;

@end

@interface BSMessageView : UIView

@property (nonatomic, weak) id<BSMessageViewDataSource> dataSource;
@property (nonatomic, weak) id<BSMessageViewDelegate> delegate;

- (void)reloadData;

@end
