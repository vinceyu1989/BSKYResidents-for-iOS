//
//  ChildrenListModel.h
//  BskyResidents
//
//  Created by vince on 2018/9/17.
//  Copyright © 2018年 罗林轩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChildrenListModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *idType;
@property (nonatomic, copy) NSString *idNo;
@property (nonatomic, copy) NSString *ehealthCode;
@property (nonatomic, copy) NSString *chcInfoId;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *nation;
@property (nonatomic, copy) NSString *mqname;
@property (nonatomic, copy) NSString *mqidno;
@property (nonatomic, copy) NSString *birthday;
- (void)decryptModel;
@end
