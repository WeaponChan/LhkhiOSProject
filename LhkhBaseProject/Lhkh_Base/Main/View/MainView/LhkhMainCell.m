//
//  LhkhMainCell.m
//  Lhkh_Base
//
//  Created by Weapon Chen on 2020/6/5.
//  Copyright © 2020 Weapon Chen. All rights reserved.
//

#import "LhkhMainCell.h"

@interface LhkhMainCell ()
@property (strong, nonatomic)UILabel *itemTL;
@end

@implementation LhkhMainCell

#pragma mark - Life Cycle

static NSString * const kCellID = @"LhkhMainCell";

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    LhkhMainCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    if (!cell) {
        cell = [[LhkhMainCell alloc] initWithStyle:0 reuseIdentifier:kCellID];
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
        make.leading.equalTo(self.contentView).offset(15);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    UIView *lineV = [[UIView alloc]init];
    lineV.backgroundColor = Color_Line;
    [self.contentView addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self.contentView);
        make.height.offset(1);
    }];
}


#pragma mark - System Delegate


#pragma mark - Custom Delegate


#pragma mark - Event Response


#pragma mark - Network requests


#pragma mark - Public Methods
+ (CGFloat)cellHeight
{
    return 50;
}

- (void)configCellWithIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.row==0) {
        self.itemTL.text = @"IJKPlayer自定义样式测试";
    }else if(indexPath.row==1){
        self.itemTL.text = @"LhkhWeb测试";
    }
}
#pragma mark - Private Methods


#pragma mark - Setters
- (UILabel*)itemTL
{
    if (!_itemTL) {
        _itemTL = [[UILabel alloc] init];
        _itemTL.textColor = Color_MainText;
        _itemTL.font = systemFontRegular(16);
    }
    return _itemTL;
}

#pragma mark - Getters


@end
