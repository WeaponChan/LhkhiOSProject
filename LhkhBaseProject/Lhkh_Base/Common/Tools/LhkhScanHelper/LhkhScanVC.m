//
//  LhkhScanVC.m
//  TC
//
//  Created by Weapon Chen on 2020/1/19.
//  Copyright © 2020 YouJie. All rights reserved.
//

#import "LhkhScanVC.h"
#import "LhkhScanMaskView.h"
#import <AVFoundation/AVFoundation.h>
#import <ImageIO/ImageIO.h>
#import "LhkhKeyWindowManager.h"
@interface LhkhScanVC ()<AVCaptureMetadataOutputObjectsDelegate,LhkhScanMaskViewDelegate>
{
    NSString *_present;
}
/** 设备 */
@property (strong, nonatomic) AVCaptureDevice * device;
/** 输入输出的中间桥梁 */
@property (strong, nonatomic) AVCaptureSession * session;
/** 相机图层 */
@property (strong, nonatomic) AVCaptureVideoPreviewLayer * previewLayer;
/** 扫描支持的编码格式的数组 */
@property (strong, nonatomic) NSMutableArray * metadataObjectTypes;
/** 遮罩层 */
@property (strong, nonatomic) LhkhScanMaskView * maskView;
@end

@implementation LhkhScanVC

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self checkCamera];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([_present isEqualToString:@"1"]) {
        [self.session startRunning];
    }
}

#pragma mark - Layout SubViews
/**
 *  添加遮罩层
 */
- (void)setMaskView
{
    self.maskView = [[LhkhScanMaskView alloc] initWithFrame:CGRectMake(0, 0, Screen_W, Screen_H) type:self.type];
    self.maskView.delegate = self;
    [self.view addSubview:self.maskView];
}

/**
 *  扫描初始化
 */
- (void)setCapture
{
    //获取摄像设备
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    //创建输出流
    AVCaptureMetadataOutput * metadataOutput = [[AVCaptureMetadataOutput alloc] init];
    //设置代理 在主线程里刷新
    [metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    CGRect rect = CGRectMake(0, 0, 0, 0);
    
    if ([self.type isEqualToString:@"lottery"]) {//扫彩票pdf-417码的
        rect = CGRectMake((Screen_W - (Screen_W * 0.93)) * 0.5, (Screen_H - (Screen_W * 0.25)) * 0.4, Screen_W * 0.93, Screen_W * 0.4);
    }else{//普通二维码
        rect = CGRectMake(0.16, (Screen_H - (Screen_W * 0.68)) * 0.5, Screen_W * 0.68, Screen_W * 0.68);
    }
    
    CGFloat x,y,width,height;
    
    x = rect.origin.y / Screen_H;
    y = rect.origin.x / Screen_W;
    width = rect.size.height / Screen_H;
    height = rect.size.width / Screen_W;
    
    metadataOutput.rectOfInterest = CGRectMake(x, y, width, height);
    
    //初始化链接对象
    self.session = [[AVCaptureSession alloc] init];
    //高质量采集率
    self.session.sessionPreset = AVCaptureSessionPresetHigh;
    
    [self.session addInput:input];
    [self.session addOutput:metadataOutput];
    
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.previewLayer.frame = CGRectMake(0, 0, Screen_W, Screen_H);
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.previewLayer.backgroundColor = [UIColor yellowColor].CGColor;
    [self.view.layer addSublayer:self.previewLayer];
    
    //设置扫描支持的编码格式(如下设置条形码和二维码兼容)
    metadataOutput.metadataObjectTypes = self.metadataObjectTypes;
    
    //开始捕获
    [self.session startRunning];
}

#pragma mark - System Delegate
#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count > 0) {
        [self.session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = metadataObjects.firstObject;
        DLog(@"------>%@",metadataObject.stringValue);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self->_present = @"1";
            
        });
    }
}

#pragma mark - Custom Delegate
#pragma mark - LhkhScanMaskViewDelegate
- (void)LhkhScanMaskViewDelegateBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Event Response


#pragma mark - Network Requests


#pragma mark - Public Methods


#pragma mark - Private Methods
- (void)checkCamera
{
    AVAuthorizationStatus videoAuthStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (videoAuthStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                // 授权成功
                DLog(@"允许");
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self setCapture];
                    [self setMaskView];
                });
            }else{
                // 授权失败
                dispatch_async(dispatch_get_main_queue(), ^{
                    [UIAlertController lhkh_alertAviewWithTarget:self andAlertTitle:nil andMessage:@"无法使用您的相机，请前往设置里开启App相机权限" andDefaultActionTitle:@"确定" Handler:^(UIAlertAction *action) {
                        NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                        if([[UIApplication sharedApplication] canOpenURL:url]) {
                            [[UIApplication sharedApplication] openURL:url];
                        }
                    } completion:nil];
                });
            }
        }];
    }else{
        if (videoAuthStatus != AVAuthorizationStatusAuthorized) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIAlertController lhkh_alertAviewWithTarget:self andAlertTitle:nil andMessage:@"无法使用您的相机，请前往设置里开启App相机权限" andDefaultActionTitle:@"确定" Handler:^(UIAlertAction *action) {
                    NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    if([[UIApplication sharedApplication] canOpenURL:url]) {
                        [[UIApplication sharedApplication] openURL:url];
                    }
                } completion:nil];
            });
            
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setCapture];
                [self setMaskView];
            });
        }
    }
}

#pragma mark - Setters
- (NSMutableArray *)metadataObjectTypes
{
    if (!_metadataObjectTypes) {
        _metadataObjectTypes = [NSMutableArray arrayWithObjects:AVMetadataObjectTypeAztecCode, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode39Mod43Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeQRCode, AVMetadataObjectTypeUPCECode, nil];
        
        // >= iOS 8
        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1) {
            [_metadataObjectTypes addObjectsFromArray:@[AVMetadataObjectTypeInterleaved2of5Code, AVMetadataObjectTypeITF14Code, AVMetadataObjectTypeDataMatrixCode]];
        }
    }
    
    return _metadataObjectTypes;
}

#pragma mark - Getters


@end
