//
//  GFAddressPicker.m
//  地址选择器
//
//  Created by 1暖通商城 on 2017/5/10.
//  Copyright © 2017年 1暖通商城. All rights reserved.
//

#import "GFAddressPicker.h"
#import "BSDivision.h"

@interface GFAddressPicker ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic ,strong) UIView *contentView;

@property (nonatomic ,copy) NSArray *dataArray;


@property (strong, nonatomic) UIPickerView *pickView;

/** 省 */
@property (nonatomic, strong) BSDivision *province;
/** 市 */
@property (nonatomic, strong) BSDivision *city;
/** 区 */
@property (nonatomic, strong) BSDivision *area;

@end

@implementation GFAddressPicker


static CGFloat const kGFAddressPickerContentViewHeight = 258;    // contentView 高度

static CGFloat const kGFAddressPickerViewHeight = 45;    // Btn 宽度

static CGFloat const kGFAddressPickerViewDuration = 0.3;    // 动画时间


- (instancetype)initWithDataArray:(NSArray *)dataArray
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, Bsky_SCREEN_WIDTH, Bsky_SCREEN_HEIGHT);
        self.backgroundColor = Bsky_COLOR_RGBA(0, 0, 0, 0);
        self.dataArray = dataArray;
        self.province = dataArray[0];
        self.city = self.province.children[0];
        self.area = self.city.children[0];
        [self setBaseView];
    }
    return self;
}
- (void)dealloc
{
    NSLog(@"%@---- 释放了",NSStringFromClass([self class]));
}

- (void)setBaseView {
    self.contentView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height, self.width, kGFAddressPickerContentViewHeight)];
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.contentView];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, kGFAddressPickerViewHeight)];
    headerView.backgroundColor = Bsky_COLOR_RGB(240, 240, 240);
    [self.contentView addSubview:headerView];
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setTitle:@"取消" forState:0];
    [cancleBtn setTitleColor:Bsky_UIColorFromRGBA(0x4e7dd3,1) forState:UIControlStateNormal];
    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    cancleBtn.frame = CGRectMake(0, 0, 60, kGFAddressPickerViewHeight);
    [cancleBtn addTarget:self action:@selector(dateCancleAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:cancleBtn];
    
    UIButton *ensureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [ensureBtn setTitle:@"确定" forState:0];
    [ensureBtn setTitleColor:Bsky_UIColorFromRGBA(0x4e7dd3,1) forState:UIControlStateNormal];
    ensureBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    ensureBtn.frame = CGRectMake(self.contentView.width - 60, 0, 60, kGFAddressPickerViewHeight);
    [ensureBtn addTarget:self action:@selector(dateEnsureAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:ensureBtn];
    
//    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, ensureBtn.bottom, self.contentView.width, 0.5)];
//    line.backgroundColor = Bsky_UIColorFromRGB(0xededed);
//    [self.contentView addSubview:line];
    
    self.pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, headerView.bottom, self.contentView.width, self.contentView.height - headerView.height)];
    self.pickView.delegate   = self;
    self.pickView.dataSource = self;
    self.pickView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.pickView];
    [self.pickView reloadAllComponents];
    [self.pickView selectRow:0 inComponent:0 animated:NO];
    
}
- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:kGFAddressPickerViewDuration
                     animations:^{
                         self.backgroundColor = Bsky_COLOR_RGBA(0, 0, 0, 0.5);
                         self.contentView.top = self.height-self.contentView.height;
                     }
                     completion:nil];
}
- (void)hide
{
    [UIView animateWithDuration:kGFAddressPickerViewDuration animations:^{
        self.backgroundColor = Bsky_COLOR_RGBA(0, 0, 0, 0);
        self.contentView.top = self.height;
    } completion:^(BOOL finished) {
        if (self.selected) {
            self.selected = nil;
        }
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
        
        [self removeFromSuperview];
    }];
}

- (void)updateArea:(BSDivision *)area
{
    if (area.divisionFullName) {
        for (NSInteger i = 0; i < self.dataArray.count; i++) {
            BSDivision *model = self.dataArray[i];
            if ([area.divisionFullName containsString:model.divisionName]) {
                self.province = model;
                [self.pickView reloadComponent:0];
                [self.pickView selectRow:i inComponent:0 animated:NO];
                break;
            }
        }
        for (NSInteger i = 0; i < self.province.children.count; i++) {
            BSDivision *model = self.province.children[i];
            if ([area.divisionFullName containsString:model.divisionName]) {
                self.city = model;
                [self.pickView reloadComponent:1];
                [self.pickView selectRow:i inComponent:1 animated:NO];
                break;
            }
        }
        for (NSInteger i = 0; i < self.city.children.count; i++) {
            BSDivision *model = self.city.children[i];
            if ([area.divisionFullName containsString:model.divisionName]) {
                self.area = model;
                [self.pickView reloadComponent:2];
                [self.pickView selectRow:i inComponent:2 animated:NO];
                break;
            }
        }
    }
}
#pragma mark --- click
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch  locationInView:self.contentView];
    BOOL isLocation = CGRectContainsPoint(self.contentView.bounds, point);
    
    if (isLocation) {
        
        [self.nextResponder touchesBegan:touches withEvent:event];
    }
    else
    {
        [self hide];
    }
}

- (void)dateCancleAction {
    [self hide];
}

- (void)dateEnsureAction {
    if (self.selected) {
        WS(weakSelf);
        self.selected(weakSelf.province,weakSelf.city,weakSelf.area);
    }
    [self hide];
}

#pragma mark ---  UIPickerViewDelegate,UIPickerViewDataSource

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:self.font?:[UIFont systemFontOfSize:18]];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == 0) {
        
        return self.dataArray.count;
        
    } else if (component == 1) {
        
        return self.province.children.count;
        
    } else {
        return self.city.children.count;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component __TVOS_PROHIBITED{
    return 60;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (component == 0) {
        BSDivision *model = self.dataArray[row];
        return model.divisionName;
    } else if (component == 1) {
        BSDivision *model = self.province.children[row];
        return model.divisionName;
    } else {
        BSDivision *model = self.city.children[row];
        return model.divisionName;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.frame.size.width / 3;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        self.province = self.dataArray[row];
        self.city = self.province.children[0];
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
    if (component == 1) {
        self.city = self.province.children[row];
        self.area = self.city.children[0];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        
    }
    if (component == 2) {
        self.area = self.city.children[row];
    }
}



@end
