//
//  UIViewController+Lhkh.m
//  Lhkh_Base
//
//  Created by Weapon Chen on 2018/1/10.
//  Copyright © 2018 LHKH. All rights reserved.
//

#import "UIViewController+Lhkh.h"

@implementation UIViewController (Lhkh)
/**  在主线程执行操作*/
- (void)performSelectorOnMainThread:(void(^)(void))block
{
    if ([[NSThread currentThread] isMainThread]) {
        block();
    }else{
        dispatch_sync(dispatch_get_main_queue(), ^{
            block();
        });
    }
}

/**  退出 presentViewController  count：次数*/
- (void)dismissViewControllerWithCount:(NSInteger)count animated:(BOOL)animated
{
    count--;
    // 不是自己，并且自己弹出过VC， 递归交给自己弹出的VC处理
    if (count>0 && self.presentingViewController) {
        [self.presentingViewController dismissViewControllerWithCount:count animated:animated];
    }
    else{
        [self dismissViewControllerAnimated:animated completion:nil];
    }
}

/**  退出 presentViewController 到指定的控制器*/
- (void)dismissToViewControllerWithClassName:(NSString *)className animated:(BOOL)animated
{
    // 不是自己，并且自己弹出过VC， 递归交给自己弹出的VC处理
    if (![self.class isKindOfClass:NSClassFromString(className)] && self.presentingViewController) {
        [self.presentingViewController dismissToViewControllerWithClassName:className animated:animated];
    }else{
        [self dismissViewControllerAnimated:animated completion:nil];
    }
}

@end
