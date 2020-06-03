//
//  LhkhKeyWindowManager.m
//  Lhkh_Base
//
//  Created by Weapon Chen on 2017/3/31.
//  Copyright © 2017 Weapon Chen. All rights reserved.
//

#import "LhkhKeyWindowManager.h"
#import "LhkhNewFeatureVC.h"
#import "LhkhNavigationController.h"
#import "LhkhTabBarController.h"
#import "LhkhMainVC.h"
#import "LhkhAppAdverManager.h"
@interface LhkhKeyWindowManager ()
@property (nonatomic, strong) UIWindow *keyWindow;
@end
static LhkhKeyWindowManager *instance = nil;
@implementation LhkhKeyWindowManager
#pragma  mark life
+ (instancetype)sharedWindow
{
    return [[self alloc] init];
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    if(instance == nil){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance = [super allocWithZone:zone];
        });
    }
    return instance;
}

- (id)init
{
    if(instance == nil){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance = [super init];
        });
    }
    return instance;
}



#pragma public mothed
- (void)showKeyWindowRootVC:(UIWindow*)window
{
    self.keyWindow = window;
    self.keyWindow.backgroundColor = Color_White;
//    BOOL isShow = [LhkhNewFeatureVC canShowNewFeature];
//    if(isShow){
//        if (IS_iPhoneX_Later) {
//            LhkhNewFeatureModel *m1 = [LhkhNewFeatureModel model:Image(@"fature-1-x")];
//            LhkhNewFeatureModel *m2 = [LhkhNewFeatureModel model:Image(@"fature-2-x")];
//            LhkhNewFeatureModel *m3 = [LhkhNewFeatureModel model:Image(@"fature-3-x")];
//
//            self.keyWindow.rootViewController = [LhkhNewFeatureVC newFeatureVCWithModels:@[m1,m2,m3] enterBlock:^{
//                [self showTabBarView];
//            }];
//        }else{
//            LhkhNewFeatureModel *m1 = [LhkhNewFeatureModel model:Image(@"fature-1")];
//            LhkhNewFeatureModel *m2 = [LhkhNewFeatureModel model:Image(@"fature-2")];
//            LhkhNewFeatureModel *m3 = [LhkhNewFeatureModel model:Image(@"fature-3")];
//
//            self.keyWindow.rootViewController = [LhkhNewFeatureVC newFeatureVCWithModels:@[m1,m2,m3] enterBlock:^{
//                [self showTabBarView];
//            }];
//        }
//        [[LhkhAppAdverManager shareAdverManager] getAds];//第一次下载一下启动图
//    }else{
//        [[LhkhAppAdverManager shareAdverManager] checkAdsWithWindow:window];
//    }
    [self showNavigationView];
}

//登录界面
- (void)showLoginView:(id)target
{
    
}

//带tabBar主页面
- (void)showTabBarView
{
    LhkhTabBarController *tabBarVC = [[LhkhTabBarController alloc] init];
    self.keyWindow.rootViewController = tabBarVC;
    [self.keyWindow makeKeyAndVisible];
}

//不带tabBar主页面
- (void)showNavigationView
{
    LhkhMainVC *mainVC = [[LhkhMainVC alloc] init];
    LhkhNavigationController *mainNVC = [[LhkhNavigationController alloc]init];
    [mainNVC addChildViewController:mainVC];
    self.keyWindow.rootViewController = mainNVC;
    [self.keyWindow makeKeyAndVisible];
}



@end
