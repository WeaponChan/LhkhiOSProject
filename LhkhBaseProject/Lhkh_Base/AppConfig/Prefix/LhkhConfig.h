//
//  LhkhConfig.h
//  Lhkh_Base
//
//  Created by Weapon on 2018/11/21.
//  Copyright © 2018 Lhkh. All rights reserved.
//

#ifndef LhkhConfig_h
#define LhkhConfig_h


//弱引用/强引用
#define LhkhWeakSelf(type)  __weak typeof(type) weak##type = type
#define LhkhStrongSelf(type)  __strong typeof(type) strong##type = weak##type;

//字符拼接
#define StringConnect(a,b)  [NSString stringWithFormat:@"%@%@",a,b]


//输出日志
#ifdef DEBUG
#define DLog(FORMAT, ...) fprintf(stderr,"File:%s Line%d Log: %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define DLog(FORMAT, ...)
#endif

//圆角 图层颜色
#define LhkhViewCorner(view,radius)\
view.layer.cornerRadius = radius;\
view.layer.masksToBounds = YES;

#define LhkhViewBorder(view,borderWidth,borderColor)\
view.layer.borderColor = borderColor.CGColor;\
view.layer.borderWidth = borderWidth;


//是否为空  nil  null
#define LhkhNotNilAndNull(_ref)  (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]))
#define LhkhIsNilOrNull(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))
//字符串是否为空
#define LhkhStrIsNotEmpty(_ref)     (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]) && (![(_ref)isEqualToString:@""]))
//数组是否为空
#define LhkhArrIsNotEmpty(_ref) (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]) && ([(_ref) count] > 0))
//字典是否包含某个key
#define LhkhDicSafeValue(_dic,_key) ([[_dic allKeys]containsObject:_key] ? [_dic objectForKey:_key] : nil)


//获得当前的年份
#define  LhkhCurrentYear [[NSCalendar currentCalendar] component:NSCalendarUnitYear fromDate:[NSDate date]]
//获得当前的月份
#define  LhkhCurrentMonth [[NSCalendar currentCalendar] component:NSCalendarUnitMonth fromDate:[NSDate date]]
//获得当前的日期
#define  LhkhCurrentDay  [[NSCalendar currentCalendar] component:NSCalendarUnitDay fromDate:[NSDate date]]
//获得当前的小时
#define  LhkhCurrentHour [[NSCalendar currentCalendar] component:NSCalendarUnitHour fromDate:[NSDate date]]
//获得当前的分
#define  LhkhCurrentMin [[NSCalendar currentCalendar] component:NSCalendarUnitMinute fromDate:[NSDate date]]
//获得当前的秒
#define  LhkhCurrentSec [[NSCalendar currentCalendar] component:NSCalendarUnitSecond fromDate:[NSDate date]]

//GCD - 在Main线程上运行
#define LhkhMainThread(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);
//GCD - 开启异步线程
#define LhkhGlobalThread(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlocl);

//APP对象 （单例对象）
#define LhkhApplication [UIApplication sharedApplication]
//主窗口 （keyWindow）
#define LhkhKeyWindow\
//UIWindow *window = nil;\
//if (@available(iOS 13.0, *))\
//{\
//    for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes)\
//    {\
//        if (windowScene.activationState == UISceneActivationStateForegroundActive)\
//        {\
//            window = windowScene.windows.firstObject;\
//            break;\
//        }\
//    }\
//}else{\
//    window = [UIApplication sharedApplication].keyWindow;\
//}\

//APP对象的delegate
#define LhkhAppDelegate LhkhApplication.delegate

#define pageSize               @10 //分页一页数量
#endif /* LhkhConfig_h */
