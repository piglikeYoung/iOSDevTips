//
//  JHTableEditVc.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/13.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHTableEditVc.h"

@interface JHTableEditVc ()

@property (nonatomic, strong) NSMutableArray *arrayValue;

@end

@implementation JHTableEditVc

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

// 只在在tableview的编辑模式下才有添加

// 只要实现代理的该方法, 手指在cell上面滑动的时候就自动实现了删除按钮
// commitEditingStyle: 传入提交的编辑操作(删除/添加)
// forRowAtIndexPath: 当前正在编辑的行
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (UITableViewCellEditingStyleDelete == editingStyle) {
        // 1.修改数据
        [self.arrayValue removeObjectAtIndex:indexPath.row];
        // 2.刷新表格
        // reloadData会重新调用数据的所有方法,刷新所有的行
        //    [self.tableView reloadData];
        
        // 该方法用于删除tableview上指定行的cell
        // 注意:使用该方法的时候,模型中删除的数据的条数必须和deleteRowsAtIndexPaths方法中删除的条数一致,否则会报错
        // 简而言之,就删除的数据必须和删除的cell保持一致
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
        

    } else if (UITableViewCellEditingStyleInsert == editingStyle) {
        // 添加一条数据

        [self.arrayValue insertObject:[NSString stringWithFormat:@"%@", @"增加的Cell"] atIndex:indexPath.row + 1];

        NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:0];
        // 注意点:数组中插入的条数必须和tableview界面上插入的cell条一致
        // 否则程序会报错
        [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationBottom];
    }
}

/*改变删除按钮的title*/
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"哈哈";
}

// 用于告诉系统开启的编辑模式是什么模式
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 0) {
        // 偶数
        return UITableViewCellEditingStyleInsert;
    } else {
        // 奇数
        return UITableViewCellEditingStyleDelete;
    }
}




@end
