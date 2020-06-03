//
//  LhkhDatePicker.h
//  Luggage_packing
//
//  Created by LHKH on 2019/9/16.
//  Copyright © 2019 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LhkhDatePicker : UIDatePicker
@property (nonatomic, strong) NSString *currentDate;
/**构建日期选择器*/
+ (instancetype)datePicker;
+ (instancetype)datePickerWithMode:(UIDatePickerMode)mode;
@end
