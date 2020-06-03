//
//  TCLocationManager.h
//  TC
//
//  Created by Weapon Chen on 2019/10/29.
//  Copyright © 2019 YouJie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
NS_ASSUME_NONNULL_BEGIN

@interface TCLocationManager : NSObject

+(instancetype)shareManager;

-(void)getLocationWithSuccess:(void(^)(id obj))success failed:(void(^)(NSError * error))failed;

- (void)reGetLocation:(id)target;
@end

NS_ASSUME_NONNULL_END
