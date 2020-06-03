//
//  LhkhTipsView.m
//  TC
//
//  Created by Weapon Chen on 2020/1/21.
//  Copyright © 2020 YouJie. All rights reserved.
//

#import "LhkhTipsView.h"
@interface LhkhTipsView()

@end

@implementation LhkhTipsView

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = Color_White;
        [self addSubview:self.tipsImage];
        [self addSubview:self.tipsLabel];
        [self addSubview:self.tipsButton];
    }
    return self;
}


#pragma mark - Layout SubViews

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.tipsImage setFrame:CGRectMake((self.width - 200)/2, 100, 200, 200)];
    [self.tipsLabel setFrame:CGRectMake(0, CGRectGetMaxY(self.tipsImage.frame) + 20, self.width, 20)];
    if (self.type==TipsType_HaveNoData || self.type==TipsType_NetWorkLost) {
        [self.tipsButton setFrame:CGRectMake((self.width - 80)/2, CGRectGetMaxY(self.tipsLabel.frame) + 20, 80, 30)];
        self.tipsButton.layer.borderColor = Color_Theme_Red.CGColor;
        self.tipsButton.layer.borderWidth = 1;
        LhkhViewCorner(self.tipsButton, 5);
    }
    
}



#pragma mark - System Delegate


#pragma mark - Custom Delegate


#pragma mark - Event Response
- (void)click
{

}

#pragma mark - Network Requests


#pragma mark - Public Methods


#pragma mark - Private Methods
//通过当前视图获取父视图的控制器
- (UIViewController*)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController
                                          class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

#pragma mark - Setters
- (UIImageView *)tipsImage
{
    if (!_tipsImage) {
        _tipsImage = [[UIImageView alloc] init];
    }
    return _tipsImage;
}


- (UILabel *)tipsLabel
{
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.font = systemFontRegular(14);
        _tipsLabel.textColor = Color_TipText;
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipsLabel;
}

- (UIButton *)tipsButton
{
    if(!_tipsButton){
        _tipsButton = [[UIButton alloc]init];
        _tipsButton.titleLabel.font = systemFontRegular(14);
        [_tipsButton setTitleColor:Color_Theme_Red forState:UIControlStateNormal];
        [_tipsButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _tipsButton;
}

#pragma mark - Getters



@end
