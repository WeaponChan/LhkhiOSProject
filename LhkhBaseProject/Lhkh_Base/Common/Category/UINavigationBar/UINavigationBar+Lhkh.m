//
//  UINavigationBar+Lhkh.m
//  Lhkh_Base
//
//  Created by Weapon Chen on 2018/6/2.
//  Copyright © 2018 LHKH. All rights reserved.
//

#import "UINavigationBar+Lhkh.h"

@implementation UINavigationBar (Lhkh)

- (void)lhkh_setCustomNavigationBarStyle
{
    //代码绘制纯色image
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, NavigationBar_H);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor colorWithHexString:@"f7f7f7"] colorWithAlphaComponent:1].CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //设置backgroundImage
    [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
   
    
    self.translucent = YES;
  
    
    //设置标题字体
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#333333"];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:16];
 
    [self setTitleTextAttributes:dict];
    
    [self setShadowImage:[UIImage new]];
}



- (void)lhkh_setNavigationBarTransparent
{
    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self setShadowImage:[UIImage new]];
}


- (void)lhkh_hideNavigationBar
{
    [self setHidden:YES];
}



+ (UIView *)lhkh_addNVBarMaskViewWithSuperView:(UIView *)superView viewColor:(UIColor *)color alpha:(CGFloat)alpha
{
    CGPoint winPoint = CGPointMake(0, 0);
    winPoint = [[UIApplication sharedApplication].keyWindow.window convertPoint:winPoint toView:superView];
    
    for (UIView *subview in superView.subviews) {
        if (subview.tag == 100) {
            return nil;
        }
    }
    
    UIView *navigationBarTmpMaskView = [[UIView alloc] initWithFrame:CGRectMake(winPoint.x, winPoint.y, Screen_W, NavigationBar_H)];
    [navigationBarTmpMaskView setBackgroundColor:color];
    navigationBarTmpMaskView.alpha = alpha;
    navigationBarTmpMaskView.tag = 100;
    
    [superView addSubview:navigationBarTmpMaskView];

    return navigationBarTmpMaskView;
}

@end
