//
//  LhkhCatchCrashTool.h
//  Lhkh_Base
//
//  Created by Weapon Chen on 2020/9/27.
//  Copyright © 2020 Weapon Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
static NSUncaughtExceptionHandler *g_vaildUncaughtExceptionHandler;
NS_ASSUME_NONNULL_BEGIN

@interface LhkhCatchCrashTool : NSObject
void uncaughtExceptionHandler(NSException *exception);
@end

NS_ASSUME_NONNULL_END
