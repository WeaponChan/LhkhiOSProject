//
//  UIImage+Lhkh.h
//  Lhkh_Base
//
//  Created by Weapon on 2018/11/22.
//  Copyright © 2018 Lhkh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Lhkh)

/// 返回一张指定颜色的图片
/// @param aColor 颜色
+ (UIImage *)imageWithColor:(UIColor *)aColor;

/// 返回一张指定颜色和尺寸的图片
/// @param aColor 颜色
/// @param aFrame 尺寸
+ (UIImage *)imageWithColor:(UIColor *)aColor withFrame:(CGRect)aFrame;



/** 禁止系统渲染图片 */
+ (UIImage *)renderingModelOriginalWithImageName:(NSString *)imageName;
+ (UIImage *)renderingModelOriginalWithImage:(UIImage *)image;

/** 图片压缩 */
- (UIImage*)scaledToSize:(CGSize)targetSize;
- (UIImage*)scaledToSize:(CGSize)targetSize highQuality:(BOOL)highQuality;
- (UIImage*)scaledToMaxSize:(CGSize )size;

- (NSData *)dataForCodingUpload;
- (NSData *)dataSmallerThan:(NSUInteger)dataLength;


/** 图片旋转问题 */
- (UIImage *)fixOrientation;
@end

NS_ASSUME_NONNULL_END
