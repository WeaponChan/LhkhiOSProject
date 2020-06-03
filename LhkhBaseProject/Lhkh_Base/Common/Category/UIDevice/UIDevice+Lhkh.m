//
//  UIDevice+Lhkh.m
//  Lhkh_Base
//
//  Created by Weapon on 2018/11/26.
//  Copyright © 2018 Lhkh. All rights reserved.
//

#import "UIDevice+Lhkh.h"
#import <sys/utsname.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
@implementation UIDevice (Lhkh)
//uname系统调用:获取当前内核名称和其它信息  参数__name：指向存放系统信息的缓冲区
-(NSString *)deviceName
{
    struct utsname u;
    uname(&u);
    return [NSString stringWithCString:u.machine encoding:NSUTF8StringEncoding];
}

-(NSString *)sysnameName
{
    struct utsname u;
    uname(&u);
    return [NSString stringWithCString:u.sysname encoding:NSUTF8StringEncoding];
}

-(NSString *)nodenameName
{
    struct utsname u;
    uname(&u);
    return [NSString stringWithCString:u.nodename encoding:NSUTF8StringEncoding];
}

-(NSString *)releaseName
{
    struct utsname u;
    uname(&u);
    return [NSString stringWithCString:u.release encoding:NSUTF8StringEncoding];
}

-(NSString *)versionName
{
    struct utsname u;
    uname(&u);
    return [NSString stringWithCString:u.version encoding:NSUTF8StringEncoding];
}

- (NSString*)iphoneType
{
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString*platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if([platform isEqualToString:@"iPhone1,1"])
        return @"iPhone 2G";
    
    if([platform isEqualToString:@"iPhone1,2"])
        return @"iPhone 3G";
    
    if([platform isEqualToString:@"iPhone2,1"])
        return @"iPhone 3GS";
    
    if([platform isEqualToString:@"iPhone3,1"])
        return @"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,2"])
        return @"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,3"])
        return @"iPhone 4";
    
    if([platform isEqualToString:@"iPhone4,1"])
        return @"iPhone 4S";
    
    if([platform isEqualToString:@"iPhone5,1"])
        return @"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,2"])
        return @"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,3"])
        return @"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone5,4"])
        return @"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone6,1"])
        return @"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone6,2"])
        return @"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone7,1"])
        return @"iPhone 6 Plus";
    
    if([platform isEqualToString:@"iPhone7,2"])
        return @"iPhone 6";
    
    if([platform isEqualToString:@"iPhone8,1"])
        return @"iPhone 6s";
    
    if([platform isEqualToString:@"iPhone8,2"])
        return @"iPhone 6s Plus";
    
    if([platform isEqualToString:@"iPhone8,4"])
        return @"iPhone SE";
    
    if([platform isEqualToString:@"iPhone9,1"])
        return @"iPhone 7";
    
    if([platform isEqualToString:@"iPhone9,3"])
        return @"iPhone 7";
    
    if([platform isEqualToString:@"iPhone9,4"])
        return @"iPhone 7 Plus";
    
    if([platform isEqualToString:@"iPhone9,2"])
        return @"iPhone 7 Plus";
    
    if([platform isEqualToString:@"iPhone10,1"])
        return @"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,4"])
        return @"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,2"])
        return @"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,5"])
        return @"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,3"])
        return @"iPhone X";
    
    if([platform isEqualToString:@"iPhone10,6"])
        return @"iPhone X";
    
    if([platform isEqualToString:@"iPhone11,2"])
    return @"iPhone Xs";
    
    if([platform isEqualToString:@"iPhone11,4"])
    return @"iPhone Xs Max";
    
    if([platform isEqualToString:@"iPhone11,6"])
    return @"iPhone Xs Max";
    
    if([platform isEqualToString:@"iPhone11,8"])
    return @"iPhone Xr";
    
    if([platform isEqualToString:@"iPhone12,1"])
    return @"iPhone 11";
    
    if([platform isEqualToString:@"iPhone12,3"])
    return @"iPhone 11 Pro";
    
    if([platform isEqualToString:@"iPhone12,5"])
    return @"iPhone 11 Pro Max";
    
    if([platform isEqualToString:@"iPod1,1"])
        return @"iPod Touch 1G";
    
    if([platform isEqualToString:@"iPod2,1"])
        return @"iPod Touch 2G";
    
    if([platform isEqualToString:@"iPod3,1"])
        return @"iPod Touch 3G";
    
    if([platform isEqualToString:@"iPod4,1"])
        return @"iPod Touch 4G";
    
    if([platform isEqualToString:@"iPod5,1"])
        return @"iPod Touch 5G";
    
    if([platform isEqualToString:@"iPad1,1"])
        return @"iPad 1G";
    
    if([platform isEqualToString:@"iPad2,1"])
        return @"iPad 2";
    
    if([platform isEqualToString:@"iPad2,2"])
        return @"iPad 2";
    
    if([platform isEqualToString:@"iPad2,3"])
        return @"iPad 2";
    
    if([platform isEqualToString:@"iPad2,4"])
        return @"iPad 2";
    
    if([platform isEqualToString:@"iPad2,5"])
        return @"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,6"])
        return @"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,7"])
        return @"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad3,1"])
        return @"iPad 3";
    
    if([platform isEqualToString:@"iPad3,2"])
        return @"iPad 3";
    
    if([platform isEqualToString:@"iPad3,3"])
        return @"iPad 3";
    
    if([platform isEqualToString:@"iPad3,4"])
        return @"iPad 4";
    
    if([platform isEqualToString:@"iPad3,5"])
        return @"iPad 4";
    
    if([platform isEqualToString:@"iPad3,6"])
        return @"iPad 4";
    
    if([platform isEqualToString:@"iPad4,1"])
        return @"iPad Air";
    
    if([platform isEqualToString:@"iPad4,2"])
        return @"iPad Air";
    
    if([platform isEqualToString:@"iPad4,3"])
        return @"iPad Air";
    
    if([platform isEqualToString:@"iPad4,4"])
        return @"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,5"])
        return @"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,6"])
        return @"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,7"])
        return @"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,8"])
        return @"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,9"])
        return @"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad5,1"])
        return @"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,2"])
        return @"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,3"])
        return @"iPad Air 2";
    
    if([platform isEqualToString:@"iPad5,4"])
        return @"iPad Air 2";
    
    if([platform isEqualToString:@"iPad6,3"])
        return @"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,4"])
        return @"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,7"])
        return @"iPad Pro 12.9";
    
    if([platform isEqualToString:@"iPad6,8"])
        return @"iPad Pro 12.9";
    
    if([platform isEqualToString:@"i386"])
        return @"iPhone Simulator";
    
    if([platform isEqualToString:@"x86_64"])
        return @"iPhone Simulator";
    
    return platform;
}

- (NSString *)deviceUniqueIdentifier
{
    NSMutableString *UUIDstring = [[[self identifierForVendor] UUIDString] mutableCopy];
    return UUIDstring;
}

// 获取运营商信息
- (NSString *)getOperatorInfomation
{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    if (carrier == nil) {
        return @"";
    }
    NSString *code = [carrier mobileNetworkCode];
    if (code == nil) {
        return @"";
    }
    if ([code isEqualToString:@"00"] || [code isEqualToString:@"02"] || [code isEqualToString:@"07"]) {
        return @"中国移动";
    } else if ([code isEqualToString:@"01"] || [code isEqualToString:@"06"]) {
        return @"中国联通";
    } else if ([code isEqualToString:@"03"] || [code isEqualToString:@"05"]) {
        return @"中国电信";
    }
    return @"";
}
@end
