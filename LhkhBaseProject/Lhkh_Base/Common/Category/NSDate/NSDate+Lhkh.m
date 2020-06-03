//
//  NSDate+Lhkh.m
//  Lhkh_Base
//
//  Created by Weapon Chen on 2020/6/2.
//  Copyright © 2020 Weapon Chen. All rights reserved.
//

#import "NSDate+Lhkh.h"

@implementation NSDate (Lhkh)

- (NSInteger)day
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitDay fromDate:self];
    return [components day];
}

- (NSInteger)month
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitMonth fromDate:self];
    return [components month];
}

- (NSInteger)year
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitYear fromDate:self];
    return [components year];
}

+(NSString *)stringWithTimestamp:(NSTimeInterval)tt format:(NSString *)format
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:tt];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}

@end
