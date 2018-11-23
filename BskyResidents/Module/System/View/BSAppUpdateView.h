//
//  BSAppUpdateView.h
//  BSKYDoctorPro
//
//  Created by LinfengYU on 2017/9/22.
//  Copyright © 2017年 ky. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BSAppUpadteViewDelegate<NSObject>
- (void)cancelUpdate;//取消更新
@end

@interface BSAppUpdateView : UIView

@property (nonatomic, copy) NSString* info;
@property (nonatomic, assign) BOOL mandatoryUpdate;
@property (weak, nonatomic) id<BSAppUpadteViewDelegate> delegate;

+ (BSAppUpdateView*)showInView:(UIView*)view animated:(BOOL)animated info:(NSString*)info mandatoryUpdate:(BOOL)mandatoryUpdate downloadUrl:(NSString *)downloadUrl delegate:(id<BSAppUpadteViewDelegate>)delegate;

- (void)hide;
@end
