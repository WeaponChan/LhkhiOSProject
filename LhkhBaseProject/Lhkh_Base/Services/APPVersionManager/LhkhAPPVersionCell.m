//
//  LhkhAPPVersionCell.m
//  TC
//
//  Created by Weapon Chen on 2020/2/12.
//  Copyright © 2020 YouJie. All rights reserved.
//

#import "LhkhAPPVersionCell.h"

@interface LhkhAPPVersionCell ()
@property (strong, nonatomic)UILabel *itemTL;
@end

@implementation LhkhAPPVersionCell

#pragma mark - Life Cycle

static NSString * const kCellID = @"LhkhAPPVersionCell";

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    LhkhAPPVersionCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    if (!cell) {
        cell = [[LhkhAPPVersionCell alloc] initWithStyle:0 reuseIdentifier:kCellID];
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self layoutCustomViews];
    }
    return self;
}


#pragma mark - Layout SubViews
- (void)layoutCustomViews
{
    [self.contentView addSubview:self.itemTL];
    [self.itemTL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(30);
        make.trailing.equalTo(self.contentView).offset(-30);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
}


#pragma mark - System Delegate


#pragma mark - Custom Delegate


#pragma mark - Event Response


#pragma mark - Network requests


#pragma mark - Public Methods
+ (CGFloat)cellHeight
{
    return UITableViewAutomaticDimension;
}

- (void)configCellWithDesc:(NSString*)desc indexPath:(NSIndexPath*)indexPath;
{
    self.itemTL.text = [NSString stringWithFormat:@"%@",desc];
}
#pragma mark - Private Methods


#pragma mark - Setters
- (UILabel*)itemTL
{
    if (!_itemTL) {
        _itemTL = [[UILabel alloc] initWithFrame:CGRectZero];
        _itemTL.textColor = Color_MainText;
        _itemTL.textAlignment = NSTextAlignmentLeft;
        _itemTL.font = systemFontRegular(14);
        _itemTL.numberOfLines = 0;
    }
    return _itemTL;
}

#pragma mark - Getters


@end
