//
//  JHCommonCell.h
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/10.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JHCommonItem;

@interface JHCommonCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)setIndexPath:(NSIndexPath *)indexPath rowsInSection:(int)rows;

/** cell对应的item数据 */
@property (nonatomic, strong) JHCommonItem *item;
@end
