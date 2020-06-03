//
//  LhkhTipsManager.h
//  TC
//
//  Created by Weapon Chen on 2020/1/21.
//  Copyright © 2020 YouJie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*
 *TipsType状态*
 */
typedef NS_ENUM(NSUInteger, TipsType){
    TipsType_HaveNoData = 0,        //无数据  //带重新加载的无数据
    TipsType_NetWorkLost,           //无网络链接
    TipsType_HaveNoCoupon,          //无卡券
    TipsType_HaveNoSearchResult,    //无搜索结果
    TipsType_HaveNoAddress,         //无地址信息
    TipsType_HaveNoBranch,          //无网点
    TipsType_HaveNoHornor,          //无荣誉资质
    TipsType_HaveNoOrder,           //无订单信息
    TipsType_HaveNoComment,         //无评论
    TipsType_HaveNoCompetition,     //无赛事
    TipsType_HaveNoGoods,           //无商品
    TipsType_HaveNoDatas,           //无数据
};

@interface LhkhTipsManager : NSObject
/*
 *单例*
 */
+ (instancetype)shareTipsManager;

/*
 *展示到当前view*
 */
- (void)showTipsViewType:(TipsType)type toView:(UIView *)view;

/*
 *从当前view移除*
 */
- (void)removeTipsViewFromView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
