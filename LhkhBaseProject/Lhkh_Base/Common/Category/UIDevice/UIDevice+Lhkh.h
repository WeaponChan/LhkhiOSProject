//
//  UIDevice+Lhkh.h
//  Lhkh_Base
//
//  Created by Weapon on 2018/11/26.
//  Copyright © 2018 Lhkh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (Lhkh)
/**
 获取当前硬件体系类型
 */
-(NSString *)deviceName;

/**
 获取当前操作系统名
 */
-(NSString *)sysnameName;

/**
 获取网络上的名称
 */
-(NSString *)nodenameName;

/**
 获取当前发布级别
 */
-(NSString *)releaseName;

/**
 获取当前发布版本
 */
-(NSString *)versionName;

/**
 获取手机型号
 */
- (NSString*)iphoneType;

/**
 获取UUID:通用唯一标识符;32位的十六进制序列:8-4-4-4-12
 */
- (NSString *)deviceUniqueIdentifier;

// 获取运营商信息
- (NSString *)getOperatorInfomation;

@end

NS_ASSUME_NONNULL_END
