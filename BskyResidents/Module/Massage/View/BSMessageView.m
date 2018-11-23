//
//  BSMessageView.m
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/17.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSMessageView.h"
#import "BSMessageCell.h"

@interface BSMessageView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *tableView;

@end

@implementation BSMessageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView = ({
            UITableView* tableView = [UITableView new];
            tableView.backgroundColor = Bsky_UIColorFromRGBA(0xf7f7f7,1);
            [self addSubview:tableView];
            tableView.separatorColor = Bsky_UIColorFromRGBA(0xededed,1);
            tableView.tableFooterView = [UIView new];
            [tableView registerNib:[UINib nibWithNibName:@"BSMessageCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BSMessageCell"];
            
            tableView.dataSource = self;
            tableView.delegate = self;
            
            tableView;
        });
        
        [self setupFrame];
    }
    
    return self;
}

#pragma mark -

- (void)setupFrame {
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)reloadData {
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource numberOfMessageCategoryInMessageView:self];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BSMessageCell* cell = [tableView dequeueReusableCellWithIdentifier:@"BSMessageCell"];
    
    id item = [self.dataSource categoryForIndex:indexPath.row];
    
    [cell bindData:item];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.f;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(didSelectSystemMailInMessageView:index:)]) {
        [self.delegate didSelectSystemMailInMessageView:self index:indexPath.row];
    }
}

@end
