//
//  LhkhButton.h
//  TC
//
//  Created by Weapon Chen on 2019/10/21.
//  Copyright © 2019 YouJie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LhkhButton : UIButton
@property (strong, nonatomic)UIImageView *btnImage;
@property (strong, nonatomic)UILabel *btnTitle;
- (instancetype)initWithFrame:(CGRect)frame type:(NSString*)type;
@end
