//
//  TCLocationManager.m
//  TC
//
//  Created by Weapon Chen on 2019/10/29.
//  Copyright © 2019 YouJie. All rights reserved.
//

#import "TCLocationManager.h"

static NSInteger count = 0;
static TCLocationManager * __m=nil;

@interface TCLocationManager ()<CLLocationManagerDelegate>
{
    CLLocationManager * _manager;
    void(^_success)(id obj);
    void(^_failed)(NSError * error);
}
@end

@implementation TCLocationManager

+(instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __m = [[TCLocationManager alloc] init];
    });
    return __m;
}

-(void)getLocationWithSuccess:(void(^)(id obj))success failed:(void(^)(NSError * error))failed
{
    _success=success;
    _failed=failed;
    //判断系统定位服务有没有打开
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];

    if (kCLAuthorizationStatusDenied == status || kCLAuthorizationStatusRestricted == status) {
        NSError * error = [NSError errorWithDomain:@"定位失败：系统定位服务未打开" code:100 userInfo:nil];
        _failed(error);
    }else{
        if ([CLLocationManager locationServicesEnabled])
        {
            if (_manager==nil)
            {
                _manager=[[CLLocationManager alloc] init];
            }
            [_manager requestWhenInUseAuthorization];
            _manager.delegate = self;
            _manager.desiredAccuracy=kCLLocationAccuracyBest;
            _manager.distanceFilter = 20;
            [_manager startUpdatingLocation];
        }else{
            if (_failed)
            {
                NSError * error = [NSError errorWithDomain:@"定位失败：系统定位服务未打开" code:100 userInfo:nil];
                _failed(error);
            }
        }
    }
    
}

- (void)reGetLocation:(id)target
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];

    if (kCLAuthorizationStatusDenied == status || kCLAuthorizationStatusRestricted == status) {
        [UIAlertController lhkh_alertAviewWithTarget:target andAlertTitle:@"请到“设置->隐私->定位服务”中开启【青海体彩】定位服务"  andMessage:@"" andDefaultActionTitle:@"去设置" dHandler:^(UIAlertAction *action){
            
            NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if([[UIApplication sharedApplication] canOpenURL:url]) {
                NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
                [[UIApplication sharedApplication] openURL:url];
            }
        } andCancelActionTitle:@"取消" cHandler:nil completion:nil];
    }else{
        
       if (_manager==nil)
        {
            _manager=[[CLLocationManager alloc] init];
        }
        [_manager requestWhenInUseAuthorization];
        _manager.delegate = self;
        _manager.desiredAccuracy=kCLLocationAccuracyBest;
        _manager.distanceFilter = 20;
        [_manager startUpdatingLocation];
    }
}


#pragma mark--CLLocationManagerDelegate
//定位失败
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if (count == 1) {
        return;
    }
    if (_failed)
    {
        _failed(error);
    }
    count ++ ;
}

//定位成功
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    if (locations.count>0)
    {
        CLLocation * lo = locations.firstObject;
        NSString *lat = [NSString stringWithFormat:@"%f",lo.coordinate.latitude];
        NSString *lon = [NSString stringWithFormat:@"%f",lo.coordinate.longitude];
        LhkhSetUserDefaults(lat, Lhkh_LocationCoordinate_lat);
        LhkhSetUserDefaults(lon, Lhkh_LocationCoordinate_lon);
        
        NSTimeInterval locationAge = - [lo.timestamp timeIntervalSinceNow];
        if (locationAge > 1.0) {
            return;
        }else {
            if (_success)
            {
                _success(lo);
            }
        }
        [_manager stopUpdatingLocation];
    }
    
    CLGeocoder *geCoder = [[CLGeocoder alloc] init];
    [geCoder reverseGeocodeLocation:locations.firstObject completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
       if (placemarks.count>0 && error == nil) {
           NSString *state = [placemarks lastObject].administrativeArea;
           NSString *currentCity = [placemarks lastObject].locality;
           NSString *block = [placemarks lastObject].subLocality;
           NSString *road = [placemarks lastObject].thoroughfare;
           DLog(@"%@-%@-%@",currentCity,block,road);
           NSString *currentCityA = StringConnect(currentCity, @"·");
           NSString *locationA = StringConnect(currentCityA, block);
           LhkhSetUserDefaults(locationA, Lhkh_Location);
           LhkhSetUserDefaults(state, Lhkh_LocationP);
           LhkhSetUserDefaults(currentCity, Lhkh_LocationC);
           LhkhSetUserDefaults(block, Lhkh_LocationD);
           
       }else {
           DLog(@"%@",error);
       }
    }];
     
}

@end
