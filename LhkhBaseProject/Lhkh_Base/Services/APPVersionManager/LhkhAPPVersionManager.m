//
//  LhkhAPPVersionManager.m
//  TC
//
//  Created by Weapon Chen on 2020/2/11.
//  Copyright © 2020 YouJie. All rights reserved.
//

#import "LhkhAPPVersionManager.h"
#import "LhkhAPPVersionView.h"
#import "LhkhAppVersionModel.h"
@implementation LhkhAPPVersionManager
static LhkhAPPVersionManager *instance = nil;

+ (instancetype)shareTipsManager
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
/***************************************************************/


//检查版本更新
- (void)checkVersion:(id)target
{
//    NSDictionary *param = @{@"appSys":@"ios"};
//    [TCCommonApiManager checkAppVersionWithParameters:param result:^(LhkhAppVersionModel * _Nonnull model, NSString * _Nonnull resultCode) {
//        NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
//        NSString *currentVersion = infoDic[@"CFBundleShortVersionString"];
//        currentVersion = [currentVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
//        NSString *appStoreVersion = model.AppVersion;
//        float cv = [currentVersion floatValue];
//        float av = [appStoreVersion floatValue];
//        
//        NSString *localappCancel = LhkhGetUserDefaults(Lhkh_AppVersionCancel);
//        NSString *localappVersion = LhkhGetUserDefaults(Lhkh_AppVersion);
//        
//        if(cv < av){
//            LhkhSetUserDefaults(@"0", Lhkh_AppIsNewestVersion);
//            if ([model.IsMust isEqualToString:@"1"]) {
//                LhkhAPPVersionView *appV = [[LhkhAPPVersionView alloc] initWithFrame:CGRectMake(0, 0, Screen_W, Screen_H)];
//                [appV configViewWithModel:model];
//                [appV show];
//            }else{
//                if (LhkhStrIsNotEmpty(localappVersion)) {
//                    if ([localappVersion isEqual:appStoreVersion]) {//服务器版本号和本地存储的上一次版本号一致
//                        if ([localappCancel isEqualToString:@"1"]) {//用户忽略了此次升级
//                            return ;
//                        }
//                    }else{//服务器版本号和本地存储的上一次版本号不一致，则有新的更新需重置本地存储版本号和忽略更新
//                        LhkhSetUserDefaults(@"0", Lhkh_AppVersionCancel);
//                        LhkhSetUserDefaults(model.AppVersion, Lhkh_AppVersion);
//                    }
//                }else{//本地没有记录，更新本地存储版本号和忽略更新
//                    LhkhSetUserDefaults(@"0", Lhkh_AppVersionCancel);
//                    LhkhSetUserDefaults(model.AppVersion, Lhkh_AppVersion);
//                }
//                
//                LhkhAPPVersionView *appV = [[LhkhAPPVersionView alloc] initWithFrame:CGRectMake(0, 0, Screen_W, Screen_H)];
//                [appV configViewWithModel:model];
//                [appV show];
//            }
//            
//        }else{
//            LhkhSetUserDefaults(@"1", Lhkh_AppIsNewestVersion);
//        }
//    }];
//    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
//    NSString *currentVersion = infoDic[@"CFBundleShortVersionString"];  //currentVersion为当前工程项目版本号
//    NSError *error;
//    NSData *response = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/lookup?id=1435023397"]] returningResponse:nil error:nil];
//
//    if (response == nil) {
//        [UIAlertController js_alertAviewWithTarget:target andAlertTitle:@"提示！" andMessage:@"由于网络问题，无法在线检测App版本信息，即将退出程序" andDefaultActionTitle:@"确定" Handler:^(UIAlertAction *action) {
//            exit(0);
//        } completion:^{
//
//        }];
//        return;
//    }
//    NSDictionary *appInfoDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
//    if (error) {
//        DLog(@"hsUpdateAppError:%@",error);
//        return;
//    }
//
//    DLog(@"可输出一下看看%@",appInfoDic);
//    NSArray *array = appInfoDic[@"results"];
//    if (array.count < 1) {
//        DLog(@"此APPID为未上架的APP或者查询不到");
//        return;
//    }
//    NSDictionary *dic = array[0];
//
//    //商店版本号
//    NSString *appStoreVersion = dic[@"version"];
//
//    DLog(@"当前版本号:%@\n商店版本号:%@",currentVersion,appStoreVersion);
//    //设置版本号，主要是为了区分不同的版本，比如有1.2.1、1.2、1.31各种类型
//
//
//    currentVersion = [currentVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
//
//    if (currentVersion.length == 2) {
//        currentVersion  = [currentVersion stringByAppendingString:@"0"];
//    }else if (currentVersion.length == 1){
//        currentVersion  = [currentVersion stringByAppendingString:@"00"];
//    }
//
//    appStoreVersion = [appStoreVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
//
//    if (appStoreVersion.length == 2) {
//        appStoreVersion  = [appStoreVersion stringByAppendingString:@"0"];
//    }else if (appStoreVersion.length == 1){
//        appStoreVersion  = [appStoreVersion stringByAppendingString:@"00"];
//    }
//
//
//    //4当前版本号小于商店版本号,就更新
//    if([currentVersion floatValue] < [appStoreVersion floatValue])
//    {
//        //强制更新
//        /*
//        [UIAlertController js_alertAviewWithTarget:target andAlertTitle:@"发现新版本！" andMessage:[NSString stringWithFormat:@"检测到新版本(%@)，为了更好地用户体验，请前往appStore更新！",dic[@"version"]] andDefaultActionTitle:@"立即更新" Handler:^(UIAlertAction *action) {
//            //此处加入应用在app store的地址，方便用户去更新，一种实现方式如下
//            //https://itunes.apple.com/cn/app/%E8%84%B8%E7%A2%91/id1435023397?mt=8
//            NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/%E8%84%B8%E7%A2%91/id1435023397?mt=8"];
//            [[UIApplication sharedApplication] openURL:url];
//        } completion:^{
//        }];*/
//
//        //非强制更新
//        [UIAlertController js_alertAviewWithTarget:target andAlertTitle:@"发现新版本！" andMessage:[NSString stringWithFormat:@"检测到新版本(%@)，为了更好地用户体验，请前往appStore更新！",dic[@"version"]] andDefaultActionTitle:@"立即更新" dHandler:^(UIAlertAction *action) {
//            //此处加入应用在app store的地址，方便用户去更新，一种实现方式如下
//            //https://itunes.apple.com/cn/app/%E8%84%B8%E7%A2%91/id1435023397?mt=8
//            NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/%E8%84%B8%E7%A2%91/id1435023397?mt=8"];
//            [[UIApplication sharedApplication] openURL:url];
//        } andCancelActionTitle:@"取消" cHandler:^(UIAlertAction *action) {
//
//        } completion:nil];
//    }else{
//        DLog(@"版本号好像比商店大噢!检测到不需要更新");
//    }
}
@end
