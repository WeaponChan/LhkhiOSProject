//
//  LhkhScanMaskView.m
//  TC
//
//  Created by Weapon Chen on 2019/12/24.
//  Copyright © 2019 YouJie. All rights reserved.
//


#import "LhkhScanMaskView.h"

@interface LhkhScanMaskView()
{
    NSString *_type;
}
@property (nonatomic, strong) UIImageView * scanLineImg;
@property (nonatomic, strong) UIView * maskView;
@property (nonatomic, strong) UILabel * tipLabel;
@property (nonatomic, strong) UIImageView * scanImgV;
@property (nonatomic, strong) UIImageView * tipImgV;
@property (nonatomic, strong) UIBezierPath * bezier;
@property (nonatomic, strong) CAShapeLayer * shapeLayer;

/** 第一次旋转 */
@property (nonatomic, assign) CGFloat isFirstTransition;
@end

@implementation LhkhScanMaskView

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame type:(NSString *)type
{
    if (self = [super initWithFrame:frame]) {
        _type = type;
        [self addUI];
    }
    return self;
}

#pragma mark - Layout SubViews

- (void)addUI{
    //遮罩层
    self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.maskView.backgroundColor = [UIColor blackColor];
    self.maskView.alpha = 0.4;
    self.maskView.layer.mask = [self maskLayer];
    [self addSubview:self.maskView];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLab.text = @"二维码/条码";
    titleLab.font = systemFontRegular(20);
    titleLab.textColor = Color_White;
    titleLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self).offset(StatusBar_H+10);
    }];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectZero];
    [btn setImage:Image(@"back_white") forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(20);
        make.centerY.equalTo(titleLab.mas_centerY);
        make.leading.equalTo(self).offset(15);
    }];
    
    //提示框
    self.tipLabel = [[UILabel alloc] init];
    self.tipLabel.text = @"将二维码/条码放入框内，即可自动扫描";
    self.tipLabel.textColor = Color_White;
    self.tipLabel.textAlignment = NSTextAlignmentCenter;
    self.tipLabel.numberOfLines = 0;
    self.tipLabel.font = systemFontRegular(12);
    [self addSubview:self.tipLabel];
    
    UIImageView *scanImgV = [[UIImageView alloc] init];
    [self addSubview:scanImgV];
    self.scanImgV = scanImgV;

    //扫描线
    UIImage * scanLine = Image(@"home_scan_line");
    self.scanLineImg = [[UIImageView alloc] init];
    self.scanLineImg.image = scanLine;
    self.scanLineImg.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.scanLineImg];
    
    UIImageView *tipImgV = [[UIImageView alloc] init];
    tipImgV.image = Image(@"home_scan_tips");
    [self addSubview:tipImgV];
    self.tipImgV = tipImgV;
    
    if ([_type isEqualToString:@"lottery"]) {//扫描彩票条码 pdf-417
        scanImgV.image = Image(@"home_scan_box");
        //设置frame
        self.scanImgV.frame = CGRectMake((self.width - (self.width * 0.93)) * 0.5, (self.height - (self.width * 0.25)) * 0.4, (self.width * 0.93), (self.width * 0.4));
        
        //扫描线
        self.scanLineImg.frame = CGRectMake((self.width - (self.width * 0.8)) * 0.5, (self.height - (self.width * 0.25)) * 0.4, self.width * 0.8, scanLine.size.height);
        
        //提示框
        self.tipLabel.frame = CGRectMake(0, self.scanImgV.y+self.scanImgV.height+10, self.width, 40);
        self.tipImgV.frame = CGRectMake((self.width-135)/2, self.tipLabel.y+50, 135, 135);
        [self.scanLineImg.layer addAnimation:[self animation] forKey:nil];
    }else{//扫描二维码
        scanImgV.image = Image(@"home_scan_sbox");
        self.scanImgV.frame = CGRectMake((self.width - (self.width * 0.68)) * 0.5, (self.height - (self.width * 0.68)) * 0.5, (self.width * 0.68), (self.width * 0.68));
        
        //扫描线
        self.scanLineImg.frame = CGRectMake((self.width - (self.width * 0.68)) * 0.5, (self.height - (self.width * 0.68)) * 0.5, self.width * 0.68, 5);
        
        //提示框
        self.tipLabel.frame = CGRectMake(0, self.scanImgV.y+self.scanImgV.height+10, self.width, 40);
        self.tipImgV.frame = CGRectMake((self.width-135)/2, self.tipLabel.y+50, 135, 135);
        [self.scanLineImg.layer addAnimation:[self animation] forKey:nil];
    }
}


#pragma mark - System Delegate


#pragma mark - Custom Delegate


#pragma mark - Event Response
- (void)back
{
    if ([self.delegate respondsToSelector:@selector(LhkhScanMaskViewDelegateBack)]) {
        [self.delegate LhkhScanMaskViewDelegateBack];
    }
}

#pragma mark - Network Requests


#pragma mark - Public Methods
/**
 *  移除动画
 */
- (void)removeAnimation
{
    [self.scanLineImg.layer removeAllAnimations];
}

#pragma mark - Private Methods


#pragma mark - Setters

/**
 *  动画
 */
- (CABasicAnimation *)animation
{
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.duration = 1.5;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.repeatCount = MAXFLOAT;
    if ([_type isEqualToString:@"lottery"]) {
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.center.x, (self.height - (self.width * 0.24)) * 0.4)];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.center.x, (self.height - (self.width * 0.24)) * 0.4 + self.width * 0.4-5)];
    }else{
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.center.x, (self.center.y - self.width * 0.68 * 0.5 + self.scanLineImg.image.size.height * 0.5))];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y + self.width * 0.68 * 0.5 - self.scanLineImg.image.size.height * 0.5)];
    }
    
    
    return animation;
}

/**
 *  遮罩层bezierPath
 *
 *  @return UIBezierPath
 */
- (UIBezierPath *)maskPath
{
    self.bezier = nil;
    self.bezier = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.width, self.height)];
    if ([_type isEqualToString:@"lottery"]) {
        [self.bezier appendPath:[[UIBezierPath bezierPathWithRect:CGRectMake((self.width - (self.width * 0.93)) * 0.5, (self.height - (self.width * 0.25)) * 0.4, self.width * 0.93, self.width * 0.4)] bezierPathByReversingPath]];
    }else{
        [self.bezier appendPath:[[UIBezierPath bezierPathWithRect:CGRectMake((self.width - ((self.width * 0.68))) * 0.5, (self.height - (self.width * 0.68)) * 0.5, (self.width * 0.68), (self.width * 0.68))] bezierPathByReversingPath]];
    }
    
    return self.bezier;
}

/**
 *  遮罩层ShapeLayer
 *
 *  @return CAShapeLayer
 */
- (CAShapeLayer *)maskLayer{
    [self.shapeLayer removeFromSuperlayer];
    self.shapeLayer = nil;
    
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.path = [self maskPath].CGPath;
    
    return self.shapeLayer;
}

#pragma mark - Getters



@end
