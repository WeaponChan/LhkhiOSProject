//
//  LhkhScanVC.h
//  TC
//
//  Created by Weapon Chen on 2020/1/19.
//  Copyright © 2020 YouJie. All rights reserved.
//

#import "LhkhBaseViewController.h"

@interface LhkhScanVC : LhkhBaseViewController
/** 扫描结果 */
@property (copy, nonatomic) void (^returnScanCodeValue)(NSString * codeString);
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *No;
@property (copy, nonatomic) NSString *Id;
@property (copy, nonatomic) NSString *className;
@end
