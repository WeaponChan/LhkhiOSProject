//
//  LhkhKeyBoardView.m
//  KeyBoardTest
//
//  Created by LHKH on 2018/4/16.
//  Copyright © 2018年 LHKH. All rights reserved.
//
#define  SCREEN_WIDTH     [UIApplication sharedApplication].keyWindow.bounds.size.width
#define  SCREEN_HEIGHT    [UIApplication sharedApplication].keyWindow.bounds.size.height
#define  KEYBOARDVIEW_HEIGHT 50
#import "LhkhKeyBoardView.h"
#import "Masonry.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface LhkhKeyBoardView()
{
    UIView *_superView;
}
@end

@implementation LhkhKeyBoardView

#pragma mark - Life Cycle

+ (instancetype)keyboardView:(CGFloat)keyboardViewHeight
{
    return [[[self class] alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-keyboardViewHeight?:KEYBOARDVIEW_HEIGHT, SCREEN_WIDTH, keyboardViewHeight?:KEYBOARDVIEW_HEIGHT)];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = Color_White;
        [self addSubview:self.textView];
        [self addSubview:self.sendButton];
        [self setContraints];
        [self registerNotifacation];
    }
    return self;
}


#pragma mark - Layout SubViews

- (void)setContraints
{
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(30);
        make.width.offset(SCREEN_WIDTH-80);
        make.leading.equalTo(self).offset(10);
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-10);
    }];
    
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(30);
        make.width.offset(50);
        make.bottom.equalTo(self).offset(-10);
        make.trailing.equalTo(self).offset(-10);
    }];
}


#pragma mark - System Delegate




#pragma mark - Custom Delegate


#pragma mark - Event Response

- (void)keyboardWillShow:(NSNotification *)notification
{

    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self convertRect:keyboardRect fromView:nil];
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, SCREEN_HEIGHT-keyboardRect.size.height-self.viewHeight?:KEYBOARDVIEW_HEIGHT, SCREEN_WIDTH, self.viewHeight?:KEYBOARDVIEW_HEIGHT);
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, SCREEN_HEIGHT-self.viewHeight?:KEYBOARDVIEW_HEIGHT, SCREEN_WIDTH, self.viewHeight?:KEYBOARDVIEW_HEIGHT);
    }];
}

- (void)keyboardDidHide:(NSNotification *)notification
{
    
}


- (void)sendClick:(UIButton*)sender
{
    if ([self.delegate respondsToSelector:@selector(LhkhKeyBoardViewDelegateClick:text:)]) {
        [self.delegate LhkhKeyBoardViewDelegateClick:sender.tag text:self.textView.text];
        self.textView.text = @"";
    }
}


#pragma mark - Network requests




#pragma mark - Public Methods

- (void)keyboardShowInView:(UIView*)view height:(CGFloat)keyboardViewHeight
{
    self.viewHeight = keyboardViewHeight;
    [view addSubview:self];
    [self.textView becomeFirstResponder];
}

- (void)endEditing
{
    [self endEditing:YES];
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, SCREEN_HEIGHT-self.viewHeight?:KEYBOARDVIEW_HEIGHT, SCREEN_WIDTH, self.viewHeight?:KEYBOARDVIEW_HEIGHT);
    }];
}

#pragma mark - Private Methods

- (void)registerNotifacation
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}

- (void)textviewBegainEdit
{
    self.textView.editable = YES;
    self.textView.placeholderLabel.hidden = NO;
    [self.textView becomeFirstResponder];
}

#pragma mark - Setters


- (LhkhKeyBoardTextView*)textView
{
    if (_textView == nil) {
        _textView = [[LhkhKeyBoardTextView alloc]init];
        _textView.backgroundColor = Color_MainBg;
        _textView.delegate = self;
        _textView.font = systemFontRegular(14);
        LhkhViewCorner(_textView, 2);
    }
    return _textView;
}

- (UIButton*)sendButton
{
    if (_sendButton == nil) {
        _sendButton = [[UIButton alloc] init];
        _sendButton.backgroundColor = Color_Theme_Red;
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [_sendButton setTitleColor:Color_White forState:UIControlStateNormal];
        _sendButton.titleLabel.font = systemFontRegular(14);
        LhkhViewCorner(_sendButton, 2);
        [_sendButton addTarget:self action:@selector(sendClick:) forControlEvents:UIControlEventTouchUpInside];
        _sendButton.tag = 200;
    }
    return _sendButton;
}

#pragma mark - Getters



@end
