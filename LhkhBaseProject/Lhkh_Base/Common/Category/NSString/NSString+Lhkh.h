//
//  NSString+Lhkh.h
//  Lhkh_Base
//
//  Created by Weapon on 2018/11/26.
//  Copyright © 2018 Lhkh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Lhkh)

#pragma mark - Filter String
/**
 *  @brief  过滤字符串
 *  @param  string 过滤条件字符串
 *  @return Yes/No 如果只包含过滤条件中的字符串则返回Yes, 否则返回No
 */
- (BOOL)filterString:(NSString *)string;

/**
 *  @brief  过滤小数和数字
 *  @return Yes/No 如果只包含数字和小数点则返回Yes, 否则返回No
 */
- (BOOL)filterDecimalNumber;

/**
 *  @brief  过滤数字
 *  @return Yes/No 如果只包含数字则返回Yes, 否则返回No
 */
- (BOOL)filterIntegerNumber;

/**
 *  @brief  过滤Emoji表情
 *  @return Yes/No 如果包含Emoji表情则返回Yes, 否则返回No
 */
- (BOOL)filterEmoji;

/**
 *  @brief  过滤Email字符串
 *  @return Yes/No 如果是email格式则返回Yes, 否则返回No
 */
- (BOOL)filterEmail;

/**
*  @brief  字符串中字母大小写转换
*  @return 转换后的字符
*/
+ (NSString *)toLower:(NSString *)str;
+ (NSString *)toUpper:(NSString *)str;

/**
 *  @brief  用户名验证
 *  @return Yes/No表示验证结果
 */
+ (BOOL)validateUserName:(NSString *)name;

/**
 *  @brief  密码验证
 *  @return Yes/No表示验证结果
 */
+ (BOOL)validatePassword:(NSString *)passWord;

 
#pragma mark - String Format

/**
 *  @brief  格式化小数，将double类型的数字转成保留小数位的字符串
 *  @param number double类型的数字
 *  @return string 保留小数位的字符串
 */
+ (NSString *)numberString:(double)number;

/**
 *  Number转为格式化的金额字符串 000,000.00
 *  @param number NSNumber
 *  @return string
 */
+ (NSString *)stringFromNumber:(NSNumber *)number;

#pragma mark - String size

/**
 *  通过字体计算字符串所占大小
 *  @param font  字体 UIFont
 *  @return CGSize
 */
- (CGSize)sizeFromFont:(UIFont *)font;

/**
 *  通过字体计算字符串所占大小
 *  @param font  字体 UIFont
 *  @param width 宽度
 *  @return CGSize
 */
- (CGSize)sizeFromFont:(UIFont *)font width:(CGFloat)width;

/**
 *  通过字体计算字符串所占大小
 *  @param font  字体 UIFont
 *  @param height 高度
 *  @return CGSize
 */
- (CGSize)sizeFromFont:(UIFont *)font height:(CGFloat)height;

/**
 *  @brief  比较字符串是否在范围内
 *  @param  min          最小值
 *  @param  max          最大值
 *  @param  subLength    需要截取比较的长度(截取前缀)
 *  @return bool         是否在范围内
 */
- (BOOL)compareWithMin:(int)min max:(int)max subLength:(int)subLength;

#pragma mark - String MD5
/**
 *  @brief  MD5加密算法
 *
 *  @return 加密结果
 */
- (NSString *)md5String;

/**
* 金额的格式转化
* str : 金额的字符串
* numberStyle : 金额转换的格式
* return  NSString : 转化后的金额格式字符串
*/
+ (NSString *)stringChangeMoneyWithStr:(NSString *)str numberStyle:(NSNumberFormatterStyle)numberStyle;

#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber;
#pragma 正则匹配身份证号
+ (BOOL)checkIDCard:(NSString *) idCard;
//根据身份证计算年龄
- (NSString *)calculateAgeStr:(NSString *)str;
#pragma 正则匹配邮箱
+ (BOOL) checkEmail:(NSString *) email;
#pragma 正则匹配银行卡
+ (BOOL) checkBankCard:(NSString *) bankCard;
#pragma 正则匹配车牌号
+ (BOOL) checkCarNo:(NSString *) CarNo;
#pragma 正则匹配车型
+ (BOOL) checkCarType:(NSString *) CarType;
#pragma 正则匹配邮政编码
+ (BOOL) checkPostalcode :(NSString *) Postalcode;
#pragma 正则匹配网址
+ (BOOL) checkUrl :(NSString *) Url;
#pragma 正则匹配IP
+ (BOOL) checkIP :(NSString *) IP;
#pragma 正则匹配纯汉字
+ (BOOL) checkChinese :(NSString *) Chinese;
#pragma 正则匹配工商税号
+ (BOOL) checkTaxNo :(NSString *) TaxNo;


@end

NS_ASSUME_NONNULL_END
