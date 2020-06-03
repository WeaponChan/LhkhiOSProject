//
//  LhkhTipsManager.m
//  TC
//
//  Created by Weapon Chen on 2020/1/21.
//  Copyright © 2020 YouJie. All rights reserved.
//

#import "LhkhTipsManager.h"
#import "LhkhTipsView.h"
static TipsType currentType;
static LhkhTipsManager *instance = nil;
@implementation LhkhTipsManager
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

- (void)showTipsViewType:(TipsType)type toView:(UIView *)view
{
    //回收上一次的tipView,如果有
    [self removeTipsViewFromView:view];
    
    LhkhTipsView *tipsView = [[LhkhTipsView alloc] initWithFrame:view.bounds];
    tipsView.type = type;
    [view addSubview:tipsView];
    
    currentType = type;
    
    if (type == TipsType_NetWorkLost) {
        tipsView.tipsImage.image = Image(@"tips_network");
        tipsView.tipsLabel.text = @"当前网络环境较差，请重新加载~";
        [tipsView.tipsButton setTitle:@"重新加载" forState:UIControlStateNormal];
    }else if (type == TipsType_HaveNoOrder) {
        tipsView.tipsImage.image = Image(@"tips_order");
        tipsView.tipsLabel.text = @"暂无订单";
    }else if (type == TipsType_HaveNoSearchResult) {
        tipsView.tipsImage.image = Image(@"tips_search");
        tipsView.tipsLabel.text = @"暂无搜索结果";
    }else if (type == TipsType_HaveNoComment) {
        tipsView.tipsImage.image = Image(@"tips_comment");
        tipsView.tipsLabel.text = @"暂无评论";
    }else if (type == TipsType_HaveNoAddress) {
        tipsView.tipsImage.image = Image(@"tips_addr");
        tipsView.tipsLabel.text = @"暂无收货地址";
        [tipsView.tipsButton setTitle:@"立即添加" forState:UIControlStateNormal];
    }else if (type == TipsType_HaveNoGoods) {
        tipsView.tipsImage.image = Image(@"tips_shopCar");
        tipsView.tipsLabel.text = @"暂无商品";
    }else if (type == TipsType_HaveNoCoupon) {
        tipsView.tipsImage.image = Image(@"tips_coupon");
        tipsView.tipsLabel.text = @"暂无卡券";
    }else if (type == TipsType_HaveNoBranch) {
        tipsView.tipsImage.image = Image(@"tips_branch");
        tipsView.tipsLabel.text = @"暂无网点";
    }else if (type == TipsType_HaveNoHornor) {
        tipsView.tipsImage.image = Image(@"tips_hornor");
        tipsView.tipsLabel.text = @"暂无荣誉资质";
    }else if (type == TipsType_HaveNoData) {
        tipsView.tipsImage.image = Image(@"tips_data");
        tipsView.tipsLabel.text = @"暂无数据";
        [tipsView.tipsButton setTitle:@"重新加载" forState:UIControlStateNormal];
    }else if (type == TipsType_HaveNoCompetition) {
        tipsView.tipsImage.image = Image(@"tips_competition");
        tipsView.tipsLabel.text = @"暂无赛事";
    }else if (type == TipsType_HaveNoDatas) {
        tipsView.tipsImage.image = Image(@"tips_data");
        tipsView.tipsLabel.text = @"暂无数据";
    }
}

-(void)removeTipsViewFromView:(UIView *)view
{
    for (UIView *sub in view.subviews) {
        if ([sub isKindOfClass:[LhkhTipsView class]]) {
            LhkhTipsView *tipsView = (LhkhTipsView *)sub;
            [tipsView removeFromSuperview];
            tipsView = nil;
        }
    }
}
@end
