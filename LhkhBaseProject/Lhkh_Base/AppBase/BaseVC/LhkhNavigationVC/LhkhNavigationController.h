//
//  LhkhNavigationController.h
//  Lhkh_Base
//
//  Created by Weapon Chen on 2017/3/31.
//  Copyright © 2017 Weapon Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+LhkhNavigationController.h"
#import "UINavigationBar+LhkhNavigationController.h"
@interface LhkhNavigationController : UINavigationController
//禁用整个导航控制器手势 如果想在启用必须再设置为NO
@property (assign, nonatomic) BOOL cancelGesture;
@end


@interface LhkhTopNavigationBar : UINavigationBar

@end

@interface LhkhNavigationBar : UINavigationBar

@end

@interface LhkhNavigationItem : UINavigationItem

@end
