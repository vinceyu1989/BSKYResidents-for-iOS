//
//  DetailInformationPickerView.m
//  BskyResidents
//
//  Created by 罗林轩 on 2017/10/23.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "DetailInformationPickerView.h"
@interface DetailInformationPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (strong, nonatomic) UIView *backView;//背景图
@property (strong, nonatomic) UIView *pickerBackView;
@property(nonatomic, strong) UIButton *cancleBtn;//取消按钮
@property(nonatomic, strong) UIButton *sureBtn;//确定按钮
@property(nonatomic, strong) UIPickerView *pickerView;
@property (assign, nonatomic) PickerViewState pickerViewState;;
@property (assign, nonatomic) NSInteger numberOfComponents;//列数
/**省*/
@property(nonatomic, strong) NSArray * provinceArray;
/** 市*/
@property(nonatomic, strong) NSArray * cityArray;
/**区*/
@property(nonatomic, strong) NSArray * areaArray;
/**所有数据*/
@property(nonatomic, strong) NSArray * dataSource;
/** 记录省选中的位置*/
@property(nonatomic, assign) NSInteger selected;
/**选中的省*/
@property(nonatomic, copy) NSString * provinceStr;
/**选中的市*/
@property(nonatomic, copy) NSString * cityStr;
/**选中的区*/
@property(nonatomic, copy) NSString * areaStr;
/**身高*/
@property (strong, nonatomic) NSMutableArray *heightsArray;
/**体重*/
@property (strong, nonatomic) NSMutableArray *weightsArray;
/**选中的体重*/
@property (copy, nonatomic) NSString *weight;
/**选中的身高*/
@property (copy, nonatomic) NSString *height;
@end

static CGFloat const pickerHeight = 216;
static CGFloat const toolBarHeight = 46;

@implementation DetailInformationPickerView
+(DetailInformationPickerView *)showWithState:(PickerViewState)pickerViewState{
    DetailInformationPickerView *view = [[DetailInformationPickerView alloc] initWithFrame:CGRectMake(0, 0, Bsky_SCREEN_WIDTH, Bsky_SCREEN_HEIGHT - Bsky_TOP_BAR_HEIGHT)];
    view.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0];
    view.pickerViewState = pickerViewState;
    [view setupPickerVIew];
    [view setupBackView];
    [view loadData];
    [view show];
    return view;
}

- (void)setupPickerVIew{
    [self addSubview:self.pickerBackView];
    [_pickerBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottom).offset(pickerHeight + toolBarHeight);
        make.height.mas_equalTo(pickerHeight + toolBarHeight);
    }];
    
    [_pickerBackView addSubview:self.pickerView];
    [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(toolBarHeight);
        make.height.mas_equalTo(pickerHeight);
    }];
    
    [_pickerBackView addSubview:self.cancleBtn];
    [_cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(5);
        make.height.mas_equalTo(toolBarHeight - 10);
        make.width.mas_equalTo(50);
    }];
    
    [_pickerBackView addSubview:self.sureBtn];
    [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(5);
        make.height.mas_equalTo(toolBarHeight - 10);
        make.width.mas_equalTo(50);
    }];
}

- (void)setupBackView{
    [self addSubview:self.backView];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(_pickerBackView.mas_top);
    }];
}

- (void)loadData{
    if (_pickerViewState == PickerViewStateCity) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
        self.dataSource = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray * tempArray = [NSMutableArray array];
        for (NSDictionary * tempDic in self.dataSource) {
            for (int i = 0; i < tempDic.allKeys.count; i ++) {
                [tempArray addObject:tempDic.allKeys[i]];
            }
        }
        //省
        self.provinceArray = [tempArray copy];
        //市
        self.cityArray = [self getCityNamesFromProvince:0];
        //区
        self.areaArray = [self getAreaNamesFromCity:0];
        
        self.provinceStr = self.provinceArray[0];
        self.cityStr = self.cityArray[0];
        self.areaStr = self.areaArray[0];
    }else if (_pickerViewState == PickerViewStateHeight){
        for (int i  = 0; i < 100; i ++) {
            NSString *hegith = [NSString stringWithFormat:@"%d cm",i + 100];
            [self.heightsArray addObject:hegith];
        }
        self.height  = @"100 cm";
    }else{
        for (int i  = 0; i < 100; i ++) {
            NSString *weight = [NSString stringWithFormat:@"%d kg",i + 30];
            [self.weightsArray addObject:weight];
        }
        self.weight  = @"30kg";
    }
}

- (void)show{
    __weak UIView * weak_backView = self.backView;
    __weak UIView *weak_pickerBackView = self.pickerBackView;
    [self layoutIfNeeded];
    [self setNeedsLayout];
    [UIView animateWithDuration:0.4 animations:^{
        weak_backView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.3];
        [weak_pickerBackView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom).offset(0);
        }];
        [self layoutIfNeeded];
    }];
}

- (void)hidden{
    __weak UIView * weak_backView = self.backView;
    __weak UIView *weak_pickerBackView = self.pickerBackView;
    __weak DetailInformationPickerView *weak_self = self;
    [self layoutIfNeeded];
    [self setNeedsLayout];
    [UIView animateWithDuration:0.4 animations:^{
        weak_backView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0];
        [weak_pickerBackView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom).offset(pickerHeight + toolBarHeight);
        }];
        [self layoutIfNeeded];
    }completion:^(BOOL finished) {
        [weak_self removeFromSuperview];
    }];
}

- (void)sureBtnClick{
    [self hidden];
    if (self.selectedBlock != nil) {
        switch (_pickerViewState) {
            case PickerViewStateCity:
                self.selectedBlock(@[self.provinceStr,self.cityStr,self.areaStr]);
                break;
            case PickerViewStateHeight:
                self.selectedBlock(@[self.height]);
                break;
            case PickerViewStateWeight:
                self.selectedBlock(@[self.weight]);
                break;
            default:
                
                break;
        }
    }
}

#pragma mark - set
- (void)setPickerViewState:(PickerViewState)pickerViewState{
    _pickerViewState = pickerViewState;
    if (_pickerViewState == PickerViewStateCity) {
        _numberOfComponents = 3;
    }else{
        _numberOfComponents = 1;
    }
}

#pragma mark - get
- (NSMutableArray *)heightsArray{
    if (!_heightsArray) {
        _heightsArray = [NSMutableArray array];
    }
    return _heightsArray;
}

- (NSMutableArray *)weightsArray{
    if (!_weightsArray) {
        _weightsArray = [NSMutableArray array];
    }
    return _weightsArray;
}

- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0];
        UIGestureRecognizer *hiddenTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidden)];
        [_backView addGestureRecognizer:hiddenTap];
        _backView.userInteractionEnabled = YES;
    }
    return _backView;
}

- (UIView *)pickerBackView{
    if (!_pickerBackView) {
        _pickerBackView = [[UIView alloc] init];
        _pickerBackView.backgroundColor = Bsky_COLOR_RGB(240, 240, 240);
    }
    return _pickerBackView;
}

- (UIButton *)cancleBtn{
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_cancleBtn setTitleColor:Bsky_UIColorFromRGBA(0x4e7dd3,1) forState:UIControlStateNormal];
//        _cancleBtn.layer.borderColor = [UIColor whiteColor].CGColor;
//        _cancleBtn.layer.borderWidth = 0.5;
//        _cancleBtn.layer.cornerRadius = 5;
        _cancleBtn.backgroundColor = [UIColor clearColor];
        [_cancleBtn addTarget:self action:@selector(hidden) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}

- (UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_sureBtn setTitleColor:Bsky_UIColorFromRGBA(0x4e7dd3,1) forState:UIControlStateNormal];
//        _sureBtn.layer.borderColor = [UIColor whiteColor].CGColor;
//        _sureBtn.layer.borderWidth = 0.5;
//        _sureBtn.layer.cornerRadius = 5;
        _sureBtn.backgroundColor = [UIColor clearColor];
        [_sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

- (UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.backgroundColor =  [UIColor whiteColor];
    }
    return _pickerView;
}

#pragma mark - UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40.0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width / _numberOfComponents, 30)];
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;
    if (_pickerViewState == PickerViewStateCity) {
        if (component == 0) {
            label.text = self.provinceArray[row];
        }else if (component == 1){
            label.text = self.cityArray[row];
        }else if (component == 2){
            label.text = self.areaArray[row];
        }
    }else if (_pickerViewState == PickerViewStateHeight){
        label.text = self.heightsArray[row];
    }else{
        label.text =self.weightsArray[row];
    }
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (_pickerViewState == PickerViewStateCity) {
        if (component == 0) {//选择省
            self.selected = row;
            self.cityArray = [self getCityNamesFromProvince:row];
            self.areaArray = [self getAreaNamesFromCity:0];
            
            [self.pickerView reloadComponent:1];
            [self.pickerView selectRow:0 inComponent:1 animated:YES];
            [self.pickerView reloadComponent:2];
            [self.pickerView selectRow:0 inComponent:2 animated:YES];
            
            self.provinceStr = self.provinceArray[row];
            self.cityStr = self.cityArray[0];
            self.areaStr = self.areaArray[0];
            
        }else if (component == 1){//选择市
            self.areaArray = [self getAreaNamesFromCity:row];
            [self.pickerView reloadComponent:2];
            [self.pickerView selectRow:0 inComponent:2 animated:YES];
            self.cityStr = self.cityArray[row];
            self.areaStr = self.areaArray[0];
        }else if (component == 2){//选择区
            self.areaStr = self.areaArray[row];
        }
    }else if (_pickerViewState == PickerViewStateHeight){
        _height = _heightsArray[row];
    }else{
        _weight  = _weightsArray[row];
    }
}

- (NSArray *)getAreaNamesFromCity:(NSInteger)row{
    NSDictionary * tempDic = [self.dataSource[self.selected] objectForKey:self.provinceArray[self.selected]];
    NSArray * array = [NSArray array];
    
    NSDictionary * dic = tempDic.allValues[row];
    array = [dic objectForKey:self.cityArray[row]];
    
    return array;
}

- (NSArray *)getCityNamesFromProvince:(NSInteger)row{
    NSDictionary * tempDic = [self.dataSource[row] objectForKey:self.provinceArray[row]];
    NSMutableArray * cityArray = [NSMutableArray array];
    for (NSDictionary * valueDic in tempDic.allValues) {
        
        for (int i = 0; i < valueDic.allKeys.count; i ++) {
            [cityArray addObject:valueDic.allKeys[i]];
        }
    }
    return [cityArray copy];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return _numberOfComponents;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (_pickerViewState == PickerViewStateCity) {
        if (component == 0) {
            return self.provinceArray.count;
        } else if (component == 1) {
            return self.cityArray.count;
        } else {
            return self.areaArray.count;
        }
    }else if (_pickerViewState == PickerViewStateHeight){
        return _heightsArray.count;
    }else{
        return _weightsArray.count;
    }
}
@end
