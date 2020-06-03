//
//  MBProgressHUD+Lhkh.h
//  Lhkh_Base
//
//  Created by Weapon Chen on 2020/6/2.
//  Copyright © 2020 Weapon Chen. All rights reserved.
//

#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (Lhkh)
//显示图标与信息
+ (void)show:(NSString *__nullable)text icon:(NSString *__nullable)icon view:(UIView *__nullable)view;
+ (void)showSuccess:(NSString *__nullable)success toView:(UIView *__nullable)view;
+ (void)showError:(NSString *__nullable)error toView:(UIView *__nullable)view;
+ (void)showSuccess:(NSString *__nullable)succes;
+ (void)showError:(NSString *__nullable)error;
//只显示提示信息
+ (void)showTips:(NSString *__nullable)tips toView:(UIView *__nullable)view;
+ (void)showTips:(NSString *__nullable)tips;



//显示加载动画
+ (MBProgressHUD *)showHUDwithMessage:(NSString *__nullable)message toView:(UIView *__nullable)view;
+ (MBProgressHUD *)showHUDwithMessage:(NSString *__nullable)message;

+ (void)hideHUDForView:(UIView *__nullable)view;
+ (void)hideHUD;
- (void)hide;
@end

NS_ASSUME_NONNULL_END
