//
//  BSSigningViewController.m
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/10.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSSigningViewController.h"
#import "BSSigningTableViewController.h"

@interface BSSigningViewController ()

@property (nonatomic, strong) BSSigningViewModel* viewModel;

@end

@implementation BSSigningViewController

+ (instancetype)viewControllerFromStoryboard {
    return [[UIStoryboard storyboardWithName:@"Home" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:NSStringFromClass(self)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"BSSigningTableViewController"]) {
        BSSigningTableViewController* viewController = (BSSigningTableViewController*)segue.destinationViewController;
        self.viewModel = [BSSigningViewModel new];
        viewController.viewModel = self.viewModel;
    }
}

#pragma mark -
- (void)setupView {
    self.view.backgroundColor = Bsky_UIColorFromRGBA(0xf7f7f7,1);
    self.title = @"签约申请";
}

- (IBAction)onSubmit:(id)sender {
    [self.view endEditing:YES];
    
//    NSMutableString* crowdTags = [NSMutableString string];
//    for (NSString* item in self.viewModel.roleList) {
//        [crowdTags appendString:[self codeForLabel:item]];
//        [crowdTags appendString:@","];
//    }

    NSMutableArray *array2 = [NSMutableArray array];
    for (NSString* item in self.viewModel.roleList) {
        [array2 addObject:[self codeForLabel:item]];
    }
    NSString *crowdTags = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:array2 options:0 error:nil] encoding:NSUTF8StringEncoding];

    NSMutableArray *array = [NSMutableArray array];
    for (NSString *item in self.viewModel.symptomList) {
       [array addObject:[self codeForLabel:item]];
    }
    NSString *diseaseLabel = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:array options:0 error:nil] encoding:NSUTF8StringEncoding];
    
    if (crowdTags.length < 1 || [crowdTags isEqualToString:@"[]"]) {
        [UIView makeToast:@"请选择所属人群"];
        return;
    }
    else if (diseaseLabel.length < 1 || [diseaseLabel isEqualToString:@"[]"])
    {
        [UIView makeToast:@"请选择疾病类型"];
        return;
    }
    BSUser *user = [BSAppManager sharedInstance].currentUser;
    BSSignApplyRequest* req = [[BSSignApplyRequest alloc]init];
    req.areaCode = user.realnameInfo.areaCode;
    req.areaId = user.realnameInfo.areaId;
    req.crowdTags = crowdTags;
    req.diseaseLabel = diseaseLabel;
    req.signingIdcard =  user.realnameInfo.documentNo;
    req.signingMobileNo = user.realnameInfo.mobileNo;
    req.signingName = user.realnameInfo.realName;
    req.userId = user.realnameInfo.userId;
    
    [MBProgressHUD showHud];
    Bsky_WeakSelf
    [req startWithCompletionBlockWithSuccess:^(__kindof BSSignApplyRequest * _Nonnull request) {
        [MBProgressHUD hideHud];
        Bsky_StrongSelf
        [UIView makeToast:@"签约成功"];
        if (self.signCompleteBlock) {
            self.signCompleteBlock();
        }
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(__kindof BSSignApplyRequest * _Nonnull request) {
        [MBProgressHUD hideHud];
        [UIView makeToast:request.msg];
        
    }];
}

- (NSString*)codeForLabel:(NSString*)label {
    if ([label isEqualToString:@"普通人群"]) {
        return @"02017001";
    }else if ([label isEqualToString:@"65岁以上老年人"]) {
        return @"02017002";
    }else if ([label isEqualToString:@"孕产妇"]) {
        return @"02017003";
    }else if ([label isEqualToString:@"残疾人"]) {
        return @"02017004";
    }else if ([label isEqualToString:@"0-6岁儿童"]) {
        return @"02017005";
    }else if ([label isEqualToString:@"贫困人群"]) {
        return @"02017006";
    }else if([label isEqualToString:@"计生特殊家庭"]){
        return @"02017007";
    }else if ([label isEqualToString:@"建档立卡贫困人口"]){
        return @"02017008";
    }else if ([label isEqualToString:@"高血压"]) {
        return @"02018001";
    }else if ([label isEqualToString:@"糖尿病"]) {
        return @"02018002";
    }else if ([label isEqualToString:@"严重精神障碍"]) {
        return @"02018003";
    }else if ([label isEqualToString:@"无疾病"]) {
        return @"02018004";
    }else if ([label isEqualToString:@"结核病"]) {
        return @"02018005";
    }else if ([label isEqualToString:@"COPD(慢阻肺)"]) {
        return @"02018006";
    }else if ([label isEqualToString:@"其他"]) {
        return @"02018007";
    }
    return @"0";
}

@end
