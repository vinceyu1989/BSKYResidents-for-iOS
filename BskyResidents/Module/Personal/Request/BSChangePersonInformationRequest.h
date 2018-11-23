//
//  BSChangePersonInformationRequest.h
//  BskyResidents
//
//  Created by 罗林轩 on 2017/11/1.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <BSKYCore/BSKYCore.h>

@interface BSChangePersonInformationRequest : BSBaseRequest
//@property (nonatomic ,strong) NSDictionary *residentInfoForm;    // 保存的json
@property (copy, nonatomic) NSString *areaCode;
@property (copy, nonatomic) NSString *areaId;
@property (copy, nonatomic) NSString *cityId;
@property (copy, nonatomic) NSString *detailAddress;
@property (copy, nonatomic) NSString *height;
@property (copy, nonatomic) NSString *phone;
@property (copy, nonatomic) NSString *photo;
@property (copy, nonatomic) NSString *properId;
@property (copy, nonatomic) NSString *provinceId;
@property (copy, nonatomic) NSString *residentId;
@property (copy, nonatomic) NSString *signingLabel;
@property (copy, nonatomic) NSString *userId;
@property (copy, nonatomic) NSString *weight;
@end
