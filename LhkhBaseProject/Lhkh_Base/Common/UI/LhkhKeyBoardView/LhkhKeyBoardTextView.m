//
//  LhkhKeyBoardTextView.m
//  KeyBoardTest
//
//  Created by LHKH on 2018/4/17.
//  Copyright © 2018年 LHKH. All rights reserved.
//

#import "LhkhKeyBoardTextView.h"
#import "Masonry.h"
#import <objc/runtime.h>
#import <objc/message.h>
@interface LhkhKeyBoardTextView()<UITextViewDelegate>
{
    NSInteger _remainingLen;
    NSString *_content;
}
@end

@implementation LhkhKeyBoardTextView

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.placeholderLabel];
        [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset = 7;
            make.leading.equalTo(self).offset = 6;
            make.width.equalTo(@200);
            make.height.equalTo(@16);
        }];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DidChange:) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - Layout SubViews




#pragma mark - System Delegate




#pragma mark - Custom Delegate




#pragma mark - Event Response

-(void)DidChange:(NSNotification*)noti
{
    if (self.text.length > 0) {
        self.placeholderLabel.hidden = YES;
    }else {
        self.placeholderLabel.hidden = NO;
    }
}




#pragma mark - Network requests




#pragma mark - Public Methods




#pragma mark - Private Methods




#pragma mark - Setters

- (UILabel *)placeholderLabel
{
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.text = self.placeholder?:@"写评论。。。";
        _placeholderLabel.textColor = [UIColor lightGrayColor];
        _placeholderLabel.font  = systemFontRegular(14);
        [_placeholderLabel sizeToFit];
        [self setValue:self.placeholderLabel forKey:@"_placeholderLabel"];
    }
    return _placeholderLabel;
}



#pragma mark - Getters



@end
