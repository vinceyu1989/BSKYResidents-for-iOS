//
//  BSSigningTableViewController.h
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/10.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSSigningViewModel : NSObject

@property (nonatomic, strong) NSArray* roleList;
@property (nonatomic, strong) NSArray* symptomList;

@end

@interface BSSigningTableViewController : UITableViewController

@property (nonatomic, strong) BSSigningViewModel* viewModel;

@end
