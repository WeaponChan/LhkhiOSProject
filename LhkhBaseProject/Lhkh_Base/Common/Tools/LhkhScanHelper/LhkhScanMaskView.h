//
//  LhkhScanMaskView.h
//  TC
//
//  Created by Weapon Chen on 2019/12/24.
//  Copyright © 2019 YouJie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LhkhScanMaskViewDelegate <NSObject>

- (void)LhkhScanMaskViewDelegateBack;

@end

@interface LhkhScanMaskView : UIView

/// 初始化遮罩层
/// @param frame frame
/// @param type 区分彩票条码还是二维码
- (instancetype)initWithFrame:(CGRect)frame type:(NSString*)type;

@property (weak, nonatomic)id<LhkhScanMaskViewDelegate>delegate;

- (void)removeAnimation;
@end
