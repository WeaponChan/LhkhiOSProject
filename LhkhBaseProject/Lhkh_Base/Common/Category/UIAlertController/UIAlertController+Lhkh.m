//
//  UIAlertController+Lhkh.m
//  Lhkh_Base
//
//  Created by Weapon Chen on 2020/6/2.
//  Copyright © 2020 Weapon Chen. All rights reserved.
//

#import "UIAlertController+Lhkh.h"

@implementation UIAlertController (Lhkh)

+ (void)lhkh_alertAviewWithTarget:(id)target
                    andAlertTitle:(NSString *)aTitle
                       andMessage:(NSString *)message
            andDefaultActionTitle:(NSString *)dTitle
                          Handler:(void (^)(UIAlertAction *))handler
                       completion:(void (^)(void))completion
{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:aTitle message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *a = [UIAlertAction actionWithTitle:dTitle style:UIAlertActionStyleDefault handler:handler];
    [alertC addAction:a];
    
    if ([target isKindOfClass:[UIViewController class]]) {
        [target presentViewController:alertC animated:YES completion:completion];
    }
}

+ (void)lhkh_alertAviewWithTarget:(id)target
                    andAlertTitle:(NSString *)aTitle
                       andMessage:(NSString *)message
            andDefaultActionTitle:(NSString *)dTitle
                         dHandler:(void (^)(UIAlertAction *))dhandler
             andCancelActionTitle:(NSString *)cTitle
                         cHandler:(void (^)(UIAlertAction *))chandler
                       completion:(void (^)(void))completion
{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:aTitle message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *a = [UIAlertAction actionWithTitle:dTitle style:UIAlertActionStyleDefault handler:dhandler];
    [alertC addAction:a];
    
    UIAlertAction *c = [UIAlertAction actionWithTitle:cTitle style:UIAlertActionStyleCancel handler:chandler];
    [alertC addAction:c];
    
    if ([target isKindOfClass:[UIViewController class]]) {
        [target presentViewController:alertC animated:YES completion:completion];
    }
}

+ (void)lhkh_alertAviewWithTarget:(id)target
                    andAlertTitle:(NSString *)aTitle
                       andMessage:(NSString *)message
          andtakePhotoActionTitle:(NSString *)takePhotoTitle
                 takePhotoHandler:(void(^)(UIAlertAction *action))takePhotohandler
              andAlbumActionTitle:(NSString *)albumTitle
                     albumHandler:(void(^)(UIAlertAction *action))albumhandler
             andCancelActionTitle:(NSString *)cTitle
                         cHandler:(void(^)(UIAlertAction *action))chandler
                       completion:(void(^)(void))completion
{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:aTitle message:message preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *takePhoto = [UIAlertAction actionWithTitle:takePhotoTitle style:UIAlertActionStyleDefault handler:takePhotohandler];
    [alertC addAction:takePhoto];
    UIAlertAction *album = [UIAlertAction actionWithTitle:albumTitle style:UIAlertActionStyleDefault handler:albumhandler];
    [alertC addAction:album];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:cTitle style:UIAlertActionStyleDefault handler:chandler];
    [alertC addAction:cancel];
    
    if ([target isKindOfClass:[UIViewController class]]) {
        [target presentViewController:alertC animated:YES completion:nil];
    }
}

+ (void)lhkh_alertAviewWithTarget:(id)target
                    andAlertTitle:(NSString *)aTitle
                       andMessage:(NSString *)message
                        andTitles:(NSArray *)titles
                       andHandler:(void(^)(UIAlertAction *action))handler
                       completion:(void(^)(void))completion
{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:aTitle message:message preferredStyle:UIAlertControllerStyleActionSheet];
    for (NSString *title in titles) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:handler];
        [alertC addAction:action];
    }
    if ([target isKindOfClass:[UIViewController class]]) {
        [target presentViewController:alertC animated:YES completion:nil];
    }
}


@end
