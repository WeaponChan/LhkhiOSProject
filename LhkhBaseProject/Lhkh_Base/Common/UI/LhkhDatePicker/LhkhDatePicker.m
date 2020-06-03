//
//  LhkhDatePicker.m
//  Luggage_packing
//
//  Created by LHKH on 2019/9/16.
//  Copyright © 2019 LHKH. All rights reserved.
//
#define  VIEW_HEIGHT   216.0f
#import "LhkhDatePicker.h"

@interface LhkhDatePicker()
{
    UIDatePickerMode _mode;
}
@end

@implementation LhkhDatePicker

#pragma mark - Life Cycle

+ (instancetype)datePicker {
    return [[[self class] alloc] initWithFrame:CGRectMake(0, 0, 0, VIEW_HEIGHT)];
}

+ (instancetype)datePickerWithMode:(UIDatePickerMode)mode
{
    return [[[self class] alloc] initWithFrame:CGRectMake(0, 0, 0, VIEW_HEIGHT) mode:mode];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setLocale:[NSLocale localeWithLocaleIdentifier:@"zh-CN"]];
        self.datePickerMode = UIDatePickerModeDate;
        self.minimumDate = [self formatterFromString:@"1900-01-01"];
        self.maximumDate = [NSDate date];
        self.currentDate = [self formatterFromDate:self.date];
        [self addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame mode:(UIDatePickerMode)mode
{
    if (self = [super initWithFrame:frame]) {
        _mode = mode;
        [self setLocale:[NSLocale localeWithLocaleIdentifier:@"zh-CN"]];
        self.datePickerMode = mode;
        self.minimumDate = [self formatterFromString:@"1900-01-01"];
        self.currentDate = [self formatterFromDateTime:self.date];
        [self addTarget:self action:@selector(dateTimeChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}


#pragma mark - Layout SubViews
- (void)layoutCustomViews
{
    
}


#pragma mark - System Delegate


#pragma mark - Custom Delegate


#pragma mark - Event Response


#pragma mark - Network Requests


#pragma mark - Public Methods


#pragma mark - Private Methods
- (void)dateChanged:(LhkhDatePicker *)picker {
    self.currentDate = [self formatterFromDate:self.date];
}

- (void)dateTimeChanged:(LhkhDatePicker *)picker {
    self.currentDate = [self formatterFromDateTime:self.date];
}

- (NSDate *)formatterFromString:(NSString *)dateStr {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter dateFromString:dateStr];
}

- (NSString *)formatterFromDateTime:(NSDate *)date {

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

- (NSString *)formatterFromDate:(NSDate *)date {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
    
//    NSRange range0 = {0,2};
//    NSRange range1 = {3,2};
//    NSRange range2 = {4,4};
//    NSString *month = [dateStr substringWithRange:range0];
//    NSString *day = [dateStr substringWithRange:range1];
//    NSString *year = [dateStr substringWithRange:range2];
//    NSString *monthstr = @"";
//    if ([month isEqualToString:@"01"]) {
//        monthstr = @"1";
//    }else if ([month isEqualToString:@"02"]){
//        monthstr = @"2";
//    }else if ([month isEqualToString:@"03"]){
//        monthstr = @"3";
//    }else if ([month isEqualToString:@"04"]){
//        monthstr = @"4";
//    }else if ([month isEqualToString:@"05"]){
//        monthstr = @"5";
//    }else if ([month isEqualToString:@"06"]){
//        monthstr = @"6";
//    }else if ([month isEqualToString:@"07"]){
//        monthstr = @"7";
//    }else if ([month isEqualToString:@"08"]){
//        monthstr = @"8";
//    }else if ([month isEqualToString:@"09"]){
//        monthstr = @"9";
//    }else if ([month isEqualToString:@"10"]){
//        monthstr = @"10";
//    }else if ([month isEqualToString:@"11"]){
//        monthstr = @"11";
//    }else if ([month isEqualToString:@"12"]){
//        monthstr = @"12";
//    }
////    return [NSString stringWithFormat:@"%@ %@, %@",monthstr,day,year];
//    return [NSString stringWithFormat:@"%@-%@-",year,monthstr];
}

#pragma mark - Setters


#pragma mark - Getters



@end
