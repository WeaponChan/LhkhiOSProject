//
//  NSString+Lhkh.m
//  Lhkh_Base
//
//  Created by Weapon on 2018/11/26.
//  Copyright © 2018 Lhkh. All rights reserved.
//

/************字符串过滤************/
#define DECIMALNUMBER @"0123456789.\n"
#define INTEGERNUMBER @"0123456789\n"
#define ALPHANUMBER   @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789.\n"

/************小数配置************/
#define kDecimalLength 2                                                                // 保留的小数位数
#define kNumberFormatStr [NSString stringWithFormat:@"%%.0%dlf", kDecimalLength]        // 小数位数的格式化字符串

#import "NSString+Lhkh.h"
#import <CommonCrypto/CommonDigest.h>


@implementation NSString (Lhkh)

#pragma mark - Filter String

- (BOOL)filterString:(NSString *)string {
    // 去反字符,把所有的除了数字的字符都找出来
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:string] invertedSet];
    
    // componentsSep 把输入框输入的字符根据cs中字符一个一个去除cs字符并分割成单字符并转化为NSArray
    // componentsJoi 是把NSArray的字符通过""无间隔连接成一个NSString字符赋给filtered,就只剩数字
    NSString *filtered = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL result = [self isEqualToString:filtered];
    
    return result;
}

- (BOOL)filterDecimalNumber {
    return [self filterString:DECIMALNUMBER];
}

- (BOOL)filterIntegerNumber {
    return [self filterString:INTEGERNUMBER];
}

- (BOOL)filterEmoji {
    __block BOOL isEomji = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    isEomji = YES;
                }
            }
        } else if (substring.length > 1) {
            const unichar ls = [substring characterAtIndex:1];
            
            if (ls == 0x20e3) {
                isEomji = YES;
            }
        } else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                isEomji = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                isEomji = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                isEomji = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                isEomji = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                isEomji = YES;
            }
            
        }
    }];
    
    return isEomji;
}

//利用正则表达式验证
-(BOOL)filterEmail {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:self];
}

+ (NSString *)toLower:(NSString *)str
{
    for (NSInteger i=0; i<str.length; i++) {
        if ([str characterAtIndex:i]>='A'&[str characterAtIndex:i]<='Z') {
            //A  65  a  97
            char  temp=[str characterAtIndex:i]+32;
            NSRange range=NSMakeRange(i, 1);
            str=[str stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"%c",temp]];
        }
    }
    return str;
}
 
+ (NSString *)toUpper:(NSString *)str
{
    for (NSInteger i=0; i<str.length; i++) {
        if ([str characterAtIndex:i]>='a'&[str characterAtIndex:i]<='z') {
            //A  65  a  97
            char  temp=[str characterAtIndex:i]-32;
            NSRange range=NSMakeRange(i, 1);
            str=[str stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"%c",temp]];
        }
    }
    return str;
}

+ (BOOL)validateUserName:(NSString *)name
{
    NSString*  regName1=@"^[\u4e00-\u9fa5]{2,16}$";//2-15位中文
    NSString*  regName2=@"^[A-Za-z]{2,16}$";//2-15位英文
    //如果仅仅是去前后空格，用whitespaceCharacterSet
    NSCharacterSet  *set = [NSCharacterSet whitespaceCharacterSet];
    name = [name stringByTrimmingCharactersInSet:set];
    NSPredicate *userNamePredicate1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regName1];
    NSPredicate *userNamePredicate2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regName2];
    
    if([userNamePredicate1 evaluateWithObject:name] ||  [userNamePredicate2 evaluateWithObject:name])
    {
        return NO;
    }
    return YES;
}

+ (BOOL)validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9.!@+-*&%$#]{6,30}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}

#pragma mark - String Format

+ (NSString *)numberString:(double)number {
    return [NSString stringWithFormat:kNumberFormatStr, number];
}

+ (NSString *)stringFromNumber:(NSNumber *)number
{
    if (number.doubleValue == INFINITY || isnan(number.doubleValue)) {
        number = @0;
    }
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    
    NSMutableString *formatStr = [NSMutableString stringWithString:@"###,##0."];
    for (int i = 0; i< kDecimalLength; i++) {
        [formatStr appendString:@"0"];
    }
    [numberFormatter setPositiveFormat:formatStr];
    return [numberFormatter stringFromNumber: number];
}

#pragma mark - String size

- (CGSize)sizeFromFont:(UIFont *)font
{
    NSDictionary *textAttributes=[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    CGSize size=[self sizeWithAttributes:textAttributes];
    return size;
}

- (CGSize)sizeFromFont:(UIFont *)font width:(CGFloat)width
{
    CGSize maxSize = CGSizeMake(width, CGFLOAT_MAX);
    CGSize textSize = CGSizeZero;
    // 多行必需使用NSStringDrawingUsesLineFragmentOrigin，网上有人说不是用NSStringDrawingUsesFontLeading计算结果不对
    NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingUsesFontLeading;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
    
    NSDictionary *attributes = @{ NSFontAttributeName : font, NSParagraphStyleAttributeName : style };
    CGRect rect = [self boundingRectWithSize:maxSize options:opts attributes:attributes context:nil];
    textSize = rect.size;
    
    return textSize;
}

- (CGSize)sizeFromFont:(UIFont *)font height:(CGFloat)height
{
    CGSize maxSize = CGSizeMake(CGFLOAT_MAX, height);
    CGSize textSize = CGSizeZero;
    // 多行必需使用NSStringDrawingUsesLineFragmentOrigin，网上有人说不是用NSStringDrawingUsesFontLeading计算结果不对
    NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingUsesFontLeading;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
    
    NSDictionary *attributes = @{ NSFontAttributeName : font, NSParagraphStyleAttributeName : style };
    CGRect rect = [self boundingRectWithSize:maxSize options:opts attributes:attributes context:nil];
    textSize = rect.size;
    
    return textSize;
}

- (BOOL)compareWithMin:(int)min max:(int)max subLength:(int)subLength
{
    NSString *temp = [self substringFromIndex:subLength];
    int num = temp.intValue;
    if (num >= min && num <= max) {
        return YES;
    } else {
        return NO;
    }
}


#pragma mark - String SaveForLogin
- (NSString *)md5String
{
    if(self == nil || [self length] == 0)
        return nil;
    
    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}


+ (NSString *)stringChangeMoneyWithStr:(NSString *)str numberStyle:(NSNumberFormatterStyle)numberStyle {
    
    // 判断是否null 若是赋值为0 防止崩溃
    if (([str isEqual:[NSNull null]] || str == nil)) {
        str = 0;
    }
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    formatter.numberStyle = numberStyle;
    // 注意传入参数的数据长度，可用double
    NSString *money = [formatter stringFromNumber:[NSNumber numberWithDouble:[str doubleValue]]];
    
    return money;
}


#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber
{
    NSString *pattern = @"^1([3-9])\\d{9}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [pred evaluateWithObject:telNumber];
}
#pragma 正则匹配身份证号
+ (BOOL)checkIDCard:(NSString *) idCard
{
    NSLog(@"idCard===%@",idCard);
    
    //判断位数
    if ([idCard length] != 15 ||[idCard length] != 18) {
        return NO;
    }
    //加权因子
    int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    //校验码
    unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
    
    //将15位身份证号转换成18位
    NSMutableString *mString = [NSMutableString stringWithString:idCard];
    if ([idCard length] == 15) {
        [mString insertString:@"19" atIndex:6];
        long p = 0;
        const char *pid = [mString UTF8String];
        for (int i=0; i<=16; i++)
        {
            p += (pid[i]-48) * R[i];
        }
        int o = p%11;
        NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
        [mString insertString:string_content atIndex:[mString length]];
        idCard = mString;
    }
    
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:idCard]) return NO;
    //** 开始进行校验 *//
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex  = [[idCard substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum      += subStrIndex * idCardWiIndex;
    }
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [idCard substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;
}

//截取身份证的出生日期并转换为日期格式
- (NSString *)subsIDStrToDate:(NSString *)str
{
    NSMutableString *result = [NSMutableString stringWithCapacity:0];
    NSString *dateStr = [str substringWithRange:NSMakeRange(6, 8)];
    NSString  *year = [dateStr substringWithRange:NSMakeRange(0, 4)];
    NSString  *month = [dateStr substringWithRange:NSMakeRange(4, 2)];
    NSString  *day = [dateStr substringWithRange:NSMakeRange(6,2)];
    
    [result appendString:year];
    [result appendString:@"-"];
    [result appendString:month];
    [result appendString:@"-"];
    [result appendString:day];
    
    return result;
}

//计算年龄
- (NSString *)calculateAgeStr:(NSString *)str
{
  //截取身份证的出生日期并转换为日期格式
    NSString *dateStr = [self subsIDStrToDate:str];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-mm-dd";
    NSDate *birthDate =  [formatter dateFromString:dateStr];
    NSTimeInterval dateDiff = [birthDate timeIntervalSinceNow];
    // 计算年龄
    int age  =  trunc(dateDiff/(60*60*24))/365;
    NSString *ageStr = [NSString stringWithFormat:@"%d", -age];
    return ageStr;
}

#pragma 正则匹配邮箱
+ (BOOL) checkEmail:(NSString *) email
{
    NSLog(@"Email===%@",email);
    NSString *emailCheck = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailCheck];
    return [pred evaluateWithObject:email];
}

#pragma 正则匹配银行卡
+ (BOOL) checkBankCard:(NSString *) bankCard
{
    NSLog(@"bankCard===%@",bankCard);
    if(bankCard.length==0)
    {
        return NO;
    }
    NSString *digitsOnly = @"";
    char c;
    for (int i = 0; i < bankCard.length; i++)
    {
        c = [bankCard characterAtIndex:i];
        if (isdigit(c))
        {
            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
        }
    }
    int sum = 0;
    int digit = 0;
    int addend = 0;
    BOOL timesTwo = false;
    for (NSInteger i = digitsOnly.length - 1; i >= 0; i--)
    {
        digit = [digitsOnly characterAtIndex:i] - '0';
        if (timesTwo)
        {
            addend = digit * 2;
            if (addend > 9) {
                addend -= 9;
            }
        }
        else {
            addend = digit;
        }
        sum += addend;
        timesTwo = !timesTwo;
    }
    int modulus = sum % 10;
    return modulus == 0;
    
}

#pragma 正则匹配车牌号
+ (BOOL) checkCarNo:(NSString *) CarNo
{
    NSString *carRegex = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [pred evaluateWithObject:CarNo];
}

#pragma 正则匹配车型
+ (BOOL) checkCarType:(NSString *) CarType
{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:CarType];
}

#pragma 正则匹配邮政编码
+ (BOOL) checkPostalcode :(NSString *) Postalcode
{
    NSString *phoneRegex = @"^[0-8]\\d{5}(?!\\d)$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [pred evaluateWithObject:Postalcode];
}

#pragma 正则匹配网址
+ (BOOL) checkUrl :(NSString *) Url
{
    NSString *regex = @"^((http)|(https))+:[^\\s]+\\.[^\\s]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:Url];
}
#pragma 正则匹配IP
+ (BOOL) checkIP :(NSString *) IP
{
    NSString *regex = [NSString stringWithFormat:@"^(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})$"];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL rc = [pred evaluateWithObject:IP];
    
    if (rc) {
        NSArray *componds = [IP componentsSeparatedByString:@","];
        
        BOOL v = YES;
        for (NSString *s in componds) {
            if (s.integerValue > 255) {
                v = NO;
                break;
            }
        }
        
        return v;
    }
    
    return NO;
}
#pragma 正则匹配纯汉字
+ (BOOL) checkChinese :(NSString *) Chinese
{
    NSString *phoneRegex = @"^[\u4e00-\u9fa5]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [pred evaluateWithObject:Chinese];
}
#pragma 正则匹配工商税号
+ (BOOL) checkTaxNo :(NSString *) TaxNo
{
    NSString *emailRegex = @"[0-9]\\d{13}([0-9]|X)$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [pred evaluateWithObject:TaxNo];
}
@end
