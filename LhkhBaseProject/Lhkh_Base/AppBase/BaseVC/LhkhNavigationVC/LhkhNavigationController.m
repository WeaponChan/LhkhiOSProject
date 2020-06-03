//
//  LhkhNavigationController.m
//  Lhkh_Base
//
//  Created by Weapon Chen on 2017/3/31.
//  Copyright © 2017 Weapon Chen. All rights reserved.
//

#import "LhkhNavigationController.h"
#import <objc/runtime.h>

@interface LhkhNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIPanGestureRecognizer *panRecognizer;

@end

@implementation LhkhNavigationController

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationBar.hidden = YES;
    LhkhTopNavigationBar *navbar=[[LhkhTopNavigationBar alloc]init] ;
    navbar.hidden = NO;
    [self setValue:navbar forKeyPath:@"_navigationBar"];
    self.interactivePopGestureRecognizer.delegate=self;
}

#pragma mark - Private Methods
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [viewController  setValue:self forKeyPath:@"lhkh_navigationController"];
    if (self.viewControllers.count>=1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


- (void)setCancelGesture:(BOOL)cancelGesture
{
    _cancelGesture = cancelGesture;
    self.interactivePopGestureRecognizer.enabled = !cancelGesture;
}

@end

@implementation LhkhTopNavigationBar

@end

@implementation LhkhNavigationBar

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.barTintColor = Color_NaviBg;
    //title颜色和字体
    self.titleTextAttributes = @{NSForegroundColorAttributeName:Color_White,  NSFontAttributeName:systemFontRegular(20)};
    for (UIView *view in self.subviews) {
        NSString *className = NSStringFromClass([view class]);
        if ([className containsString:@"_UIBarBackground"]||[className containsString:@"_UINavigationBarBackground"]) {
            CGFloat height = [UIApplication sharedApplication].statusBarFrame.size.height;
            CGRect frame = self.bounds;
            frame.size.height = self.frame.size.height+height;
            frame.origin.y =-height;
            view.frame = frame;
        }
    }
}
@end

@implementation LhkhNavigationItem

- (void)setLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem
{
    //解决ios11以下系统 设置leftBarButtonItem不显示问题 通过延迟也可以解决 但是此方法不用延时也可以解决
    dispatch_async(dispatch_get_main_queue(), ^{
        [super setLeftBarButtonItem:leftBarButtonItem];
    });
}

@end
