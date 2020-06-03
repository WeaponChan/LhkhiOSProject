//
//  TCLotteryZCSelectModel.h
//  TC
//
//  Created by Weapon Chen on 2019/12/25.
//  Copyright © 2019 YouJie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TCLotteryZCSelectModel : NSObject
@property (copy, nonatomic)NSString *issueNo;//期号
@property (copy, nonatomic)NSString *lotType;//彩种名字
@property (copy, nonatomic)NSString *lotKind;//当前彩种的类别

@property (copy, nonatomic)NSString *matchNo;//赛事的周编号
@property (copy, nonatomic)NSString *leagueId;//联盟Id
@property (copy, nonatomic)NSString *leagueName;//联盟名称
@property (copy, nonatomic)NSString *matchTime;//比赛时间

@property (copy, nonatomic)NSString *itemHostN;//主队名称
@property (copy, nonatomic)NSString *itemHostR;//主队类别
@property (copy, nonatomic)NSString *itemVisitN;//客队名称
@property (copy, nonatomic)NSString *itemVisitR;//客队类别
@property (copy, nonatomic)NSString *itemSPLists;//投注的比例
@property (copy, nonatomic)NSString *selectS;//选中的投注
@property (copy, nonatomic)NSString *selectVs;//选中的投注的value 针对于总进球和比分 半全场的
@property (copy, nonatomic)NSString *selectTagS;//选中的投注的tag 针对于胜平负 让球胜平负的
@property (copy, nonatomic)NSString *selectkS;//选中的投注 客场 或者 半场
@property (copy, nonatomic)NSString *selectkVs;//选中的投注的value 针对于总进球和比分 半全场的 客场 或者 半场
@property (copy, nonatomic)NSString *selectkTagS;//选中的投注的tag 针对于胜平负 让球胜平负的 客场 或者 半场
@property (copy, nonatomic)NSString *section;//初始数据section
@property (copy, nonatomic)NSString *row;//初始数据row
@property (copy, nonatomic)NSString *isSelected;//0 未选择  1选择了
@property (copy, nonatomic)NSString *iskSelected;//0 未选择  1选择了 客场 或者 半场
@end

NS_ASSUME_NONNULL_END
