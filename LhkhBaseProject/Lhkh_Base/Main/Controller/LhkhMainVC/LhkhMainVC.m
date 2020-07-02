//
//  LhkhMainVC.m
//  Lhkh_Base
//
//  Created by Weapon Chen on 2018/6/2.
//  Copyright © 2018 Weapon Chen. All rights reserved.
//

#import "LhkhMainVC.h"
#import "LhkhIJKPlayerVC.h"
#import "LhkhWebVC.h"
#import "LhkhMainCell.h"
@interface LhkhMainVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)UITableView *tableView;
@end

@implementation LhkhMainVC

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Lhkh主页";
    [self setSubView];
    
}


#pragma mark - Layout SubViews
- (void)setSubView
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(NavigationBar_H+10);
        make.leading.bottom.trailing.equalTo(self.view);
    }];
}

#pragma mark - System Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LhkhMainCell *cell = [LhkhMainCell cellWithTableView:tableView];
    [cell configCellWithIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [LhkhMainCell cellHeight];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        [self.navigationController pushViewController:[LhkhIJKPlayerVC new] animated:YES];
    }else if(indexPath.row==1){
        [self.navigationController pushViewController:[LhkhWebVC new] animated:YES];
    }
    
}

#pragma mark - Custom Delegate


#pragma mark - Event Response


#pragma mark - Network Requests


#pragma mark - Public Methods


#pragma mark - Private Methods


#pragma mark - Setters
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

#pragma mark - Getters


@end
