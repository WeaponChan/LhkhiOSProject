//
//  LhkhAPPVersionManager.h
//  TC
//
//  Created by Weapon Chen on 2020/2/11.
//  Copyright © 2020 YouJie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LhkhAPPVersionManager : NSObject
+ (instancetype)shareTipsManager;

- (void)checkVersion:(id)target;
@end

NS_ASSUME_NONNULL_END
