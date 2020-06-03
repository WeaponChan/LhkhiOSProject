//
//  UINavigationBar+LhkhNavigationController.h
//  Lhkh_Base
//
//  Created by Weapon Chen on 2017/3/31.
//  Copyright © 2017 Weapon Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
//UIView的level用于在当前view上添加覆盖整个屏幕的view并且不被navigationBar覆盖
typedef NS_ENUM(NSInteger,UIViewLevel){
    UIViewLevelLow=0,
    UIViewLevelMiddle,
    UIViewLevelHigh
};

@class LhkhTopNavigationBar;

@interface UINavigationBar (LhkhNavigationController)

+ (void)lhkh_navBar_exchangeInstanceMethod:(Class) dClass originalSel:(SEL)originalSelector newSel:(SEL)newSelector;

@end

@interface UIView (LhkhNavigationController)

@property (nonatomic,assign) UIViewLevel viewLevel;

//是ViewController的根view
@property (nonatomic,assign) BOOL lhkh_isViewControllerBaseView;

@end
