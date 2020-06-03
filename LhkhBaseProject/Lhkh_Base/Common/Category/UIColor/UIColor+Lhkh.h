//
//  UIColor+Lhkh.h
//  Lhkh_Base
//
//  Created by Weapon on 2018/11/22.
//  Copyright © 2018 Lhkh. All rights reserved.
//

#import <UIKit/UIKit.h>
#define RGBA_COLOR(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]
#define RGB_COLOR(R, G, B) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1.0f]
NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Lhkh)
+ (UIColor *)colorWithHexString:(NSString *)color;
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
+ (UIColor *)randomColor;
@end

NS_ASSUME_NONNULL_END
