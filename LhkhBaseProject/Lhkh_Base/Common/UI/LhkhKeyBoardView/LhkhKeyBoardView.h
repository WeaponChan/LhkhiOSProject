//
//  LhkhKeyBoardView.h
//  KeyBoardTest
//
//  Created by LHKH on 2018/4/16.
//  Copyright © 2018年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LhkhKeyBoardTextView.h"
@class LhkhKeyBoardToolBar;
@protocol LhkhKeyBoardViewDelegate<NSObject>
- (void)LhkhKeyBoardViewDelegateClick:(NSInteger)btntag text:(NSString*)text;
@end
@interface LhkhKeyBoardView : UIView<UITextViewDelegate>
@property(strong, nonatomic)LhkhKeyBoardTextView *textView;//输入框view
@property(strong, nonatomic)UIButton             *sendButton;//发送按钮
@property(assign, nonatomic)CGFloat              viewHeight;
@property BOOL isKeyBoardShow;
@property(weak, nonatomic)id<LhkhKeyBoardViewDelegate>delegate;
+ (instancetype)keyboardView:(CGFloat)keyboardViewHeight;
- (void)keyboardShowInView:(UIView*)view  height:(CGFloat)keyboardViewHeight;
- (void)endEditing;
@end
