//
//  BSSigningServiceView.m
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/12.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSSigningServiceView.h"
#import "BSSigningServiceHeaderView.h"
#import "BSSigningServiceCell.h"
#import "BSServicePackCell.h"

@interface BSSigningServiceView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) BSSigningServiceHeaderView* headerView;

@property (nonatomic, assign) NSInteger expandIndex;

@end

@implementation BSSigningServiceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = Bsky_UIColorFromRGBA(0xededed,1);
        self.tableView = ({
            UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
            tableView.backgroundColor = Bsky_UIColorFromRGBA(0xededed,1);
            [self addSubview:tableView];
            tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
            tableView.showsVerticalScrollIndicator = NO;
            tableView.separatorColor = Bsky_UIColorFromRGBA(0xededed,1);
            tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, CGFLOAT_MIN)];
            [tableView registerNib:[UINib nibWithNibName:@"BSSigningServiceCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BSSigningServiceCell"];
            [tableView registerNib:[UINib nibWithNibName:@"BSServicePackCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BSServicePackCell"];
            tableView.dataSource = self;
            tableView.delegate = self;
            tableView.tableHeaderView = ({
                self.headerView = [[BSSigningServiceHeaderView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, 130)];
                WS(weakSelf);
                [self.headerView setTouchBlock:^{
                    if ([weakSelf.delegate respondsToSelector:@selector(didTouchContractInSigningServiceView:)]) {
                        [weakSelf.delegate didTouchContractInSigningServiceView:weakSelf];
                    }
                }];
                self.headerView;
            });
            
            tableView;
        });
        
        self.expandIndex = -1;
        
        [self setupFrame];
    }
    
    return self;
}

#pragma mark -

- (void)setupFrame {
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 10, 0));
    }];
}

- (void)reloadData {
    [self.tableView reloadData];
    [self.headerView bindData:[self.dataSource signInfoData]];
}

- (void)loadServicePackList:(NSString*)servicePackId completion:(void (^)(NSArray* servicePackList))completion {
    BSSignServiceInfoRequest* request = [BSSignServiceInfoRequest new];
    request.servicePackId = servicePackId;
    [request startWithCompletionBlockWithSuccess:^(__kindof BSSignServiceInfoRequest * _Nonnull request) {
        if (completion) {
            completion(request.servicePackList);
        }
    } failure:^(__kindof BSSignServiceInfoRequest * _Nonnull request) {
        if (completion) {
            completion(nil);
        }
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dataSource numberOfServiceInSigningServiceView:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SignService* item = [self.dataSource serviceAtIndex:section];
    if (item.servicePackList.count > 0 && self.expandIndex == section) {
        return item.servicePackList.count + 1;
    }
    
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        BSSigningServiceCell* cell = [tableView dequeueReusableCellWithIdentifier:@"BSSigningServiceCell"];
        SignService* item = [self.dataSource serviceAtIndex:indexPath.section];
        [cell bindData:item];
        __weak typeof(self) weakSelf = self;
        if (self.expandIndex == indexPath.section) {
            cell.expand = YES;
        }else{
            cell.expand = NO;
        }
        [cell setExpandBlock:^(BOOL expand) {
            if (expand) {
                weakSelf.expandIndex = indexPath.section;
            }else {
                weakSelf.expandIndex = -1;
            }
            if (item.servicePackList) {
                [tableView reloadData];
            }else {
                [weakSelf loadServicePackList:item.id completion:^(NSArray* servicePackList) {
                    item.servicePackList = servicePackList;
                    [tableView reloadData];
                }];
            }
        }];
        return cell;
    }
    
    BSServicePackCell* cell = [tableView dequeueReusableCellWithIdentifier:@"BSServicePackCell"];
    SignService* signService = [self.dataSource serviceAtIndex:indexPath.section];
    ServicePack* item = signService.servicePackList[indexPath.row - 1];
    [cell bindData:item];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 45.f;
    }
    
    return 20.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView* headerView = ({
            UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, 45)];
            UIView* line = [UIView new];
            line.backgroundColor = Bsky_UIColorFromRGBA(0xcccccc,1);
            [view addSubview:line];
            
            UILabel* label = [UILabel new];
            label.text = @"已签约服务";
            label.textColor = Bsky_UIColorFromRGBA(0x999999,1);
            label.font = [UIFont systemFontOfSize:14];
            label.backgroundColor = Bsky_UIColorFromRGBA(0xededed,1);
            label.textAlignment = NSTextAlignmentCenter;
            [view addSubview:label];
            
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(view);
                make.left.equalTo(view.mas_left).offset(20);
                make.right.equalTo(view.mas_right).offset(-20);
                make.height.equalTo(@1);
            }];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(view);
                make.centerX.equalTo(view);
                make.width.equalTo(@100);
            }];
            
            view;
        });
        
        return headerView;
    }
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, 20)];
    view.backgroundColor = Bsky_UIColorFromRGBA(0xededed,1);
    return view;
}

#pragma mark - UITableViewDelegate

@end
