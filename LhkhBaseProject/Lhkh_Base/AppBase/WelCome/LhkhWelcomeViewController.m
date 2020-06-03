//
//  LhkhWelcomeViewController.m
//  Lhkh_Base
//
//  Created by Weapon on 2018/11/22.
//  Copyright © 2018 Lhkh. All rights reserved.
//

#import "LhkhWelcomeViewController.h"
@interface LhkhWelcomeViewController ()
@property (strong, nonatomic)NSMutableArray *imgUrls;
@property (strong, nonatomic)UIImageView *imageView;
@property (strong, nonatomic)dispatch_source_t timer;
@property (strong, nonatomic)UILabel *timeL;
@end

@implementation LhkhWelcomeViewController

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setSubView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(timerCancel) name:@"timerCancel" object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - Layout SubViews
- (void)setSubView
{
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.equalTo(self.view);
    }];
    
    UIView *adView = [[UIView alloc] initWithFrame:CGRectZero];
    adView.backgroundColor = Color_viewBg;
    [self.view addSubview:adView];
    [adView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(60);
        make.height.offset(30);
        make.top.equalTo(self.view).offset(StatusBar_H);
        make.trailing.equalTo(self.view).offset(-10);
    }];
    LhkhViewCorner(adView, 15);
    
    UILabel *timel = [[UILabel alloc] initWithFrame:CGRectZero];
    timel.textColor = Color_White;
    timel.textAlignment = NSTextAlignmentCenter;
    timel.font = systemFontRegular(14);
    [adView addSubview:timel];
    self.timeL = timel;
    [timel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(adView).offset(5);
        make.width.offset(15);
        make.centerY.equalTo(adView.mas_centerY);
    }];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectZero];
    [btn setTitle:@"跳过" forState:UIControlStateNormal];
    [btn setTitleColor:Color_White forState:UIControlStateNormal];
    btn.titleLabel.font = systemFontRegular(14);
    [btn addTarget:self action:@selector(skipClick) forControlEvents:UIControlEventTouchUpInside];
    [adView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(timel.mas_trailing);
        make.top.bottom.trailing.equalTo(adView);
    }];
}

#pragma mark - System Delegate


#pragma mark - Custom Delegate


#pragma mark - Event Response
- (void)skipClick
{
    dispatch_source_cancel(self.timer);
    if (self.block) {
        self.block();
    }
}

- (void)gestureTap:(UITapGestureRecognizer*)tap
{
    dispatch_source_cancel(self.timer);
}

#pragma mark - Network Requests
//获取广告
- (void)getStartupAds
{

}

#pragma mark - Public Methods

- (void)welcomeViewStartAnimationWithData:(NSString *)imagePath
{
    self.imageView.image = [UIImage imageWithContentsOfFile:imagePath];
    [self timeFireMethod];
}

#pragma mark - Private Methods
- (void)timeFireMethod
{
    __block NSInteger time = 5;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(self.timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.timer, ^{
        
        if (time ==0) {
            dispatch_source_cancel(self.timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.block) {
                    self.block();
                }
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
               self.timeL.text = [NSString stringWithFormat:@"%ld",time];
            });
            time --;
        }
    });
    dispatch_resume(self.timer);
}

- (void)timerCancel
{
    dispatch_source_cancel(self.timer);
}

#pragma mark - Setters

- (UIImageView*)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.contentMode = UIViewContentModeScaleToFill;
        _imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureTap:)];
        [_imageView addGestureRecognizer:tap];
    }
    return _imageView;
}
#pragma mark - Getters


@end
