//
//  UIBarButtonItem+Lhkh.h
//  Lhkh_Base
//
//  Created by Weapon Chen on 2018/6/2.
//  Copyright © 2018 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (Lhkh)

/**
 设置图片按钮

 @param image 常规图片
 @param highImage 高亮图片
 @param target 点击事件接受者，一般是控制器
 @param action 点击事件方法名
 @return instance
 */
+ (instancetype)lhkh_itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;


/**
 设置文字按钮
 
 @param title 按钮文字
 @param target 点击事件接受者，一般是控制器
 @param action 点击事件方法名
 @return instance
 */
+ (instancetype)lhkh_itemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
