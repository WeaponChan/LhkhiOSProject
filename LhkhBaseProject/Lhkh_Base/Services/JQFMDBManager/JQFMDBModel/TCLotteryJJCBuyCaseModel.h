//
//  TCLotteryJJCBuyCaseModel.h
//  TC
//
//  Created by Weapon Chen on 2019/11/13.
//  Copyright © 2019 YouJie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TCLotteryJJCBuyCaseModel : NSObject
@property (copy, nonatomic)NSString *issueNo;//期号
@property (copy, nonatomic)NSString *lotType;//彩种名字
@property (copy, nonatomic)NSString *lotId;//当前彩种的类别
@property (copy, nonatomic)NSString *lotName;//当前彩种的类别名字

@property (copy, nonatomic)NSString *weekNo;//赛事的周编号
@property (copy, nonatomic)NSString *leagueId;//联盟Id
@property (copy, nonatomic)NSString *leagueName;//联盟名称
@property (copy, nonatomic)NSString *matchTime;//比赛时间
@property (copy, nonatomic)NSString *itemHostN;//主队名称
@property (copy, nonatomic)NSString *itemHostR;//主队类别
@property (copy, nonatomic)NSString *itemVisitN;//客队名称
@property (copy, nonatomic)NSString *itemVisitR;//客队类别
@property (copy, nonatomic)NSString *itemSPLists;//投注的比例
@property (copy, nonatomic)NSString *isDan;//投注的比例
@property (copy, nonatomic)NSString *selectS;//选中的项
@property (copy, nonatomic)NSString *selectVs;//选中的投注的value 针对于总进球和比分 半全场的
@property (copy, nonatomic)NSString *selectTagS;//选中的投注的tag 针对于胜平负 让球胜平负的
@property (copy, nonatomic)NSString *row;//投注列表的row
@property (copy, nonatomic)NSString *isSelected;//0 未选择  1选择了
@property (assign, nonatomic)NSInteger zhu;//注数
@property (assign, nonatomic)NSInteger price;//金额
@property (assign, nonatomic)NSInteger totalM;//总金额
@end

NS_ASSUME_NONNULL_END
