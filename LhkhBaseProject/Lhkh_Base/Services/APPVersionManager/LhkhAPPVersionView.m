//
//  LhkhAPPVersionView.m
//  TC
//
//  Created by Weapon Chen on 2020/2/11.
//  Copyright © 2020 YouJie. All rights reserved.
//

#import "LhkhAPPVersionView.h"
#import "LhkhAPPVersionCell.h"
#import "LhkhAppVersionModel.h"
@interface LhkhAPPVersionView()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic)UIView *maskView;
@property (strong, nonatomic)UILabel *itemTL;
@property (strong, nonatomic)LhkhAppVersionModel *model;
@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic)NSMutableArray *appdescA;
@property (weak, nonatomic)UIView *btnV;
@property (weak, nonatomic)UIView *ljbtnV;
@end

@implementation LhkhAPPVersionView

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self layoutCustomViews];
    }
    return self;
}


#pragma mark - Layout SubViews
- (void)layoutCustomViews
{
    UIView *maskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    maskView.backgroundColor = Color_Black;
    maskView.layer.opacity = 0.5;
    [self addSubview:maskView];
    self.maskView = maskView;
    UIView *conV = [[UIView alloc] initWithFrame:CGRectZero];
    conV.backgroundColor = Color_White;
    [self addSubview:conV];
    [conV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.height.offset(330);
        make.width.offset(270);
    }];
    LhkhViewCorner(conV, 10);
    
    UIImageView *topImgV = [[UIImageView alloc] initWithFrame:CGRectZero];
    topImgV.image = Image(@"app_update");
    [conV addSubview:topImgV];
    [topImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.equalTo(conV);
        make.height.offset(100);
    }];
    
    UILabel *itemL = [[UILabel alloc] initWithFrame:CGRectZero];
    itemL.text = @"新版本";
    itemL.textColor = Color_White;
    itemL.font = systemFontBold(24);
    [conV addSubview:itemL];
    [itemL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(conV).offset(35);
        make.leading.equalTo(conV).offset(30);
        make.height.offset(25);
        make.width.offset(80);
    }];
    
    [conV addSubview:self.itemTL];
    [self.itemTL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(conV).offset(32);
        make.leading.equalTo(itemL.mas_trailing);
        make.width.offset(45);
        make.height.offset(16);
    }];
    LhkhViewCorner(self.itemTL, 8);

    [conV addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(conV);
        make.top.equalTo(topImgV.mas_bottom).offset(10);
        make.bottom.equalTo(conV).offset(-45);
    }];

    UIView *btnView = [[UIView alloc] initWithFrame:CGRectZero];
    [conV addSubview:btnView];
    [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(conV);
        make.bottom.equalTo(conV).offset(-20);
        make.height.offset(30);
    }];
    self.btnV = btnView;
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [cancelBtn setBackgroundColor:Color_MainBg];
    cancelBtn.tag = 0;
    [cancelBtn setTitle:@"暂不升级" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:Color_MainText forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = systemFontRegular(14);
    [cancelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:cancelBtn];
    LhkhViewCorner(cancelBtn, 5);
    
    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [sureBtn setBackgroundColor:Color_Theme_Red];
    sureBtn.tag = 1;
    [sureBtn setTitle:@"立即升级" forState:UIControlStateNormal];
    [sureBtn setTitleColor:Color_White forState:UIControlStateNormal];
    sureBtn.titleLabel.font = systemFontRegular(14);
    [sureBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:sureBtn];
    LhkhViewCorner(sureBtn, 5);
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnView);
        make.leading.equalTo(btnView).offset(30);
        make.width.offset(100);
        make.height.offset(30);
    }];
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(btnView).offset(-30);
        make.top.equalTo(btnView);
        make.width.offset(100);
        make.height.offset(30);
    }];
    
    UIView *ljbtnView = [[UIView alloc] initWithFrame:CGRectZero];
    [conV addSubview:ljbtnView];
    [ljbtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(conV);
        make.bottom.equalTo(conV).offset(-20);
        make.height.offset(30);
    }];
    self.ljbtnV = ljbtnView;
    
    UIButton *ljsureBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [ljsureBtn setBackgroundColor:Color_Theme_Red];
    ljsureBtn.tag = 2;
    [ljsureBtn setTitle:@"立即升级" forState:UIControlStateNormal];
    [ljsureBtn setTitleColor:Color_White forState:UIControlStateNormal];
    ljsureBtn.titleLabel.font = systemFontRegular(14);
    [ljsureBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [ljbtnView addSubview:ljsureBtn];
    LhkhViewCorner(ljsureBtn, 5);
    [ljsureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ljbtnView);
        make.leading.equalTo(ljbtnView).offset(30);
        make.trailing.equalTo(ljbtnView).offset(-30);
        make.height.offset(30);
    }];
}


#pragma mark - System Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.appdescA.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LhkhAPPVersionCell *cell = [LhkhAPPVersionCell cellWithTableView:tableView];
    [cell configCellWithDesc:self.appdescA[indexPath.row] indexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [LhkhAPPVersionCell cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
#pragma mark - Custom Delegate


#pragma mark - Event Response
- (void)btnClick:(UIButton*)sender
{
//    if (sender.tag ==0) {
//        LhkhSetUserDefaults(@"1", Lhkh_AppVersionCancel);
//        [self dismiss];
//    }else{
//        [self dismiss];
//        NSURL *url = [NSURL URLWithString:@"https://apps.apple.com/cn/app/%E9%9D%92%E6%B5%B7%E4%BD%93%E5%BD%A9/id1507302615?mt=8"];
//        [[UIApplication sharedApplication] openURL:url];
//    }
}

#pragma mark - Network Requests


#pragma mark - Public Methods
- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)dismiss
{
    [self removeFromSuperview];
}

- (void)configViewWithModel:(LhkhAppVersionModel*)model
{
    self.model = model;
    if ([model.IsMust isEqualToString:@"1"]) {
        self.ljbtnV.hidden = NO;
        self.btnV.hidden = YES;
    }else{
        self.ljbtnV.hidden = YES;
        self.btnV.hidden = NO;
    }
    NSString *descS = model.AppVersionName;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:descS];
    CGAffineTransform matrix = CGAffineTransformMake(1, 0, tanf(5 * (CGFloat)M_PI / 180), 1, 0, 0);
    UIFontDescriptor *desc = [UIFontDescriptor fontDescriptorWithName:[UIFont systemFontOfSize:12].fontName matrix:matrix];
    [attributedString addAttributes:@{NSForegroundColorAttributeName:Color_Theme_Red,  NSFontAttributeName:[UIFont fontWithDescriptor:desc size:12]} range:NSMakeRange(0, descS.length)];
    self.itemTL.attributedText = attributedString;
    
    NSArray *tempA = [model.Description componentsSeparatedByString:@"$"];
    [self.appdescA removeAllObjects];
    [self.appdescA addObjectsFromArray:tempA];
    [self.tableView reloadData];
}

#pragma mark - Private Methods


#pragma mark - Setters
- (UILabel*)itemTL
{
    if (!_itemTL) {
        _itemTL = [[UILabel alloc] initWithFrame:CGRectZero];
        _itemTL.backgroundColor = Color_White;
        _itemTL.textColor = Color_Theme_Red;
        _itemTL.textAlignment = NSTextAlignmentCenter;
        _itemTL.font = systemFontMedium(12);
    }
    return _itemTL;
}

- (UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.backgroundColor = Color_Clear;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (NSMutableArray*)appdescA
{
    if (!_appdescA) {
        _appdescA = [NSMutableArray array];
    }
    return _appdescA;
}
#pragma mark - Getters



@end
