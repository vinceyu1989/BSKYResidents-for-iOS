//
//  BSSigningLabelView.h
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/10.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSSigningLabelView;

@protocol BSSigningLabelViewDataSource <NSObject>

@required
- (NSString*)titleForView:(BSSigningLabelView*)view;

- (NSInteger)numberOfLabelsInView:(BSSigningLabelView*)view;

- (NSString*)signingLabelView:(BSSigningLabelView*)view labelTitleForIndex:(NSInteger)index;

@end

@protocol BSSigningLabelViewDelegate <NSObject>

@optional
- (void)signingLabelView:(BSSigningLabelView*)view didChangeSelectedList:(NSArray*)selectedList;

@end

@interface BSSigningLabelView : UIView

@property (nonatomic, weak) id<BSSigningLabelViewDataSource> dataSource;
@property (nonatomic, weak) id<BSSigningLabelViewDelegate> delegate;

- (void)reloadData;

@end
