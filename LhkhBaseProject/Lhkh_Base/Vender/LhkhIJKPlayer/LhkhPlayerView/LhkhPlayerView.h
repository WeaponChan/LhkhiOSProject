//
//  LhkhPlayerView.h
//  Lhkh_Base
//
//  Created by Weapon Chen on 2020/6/5.
//  Copyright © 2020 Weapon Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IJKMediaFrameworkWithSSL/IJKMediaFrameworkWithSSL.h>

@protocol LhkhPlayerViewDelegate <NSObject>


/// 点击全屏
/// @param isFullScreen 是否全屏 Yes/No
- (void)LhkhPlayerViewDelegateFullScreenClick:(BOOL)isFullScreen;

@end

@interface LhkhPlayerView : UIView

/// 初始化播放器
/// @param urlString 播放地址
/// @param title 视频title
/// @param shouldAutoPlay 是否自动播放
- (void)playerViewWithUrl:(NSString*)urlString WithTitle:(NSString*)title WithShouldAutoPlay:(BOOL)shouldAutoPlay;

@property (weak, nonatomic)id<LhkhPlayerViewDelegate>delegate;
@property (strong, nonatomic)id<IJKMediaPlayback>player;
@property (assign, nonatomic)BOOL shouldAutoplay;//是否自动播放
/// 移除播放器
- (void)removePlayer;
@end
