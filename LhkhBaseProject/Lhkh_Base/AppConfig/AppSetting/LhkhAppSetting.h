//
//  LhkhAppSetting.h
//  TC
//
//  Created by Weapon Chen on 2019/11/6.
//  Copyright © 2019 YouJie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LhkhAppSetting : NSObject
/*
 *单例-创建LhkhAppSetting*
 */
+ (instancetype)sharedAppSetting;

- (NSString*)getDomainName;
- (NSString*)getImageDomainName;
@end

NS_ASSUME_NONNULL_END
