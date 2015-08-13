//
//  JHTableSwipeToPerformActionsVc.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/13.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHTableSwipeToPerformActionsVc.h"
#import "SwipeableCell.h"

@interface JHTableSwipeToPerformActionsVc ()<SwipeableCellDelegate>
@property (nonatomic, strong) NSMutableArray *arrayValue;
@property (nonatomic, strong) NSMutableSet *cellsCurrentlyEditing;
@end

@implementation JHTableSwipeToPerformActionsVc

- (NSMutableArray *)arrayValue {
    if (!_arrayValue) {
        _arrayValue = [NSMutableArray array];
        for (int i = 0; i < 20; i++) {
            [_arrayValue addObject:[NSString stringWithFormat:@"%zd", i]];
        }
    }
    return _arrayValue;
}

/** 屏蔽tableView的样式 */
- (id)init{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cellsCurrentlyEditing = [[NSMutableSet alloc] init];
    
}



#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.arrayValue.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    SwipeableCell *cell = [SwipeableCell cellWithTableView:tableView];
    cell.delegate = self;
    cell.itemText = [NSString stringWithFormat:@"Longer Title Item #%@", self.arrayValue[indexPath.row]];
    if ([self.cellsCurrentlyEditing containsObject:indexPath]) {
        [cell openCell];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.arrayValue removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else {
        NSLog(@"Unhandled editing style! %zd", editingStyle);
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma mark - SwipeableCellDelegate
- (void)buttonOneActionForItemText:(NSString *)itemText {
    NSLog(@"In the delegate, Clicked button one for %@", itemText);
}

- (void)buttonTwoActionForItemText:(NSString *)itemText {
    NSLog(@"In the delegate, Clicked button two for %@", itemText);
}

- (void)cellDidOpen:(UITableViewCell *)cell {
    NSIndexPath *currentEditingIndexPath = [self.tableView indexPathForCell:cell];
    [self.cellsCurrentlyEditing addObject:currentEditingIndexPath];
}

- (void)cellDidClose:(UITableViewCell *)cell {
    [self.cellsCurrentlyEditing removeObject:[self.tableView indexPathForCell:cell]];
}

@end
