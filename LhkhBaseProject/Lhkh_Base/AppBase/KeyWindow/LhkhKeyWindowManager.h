//
//  LhkhKeyWindowManager.h
//  Lhkh_Base
//
//  Created by Weapon Chen on 2017/3/31.
//  Copyright © 2017 LHKH. All rights reserved.
//                         _0_
//                       _oo0oo_
//                      o8888888o
//                      88" . "88
//                      (| -_- |)
//                      0\  =  /0
//                    ___/`---'\___
//                  .' \\|     |// '.
//                 / \\|||  :  |||// \
//                / _||||| -:- |||||- \
//               |   | \\\  -  /// |   |
//               | \_|  ''\---/''  |_/ |
//               \  .-\__  '-'  ___/-. /
//             ___'. .'  /--.--\  `. .'___
//          ."" '<  `.___\_<|>_/___.' >' "".
//         | | :  `- \`.;`\ _ /`;.`/ - ` : | |
//         \  \ `_.   \_ __\ /__ _/   .-` /  /
//     =====`-.____`.___ \_____/___.-`___.-'=====
//                       `=---='
//*****************************************************
//     ¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥
//         €€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€
//               $$$$$$$$$$$$$$$$$$$$$$$
//                   BUDDHA_BLESS_YOU
//                      AWAY_FROM
//                         BUG
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface LhkhKeyWindowManager : NSObject

+ (instancetype)sharedWindow;

//配置LhkhKeyWindowManager
- (void)showKeyWindowRootVC:(UIWindow*)keyWindow;
//展示登录界面
- (void)showLoginView:(id)target;
//展示业务界面
- (void)showTabBarView;
@end

