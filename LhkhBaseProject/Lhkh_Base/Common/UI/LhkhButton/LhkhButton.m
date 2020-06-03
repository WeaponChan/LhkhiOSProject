//
//  LhkhButton.m
//  TC
//
//  Created by Weapon Chen on 2019/10/21.
//  Copyright © 2019 YouJie. All rights reserved.
//

#import "LhkhButton.h"

@interface LhkhButton()

@end

@implementation LhkhButton

#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame type:(NSString*)type
{
    if (self = [super initWithFrame:frame]) {
        if ([type isEqualToString:@"1"]) {
                 
             [self setTitleColor:[Color_White colorWithAlphaComponent:0.5] forState:UIControlStateNormal];
             [self setTitleColor:Color_White forState:UIControlStateDisabled];
             UIImage *btnImage = [Image(@"news_border_gray") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
             UIImage *btnSelImage = [Image(@"news_border_white") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
             [self setBackgroundImage:btnSelImage  forState:UIControlStateDisabled];
             [self setBackgroundImage:btnImage forState:UIControlStateNormal];
    
        }else{
            [self setTitleColor:Color_TipText forState:UIControlStateNormal];
            [self setTitleColor:Color_Theme_Red forState:UIControlStateDisabled];
            self.titleLabel.font = systemFontRegular(14);
        }
        [self layoutCustomViews];
    }
    return self;
}

#pragma mark - Layout SubViews
- (void)layoutCustomViews
{
     [self addSubview:self.btnImage];
     [self.btnImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.centerX.equalTo(self.mas_centerX);
     }];
   
     UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
     view.userInteractionEnabled = NO;
     view.backgroundColor = Color_Clear;
     [self addSubview:view];
     [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnImage.mas_bottom).offset(10);
        make.leading.equalTo(self);
        make.trailing.equalTo(self);
        make.bottom.equalTo(self).offset(-10);
     }];
   
     [view addSubview:self.btnTitle];
     [self.btnTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view.mas_centerX);
        make.centerY.equalTo(view.mas_centerY);
        make.leading.equalTo(view);
        make.trailing.equalTo(view);
     }];
}


#pragma mark - System Delegate


#pragma mark - Custom Delegate


#pragma mark - Event Response


#pragma mark - Network Requests


#pragma mark - Public Methods


#pragma mark - Private Methods


#pragma mark - Setters
- (UIImageView*)btnImage
{
    if (!_btnImage) {
        _btnImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        _btnImage.userInteractionEnabled = NO;
    }
    return _btnImage;
}

- (UILabel*)btnTitle
{
    if (!_btnTitle) {
        _btnTitle = [[UILabel alloc] initWithFrame:CGRectZero];
        _btnTitle.font = systemFontRegular(14);
        _btnTitle.textColor = Color_SubText;
        _btnTitle.userInteractionEnabled = NO;
        _btnTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _btnTitle;
}

#pragma mark - Getters



@end
