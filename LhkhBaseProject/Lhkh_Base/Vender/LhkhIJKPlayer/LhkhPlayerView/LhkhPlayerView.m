//
//  LhkhPlayerView.m
//  Lhkh_Base
//
//  Created by Weapon Chen on 2020/6/5.
//  Copyright © 2020 Weapon Chen. All rights reserved.
//


#import "LhkhPlayerView.h"

@interface LhkhPlayerView()

@end

@implementation LhkhPlayerView

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self layoutCustomViews];
    }
    return self;
}


#pragma mark - Layout SubViews
- (void)layoutCustomViews
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playClick)];
    [self addGestureRecognizer:tap];
}


#pragma mark - System Delegate


#pragma mark - Custom Delegate


#pragma mark - Event Response
- (void)playClick
{
    [self.player play];
}

- (void)fullScreenClick:(UIButton*)sender
{
    sender.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(LhkhPlayerViewDelegateFullScreenClick:)]) {
        [self.delegate LhkhPlayerViewDelegateFullScreenClick:sender.selected];
    }
}

#pragma mark - Network Requests


#pragma mark - Public Methods
- (void)playerViewWithUrl:(NSString *)urlString WithTitle:(NSString *)title WithShouldAutoPlay:(BOOL)shouldAutoPlay
{
    if (!self.player) {
        [self preparePlayerWithUrl:urlString WithTitle:title WithShouldAutoPlay:shouldAutoPlay];
    }
    [self installMovieNotificationObservers];
    [self.player prepareToPlay];
}

//播放器设置准备
- (void)preparePlayerWithUrl:(NSString *)urlString WithTitle:(NSString *)title WithShouldAutoPlay:(BOOL)shouldAutoPlay
{
    if (self.player) {
        [self.player shutdown];
        [self.player.view removeFromSuperview];
        self.player = nil;
    }
    
    //1. 根据当前环境设置日志信息
#ifdef DEBUG
    [IJKFFMoviePlayerController setLogReport:YES];
    [IJKFFMoviePlayerController setLogLevel:k_IJK_LOG_VERBOSE];//k_IJK_LOG_VERBOSE k_IJK_LOG_DEBUG
#else
    [IJKFFMoviePlayerController setLogReport:NO];
    [IJKFFMoviePlayerController setLogLevel:k_IJK_LOG_INFO];
#endif
    // 2. 检查版本是否匹配
    [IJKFFMoviePlayerController checkIfFFmpegVersionMatch:YES];
    // 3.创建IJKFFMoviePlayerController
    //默认选项配置
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    //创建播放控制器
    IJKFFMoviePlayerController *playerVC = [[IJKFFMoviePlayerController alloc] initWithContentURLString:urlString withOptions: options];
    
    playerVC.shouldShowHudView = true;
    playerVC.view.frame = self.bounds;
    //设置适配横竖屏(设置四边固定,长宽灵活)
//    playerVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//    //设置播放视图的缩放模式
//    playerVC.scalingMode = IJKMPMovieScalingModeAspectFit;
    //设置自动播放
    playerVC.shouldAutoplay = shouldAutoPlay;
    self.autoresizesSubviews = YES;
    [self addSubview:playerVC.view];
    self.player = playerVC;
    
    UIView *redV = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-30, self.width, 30)];
    redV.backgroundColor = [Color_Red colorWithAlphaComponent:0.2];
    [self addSubview:redV];
    
    UIButton *fullB = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, redV.width, 30)];
    [fullB addTarget:self action:@selector(fullScreenClick:) forControlEvents:UIControlEventTouchUpInside];
    [redV addSubview:fullB];
}


//播放器即将隐藏
- (void)playerWillHide
{
    if (self.player) {
        [self.player shutdown];
        [self removeMovieNotificationObservers];
    }
    
}

//移除播放器
- (void)removePlayer
{
    [self playerWillHide];
    [self removeFromSuperview];
}
#pragma mark - Private Methods
-(void)installMovieNotificationObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStateDidChange:)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:_player];//视频加载状态
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:_player];//播放状态改变
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_player];//用户改变播放状态
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayFirstVideoFrameRendered:)
                                                 name:IJKMPMoviePlayerFirstVideoFrameRenderedNotification
                                               object:_player];//视频第一帧
}

- (void)loadStateDidChange:(NSNotification*)notification
{
    //MPMovieLoadStateUnknown        = 0,
    //MPMovieLoadStatePlayable       = 1 << 0,
    //MPMovieLoadStatePlaythroughOK  = 1 << 1, // 当shouldAutoplay为YES时，将在此状态下自动开始播放
    //MPMovieLoadStateStalled        = 1 << 2, // 如果开始播放，将在此状态下自动暂停播放

    IJKMPMovieLoadState loadState = _player.loadState;
    
    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        DLog(@"loadStateDidChange: IJKMPMovieLoadStatePlaythroughOK: %d\n", (int)loadState);
    } else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {
        DLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
    } else {
        DLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
    }
}

//当电影播放结束或用户退出播放时调用
- (void)moviePlayBackDidFinish:(NSNotification*)notification
{
    int reason = [[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    
    switch (reason)
    {
        case IJKMPMovieFinishReasonPlaybackEnded:
            DLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonUserExited:
            DLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonPlaybackError:
        {
            DLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
            [self failPlay];
            break;
            
        }
        default:
            DLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
            break;
    }
}

- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification
{
    DLog(@"mediaIsPreparedToPlayDidChange\n");
}

//播放状态改变
- (void)moviePlayBackStateDidChange:(NSNotification*)notification
{
    switch (_player.playbackState)
    {
        case IJKMPMoviePlaybackStateStopped: {
            DLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStatePlaying: {
            DLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStatePaused: {
            DLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStateInterrupted: {
            DLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStateSeekingForward:{
            DLog(@"IJKMPMoviePlayBackStateDidChange %d: SeekingForward", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStateSeekingBackward: {
            DLog(@"IJKMPMoviePlayBackStateDidChange %d: SeekingBackward", (int)_player.playbackState);
            break;
        }
        default: {
            DLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_player.playbackState);
            break;
        }
    }
}

//视频第一帧
- (void)moviePlayFirstVideoFrameRendered:(NSNotification*)notification
{
    DLog(@"加载第一个画面！");
    if(![self.player isPlaying]){
        DLog(@"检测的一次播放状态错误");
        [self.player play];
    }
}

//移除通知
-(void)removeMovieNotificationObservers
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerLoadStateDidChangeNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerPlaybackDidFinishNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerPlaybackStateDidChangeNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerFirstVideoFrameRenderedNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)failPlay
{
    if (self.player) {
        [self.player pause];
    }
}

#pragma mark - Setters


#pragma mark - Getters



@end
