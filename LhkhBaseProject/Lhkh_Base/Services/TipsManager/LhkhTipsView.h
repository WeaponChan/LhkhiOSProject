//
//  LhkhTipsView.h
//  TC
//
//  Created by Weapon Chen on 2020/1/21.
//  Copyright © 2020 YouJie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LhkhTipsView : UIView
/*
 *各类空页面的图片*
 */
@property (nonatomic, strong) UIImageView *tipsImage;

/*
 *各类空页面的下标题*
 */
@property (nonatomic, strong) UILabel *tipsLabel;

/*
 *跳转按钮*
 */
@property (nonatomic, strong) UIButton *tipsButton;

/*
 *跳转按钮*
 */
@property (nonatomic, assign) TipsType type;
@end
