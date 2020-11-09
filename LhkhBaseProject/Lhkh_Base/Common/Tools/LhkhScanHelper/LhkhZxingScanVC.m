//
//  LhkhZxingScanVC.m
//  Lhkh_Base
//
//  Created by Weapon Chen on 2020/10/23.
//  Copyright © 2020 Weapon Chen. All rights reserved.
//

#import "LhkhZxingScanVC.h"
#import <ZXingObjC/ZXingObjC.h>
#import <AudioToolbox/AudioToolbox.h>

#import "LhkhScanMaskView.h"

@interface LhkhZxingScanVC ()<ZXCaptureDelegate,LhkhScanMaskViewDelegate>
@property (nonatomic, strong) ZXCapture *capture;
@property (nonatomic) BOOL scanning;

/** 遮罩层 */
@property (strong, nonatomic) LhkhScanMaskView * maskView;
@end

@implementation LhkhZxingScanVC
{
    CGAffineTransform _captureSizeTransform;
}

#pragma mark - View Controller Methods

- (void)dealloc {
  [self.capture.layer removeFromSuperlayer];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.capture = [[ZXCapture alloc] init];
  self.capture.layer.frame = self.view.frame;
  self.capture.camera = self.capture.back;
  self.capture.focusMode = AVCaptureFocusModeContinuousAutoFocus;
  self.capture.delegate = self;
  self.scanning = NO;
  
  [self.view.layer addSublayer:self.capture.layer];
   [self setMaskView];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  [self applyOrientation];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator {
  [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
  [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
  } completion:^(id<UIViewControllerTransitionCoordinatorContext> context)
   {
     [self applyOrientation];
   }];
}
- (void)applyOrientation {
  UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
  float scanRectRotation;
  float captureRotation;
  
  switch (orientation) {
    case UIInterfaceOrientationPortrait:
      captureRotation = 0;
      scanRectRotation = 90;
      break;
    case UIInterfaceOrientationLandscapeLeft:
      captureRotation = 90;
      scanRectRotation = 180;
      break;
    case UIInterfaceOrientationLandscapeRight:
      captureRotation = 270;
      scanRectRotation = 0;
      break;
    case UIInterfaceOrientationPortraitUpsideDown:
      captureRotation = 180;
      scanRectRotation = 270;
      break;
    default:
      captureRotation = 0;
      scanRectRotation = 90;
      break;
  }
  self.capture.layer.frame = self.view.frame;
  CGAffineTransform transform = CGAffineTransformMakeRotation((CGFloat) (captureRotation / 180 * M_PI));
  [self.capture setTransform:transform];
  [self.capture setRotation:scanRectRotation];
  
  [self applyRectOfInterest:orientation];
}

- (void)applyRectOfInterest:(UIInterfaceOrientation)orientation {
  CGFloat scaleVideoX, scaleVideoY;
  CGFloat videoSizeX, videoSizeY;
    
  CGRect transformedVideoRect = CGRectMake((Screen_W - (Screen_W * 0.93)) * 0.5, (Screen_H - (Screen_W * 0.25)) * 0.4, Screen_W * 0.93, Screen_W * 0.4);
  if([self.capture.sessionPreset isEqualToString:AVCaptureSessionPreset1920x1080]) {
    videoSizeX = 1080;
    videoSizeY = 1920;
  } else {
    videoSizeX = 720;
    videoSizeY = 1280;
  }
  if(UIInterfaceOrientationIsPortrait(orientation)) {
    scaleVideoX = self.capture.layer.frame.size.width / videoSizeX;
    scaleVideoY = self.capture.layer.frame.size.height / videoSizeY;
    
    CGFloat realX = transformedVideoRect.origin.y;
    CGFloat realY = self.capture.layer.frame.size.width - transformedVideoRect.size.width - transformedVideoRect.origin.x;
    CGFloat realWidth = transformedVideoRect.size.height;
    CGFloat realHeight = transformedVideoRect.size.width;
    transformedVideoRect = CGRectMake(realX, realY, realWidth, realHeight);
    
  } else {
    scaleVideoX = self.capture.layer.frame.size.width / videoSizeY;
    scaleVideoY = self.capture.layer.frame.size.height / videoSizeX;
  }

  _captureSizeTransform = CGAffineTransformMakeScale(1.0/scaleVideoX, 1.0/scaleVideoY);
  self.capture.scanRect = CGRectApplyAffineTransform(transformedVideoRect, _captureSizeTransform);
}

/**
 *  添加遮罩层
 */
- (void)setMaskView
{
    self.maskView = [[LhkhScanMaskView alloc] initWithFrame:CGRectMake(0, 0, Screen_W, Screen_H) type:@"pdf417"];
    self.maskView.delegate = self;
    [self.view addSubview:self.maskView];
}

#pragma mark - LhkhScanMaskViewDelegate
- (void)LhkhScanMaskViewDelegateBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Private


#pragma mark - Private Methods


#pragma mark - ZXCaptureDelegate Methods

- (void)captureCameraIsReady:(ZXCapture *)capture {
  self.scanning = YES;
}

- (void)captureResult:(ZXCapture *)capture result:(ZXResult *)result
{
  if (!self.scanning) return;
  if (!result) return;

  // We got a result.
  [self.capture stop];
  self.scanning = NO;
    NSLog(@"---%@",result.text);
  
  // Vibrate
  AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
  
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
    self.scanning = YES;
    [self.capture start];
  });
}

@end

