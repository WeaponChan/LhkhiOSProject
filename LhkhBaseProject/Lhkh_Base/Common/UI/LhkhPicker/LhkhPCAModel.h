//
//  LhkhPCAModel.h
//  Lhkh_Base
//
//  Created by Weapon Chen on 2017/11/23.
//  Copyright © 2017 LHKH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LhkhPCAModel : NSObject

@end

@interface LhkhProvince : NSObject
@property (strong, nonatomic)NSArray *city;
@property (strong, nonatomic)NSString *name;
@end

@interface LhkhCity : NSObject
@property (strong, nonatomic)NSArray *area;
@property (strong, nonatomic)NSString *name;
@end






NS_ASSUME_NONNULL_END
