//
//  LhkhAPPVersionView.h
//  TC
//
//  Created by Weapon Chen on 2020/2/11.
//  Copyright © 2020 YouJie. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LhkhAppVersionModel;
@interface LhkhAPPVersionView : UIView
- (void)show;
- (void)dismiss;
- (void)configViewWithModel:(LhkhAppVersionModel*)model;
@end
