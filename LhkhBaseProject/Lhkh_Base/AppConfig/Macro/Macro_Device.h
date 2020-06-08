//
//  Macro_Device.h
//  Lhkh_Base
//
//  Created by Weapon on 2018/11/19.
//  Copyright © 2018 Lhkh. All rights reserved.
//

#ifndef Macro_Device_h
#define Macro_Device_h

/*********************************************************************************/
/*               AppVersion             */
/*********************************************************************************/
#define APP_VERSON [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]


/*********************************************************************************/
/*               deviceSystemVersion             */
/*********************************************************************************/
#define SYSTEM_VERSION [UIDevice currentDevice].systemVersion.floatValue

#define iOS_8   (SYSTEM_VERSION >= 8.0f  && SYSTEM_VERSION < 9.0f)
#define iOS_9   (SYSTEM_VERSION >= 9.0f  && SYSTEM_VERSION < 10.0f)
#define iOS_10  (SYSTEM_VERSION >= 10.0f && SYSTEM_VERSION < 11.0f)
#define iOS_11  (SYSTEM_VERSION >= 11.0f && SYSTEM_VERSION < 12.0f)
#define iOS_12  (SYSTEM_VERSION >= 12.0f && SYSTEM_VERSION < 13.0f)
#define iOS_13  (SYSTEM_VERSION >= 13.0f && SYSTEM_VERSION < 14.0f)
#define iOS_14  (SYSTEM_VERSION >= 14.0f && SYSTEM_VERSION < 15.0f)
#define iOS_8_Later (SYSTEM_VERSION >= 8.0f)
#define iOS_9_Later (SYSTEM_VERSION >= 9.0f)
#define iOS_10_Later (SYSTEM_VERSION >= 10.0f)
#define iOS_11_Later (SYSTEM_VERSION >= 11.0f)
#define iOS_12_Later (SYSTEM_VERSION >= 12.0f)
#define iOS_13_Later (SYSTEM_VERSION >= 13.0f)
#define iOS_14_Later (SYSTEM_VERSION >= 14.0f)
/*********************************************************************************/
/*               screenSize             */
/*********************************************************************************/


// 是否横竖屏
// 用户界面横屏了才会返回YES
#define IS_LANDSCAPE UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])
// 无论支不支持横屏，只要设备横屏了，就会返回YES
#define IS_DEVICE_LANDSCAPE UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])

// 屏幕宽高度，会根据横竖屏的变化而变化
#define Screen_W        [[UIScreen mainScreen] bounds].size.width
#define Screen_H        [[UIScreen mainScreen] bounds].size.height

// 屏幕宽高度，跟横竖屏无关
#define Device_Screen_W (IS_LANDSCAPE ? Screen_H : Screen_W)
#define Device_Screen_H (IS_LANDSCAPE ? Screen_W : Screen_H)

// iPhone4S 3.5吋
#define IS_iPhone_4S ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

// iPhone5 iPhone5s iPhoneSE 4.0吋
#define IS_iPhone_5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

// iPhone6 7 8  4.7吋
#define IS_iPhone_6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) : NO)

// iPhone6plus  iPhone7plus iPhone8plus 5.5吋
#define IS_iPhone6_Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

// iPhone XR/11 6.1吋
#define IS_iPhoneXr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)

// iPhone X/Xs/11 Pro 5.8吋
#define IS_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

// iPhone Xs Max/11 Pro Max 6.5吋
#define IS_iPhoneXs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

/*********************************************************************************/
/*               iPhone X 以后机型判断             */
/*********************************************************************************/

#define IS_iPhoneX_Later    IS_iPhoneX || IS_iPhoneXr || IS_iPhoneXs_Max


/*********************************************************************************/
/*               statusBar             */
/*********************************************************************************/
#define StatusBar_H \
({\
CGFloat h = 0; \
if (IS_iPhoneX_Later) { \
h = 44.0; \
}else {  \
h = 20.0f;\
} \
(h); \
})


/*********************************************************************************/
/*               tabBar             */
/*********************************************************************************/
#define TabBar_H \
({\
CGFloat h = 0; \
if (IS_iPhoneX_Later) { \
h = 49.0 + 34.0; \
}else {  \
h = 49.0f;\
} \
(h); \
})


/*********************************************************************************/
/*               navigationBar             */
/*********************************************************************************/
#define NavigationBar_H \
({\
CGFloat h = 0; \
if (IS_iPhoneX_Later) { \
h = 44.0 + 44.0; \
}else {  \
h = 44.0 + 20.0;\
} \
(h); \
})

/*********************************************************************************/
/*               当滚动时 改变的导航栏高度             */
/*********************************************************************************/
#define Scroll_H \
({\
CGFloat h = 0; \
if (IS_iPhoneX_Later) { \
h = 50.0; \
}else {  \
h = 44.0;\
} \
(h); \
})


#endif /* Macro_Device_h */
