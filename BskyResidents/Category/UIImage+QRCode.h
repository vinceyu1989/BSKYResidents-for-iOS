//
//  UIImage+QRCode.h
//  BskyResidents
//
//  Created by LinfengYU on 2017/10/19.
//  Copyright © 2017年 何雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (QRCode)

+ (UIImage*)qrImageForString:(NSString*)string centerImage:(UIImage*)centerImage;

@end
