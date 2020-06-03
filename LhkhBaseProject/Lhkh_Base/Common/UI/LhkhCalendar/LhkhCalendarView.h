//
//  LhkhCalendarView.h
//  NWMJ_B
//
//  Created by LHKH on 2018/4/24.
//  Copyright © 2018年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LhkhCalendarViewDelegate<NSObject>
- (void)LhkhCalendarViewDelegate:(NSString*)dateStr;
@end
@interface LhkhCalendarView : UIView
+ (instancetype)shareCalendarView;
@property(weak, nonatomic)id<LhkhCalendarViewDelegate>delegate;
@end
