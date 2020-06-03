//
//  Macro_UserDefaults.h
//  Lhkh_Base
//
//  Created by Weapon on 2018/11/19.
//  Copyright © 2018 Lhkh. All rights reserved.
//

#ifndef Macro_UserDefaults_h
#define Macro_UserDefaults_h


//永久存储对象
#define LhkhSetUserDefaults(object, key)                                                                                                 \
({                                                                                                                                             \
NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];                                                                         \
[defaults setObject:object forKey:key];                                                                                                    \
[defaults synchronize];                                                                                                                    \
})

//获取对象
#define LhkhGetUserDefaults(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]

//删除某一个对象
#define LhkhRemoveUserDefaults(key)                                         \
({                                                                          \
NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];       \
[defaults removeObjectForKey:_key];                                     \
[defaults synchronize];                                                 \
})

//清除 NSUserDefaults 保存的所有数据
#define LhkhRemoveAllUserDefaults  [[NSUserDefaults standardUserDefaults] removePersistentDomainF


/*********************************************************************************/
/*               NSUserDefaults键名                */
/*********************************************************************************/
#define Lhkh_DefaultDomainName         @"Lhkh_DefaultDomainName"          //域名更改
#define Lhkh_DefaultImageDomainName    @"Lhkh_DefaultImageDomainName"          //图片域名更改
#define Lhkh_RegistrationID            @"Lhkh_RegistrationID"             //极光注册id
#define Lhkh_Token                     @"Lhkh_Token"                      //token
#define Lhkh_Expires                   @"Lhkh_Expires"                    //token过期时间
#define Lhkh_NewWork                   @"Lhkh_NewWork"                    //当前网络情况
//用户相关
#define Lhkh_UserId                    @"Lhkh_UserId"                    //当前登录账号
#define Lhkh_LoginType                 @"Lhkh_LoginType"                  //登录类型
#define Lhkh_UserPhone                 @"Lhkh_UserPhone"                  //用户手机号
#define Lhkh_UserPwd                   @"Lhkh_UserPwd"                    //密码
#define Lhkh_RealName                  @"Lhkh_RealName"                   //真实姓名
#define Lhkh_idCard                    @"Lhkh_idCard"                     //身份证号
#define Lhkh_UserHeadImg               @"Lhkh_UserHeadImg"                //用户头像

#define Lhkh_ISO                       @"Lhkh_ISO"                        //手机SIM卡的国家编码 CN等
#define Lhkh_CountryName               @"Lhkh_CountryName"                //根据SIM卡的ISO获取到的国家名称
#define Lhkh_CountryCode               @"Lhkh_CountryCode"                //根据SIM卡的ISO获取到的国家国际编码
#define Lhkh_CountryID                 @"Lhkh_CountryID"                  //根据SIM卡的ISO获取到的国家ID


//地理位置
#define Lhkh_LocationCoordinate_lat      @"Lhkh_LocationCoordinate_lat"      //纬度
#define Lhkh_LocationCoordinate_lon      @"Lhkh_LocationCoordinate_lon"      //经度

#define Lhkh_LocationP                   @"Lhkh_LocationP" //省
#define Lhkh_LocationC                   @"Lhkh_LocationC" //市
#define Lhkh_LocationD                   @"Lhkh_LocationD" //区
#define Lhkh_Location                    @"Lhkh_Location" //市·区

#define Lhkh_WECHATOPENID                @"Lhkh_WECHATOPENID" //微信的openid
#define Lhkh_ZFBUSERID                   @"Lhkh_ZFBUSERID" //支付宝的userid
#define Lhkh_QQOPENID                    @"Lhkh_QQOPENID" //qq的openid
#define Lhkh_APPLEID                     @"Lhkh_APPLEID" //apple的Id
#endif /* Macro_UserDefaults_h */
