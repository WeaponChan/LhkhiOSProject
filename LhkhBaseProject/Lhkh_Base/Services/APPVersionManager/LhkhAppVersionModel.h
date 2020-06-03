//
//  LhkhAppVersionModel.h
//  TC
//
//  Created by Weapon Chen on 2020/2/12.
//  Copyright © 2020 YouJie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LhkhAppVersionModel : NSObject
@property (copy, nonatomic)NSString *AppName;
@property (copy, nonatomic)NSString *AppVersion;
@property (copy, nonatomic)NSString *AppVersionName;
@property (copy, nonatomic)NSString *DownloadUrl;
@property (copy, nonatomic)NSString *Description;
@property (copy, nonatomic)NSString *IsMust;
@end

NS_ASSUME_NONNULL_END
