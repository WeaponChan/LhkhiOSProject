//
//  UIView+Lhkh.h
//  Lhkh_Base
//
//  Created by Weapon on 2018/11/22.
//  Copyright © 2018 Lhkh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Lhkh)
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;

//转化圆角
+ (void)viewToRoundedRectWithView:(UIView*)view corners:(UIRectCorner)corners borderColor:(UIColor*)borderColor fillColor:(UIColor*)fillColor radius:(CGFloat)redius;


/// 画虚线
/// @param lineView view
/// @param lineLength 线的宽度
/// @param lineSpacing 线之间的距离
/// @param lineColor 线的颜色
+ (void)drawDashLine:(UIView *)lineView lineLength:(CGFloat)lineLength lineSpacing:(CGFloat)lineSpacing lineColor:(UIColor *)lineColor;
@end

NS_ASSUME_NONNULL_END
