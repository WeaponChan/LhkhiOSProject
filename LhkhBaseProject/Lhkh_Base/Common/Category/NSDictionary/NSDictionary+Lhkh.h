//
//  NSDictionary+Lhkh.h
//  Lhkh_Base
//
//  Created by Weapon on 2018/11/26.
//  Copyright © 2018 Lhkh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (Lhkh)
/**
 *  @brief  字典参数加密  服务端的需求  通过接口私钥对访问接口进行加密
 *  @param  dictionary 参数字典 param
 *  @param  secret     秘钥
 *
 */
+ (NSDictionary *)encryption:(NSDictionary *)dictionary withSecret:(NSString *)secret;
@end

NS_ASSUME_NONNULL_END
