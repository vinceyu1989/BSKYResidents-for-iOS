//
//  DetailInformationPickerView.h
//  BskyResidents
//
//  Created by 罗林轩 on 2017/10/23.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  NS_ENUM(NSInteger,PickerViewState){
    PickerViewStateHeight ,//身高
    PickerViewStateWeight,//体重
    PickerViewStateCity,//省市区
};
typedef void(^SelectedHandle)(NSArray *data);

@interface DetailInformationPickerView : UIView
+ (DetailInformationPickerView *)showWithState:(PickerViewState )pickerViewState;
@property(nonatomic, copy) SelectedHandle selectedBlock;
@end
