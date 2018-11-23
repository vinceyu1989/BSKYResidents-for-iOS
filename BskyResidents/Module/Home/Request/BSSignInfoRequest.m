//
//  BSSignInfoRequest.m
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/24.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import "BSSignInfoRequest.h"

@implementation BSSignInfoRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        self.pageIndex = 1;
        self.pageSize = 10;
    }
    
    return self;
}

- (NSString*)bs_requestUrl {
    return [NSString stringWithFormat:@"/resident/sign/info?pageIndex=%ld&pageSize=%ld", self.pageIndex, self.pageSize];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    return @{};
}

- (void)requestCompleteFilter {
    [super requestCompleteFilter];
    self.model = [SignInfoModel mj_objectWithKeyValues:self.ret];
    self.model.signInfo.cardId = [self.model.signInfo.cardId decryptCBCStr];
    self.model.signInfo.createEmp = [self.model.signInfo.createEmp decryptCBCStr];
    self.model.signInfo.doctorName = [self.model.signInfo.doctorName decryptCBCStr];
    self.model.signInfo.personName = [self.model.signInfo.personName decryptCBCStr];
    self.model.signInfo.phoneTel = [self.model.signInfo.phoneTel decryptCBCStr];
    self.model.signInfo.signPerson = [self.model.signInfo.signPerson decryptCBCStr];
    self.model.signInfo.teamId = [self.model.signInfo.teamId decryptCBCStr];
    self.model.signInfo.contractId = [self.model.signInfo.contractId decryptCBCStr];
    
    id signInfo = self.ret[@"signInfo"];
    if ([signInfo isKindOfClass:[NSDictionary class]]) {
        NSString* dataString = signInfo[@"attachfile"];
        self.model.signInfo.attachfile = [[NSData alloc] initWithBase64EncodedString:dataString options:NSDataBase64DecodingIgnoreUnknownCharacters];
        
        for (SignService* item in self.model.signInfo.servicelist) {
            item.startTime = self.model.signInfo.startTime;
            item.endTime = self.model.signInfo.endTime;
        }
    }
}

- (void)requestFailedFilter {
    [super requestFailedFilter];
    
}

@end
