//
//  BSSigningServiceView.h
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/12.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSSigningServiceView;

@protocol BSSigningServiceViewDataSource <NSObject>

@required
- (NSInteger)numberOfServiceInSigningServiceView:(BSSigningServiceView*)signingServiceView;
- (SignService*)serviceAtIndex:(NSInteger)index;
- (SignInfoModel*)signInfoData;

@end

@protocol BSSigningServiceViewDelegate <NSObject>

@optional
- (void)didTouchContractInSigningServiceView:(BSSigningServiceView*)signingServiceView;

@end

@interface BSSigningServiceView : UIView

@property (nonatomic, weak) id<BSSigningServiceViewDataSource> dataSource;
@property (nonatomic, weak) id<BSSigningServiceViewDelegate> delegate;

- (void)reloadData;

@end
