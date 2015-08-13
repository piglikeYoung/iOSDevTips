//
//  JHTableSwipeToPerformActionsVc2.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/13.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHTableSwipeToPerformActionsVc2.h"

@interface JHTableSwipeToPerformActionsVc2 ()

@property (nonatomic, strong) NSMutableArray *arrayValue;

@end

@implementation JHTableSwipeToPerformActionsVc2

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
    
    UIBarButtonItem *moveButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"编辑"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(toggleEdit)];
    self.navigationItem.rightBarButtonItem = moveButton;
}

-(void)toggleEdit{
    
    //初始话时默认不可编辑 点击事件的时候取反 为真！可编辑
    [self.tableView setEditing:!self.tableView.editing animated : YES];
    
    if (self.tableView.editing){
        [self.navigationItem.rightBarButtonItem setTitle:@"完成"];
    }else{
        [self.navigationItem.rightBarButtonItem setTitle:@"编辑"];
    }
    
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.arrayValue.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = self.arrayValue[indexPath.row];
    cell.accessoryType = UITableViewCellStyleDefault;
    
    return cell;
}


/*改变删除按钮的title*/
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"哈哈";
}

/**
 *  必须重写，否则只有进入编辑模式才能滑动cell
 *
 */
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 删除
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.arrayValue removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


/**
 *  cell添加滑动显示按钮
 *
 */
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //设置删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除"handler:^(UITableViewRowAction *action,NSIndexPath *indexPath) {
        
        [self.arrayValue removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }];
    
    //设置收藏按钮
    UITableViewRowAction *collectRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"收藏"handler:^(UITableViewRowAction *action,NSIndexPath *indexPath) {
        
        
        collectRowAction.backgroundColor = [UIColor greenColor];
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"收藏" message:@"收藏成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        
        
    }];
    
    //设置置顶按钮
    UITableViewRowAction *topRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"置顶" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        
        [self.arrayValue exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
        
        NSIndexPath *firstIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
        [tableView moveRowAtIndexPath:indexPath toIndexPath:firstIndexPath];
        
    }];
    
    topRowAction.backgroundColor = [UIColor blueColor];
    
    // collectRowAction添加毛玻璃特效
    collectRowAction.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    collectRowAction.backgroundColor = [UIColor grayColor];
    
    return  @[deleteRowAction,collectRowAction,topRowAction];
}

@end
