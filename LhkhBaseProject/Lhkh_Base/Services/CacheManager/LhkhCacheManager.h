//
//  LhkhCacheManager.h
//  Lhkh_Base
//
//  Created by Weapon Chen on 2017/11/22.
//  Copyright © 2017 LHKH. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^clearCacheBlock)(void);
NS_ASSUME_NONNULL_BEGIN

@interface LhkhCacheManager : NSObject
//计算单个文件大小
+ (CGFloat)fileSizeAtPath:(NSString *)path;

//计算目录大小
+ (CGFloat)folderSizeAtPath;

//清除缓存
+(void)clearCache:(clearCacheBlock)block;
@end

NS_ASSUME_NONNULL_END
