//
//  LhkhFMDBManager.m
//  TC
//
//  Created by Weapon Chen on 2019/11/6.
//  Copyright © 2019 YouJie. All rights reserved.
//

#import "LhkhFMDBManager.h"
#import "JQFMDB.h"
static LhkhFMDBManager *instance = nil;
@interface LhkhFMDBManager ()

@end
@implementation LhkhFMDBManager
#pragma  mark life
+ (instancetype)sharedFMDBManager
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

//数据库配置
- (void)configDefault
{
    //创建数据库
    JQFMDB *db = [JQFMDB shareDatabase:@"Lhkh.sqlite"];
    //创建表
    if (![db jq_isExistTable:@"xxx"]) {//判断‘xxx’这个表是否存在
        [db jq_createTable:@"xxx" dicOrModel:[NSObject class]];
    }
    DLog(@"沙盒路径:%@", NSHomeDirectory());
}
@end
