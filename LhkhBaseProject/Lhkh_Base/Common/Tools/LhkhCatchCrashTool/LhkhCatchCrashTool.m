//
//  LhkhCatchCrashTool.m
//  Lhkh_Base
//
//  Created by Weapon Chen on 2020/9/27.
//  Copyright © 2020 Weapon Chen. All rights reserved.
//

#import "LhkhCatchCrashTool.h"

@implementation LhkhCatchCrashTool

void uncaughtExceptionHandler(NSException *exception)
{
    // 异常的堆栈信息
    NSArray *stackArray = [exception callStackSymbols];
    // 出现异常的原因
    NSString *reason = [exception reason];
    // 异常名称
    NSString *name = [exception name];
    NSString *exceptionInfo = [NSString stringWithFormat:@"Exception reason：%@\nException name：%@\nException stack：%@",name, reason, stackArray];
    NSLog(@"%@", exceptionInfo);
    
    //这里会崩溃，不知道为啥，后续还需要在研究一下
    g_vaildUncaughtExceptionHandler(exception);
}

@end
