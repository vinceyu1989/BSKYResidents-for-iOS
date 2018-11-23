//
//  HomePopView.m
//  BskyResidents
//
//  Created by 何雷 on 2017/10/11.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "HomePopView.h"
#import "PopTableViewCell.h"

@interface HomePopView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong) UITableView *tableView;

@property (nonatomic ,copy) NSArray *imageArray;

@property (nonatomic ,copy) NSArray *titleArray;

@property (nonatomic ,assign) CGRect originFrame;

@property (nonatomic ,assign) CGRect finishFrame;

@property (nonatomic ,copy) void(^completion)(NSInteger index);

@end

@implementation HomePopView

+ (void)sharedInstanceoOriginFrame:(CGRect)originFrame
                           toFrame:(CGRect)finishFrame
                        completion:(void(^)(NSInteger index))completion
{
    [[[HomePopView alloc]init]sharedInstanceoOriginFrame:originFrame toFrame:finishFrame completion:completion];
}

- (void)sharedInstanceoOriginFrame:(CGRect)originFrame
                           toFrame:(CGRect)finishFrame
                        completion:(void(^)(NSInteger index))completion
{
    self.originFrame = originFrame;
    self.tableView.frame = originFrame;
    self.finishFrame = finishFrame;
    self.completion = completion;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self showView];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, Bsky_SCREEN_WIDTH, Bsky_SCREEN_HEIGHT);
        self.backgroundColor = [UIColor clearColor];
        self.imageArray = @[@"saomiao_icon",@"remind_icon",@"qrCode_icon"];
        self.titleArray = @[@"扫一扫",@"用药提醒",@"个人二维码"];
        self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.tableView setCornerRadius:5];
        self.tableView.backgroundColor = Bsky_COLOR_RGBA(38, 38, 38,0.5);
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        [self.tableView registerNib:[PopTableViewCell nib] forCellReuseIdentifier:[PopTableViewCell cellIdentifier]];
        [self addSubview:self.tableView];

    }
    return self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch  locationInView:self.tableView];
    BOOL isLocation = CGRectContainsPoint(self.tableView.bounds, point);
    
    if (isLocation) {
        
        [self.nextResponder touchesBegan:touches withEvent:event];
    }
    else
    {
        if (self.completion) {
            self.completion(-1);
        }
        [self closeView];
    }
}
- (void)showView
{
    [UIView animateWithDuration:0.2 animations:^{
        self.tableView.frame = self.finishFrame;
        self.tableView.backgroundColor = Bsky_COLOR_RGBA(38, 38, 38, 1);
    } completion:^(BOOL finished) {
        
    }];
}
- (void)closeView
{
    [UIView animateWithDuration:0.2 animations:^{
        self.tableView.frame = self.originFrame;
        self.tableView.backgroundColor = Bsky_COLOR_RGBA(38, 38, 38, 0.5);
    } completion:^(BOOL finished) {
        
        if (self.completion) {
            self.completion = nil;
        }
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
        [self removeFromSuperview];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[PopTableViewCell cellIdentifier] forIndexPath:indexPath];
    cell.iconImageView.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    cell.titleLabel.text = self.titleArray[indexPath.row];
    cell.line.hidden = NO;
    if (indexPath.row == self.imageArray.count -1) {
        cell.line.hidden = YES;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.completion) {
        self.completion(indexPath.row);
    }
    [self closeView];
}

@end
