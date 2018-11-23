//
//  BannerModel.h
//  BskyResidents
//
//  Created by 何雷 on 2017/10/25.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BannerModel : NSObject

@property (nonatomic, copy) NSString * bannerId;//主键ID
@property (nonatomic, copy) NSString * citingSource;//引用来源
@property (nonatomic, copy) NSString * content;//banner内容
@property (nonatomic, copy) NSString * href;// 图片地址
@property (nonatomic, copy) NSString * isEnable;//是否显示
@property (nonatomic, copy) NSString * releaseDate;//发布时间
@property (nonatomic, copy) NSString * scopeRange;// 作用域（居民端首页)
@property (nonatomic, copy) NSString * sort;//排序
@property (nonatomic, copy) NSString * subtitle;//副标题
@property (nonatomic, copy) NSString * title;//标题

@end
