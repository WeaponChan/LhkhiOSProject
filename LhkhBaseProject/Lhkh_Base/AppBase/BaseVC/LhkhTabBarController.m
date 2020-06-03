//
//  LhkhTabBarController.m
//  Lhkh_Base
//
//  Created by Weapon Chen on 2017/3/31.
//  Copyright © 2017 Weapon Chen. All rights reserved.
//

#import "LhkhTabBarController.h"
#import "LhkhNavigationController.h"
#import "LhkhMainVC.h"
@interface LhkhTabBarController ()<UITabBarControllerDelegate>
@property(strong, nonatomic)LhkhNavigationController *mainNavc;

@end

@implementation LhkhTabBarController

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = Color_White;
    self.delegate = self;
    [[UITabBar appearance] setBarTintColor:Color_White];
    [UITabBar appearance].translucent = NO;//防止返回到有tabbar的页面时出现tabBar偏移
    [UITabBar appearance].clipsToBounds = YES;//是否去掉上面那根横线
    [self setupChildVC];
}


#pragma mark - Layout SubViews
- (void)setSubView
{
    
}

#pragma mark - System Delegate
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
//    if ([tabBarController.selectedViewController isEqual:[LhkhBaseViewController class]]) {
//        // 判断再次选中的是否为当前的控制器
//        if ([viewController isEqual:tabBarController.selectedViewController]) {
//            // 执行操作
//
//        }
//    }
}

//这个是UITabBarController的代理方法
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    //判断哪个界面要需要再次点击刷新，这里以第一个VC为例
//    if ([tabBarController.selectedViewController isEqual:[LhkhBaseViewController class]]) {
//        // 判断再次选中的是否为当前的控制器
//        if ([viewController isEqual:tabBarController.selectedViewController]) {
//            // 执行操作
//            return NO;
//        }
//    }
    return YES;
}

#pragma mark - Custom Delegate


#pragma mark - Event Response


#pragma mark - Network Requests


#pragma mark - Public Methods


#pragma mark - Private Methods
- (void)setupChildVC
{
    LhkhMainVC *mainVC = [LhkhMainVC new];
    self.mainNavc = [[LhkhNavigationController alloc] initWithRootViewController:mainVC];
    [self setupChildVC: self.mainNavc title:@"主页" unselectedimage:@"tabBar_home" selectedImage:@"tabBar_homeSel"];
}


- (void)setupChildVC:(UINavigationController *)viewController title:(NSString *)title unselectedimage:(NSString *)image selectedImage:(NSString *)selectedImage
{
    viewController.tabBarItem.title = title;
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:Color_Theme_Red,NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateSelected];
    
    viewController.tabBarItem.image = viewController.tabBarItem.selectedImage = [UIImage js_renderingModelOriginalWithImageName:image];
    viewController.tabBarItem.selectedImage = [UIImage js_renderingModelOriginalWithImageName:selectedImage];
    
    [self addChildViewController:viewController];
}

#pragma mark - Setters


#pragma mark - Getters


@end
