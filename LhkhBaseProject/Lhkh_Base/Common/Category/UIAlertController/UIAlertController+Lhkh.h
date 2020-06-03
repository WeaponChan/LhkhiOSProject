//
//  UIAlertController+Lhkh.h
//  Lhkh_Base
//
//  Created by Weapon Chen on 2020/6/2.
//  Copyright © 2020 Weapon Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertController (Lhkh)
/**
 创建只有一个默认action的alertView
 */
+ (void)lhkh_alertAviewWithTarget:(id __nullable)target
                    andAlertTitle:(NSString *__nullable)aTitle
                       andMessage:(NSString *__nullable)message
            andDefaultActionTitle:(NSString *__nullable)dTitle
                          Handler:(void(^)(UIAlertAction *action))handler
                       completion:(void(^)(void))completion;


/**
 创建有一个 default 和 cancel 的alertView
 */
+ (void)lhkh_alertAviewWithTarget:(id __nullable)target
                    andAlertTitle:(NSString *__nullable)aTitle
                       andMessage:(NSString *__nullable)message
            andDefaultActionTitle:(NSString *__nullable)dTitle
                         dHandler:(void(^)(UIAlertAction *action))dhandler
             andCancelActionTitle:(NSString *__nullable)cTitle
                         cHandler:(void(^)(UIAlertAction *action))chandler
                       completion:(void(^)(void))completion;


/**
创建拍照 actionSheet
*/
+ (void)lhkh_alertAviewWithTarget:(id __nullable)target
                    andAlertTitle:(NSString *__nullable)aTitle
                       andMessage:(NSString *__nullable)message
          andtakePhotoActionTitle:(NSString *__nullable)takePhotoTitle
                 takePhotoHandler:(void(^)(UIAlertAction *action))takePhotohandler
              andAlbumActionTitle:(NSString *__nullable)albumTitle
                     albumHandler:(void(^)(UIAlertAction *action))albumhandler
             andCancelActionTitle:(NSString *__nullable)cTitle
                         cHandler:(void(^)(UIAlertAction *action))chandler
                       completion:(void(^)(void))completion;

/**
创建 actionSheet
*/
+ (void)lhkh_alertAviewWithTarget:(id __nullable)target
                    andAlertTitle:(NSString *__nullable)aTitle
                       andMessage:(NSString *__nullable)message
                        andTitles:(NSArray *__nullable)titles
                       andHandler:(void(^)(UIAlertAction *action))handler
                       completion:(void(^)(void))completion;
@end

NS_ASSUME_NONNULL_END
