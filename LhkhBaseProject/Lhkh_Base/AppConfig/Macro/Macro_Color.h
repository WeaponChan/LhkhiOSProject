//
//  Macro_Color.h
//  Lhkh_Base
//
//  Created by Weapon on 2018/11/19.
//  Copyright © 2018 Lhkh. All rights reserved.
//

#ifndef Macro_Color_h
#define Macro_Color_h


#define COLOR_ALPHA(R,G,B,A)        [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define COLOR(R,G,B)                [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]
//随机颜色
#define Color_arc4Random [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

/*********************************************************************************/
/*             基本颜色                */
/*********************************************************************************/
#define Color_NaviBg                [UIColor colorWithHexString:@"#ED6D00"]      //app导航栏背景色
#define Color_MainBg                [UIColor colorWithHexString:@"#F0F0F0"]      //主背景色
#define Color_MainText              [UIColor colorWithHexString:@"#333333"]      //标题、正文等主要文字
#define Color_SubText               [UIColor colorWithHexString:@"#666666"]      //辅助、默认等主要文字
#define Color_TipText               [UIColor colorWithHexString:@"#999999"]      //提示性文字
#define Color_Line                  [UIColor colorWithHexString:@"#F0F0F0"]      //分割线
#define Color_viewBg                [UIColor colorWithHexString:@"#CCCCCC"]      //view背景色

/*********************************************************************************/
/*             APP内基本配色              */
/*********************************************************************************/
#define Color_Theme_Blue            [UIColor colorWithHexString:@"#0000FF"]//APP元素色——深蓝
#define Color_Theme_WBlue           [UIColor colorWithHexString:@"#00A2E9"]//APP元素色——浅蓝
#define Color_Theme_Red             [UIColor colorWithHexString:@"#E4393C"]//APP元素色——红
#define Color_Theme_ORed            [UIColor colorWithHexString:@"#FF5E3C"]//APP元素色——橘红
#define Color_Theme_Orange          [UIColor colorWithHexString:@"#ED6D00"]//APP元素色——橙
#define Color_Theme_WOrange         [UIColor colorWithHexString:@"#FDAA18"]//APP元素色——浅橙
#define Color_Theme_Croci           [UIColor colorWithHexString:@"#F37724"]//APP元素色——橘
#define Color_Theme_Yellow          [UIColor colorWithHexString:@"#FFA500"]//APP元素色——黄
#define Color_Theme_LYellow         [UIColor colorWithHexString:@"#FBD820"]//APP元素色——亮黄
#define Color_Theme_Green           [UIColor colorWithHexString:@"#99E64D"]//APP元素色——绿

/*********************************************************************************/
/*            系统基础颜色宏定义              */
/*********************************************************************************/
#define Color_Clear                 [UIColor clearColor]
#define Color_Black                 [UIColor blackColor]
#define Color_White                 [UIColor whiteColor]
#define Color_Red                   [UIColor redColor]
#define Color_Yellow                [UIColor yellowColor]
#define Color_Blue                  [UIColor blueColor]
#define Color_Green                 [UIColor greenColor]
#define Color_Gray                  [UIColor grayColor]
#define Color_Random                [UIColor randomColor]//随机颜色

#endif /* Macro_Color_h */
