//
//  UIBarButtonItem+Lhkh.m
//  Lhkh_Base
//
//  Created by Weapon Chen on 2020/6/2.
//  Copyright © 2020 Weapon Chen. All rights reserved.
//

#import "UIBarButtonItem+Lhkh.h"

@implementation UIBarButtonItem (Lhkh)

+ (instancetype)lhkh_itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    view.backgroundColor = Color_Clear;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:Image(image)];
    imageView.center = view.center;
    [view addSubview:imageView];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, view.width, view.height)];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    return [[self alloc] initWithCustomView:view];
}


+ (instancetype)lhkh_itemWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
    [barButtonItem setTintColor:Color_White];
   [barButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16],NSFontAttributeName, nil] forState:UIControlStateNormal];
    return barButtonItem;
}

@end
