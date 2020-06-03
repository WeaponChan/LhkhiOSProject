//
//  UIButton+Lhkh.h
//  UEHTML
//
//  Created by LHKH on 2017/10/2.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Lhkh)

/// 更改图片和文字位置
- (void)changeImageAndTitle;
/// 图片文字居中
/// @param space 图片和文字之间的距离
- (void)centerImageAndTitleWithSpace:(float)space;

/// 加载一张网络图片并设置size
/// @param urlStr 图片地址
/// @param size 图片size
- (void)lhkh_setButtonImageWithUrl:(NSString *)urlStr size:(CGSize)size;

@end
