//
//  LhkhFMDBManager.h
//  TC
//
//  Created by Weapon Chen on 2019/11/6.
//  Copyright © 2019 YouJie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LhkhFMDBManager : NSObject
+ (instancetype)sharedFMDBManager;
- (void)configDefault;
@end

NS_ASSUME_NONNULL_END
