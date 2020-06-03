//
//  UINavigationBar+Lhkh.h
//  Lhkh_Base
//
//  Created by Weapon Chen on 2018/6/2.
//  Copyright © 2018 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationBar (Lhkh)

/**
 设置全局导航栏样式
 */
- (void)lhkh_setCustomNavigationBarStyle;


/**
 设置导航栏透明
 */
- (void)lhkh_setNavigationBarTransparent;


/**
 隐藏导航栏
 */
- (void)lhkh_hideNavigationBar;


/**
 在导航栏的位置添加一个相同大小的背景view
 */
+ (UIView *)lhkh_addNVBarMaskViewWithSuperView:(UIView *)superView viewColor:(UIColor *)color alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
