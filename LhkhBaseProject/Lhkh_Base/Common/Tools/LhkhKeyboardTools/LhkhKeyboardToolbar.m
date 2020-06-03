//
//  LhkhKeyboardToolbar.m
//  Luggage_packing
//
//  Created by LHKH on 2019/9/16.
//  Copyright © 2019 LHKH. All rights reserved.
//

#define  SCREEN_WIDTH     [[UIScreen mainScreen] bounds].size.width
#define  Screen_HEIGHT    [[UIScreen mainScreen] bounds].size.height
#define  TOOLBAR_HEIGHT   44.0f

#import "LhkhKeyboardToolbar.h"

@interface LhkhKeyboardToolbar()
@property (nonatomic, strong) NSMutableArray *optionButtonItems;
@end

@implementation LhkhKeyboardToolbar

#pragma mark - Life Cycle
+ (instancetype)keyboardToolbar
{
    return [[[self class] alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TOOLBAR_HEIGHT)];
}


+ (instancetype)keyboardToolbarWithDoneItem
{
    return [[[self class] alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TOOLBAR_HEIGHT) withDoneItem:YES];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //上一个
        UIBarButtonItem *previousItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home-keyboardItem-up"] style:UIBarButtonItemStylePlain target:self action:@selector(itemDidClick:)];
        _previousItem = previousItem;
        
        [self.optionButtonItems addObject:self.previousItem];
        
        //下一个
        UIBarButtonItem *nextItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home-keyboardIem-down"] style:UIBarButtonItemStylePlain target:self action:@selector(itemDidClick:)];
        _nextItem = nextItem;
        
        [self.optionButtonItems addObject:self.nextItem];
        
        //完成
        UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(itemDidClick:)];
        _doneItem = doneItem;
        
        //弹簧
        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        //填充
        UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        
        self.items = [NSArray arrayWithObjects:self.previousItem,self.nextItem,flexibleSpace,self.doneItem,fixedSpace, nil];
        [self setItems:self.items];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame withDoneItem:(BOOL)state
{
    if (self = [super initWithFrame:frame]) {

//        UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"取消"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(itemDidClick:)];
        UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(itemDoneDidClick:)];
        _closeItem = closeItem;
        [self.optionButtonItems addObject:self.closeItem];
        
        //完成
        UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(itemDoneDidClick:)];
        _doneItem = doneItem;
        
        //弹簧
        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        //填充
        UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        
        self.items = [NSArray arrayWithObjects:self.closeItem,fixedSpace,flexibleSpace,self.doneItem,fixedSpace, nil];
        [self setItems:self.items];
        
    }
    return self;
    
}


#pragma mark - Layout SubViews


#pragma mark - System Delegate


#pragma mark - Custom Delegate


#pragma mark - Event Response
- (void)itemDoneDidClick:(UIBarButtonItem *)item
{
    
    NSInteger itemIndex = [self.items indexOfObject:item];
    DLog(@"%ld",itemIndex);
    if ([self.toolbarDelegate respondsToSelector:@selector(toolbar:DidClicked:)] == NO) {
        return;
    }else {
        if (itemIndex == 0) {
            [self.toolbarDelegate toolbar:self DidClicked:LhkhKeyboardToolbarItemClose];
        }
        if (itemIndex == 3) {
            [self.toolbarDelegate toolbar:self DidClicked:LhkhKeyboardToolbarItemDone];
        }
    }
}


- (void)itemDidClick:(UIBarButtonItem *)item
{
    
    NSInteger itemIndex = [self.items indexOfObject:item];
    DLog(@"%ld",itemIndex);
    if ([self.toolbarDelegate respondsToSelector:@selector(toolbar:DidClicked:)] == NO) {
        return;
    }else {
        if (itemIndex == 0) {
            [self.toolbarDelegate toolbar:self DidClicked:LhkhKeyboardToolbarItemPrevious];
        }
        if (itemIndex == 1) {
            [self.toolbarDelegate toolbar:self DidClicked:LhkhKeyboardToolbarItemNext];
        }
        if (itemIndex == 3) {
            [self.toolbarDelegate toolbar:self DidClicked:LhkhKeyboardToolbarItemDone];
        }
    }
}

#pragma mark - Network Requests


#pragma mark - Public Methods



- (NSMutableArray *)optionButtonItems
{
    if (!_optionButtonItems) {
        _optionButtonItems = [NSMutableArray array];
    }
    return _optionButtonItems;
}

#pragma mark - Private Methods


#pragma mark - Setters


#pragma mark - Getters



@end
