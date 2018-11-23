//
//  NSString+Extension.h
//  Dingding
//
//  Created by 陈欢 on 14-2-27.
//  Copyright (c) 2014年 陈欢. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
/**
 比较两个版本号的大小
 
 @param v1 第一个版本号
 @param v2 第二个版本号
 @return 版本号相等,返回0; v1小于v2,返回-1; 否则返回1.
 */
+ (NSInteger)compareVersion:(NSString *)v1 to:(NSString *)v2;

/**
 *  替换字符串
 *
 *  @param indexes indexes
 *  @param aString 字符串
 *
 *  @return 替换后的字符串
 */
- (NSString *)replaceCharactersAtIndexes:(NSArray *)indexes withString:(NSString *)aString;

/**
 *  urlencode
 *
 *  @return urlencode值
 */
- (NSString *)urlencode;

/**
 *  md5字符串
 *
 *  @return md5加密后的字符串
 */
- (NSString *)md5String;

/**
 *  获得设备型号
 *
 *  @return 设备型号
 */
+ (NSString *)getCurrentDeviceModel;

/**
 *  是否不是空字符串且不含有@“null”
 * *
 *  @return 是否不是空字符串
 */
- (BOOL)isNotEmptyStringAndNoNull;

/**
 *  是否是空字符串
 *
 *  @param string 字符串
 *
 *  @return 是否是空字符串
 */
+ (BOOL)isEmptyString:(NSString *)string;

/**
 *  是否不是空字符串
 *
 *  @param string 字符串
 *
 *  @return 是否不是空字符串
 */
+ (BOOL)isNotEmptyString:(NSString *)string;

/**
 *  Int->NSString
 *
 *  @param value Int值
 *
 *  @return 转换之后的字符串
 */
+ (NSString *)fromInt:(int)value;

/**
 *  LonglongInt->NSString
 *
 *  @param value LonglongInt值
 *
 *  @return 转换之后的字符串
 */
+ (NSString *)fromLonglongInt:(long long int)value;

/**
 *  Integer->NSString
 *
 *  @param value Integer值
 *
 *  @return 转换之后的字符串
 */
+ (NSString *)fromInteger:(NSInteger)value;

/**
 *  UInteger->NSString
 *
 *  @param value UInteger值
 *
 *  @return 转换之后的字符串
 */
+ (NSString *)fromUInteger:(NSUInteger)value;

/**
 *  Float->NSString
 *
 *  @param value Float值
 *
 *  @return 转换之后的字符串
 */
+ (NSString *)fromFloat:(float)value;

/**
 *  Double->NSString
 *
 *  @param value Double值
 *
 *  @return 转换之后的字符串
 */
+ (NSString *)fromDouble:(double)value;

/**
 *  BOOL->NSString
 *
 *  @param value BOOL值
 *
 *  @return 转换之后的字符串
 */
+ (NSString *)fromBool:(BOOL)value;

/**
 *  获得字体高度
 *
 *  @param font 字体
 *
 *  @return 返回字体高度
 */
+ (CGFloat)fontHeight:(UIFont *)font;

/**
 *  计算字体宽度
 *
 *  @param font 字体
 *
 *  @return 返回字体宽度
 */
- (CGFloat)getDrawWidthWithFont:(UIFont *)font;

/**
 *  根据宽度计算字体高度
 *
 *  @param font  字体
 *  @param width 宽度
 *
 *  @return 返回字体高度
 */
- (CGFloat)getDrawHeightWithFont:(UIFont *)font Width:(CGFloat)width;

/**
 *  是否为空
 *
 *  @return 是否为空
 */
- (BOOL)isEmpty;

/**
 *  是否不为空
 *
 *  @return 是否不为空
 */
- (BOOL)isNotEmpty;

/**
 *  是否中文
 *
 *  @return 是否中文
 */
- (BOOL)isChinese;

/**
 *  是否匹配正则表达式
 *
 *  @param regex 正则表达式
 *
 *  @return 是否匹配
 */
- (BOOL)isMatchesRegularExp:(NSString *)regex;

/**
 *  是否是座机号码
 *
 *  @return 是否是座机号码
 */
- (BOOL)isLandlineNumber;

/**
 *  是否是手机号
 *
 *  @return 是否是手机号
 */
- (BOOL)isPhoneNumber;
/**
 *  是否是纯数字
 *
 *  @return 是否是纯数字
 */
- (BOOL)isNumText;
/**
 *  是否是身份证号
 *
 *  @return 是否是身份证号
 */
- (BOOL)isIdCard;
/**
 *  计算字符串的尺寸
 *
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxsize;
/**
 *  字符串转换成时间格式
 */
-(NSString *)stringCoverToTime;

/**
 *  通过字符串的字号和字符串的长度来确定文本框的大小
 *
 *  @return 文本框的大小
 */
//通过文字设定文本框的大小(适配ios9字体的问题)
- (CGSize)calculateSizeWithText:(CGFloat)font;

/**
 *  替换字符串中的关键字
 *
 *  @param regString    正则表达式
 *  @param str          替换成目标字符
 *
 *  @return 替换完成的字符串
 */
- (NSString *)replaceWithKeyWord:(NSString *)regString replace:(NSString *)str;

/**
 *  转换时间为字符串形式
 *
 *  @param date 新闻时间
 *
 *  @return 装换后的时间
 */
+ (NSString *)convertNewsTime:(NSDate *)date;

/**
 *  转换时间为字符串形式
 *
 *  @param formatter 格式
 *
 *  @return 装换后的时间
 */
- (NSString *)convertDateStringWithTimeStr:(NSString *)formatter;
/**
 aes cbc 解密
 **/
- (NSString *)decryptCBCStr;
/**
 aes cbc 加密
 **/
- (NSString *)encryptCBCStr;
/**
 *随机生成字符串
 *@param len 长度
 *@param letters 字符源
 *
 **/
+ (NSString *)randomStringWithLength:(NSInteger)len String:(NSString *)letters;
/**
 rsa 加密 cbc 密钥
 **/
+ (NSString *)enctryptCBCKeyWithRSA;
/**
 身份证加密 ****
 **/
-(NSString *)secretStrFromIdentityCard;
/**
 判断字符串是否为浮点数
 **/
- (BOOL)isPureFloat;
/**
 判断字符串是否为整型
 **/
- (BOOL)isPureInt;
/**
 字符串加密 ****
 **/
- (NSString *)secretStrWithRange:(NSRange )range;
@end
