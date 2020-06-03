//
//  LhkhAppSetting.m
//  TC
//
//  Created by Weapon Chen on 2019/11/6.
//  Copyright © 2019 YouJie. All rights reserved.
//

#import "LhkhAppSetting.h"

static LhkhAppSetting *instance = nil;

@interface LhkhAppSetting ()

@end
@implementation LhkhAppSetting

#pragma  mark life
+ (instancetype)sharedAppSetting
{
    return [[self alloc] init];
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    if(instance == nil){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance = [super allocWithZone:zone];
        });
    }
    return instance;
}

- (id)init
{
    if(instance == nil){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance = [super init];
        });
    }
    return instance;
}


- (NSString*)getDomainName
{
    NSString *defaultDomainName = LhkhGetUserDefaults(Lhkh_DefaultDomainName);
    if ([defaultDomainName isEqualToString:@""] || defaultDomainName==nil) {
        return LhkhBaseUrl;
    }else{
        return defaultDomainName;
    }
    
}

- (NSString*)getImageDomainName
{
    NSString *defaultImageDomainName = LhkhGetUserDefaults(Lhkh_DefaultImageDomainName);
    if ([defaultImageDomainName isEqualToString:@""] || defaultImageDomainName==nil) {
        return LhkhImageBaseUrl;
    }else{
        return defaultImageDomainName;
    }
}


@end
