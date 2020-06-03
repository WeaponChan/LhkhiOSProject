//
//  LhkhLabel.m
//  TC
//
//  Created by Weapon Chen on 2019/11/8.
//  Copyright © 2019 YouJie. All rights reserved.
//

#import "LhkhLabel.h"

@interface LhkhLabel()
@property (strong, nonatomic)UIBezierPath *path;
@end

@implementation LhkhLabel

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}


#pragma mark - Layout SubViews
- (void)layoutCustomViews
{
    
}


#pragma mark - System Delegate


#pragma mark - Custom Delegate


#pragma mark - Event Response


#pragma mark - Network Requests


#pragma mark - Public Methods


#pragma mark - Private Methods
// pointArray
- (void)setPointArray:(NSArray *)pointArray
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (int i =0; i < pointArray.count; i++) {
        NSArray  *arr    = pointArray[i];
        NSString *xStr   = arr[0];
        NSString *yStr   = arr[1];
        CGFloat   x      = xStr.floatValue;
        CGFloat   y      = yStr.floatValue;
        if (i == 0) {
            [path moveToPoint:CGPointMake(x, y)];
            continue;
        }
        [path addLineToPoint:CGPointMake(x, y)];
    }
    [path stroke];
    [path closePath];
    [path fill];
    self.path = path;
}

// 绘制图形时添加path遮罩
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CAShapeLayer *shapLayer = [CAShapeLayer layer];
    shapLayer.path = self.path.CGPath;
    self.layer.mask = shapLayer;
}

#pragma mark - Setters


#pragma mark - Getters



@end
