//
//  LhkhIJKPlayerVC.m
//  Lhkh_Base
//
//  Created by Weapon Chen on 2020/6/5.
//  Copyright © 2020 Weapon Chen. All rights reserved.
//

#import "LhkhIJKPlayerVC.h"
#import "LhkhPlayerView.h"
#import "AppDelegate.h"
@interface LhkhIJKPlayerVC ()<LhkhPlayerViewDelegate>
@property (strong, nonatomic)LhkhPlayerView *playerView;
@end

@implementation LhkhIJKPlayerVC

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"IJKPlayer";
    [self setSubView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    dispatch_async(dispatch_get_main_queue(), ^{
        ((AppDelegate *) [[UIApplication sharedApplication] delegate]).fullScreen = YES;
    });
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    // 确保在该控制器即将消失的时候关闭全屏模式
    dispatch_async(dispatch_get_main_queue(), ^{
        ((AppDelegate *) [[UIApplication sharedApplication] delegate]).fullScreen = NO;
    });
    [self.playerView removePlayer];
}

#pragma mark - Layout SubViews
- (void)setSubView
{
    [self.view addSubview:self.playerView];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.playerView playerViewWithUrl:@"https://file.qhcpxt.com:444/oss-sz-1/CourseVideo/20200603/7222fd8f-95c1-4d46-b27f-689a6645b1eb/637267769475237199.m3u8" WithTitle:@"测试" WithShouldAutoPlay:NO];
    });
}

#pragma mark - System Delegate


#pragma mark - Custom Delegate
#pragma mark - LhkhPlayerViewDelegate
- (void)LhkhPlayerViewDelegateFullScreenClick:(BOOL)isFullScreen
{
    if (isFullScreen == YES) {
        NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeRight];
        [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    } else {
        NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
        [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    }
}

#pragma mark - Event Response


#pragma mark - Network Requests


#pragma mark - Public Methods


#pragma mark - Private Methods
/// 改变View大小布局
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft ||
        [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        if (_playerView.height != window.height) {
            _playerView.frame = CGRectMake(0, 0, window.size.height,window.size.width);
            _playerView.player.view.frame = CGRectMake(0, 0, window.size.height,window.size.width);
        }else{
            _playerView.frame = CGRectMake(0, 0, window.size.width,window.size.height);
            _playerView.player.view.frame = CGRectMake(0, 0, window.size.width,window.size.height);
        }
        [window addSubview:_playerView];
    }else {
        _playerView.frame = CGRectMake(0, NavigationBar_H, size.width, size.width/16*9);
        _playerView.player.view.frame = CGRectMake(0, 0, size.width, size.width/16*9);
        [self.view addSubview:_playerView];
    }
}

#pragma mark - Setters
- (LhkhPlayerView*)playerView
{
    if (!_playerView) {
        _playerView = [[LhkhPlayerView alloc] initWithFrame:CGRectMake(0, NavigationBar_H, Screen_W, Screen_W*9/16)];
        _playerView.delegate = self;
    }
    return _playerView;
}

#pragma mark - Getters


@end
