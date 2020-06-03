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
+ (UIImage *)imageWithColor:(UIColor *)aColor;
+ (UIImage *)imageWithColor:(UIColor *)aColor withFrame:(CGRect)aFrame;
+ (UIImage *)imageWithFileType:(NSString *)fileType;


/** 禁止系统渲染图片 */
+ (UIImage *)js_renderingModelOriginalWithImageName:(NSString *)imageName;
+ (UIImage *)js_renderingModelOriginalWithImage:(UIImage *)image;

- (UIImage*)scaledToSize:(CGSize)targetSize;
- (UIImage*)scaledToSize:(CGSize)targetSize highQuality:(BOOL)highQuality;
- (UIImage*)scaledToMaxSize:(CGSize )size;





- (NSData *)dataSmallerThan:(NSUInteger)dataLength;
- (NSData *)dataForCodingUpload;
@end

NS_ASSUME_NONNULL_END
