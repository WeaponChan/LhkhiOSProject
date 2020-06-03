//
//  NSDate+Lhkh.h
//  Lhkh_Base
//
//  Created by Weapon Chen on 2020/6/2.
//  Copyright © 2020 Weapon Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Lhkh)

- (NSInteger)day;
- (NSInteger)month;
- (NSInteger)year;

/* 从时间戳获取特定格式的时间字符串 */
+ (NSString *)stringWithTimestamp:(NSTimeInterval)tt format:(NSString *)format;


@end

NS_ASSUME_NONNULL_END
