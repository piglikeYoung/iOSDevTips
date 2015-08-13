//
//  SwipeableCell.h
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/13.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SwipeableCellDelegate <NSObject>
- (void)buttonOneActionForItemText:(NSString *)itemText;
- (void)buttonTwoActionForItemText:(NSString *)itemText;
- (void)cellDidOpen:(UITableViewCell *)cell;
- (void)cellDidClose:(UITableViewCell *)cell;
@end

@interface SwipeableCell : UITableViewCell

@property (nonatomic, copy) NSString *itemText;
+(instancetype) cellWithTableView:(UITableView *)tableView;
- (void)openCell;

@property (nonatomic, weak) id <SwipeableCellDelegate> delegate;
@end
