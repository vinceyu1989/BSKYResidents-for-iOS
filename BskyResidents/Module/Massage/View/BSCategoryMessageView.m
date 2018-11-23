
//
//  BSCategoryMessageView.m
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/17.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSCategoryMessageView.h"
#import "BSCategoryMessageCell.h"
#import "BSTimeLabel.h"

@interface BSCategoryMessageView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *tableView;

@end

@implementation BSCategoryMessageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView = ({
            UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
            tableView.backgroundColor = Bsky_UIColorFromRGBA(0xf7f7f7,1);
            [self addSubview:tableView];
            tableView.separatorColor = Bsky_UIColorFromRGBA(0xededed,1);
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            tableView.tableFooterView = [UIView new];
            tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGFLOAT_MIN, CGFLOAT_MIN)];
            [tableView registerNib:[UINib nibWithNibName:@"BSCategoryMessageCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BSCategoryMessageCell"];
            
            tableView.dataSource = self;
            tableView.delegate = self;
            
            tableView;
        });
        
        [self setupFrame];
    }
    
    return self;
}

#pragma mark -

- (void)reloadData {
    [self.tableView reloadData];
}

- (void)setupFrame {
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dataSource numberOfNewsInView:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BSCategoryMessageCell* cell = [tableView dequeueReusableCellWithIdentifier:@"BSCategoryMessageCell"];
    
    BSNews* item = [self.dataSource newsForIndex:indexPath.section];
    [cell bindData:item];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 45.f;
    }
    return 50.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* headerView = ({
        UIView* view = [UIView new];
        view.backgroundColor = Bsky_UIColorFromRGBA(0xf7f7f7,1);
        
        BSNews* item = [self.dataSource newsForIndex:section];
        BSTimeLabel* tagLabel = [BSTimeLabel labelWithTagString:item.publishDate];
        [view addSubview:tagLabel];
        __weak typeof(view) weakView = view;
        [tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(weakView);
        }];
        view;
    });
    
    return headerView;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

@end
