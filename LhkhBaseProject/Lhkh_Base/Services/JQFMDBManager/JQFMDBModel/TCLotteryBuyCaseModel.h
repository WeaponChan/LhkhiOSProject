//
//  TCLotteryBuyCaseModel.h
//  TC
//
//  Created by Weapon Chen on 2019/11/6.
//  Copyright © 2019 YouJie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TCLotteryBuyCaseModel : NSObject
@property (copy, nonatomic)NSString *Id;
@property (copy, nonatomic)NSString *IssueNo;
@property (copy, nonatomic)NSString *type;//dlt pl3 pl5 qxc
@property (copy, nonatomic)NSString *kind;//PT:普通投注  DT:胆拖投注 pl30:排列三直选 pl33:排列三组三 pl36:排列三组六
@property (assign, nonatomic)NSInteger zhu;//注数
@property (assign, nonatomic)NSInteger price;//单注金额
@property (assign, nonatomic)NSInteger totalPrice;//总金额
@property (assign, nonatomic)BOOL isZJ;//是否追加
@property (assign, nonatomic)NSInteger multiple;//倍数
@property (copy, nonatomic)NSString *rs;//普通投注红球
@property (copy, nonatomic)NSString *bs; //普通投注蓝球
@property (copy, nonatomic)NSString *rds;//胆拖投注红球胆码
@property (copy, nonatomic)NSString *rts;//胆拖投注红球拖码
@property (copy, nonatomic)NSString *bds;//胆拖投注蓝球胆码
@property (copy, nonatomic)NSString *bts;//胆拖投注蓝球拖码
@property (copy, nonatomic)NSString *pl3s;//pl3号码
@property (copy, nonatomic)NSString *pl5s;//pl5号码
@property (copy, nonatomic)NSString *qxcs;//七星彩号码
@end

NS_ASSUME_NONNULL_END
