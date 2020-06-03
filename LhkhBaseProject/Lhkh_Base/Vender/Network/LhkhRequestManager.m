//
//  LhkhRequestManager.m
//  LhkhBaseDemo
//
//  Created by Lhkh on 2017/4/24.
//  Copyright © 2017年 Lhkh. All rights reserved.
//

#define APIURLStringConnect(a)  [NSString stringWithFormat:@"%@%@",[[LhkhAppSetting sharedAppSetting]getDomainName],a]
#define APIImageURLStringConnect(a)  [NSString stringWithFormat:@"%@%@",[[LhkhAppSetting sharedAppSetting]getImageDomainName],a]

#import "LhkhRequestManager.h"
#import "LhkhAppSetting.h"
#import "LhkhKeyWindowManager.h"
@implementation LhkhRequestManager


#pragma mark - POST_GET
// post
- (void)POST:(NSString *)urlString parameters:(id)parameters completion:(void (^)(LhkhBaseResponse *))completion
{
    if (!([urlString containsString:@"https://aip.baidubce.com"]||[urlString containsString:@"https://graph.qq.com"]||[urlString containsString:@"https://api.weixin.qq.com"])) {//百度ocr接口
        if (parameters == nil) {
            [self request:@"POST" URL:urlString parameters:nil completion:completion];
        }else{
            NSError *error;
            NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:&error];
            NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            [self request:@"POST" URL:urlString parameters:jsonStr completion:completion];
        }
    }else{
        [self request:@"POST" URL:urlString parameters:parameters completion:completion];
    }
}

//get
- (void)GET:(NSString *)urlString parameters:(id)parameters completion:(void (^)(LhkhBaseResponse *))completion
{
    [self request:@"GET" URL:urlString parameters:parameters completion:completion];
}

#pragma mark - post & get
- (void)request:(NSString *)method URL:(NSString *)urlString parameters:(id)parameters completion:(void (^)(LhkhBaseResponse *response))completion
{

    if (!([urlString containsString:@"https://aip.baidubce.com"]||[urlString containsString:@"https://graph.qq.com"]||[urlString containsString:@"https://api.weixin.qq.com"])) {////qq信息 或者百度OCR
        urlString = APIURLStringConnect(urlString);
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }else{
        [self.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    }
    
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    DLog(@"\n\n=======================Request Start=======================\n\n%@\n\n=======================Request Param=======================\n\n%@\n===========================================================\n\n",urlString,parameters);
    if (self.isLocal) {
        [self requestLocal:urlString completion:completion];
        return;
    }
    
    if (self.currentNetworkStatus == AFNetworkReachabilityStatusNotReachable) {
        LhkhBaseResponse *response = [LhkhBaseResponse new];
        response.error = [NSError errorWithDomain:NSCocoaErrorDomain code:-1 userInfo:nil];
        response.errorMsg = @"网络无法连接";
        completion(response);
        LhkhSetUserDefaults(@"0", Lhkh_NewWork);
        return;
    }
    
    
    void(^success)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        [self wrapperTask:task responseObject:responseObject error:nil completion:completion];
    };
    
    void(^failure)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self wrapperTask:task responseObject:nil error:error completion:completion];
    };
    
    
    
    if ([method isEqualToString:@"GET"]) {
        [self GET:urlString parameters:parameters headers:nil progress:nil success:success failure:failure];
    }
    
    
    if ([method isEqualToString:@"POST"]) {
        [self POST:urlString parameters:parameters headers:nil progress:nil success:success failure:failure];
    }
    
}


#pragma mark - 加载本地数据
- (void)requestLocal:(NSString *)urlString completion:(void (^)(LhkhBaseResponse *response))completion
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSError *fileError = nil;
        NSError *jsonError = nil;
        
        NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:[urlString lastPathComponent] withExtension:@"json"];
        
        NSData *jsonData = [NSData dataWithContentsOfURL:fileUrl options:0 error:&fileError];
        
        
        id responseObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
        
        
        [self wrapperTask:nil responseObject:responseObj error:fileError ?: jsonError completion:completion];
        
    });
    
}


#pragma mark - 处理数据
- (void)wrapperTask:(NSURLSessionDataTask *)task responseObject:(id)responseObject error:(NSError *)error completion:(void (^)(LhkhBaseResponse *response))completion
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        LhkhBaseResponse *response = [self convertTask:task responseObject:responseObject error:error];
        
        [self LogResponse:task.currentRequest.URL.absoluteString response:response];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            !completion ?: completion(response);
            
        });
        
    });
    
}

#pragma mark - 包装返回的数据
- (LhkhBaseResponse *)convertTask:(NSURLSessionDataTask *)task responseObject:(id)responseObject error:(NSError *)error
{
    
    LhkhBaseResponse *response = [LhkhBaseResponse new];
    if (responseObject) {
        response.responseObject = responseObject;
    }
    
    if (error) {
        response.error = error;
        response.statusCode = error.code;
        if (response.errorMsg==nil) {
            response.errorMsg = response.responseObject[@"Message"];
        }
    }else{
        if (response.errorMsg==nil) {
            response.errorMsg = response.responseObject[@"Message"];
        }
    }
    
    
    if ([task.response isKindOfClass:[NSHTTPURLResponse class]]) {
        
        NSHTTPURLResponse *HTTPURLResponse = (NSHTTPURLResponse *)task.response;
        response.headers = HTTPURLResponse.allHeaderFields.mutableCopy;
        //接口回调拦截
        if (HTTPURLResponse && HTTPURLResponse.statusCode == 401) {
            response.errorMsg = @"用户授权失效，请重新登录";
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
            });
        }else if (HTTPURLResponse && (HTTPURLResponse.statusCode == 500||HTTPURLResponse.statusCode == 404)){
            response.errorMsg = @"服务器繁忙，请稍后再试";
        }
    }
    
    if (self.responseFormat) {
        response = self.responseFormat(response);
    }
    return response;
}


#pragma mark - 打印返回日志
- (void)LogResponse:(NSString *)urlString response:(LhkhBaseResponse *)response
{
    DLog(@"\n\n=======================API Response========================\n%@\n\n=======================Request End========================\n\n", response);
}



#pragma mark - 上传文件
//  data 图片对应的二进制数据
//  name 服务端需要参数
//  fileName 图片对应名字,一般服务不会使用,因为服务端会直接根据你上传的图片随机产生一个唯一的图片名字
//  mimeType 资源类型
//  不确定参数类型 可以这个 octet-stream 类型, 二进制流
- (void)upload:(NSString *)urlString parameters:(id)parameters images:(NSArray <UIImage*>*)images videos:(NSArray *)videos name:(NSString *)name formDataBlock:(void(^)(id<AFMultipartFormData> formData))formDataBlock progress:(void (^)(NSProgress *progress))progress completion:(void (^)(LhkhBaseResponse *response))completion
{
    NSString *path = @"";
    if ([name containsString:@"Video"]) {
        for (int i=0; i<videos.count; i++) {
            if ([path isEqualToString:@""]) {
                path = [NSString toUpper:[NSString stringWithFormat:@"%@/%@.mp4",name,[self getNowTimeTimestamp]]];
            }else{
                path = [NSString stringWithFormat:@"%@&%@",path,[NSString toUpper:[NSString stringWithFormat:@"%@/%@.mp4",name,[self getNowTimeTimestamp]]]];
            }
        }
    }else{
        for (int i=0; i<images.count; i++) {
            if ([path isEqualToString:@""]) {
                path = [NSString toUpper:[NSString stringWithFormat:@"%@/%@.jpg",name,[self getNowTimeTimestamp]]];
            }else{
                path = [NSString stringWithFormat:@"%@&%@",path,[NSString toUpper:[NSString stringWithFormat:@"%@/%@.jpg",name,[self getNowTimeTimestamp]]]];
            }
        }
    }
    
//    NSString *sign = [[NSString stringWithFormat:@"%@&%@",path,TCAppkey] md5String];
//    NSDictionary *param = @{@"AppId":TCAppId,@"Path":name,@"Sign":sign};
//    DLog(@"param===%@",param);
    
    urlString = APIImageURLStringConnect(urlString);
    
    
    [self POST:urlString parameters:nil headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if ([name containsString:@"Video"]) {
            NSString *mineType = @"video/mp4";
            NSString *pathurl = [NSString stringWithFormat:@"%@",videos.firstObject];
            NSURL *pathUrl = [NSURL URLWithString:pathurl];
            NSData *videoData = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:pathUrl.path]];
            NSString *fileName = [NSString stringWithFormat:@"%@.mp4",[self getNowTimeTimestamp]];
            
            [formData appendPartWithFileData:videoData name:name fileName:fileName mimeType:mineType];
        }else{
            NSString *mineType = @"image/jpeg";
            for (int i = 0; i < images.count; i++) {
               UIImage *image = images[i];
               NSData *imageData = UIImageJPEGRepresentation(image, 0.9);
               NSString *fileName = [NSString stringWithFormat:@"%@.jpg",[self getNowTimeTimestamp]];
                 
               [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:mineType];
            }
        }
        
        !formDataBlock ?: formDataBlock(formData);
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            !progress ?: progress(uploadProgress);
        });
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self wrapperTask:task responseObject:responseObject error:nil completion:completion];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self wrapperTask:task responseObject:nil error:error completion:completion];
        
    }];
    
}

//取当前时间戳
- (NSString *)getNowTimeTimestamp
{
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    return timeSp;
}

#pragma mark - 初始化设置
- (void)configSettings
{
    //设置可接收的数据类型
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", @"application/xml", @"text/xml", @"*/*", nil];

    //设置传递数据类型
//    [self.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [self.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    self.currentNetworkStatus = AFNetworkReachabilityStatusUnknown;
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    [securityPolicy setValidatesDomainName:YES];
    self.securityPolicy = securityPolicy;
    self.requestSerializer.timeoutInterval = 30;
    __weak typeof(self) weakself = self;
    //记录网络状态
    [self.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        weakself.currentNetworkStatus = status;
    }];
    
    [self.reachabilityManager startMonitoring];
    
    //自定义处理数据
    self.responseFormat = ^LhkhBaseResponse *(LhkhBaseResponse *response) {
        return response;
    };
    
}

#pragma mark - 处理返回序列化
- (void)setResponseSerializer:(AFHTTPResponseSerializer<AFURLResponseSerialization> *)responseSerializer
{
    [super setResponseSerializer:responseSerializer];
    
    if ([responseSerializer isKindOfClass:[AFJSONResponseSerializer class]]) {
        AFJSONResponseSerializer *JSONserializer = (AFJSONResponseSerializer *)responseSerializer;
        JSONserializer.removesKeysWithNullValues = YES;
        JSONserializer.readingOptions = NSJSONReadingMutableContainers;
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self configSettings];
    }
    return self;
}

static LhkhRequestManager *_instance = nil;

+ (instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _instance = [[self alloc] init];
    });
    
    return _instance;
}

@end
