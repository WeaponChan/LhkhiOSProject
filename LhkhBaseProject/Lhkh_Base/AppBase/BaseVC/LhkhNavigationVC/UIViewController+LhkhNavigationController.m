//
//  UIViewController+LhkhNavigationController.m
//  Lhkh_Base
//
//  Created by Weapon Chen on 2017/3/31.
//  Copyright © 2017 Weapon Chen. All rights reserved.
//

#import "UIViewController+LhkhNavigationController.h"
#import "LhkhNavigationController.h"
#import "UINavigationBar+LhkhNavigationController.h"
#import <objc/runtime.h>

@interface UIViewController ()
@property (weak, nonatomic) LhkhNavigationController *lhkh_navigationController;
@property (strong, nonatomic) LhkhNavigationItem *lhkh_navigation_item;

@end

@implementation UIViewController (LhkhNavigationController)

+ (void)load
{
    [UINavigationBar lhkh_navBar_exchangeInstanceMethod:[self class] originalSel:@selector(viewDidAppear:) newSel:@selector(lhkh_viewDidAppear:)];
    
    [UINavigationBar lhkh_navBar_exchangeInstanceMethod:[self class] originalSel:@selector(navigationItem) newSel:@selector(lhkh_navigationItem)];
    
    [UINavigationBar lhkh_navBar_exchangeInstanceMethod:[self class] originalSel:@selector(setTitle:) newSel:@selector(lhkh_setTitle:)];

}

#pragma mark - 以下为方法替换
- (void)lhkh_setTitle:(NSString *)title
{
    [self lhkh_setTitle:title];
    if (self.lhkh_navigation_item) {
        self.lhkh_navigation_item.title = title;
    }
}

- (void)lhkh_viewDidAppear:(BOOL)animated
{
    [self lhkh_viewDidAppear:animated];
    //只有通过LhkhNavigationController push过来的VC才做此设置
    if (self.lhkh_navigationController) {
        if (self.navigationController.viewControllers.firstObject == self) {
            //在根控制器界面
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }else{
            
            LhkhNavigationController *nav=(LhkhNavigationController*)self.navigationController;
            //不在跟控制界面
            if (nav.cancelGesture) {
                self.navigationController.interactivePopGestureRecognizer.enabled=NO;
            }else{
                self.navigationController.interactivePopGestureRecognizer.enabled = !self.cancelGesture;
            }
        }
    }
}

- (UINavigationItem *)lhkh_navigationItem
{
    if (self.lhkh_navigation_item) {
        return self.lhkh_navigation_item;
    }
    return  [self lhkh_navigationItem];
}

#pragma mark - Private Methods
- (void)bringNavigationBarToFront
{
    [self.view bringSubviewToFront:self.navigationBar];
}

- (void)lhkh_removeNavigationBar
{
    if (self.navigationBar) {
        [self.navigationBar removeFromSuperview];
        self.lhkh_navigation_item=nil;
    }
}
- (void)lhkh_reloadNavigationBar
{
    [self lhkh_removeNavigationBar];
    CGSize size = [UIApplication sharedApplication].statusBarFrame.size;
    LhkhNavigationBar *navigationBar = [[LhkhNavigationBar alloc]init];

    self.edgesForExtendedLayout = UIRectEdgeTop;
    navigationBar.frame = CGRectMake(0, size.height, size.width, 44);
    self.view.lhkh_isViewControllerBaseView=YES;
    
    self.navigationBar = navigationBar;
    [self.view addSubview:navigationBar];
    self.lhkh_navigation_item = [[LhkhNavigationItem alloc]init];
    if (self.lhkh_navigationController.childViewControllers.count>1) {
       self.lhkh_navigation_item.leftBarButtonItem = [UIBarButtonItem lhkh_itemWithImage:@"back_white" highImage:@"back_white" target:self action:@selector(didTapBackButton)];
    }
    navigationBar.items=@[self.lhkh_navigation_item];
}

- (void)didTapBackButton
{
    [self.lhkh_navigationController popViewControllerAnimated:YES];
}

- (UIImage*)lhkh_imageWithColor:(UIColor*)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - 以下为增加属性
- (void)setLhkh_navigation_item:(LhkhNavigationItem *)lhkh_navigation_item
{
     objc_setAssociatedObject(self, @selector(lhkh_navigation_item), lhkh_navigation_item, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (LhkhNavigationItem *)lhkh_navigation_item
{
    return  objc_getAssociatedObject(self, _cmd);
}

- (LhkhNavigationController *)lhkh_navigationController
{
    return  objc_getAssociatedObject(self, _cmd);
}
- (void)setLhkh_navigationController:(LhkhNavigationController *)lhkh_navigationController
{
     objc_setAssociatedObject(self, @selector(lhkh_navigationController), lhkh_navigationController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setNavigationBar:(LhkhNavigationBar *)navigationBar
{
    objc_setAssociatedObject(self, @selector(navigationBar), navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (LhkhNavigationBar *)navigationBar
{
    return  objc_getAssociatedObject(self, _cmd);
}

- (void)setCancelGesture:(BOOL)cancelGesture
{
     objc_setAssociatedObject(self, @selector(cancelGesture), @(cancelGesture), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (!((LhkhNavigationController*)self.navigationController).cancelGesture) {
        //导航控制器没有全局取消 直接设置
        self.navigationController.interactivePopGestureRecognizer.enabled=!cancelGesture;
    }
}

- (BOOL)cancelGesture
{
     return  [objc_getAssociatedObject(self, _cmd) boolValue];
}

@end
