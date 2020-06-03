//
//  LhkhAppAdverManager.h
//  TC
//
//  Created by Weapon Chen on 2020/5/8.
//  Copyright © 2020 YouJie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LhkhAppAdverManager : NSObject
+ (instancetype)shareAdverManager;
- (void)checkAdsWithWindow:(UIWindow*)keyWindow;
- (void)getAds;
@end

NS_ASSUME_NONNULL_END
