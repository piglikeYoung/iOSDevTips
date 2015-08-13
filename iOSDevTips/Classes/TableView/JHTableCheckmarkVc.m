//
//  JHTableCheckmarkVc.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/13.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHTableCheckmarkVc.h"

@interface JHTableCheckmarkVc ()

@property (strong,nonatomic)NSIndexPath *lastPath;/**< 上一次选择的cell的Path */

@end

@implementation JHTableCheckmarkVc

/** 屏蔽tableView的样式 */
- (id)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"cell----%zd----%zd", indexPath.section, indexPath.row];
    
    
    if (self.lastPath && indexPath == self.lastPath) {
        // 如果等于上一次选中的cell，accessoryType为UITableViewCellAccessoryCheckmark
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellStyleDefault;
    }
    
    
    return cell;
}

/**
 *  点击cell会触发的方法
 *
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
    // 不是第一次选择
    if (self.lastPath) {
        // 选择不一样的cell
        if (indexPath != self.lastPath) {
            newCell.accessoryType = UITableViewCellAccessoryCheckmark;
            UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:self.lastPath];
            oldCell.accessoryType = UITableViewCellStyleDefault;
        }
    }
    // 第一次选择
    else {
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    self.lastPath = indexPath;

    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
