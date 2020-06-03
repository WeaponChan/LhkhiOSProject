//
//  UIViewController+LhkhNavigationController.h
//  Lhkh_Base
//
//  Created by Weapon Chen on 2017/3/31.
//  Copyright © 2017 Weapon Chen. All rights reserved.
//
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class LhkhNavigationBar;
@interface UIViewController (LhkhNavigationController)
@property (weak, nonatomic) LhkhNavigationBar *navigationBar;
@property (assign, nonatomic) BOOL cancelGesture; //取消当前页面手势 不影响其他VC手势使用
//创建UINavigationBar 创建一个新UIViewController时如果想带导航栏必须调用此方法创建UINavigationBar
-(void)lhkh_reloadNavigationBar;
//删除UINavigationBar
-(void)lhkh_removeNavigationBar;
//根据UIColor生成UIImage
- (UIImage*)lhkh_imageWithColor:(UIColor*)color;
@end

NS_ASSUME_NONNULL_END
