//
//  LhkhKeyBoardTextView.h
//  KeyBoardTest
//
//  Created by LHKH on 2018/4/17.
//  Copyright © 2018年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LhkhKeyBoardTextView : UITextView
@property (nonatomic, strong) UILabel      *placeholderLabel;//提示文字控件
@property (nonatomic, strong) UIColor      *placeholderColor;//提示文字颜色
@property (nonatomic, strong) UIFont       *placeholderFont;//提示文字大小
@property (nonatomic, copy)   NSString     *placeholder;//提示文字
@property (nonatomic, assign) NSInteger    number;//限定字数

@end
