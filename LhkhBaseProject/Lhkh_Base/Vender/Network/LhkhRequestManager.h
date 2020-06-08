//
//  LhkhRequestManager.h
//  LhkhBaseDemo
//
//  Created by Lhkh on 2017/4/24.
//  Copyright © 2017年 Lhkh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LhkhBaseResponse.h"
#import <AFNetworking.h>

typedef enum : NSInteger {
    LhkhRequestManagerStatusCodeCustomDemo = -10000,
} LhkhRequestManagerStatusCode;

typedef LhkhBaseResponse *(^ResponseFormat)(LhkhBaseResponse *response);



@interface LhkhRequestManager : AFHTTPSessionManager


+ (instancetype)sharedManager;

//本地数据模式
@property (assign, nonatomic) BOOL isLocal;

//预处理返回的数据
@property (copy, nonatomic) ResponseFormat responseFormat;

//当前的网络状态
@property (assign, nonatomic) AFNetworkReachabilityStatus currentNetworkStatus;



- (void)POST:(NSString *)urlString parameters:(id)parameters completion:(void (^)(LhkhBaseResponse *response))completion;

- (void)GET:(NSString *)urlString parameters:(id)parameters completion:(void (^)(LhkhBaseResponse *response))completion;


/// 上传图片/视频
/// @param urlString url
/// @param parameters 服务端需要的参数
/// @param images 图片数组
/// @param name 图片类型名称
/// @param formDataBlock 返回数据
/// @param progress 上传进度
/// @param completion 完成上传
- (void)upload:(NSString *)urlString parameters:(id)parameters images:(NSArray <UIImage*>*)images videos:(NSArray *)videos name:(NSString *)name formDataBlock:(void(^)(id<AFMultipartFormData> formData))formDataBlock progress:(void (^)(NSProgress *progress))progress completion:(void (^)(LhkhBaseResponse *response))completion;


@end
