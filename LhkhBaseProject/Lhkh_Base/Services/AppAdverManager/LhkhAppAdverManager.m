//
//  LhkhAppAdverManager.m
//  TC
//
//  Created by Weapon Chen on 2020/5/8.
//  Copyright © 2020 YouJie. All rights reserved.
//

#import "LhkhAppAdverManager.h"
#import "LhkhKeyWindowManager.h"
#import "LhkhWelcomeViewController.h"
@implementation LhkhAppAdverManager
static LhkhAppAdverManager *instance = nil;
+ (instancetype)shareAdverManager
{
    return [[self alloc] init];
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    if(instance == nil){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance = [super allocWithZone:zone];
        });
    }
    return instance;
}

- (id)init
{
    if(instance == nil){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance = [super init];
        });
    }
    return instance;
}

- (void)checkAdsWithWindow:(UIWindow *)keyWindow
{
    // 1.判断沙盒中是否存在广告图片，如果存在，直接显示
    NSString *filePath = [self getFilePathWithImageName:[[NSUserDefaults standardUserDefaults]valueForKey:adImageName]];
    BOOL isExist = [self isFileExistWithFilePath:filePath];
    if (isExist) {// 图片存在
        LhkhWelcomeViewController *vc = [LhkhWelcomeViewController new];
        [vc welcomeViewStartAnimationWithData:filePath];
        keyWindow.rootViewController = vc;
        vc.block = ^{
            [[LhkhKeyWindowManager sharedWindow]showTabBarView];
        };
    }else{
        [[LhkhKeyWindowManager sharedWindow]showTabBarView];
    }
    // 2.无论沙盒中是否存在广告图片，都需要重新调用广告接口，判断广告是否更新
    [self getAds];
}

//获取启动图片
- (void)getAds
{
//    [TCCommonApiManager getStartupItemsWithResult:^(NSArray * _Nonnull data, NSString * _Nonnull resultCode) {
//        if (data&&data.count>0) {
//            NSDictionary *dic = data.firstObject;
//            NSString *imageUrl = dic[@"PicUrl"];
//            NSString *linkUrl = dic[@"LinkUrl"];
//            NSArray *imageUrlsArr = [imageUrl componentsSeparatedByString:@"/"];
//            NSString *imageName = imageUrlsArr.lastObject;
//            // 拼接沙盒路径
//            NSString *filePath = [self getFilePathWithImageName:imageName];
//            BOOL isExist = [self isFileExistWithFilePath:filePath];
//            if (!isExist){// 如果该图片不存在，则删除老图片，下载新图片
//                [self downloadAdImageWithUrl:imageUrl imageName:imageName urls:linkUrl];
//            }
//        }
//    }];
}

/**
 *  判断文件是否存在
 */
- (BOOL)isFileExistWithFilePath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = FALSE;
    return [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
}

/**
 *  下载新图片
 */
- (void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName urls:(NSString*)urls
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        UIImage *image = [UIImage imageWithData:data];
        NSString *filePath = [self getFilePathWithImageName:imageName]; // 保存文件的名称
        if ([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {// 保存成功
            DLog(@"保存成功");
            [self deleteOldImage];
            [[NSUserDefaults standardUserDefaults] setValue:imageName forKey:adImageName];
            [[NSUserDefaults standardUserDefaults] setValue:urls forKey:adUrl];
            [[NSUserDefaults standardUserDefaults] synchronize];
            // 如果有广告链接，将广告链接也保存下来
        }else{
            DLog(@"保存失败");
        }
    });
}

/**
 *  删除旧图片
 */
- (void)deleteOldImage
{
    NSString *imageName = [[NSUserDefaults standardUserDefaults]valueForKey:adImageName];
    if (imageName) {
        NSString *filePath = [self getFilePathWithImageName:imageName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filePath error:nil];
        DLog(@"删除成功");
    }
}

/**
 *  根据图片名拼接文件路径
 */
- (NSString *)getFilePathWithImageName:(NSString *)imageName
{
    if (imageName) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imageName];
        return filePath;
    }
    return nil;
}
@end
