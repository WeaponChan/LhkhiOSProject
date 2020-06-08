//
//  LhkhMainCell.h
//  Lhkh_Base
//
//  Created by Weapon Chen on 2020/6/5.
//  Copyright © 2020 Weapon Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LhkhMainCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

+ (CGFloat)cellHeight;

- (void)configCellWithIndexPath:(NSIndexPath*)indexPath;
@end
