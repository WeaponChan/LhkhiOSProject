//
//  LhkhWelcomeViewController.h
//  Lhkh_Base
//
//  Created by Weapon on 2018/11/22.
//  Copyright © 2018 Lhkh. All rights reserved.
//

#import "LhkhBaseViewController.h"
static NSString *const adImageName = @"adImageName";
static NSString *const adUrl = @"adUrl";
typedef void(^LhkhWelcomeVCBlock)(void);
@interface LhkhWelcomeViewController : LhkhBaseViewController
@property (copy, nonatomic) LhkhWelcomeVCBlock block;
- (void)welcomeViewStartAnimationWithData:(NSString *)imagePath;
@end
