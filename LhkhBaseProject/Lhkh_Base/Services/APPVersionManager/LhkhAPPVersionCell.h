//
//  LhkhAPPVersionCell.h
//  TC
//
//  Created by Weapon Chen on 2020/2/12.
//  Copyright © 2020 YouJie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LhkhAPPVersionCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

+ (CGFloat)cellHeight;

- (void)configCellWithDesc:(NSString*)desc indexPath:(NSIndexPath*)indexPath;
@end
