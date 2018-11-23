
//
//  BSSigningContractViewController.m
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/12.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSSigningContractViewController.h"
#import "BSSigningContractTableViewController.h"

@interface BSSigningContractViewController ()

@end

@implementation BSSigningContractViewController

+ (instancetype)viewControllerFromStoryboard {
    return [[UIStoryboard storyboardWithName:@"Home" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:NSStringFromClass(self)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"BSSigningContractTableViewController"]) {
        BSSigningContractTableViewController* viewController = segue.destinationViewController;
        viewController.signInfo = self.signInfo;
    }
}

#pragma mark -

- (void)setupView {
    self.title = @"签约合同";
    self.view.backgroundColor = Bsky_UIColorFromRGBA(0xededed,1);
}

@end
