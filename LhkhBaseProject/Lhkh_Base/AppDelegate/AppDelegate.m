//
//  AppDelegate.m
//  Lhkh_Base
//
//  Created by Weapon Chen on 2020/1/1.
//  Copyright © 2020 Weapon Chen. All rights reserved.
//

#import "AppDelegate.h"
#import "LhkhKeyWindowManager.h"
#import "LhkhCatchCrashTool.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
//应用程序启动后进行自定义     
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //注册异常消息处理函数的处理方法
    g_vaildUncaughtExceptionHandler = NSGetUncaughtExceptionHandler();
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    
    [self initWithKeyWindow];
    return YES;
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if (self.fullScreen == YES) {
        return UIInterfaceOrientationMaskAll;
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    if ([url.scheme containsString:@"lhkhlinking"]) {
        DLog(@"%@",url);
        return YES;
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler
{

    //其他第三方回调；
     return YES;
}

#pragma mark - UISceneSession lifecycle
//创建新的场景会话时调用
//使用此方法选择用于创建新场景的配置
- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options API_AVAILABLE(ios(13.0))
{
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}

//当用户放弃场景会话时调用
//如果在应用程序未运行时丢弃了任何会话，则会在application：didFinishLaunchingWithOptions之后不久调用此方法
//使用此方法释放特定于被丢弃场景的任何资源，因为它们不会返回。
- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions API_AVAILABLE(ios(13.0))
{
    
}




//初始化keywindow
- (void)initWithKeyWindow
{
    if (@available(iOS 13.0, *)) {
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [[LhkhKeyWindowManager sharedWindow] showKeyWindowRootVC:self.window];
    }else{
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [[LhkhKeyWindowManager sharedWindow] showKeyWindowRootVC:self.window];
    }
}

@end
