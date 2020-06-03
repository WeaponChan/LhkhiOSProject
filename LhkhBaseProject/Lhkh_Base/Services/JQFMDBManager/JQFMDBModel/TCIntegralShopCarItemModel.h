//
//  TCIntegralShopCarItemModel.h
//  TC
//
//  Created by Weapon Chen on 2019/11/16.
//  Copyright © 2019 YouJie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TCIntegralShopCarItemModel : NSObject
@property (copy, nonatomic)NSString *Id;
@property (copy, nonatomic)NSString *GoodsPic;
@property (copy, nonatomic)NSString *GoodsName;
@property (copy, nonatomic)NSString *GoodsDesc;
@property (copy, nonatomic)NSString *GoodsPrice;
@property (copy, nonatomic)NSString *GoodsNum;
@property (assign, nonatomic)BOOL isSelected;
@end

NS_ASSUME_NONNULL_END
