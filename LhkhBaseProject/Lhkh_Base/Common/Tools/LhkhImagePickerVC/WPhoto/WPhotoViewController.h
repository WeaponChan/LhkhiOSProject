//
//  WPhotoViewController.h
//  photoDemo
//
//  Created by wangxinxu on 2017/6/1.
//  Copyright © 2017年 wangxinxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myPhotoCell.h"
#import "UIImage+fixOrientation.h"
#import "WPMacros.h"
#import "WPFunctionView.h"
#import "NavView.h"

@interface WPhotoViewController : UIViewController

@property (assign, nonatomic) NSInteger selectPhotoOfMax;/**< 选择照片的最多张数 */
@property (copy, nonatomic) NSString *singleType;//是否是选择单张，是的话选好一张直接返回
/** 回调方法 */
@property (nonatomic, copy) void(^selectPhotosBack)(NSMutableArray *photosArr);

@end
