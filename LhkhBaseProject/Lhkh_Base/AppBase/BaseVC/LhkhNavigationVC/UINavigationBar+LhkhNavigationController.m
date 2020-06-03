//
//  UINavigationBar+LhkhNavigationController.m
//  Lhkh_Base
//
//  Created by Weapon Chen on 2017/3/31.
//  Copyright © 2017 Weapon Chen. All rights reserved.
//

#import "UINavigationBar+LhkhNavigationController.h"
#import "LhkhNavigationController.h"
#import <objc/runtime.h>

@implementation UINavigationBar (LhkhNavigationController)
+ (void)load
{
    Class dClass=[self class];
    [self lhkh_navBar_exchangeInstanceMethod:dClass originalSel:@selector(pushNavigationItem:) newSel:@selector(lhkh_pushNavigationItem:)];
    [self lhkh_navBar_exchangeInstanceMethod:dClass originalSel:@selector(pushNavigationItem:animated:) newSel:@selector(lhkh_pushNavigationItem:animated:)];
    
}

+ (void)lhkh_navBar_exchangeInstanceMethod : (Class) dClass originalSel :(SEL)originalSelector newSel: (SEL)newSelector
{
    Method originalMethod = class_getInstanceMethod(dClass, originalSelector);
    Method newMethod = class_getInstanceMethod(dClass, newSelector);
    //将 newMethod的实现 添加到系统方法中 也就是说 将 originalMethod方法指针添加成方法newMethod的  返回值表示是否添加成功
    BOOL isAdd = class_addMethod(dClass, originalSelector,
                                 method_getImplementation(newMethod),
                                 method_getTypeEncoding(newMethod));
    //添加成功了 说明 本类中不存在新方法
    //所以此时必须将新方法的实现指针换成原方法的，否则 新方法将没有实现。
    if (isAdd) {
        class_replaceMethod(dClass, newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        //添加失败了 说明本类中 有methodB的实现，此时只需要将originalMethod和newMethod的IMP互换一下即可。
        method_exchangeImplementations(originalMethod, newMethod);
    }
    
}

- (void)lhkh_pushNavigationItem:(UINavigationItem *)item
{
    if ([self isKindOfClass:[LhkhTopNavigationBar class]]) {
        item = [[UINavigationItem alloc]init];
        item.leftBarButtonItem = [UIBarButtonItem new];
    }
    [self lhkh_pushNavigationItem:item];
}

- (void)lhkh_pushNavigationItem:(UINavigationItem *)item animated:(BOOL)animated
{
    if ([self isKindOfClass:[LhkhTopNavigationBar class]]) {
        item = [[UINavigationItem alloc]init];
    }
    [self lhkh_pushNavigationItem:item animated:animated];
}
@end

@implementation UIView (LhkhNavigationController)

+ (void)load
{
    [UINavigationBar lhkh_navBar_exchangeInstanceMethod:[self class] originalSel:@selector(didAddSubview:) newSel:@selector(lhkh_didAddSubview:)];
}
- (BOOL)lhkh_isViewControllerBaseView
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setLhkh_isViewControllerBaseView:(BOOL)lhkh_isViewControllerBaseView
{
    objc_setAssociatedObject(self, @selector(lhkh_isViewControllerBaseView), @(lhkh_isViewControllerBaseView), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setViewLevel:(UIViewLevel)viewLevel
{
    objc_setAssociatedObject(self, @selector(viewLevel), @(viewLevel), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIViewLevel)viewLevel
{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}


- (void)lhkh_didAddSubview:(UIView *)subview
{
    [self lhkh_didAddSubview:subview];
    if (self.lhkh_isViewControllerBaseView) {
        if (subview.viewLevel==UIViewLevelHigh) {
            return;
        }
        UIViewController *vc= (UIViewController*)[self nextResponder];
        if ([vc isKindOfClass:[UIViewController class]]) {
            if(vc.navigationBar){
                [self bringSubviewToFront:vc.navigationBar];
            }
        }
    }
}
@end
