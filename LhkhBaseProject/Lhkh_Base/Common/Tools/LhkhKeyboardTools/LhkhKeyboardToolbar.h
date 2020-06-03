//
//  LhkhKeyboardToolbar.h
//  Luggage_packing
//
//  Created by LHKH on 2019/9/16.
//  Copyright © 2019 LHKH. All rights reserved.
//

typedef enum {
    LhkhKeyboardToolbarItemPrevious = 0,      //工具条 "上一个" 按钮
    LhkhKeyboardToolbarItemNext,              //工具条 "下一个" 按钮
    LhkhKeyboardToolbarItemClose,              //工具条 "关闭" 按钮
    LhkhKeyboardToolbarItemDone,              //工具条 "完成" 按钮
} LhkhKeyboardToolbarItem;

#import <UIKit/UIKit.h>
@class LhkhKeyboardToolbar;
@protocol LhkhKeyboardToolbarDelegate <NSObject>
@optional
- (void)toolbar:(LhkhKeyboardToolbar *)toolbar DidClicked:(LhkhKeyboardToolbarItem)item;
@end

@interface LhkhKeyboardToolbar : UIToolbar
@property (nonatomic, weak) id <LhkhKeyboardToolbarDelegate> toolbarDelegate;
@property (nonatomic, weak, readonly) UIBarButtonItem *previousItem;
@property (nonatomic, weak, readonly) UIBarButtonItem *nextItem;
@property (nonatomic, weak, readonly) UIBarButtonItem *closeItem;
@property (nonatomic, weak, readonly) UIBarButtonItem *doneItem;

/**
 快速构造键盘工具条
 
 @return JSKeyboardToolbar
 */
+ (instancetype)keyboardToolbar;

+ (instancetype)keyboardToolbarWithDoneItem;

@end
