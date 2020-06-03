//
//  LhkhPickerView.h
//  Lhkh_Base
//
//  Created by Weapon Chen on 2017/10/23.
//  Copyright © 2017 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LhkhPickerView : UIPickerView
/**当前选中的title*/
@property (nonatomic, strong) NSString *selectedTitle;
+ (instancetype)pickerView:(NSArray *)pickerData single:(BOOL)isSingle;
+ (instancetype)pickerViewWithMore:(NSDictionary *)pickerData single:(BOOL)isSingle;
@end
