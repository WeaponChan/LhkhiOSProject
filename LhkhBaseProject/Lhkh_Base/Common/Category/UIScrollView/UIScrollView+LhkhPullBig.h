//
//  UIScrollView+LhkhPullBig.h
//  Lhkh_Base
//
//  Created by Weapon Chen on 2020/9/17.
//  Copyright © 2020 Weapon Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (LhkhPullBig)
@property (strong, nonatomic) UIView *bigView;
@property (strong, nonatomic) UIView *headerView;
-(void)setBigView:(UIView *)bigView withHeaderView:(UIView *)headerView;
@end

NS_ASSUME_NONNULL_END
