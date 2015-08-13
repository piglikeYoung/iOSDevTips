//
//  JHTableCustomBtnVc.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/13.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHTableCustomBtnVc.h"

@interface JHTableCustomBtnVc ()

@end

@implementation JHTableCustomBtnVc

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
        
        /**
         *  自定义btn作为accessoryView
         */
        UIButton *mybutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        mybutton.frame = CGRectMake(0, 0, 100, 25);
        [mybutton setTitle:@"myButton" forState:UIControlStateNormal];
        [mybutton addTarget:self action:@selector(myBtnClick:event:) forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryView = mybutton;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"cell----%zd----%zd", indexPath.section, indexPath.row];
    
    return cell;
}

-(void)myBtnClick:(id)sender event:(id)event {
    NSSet *touches = [event allTouches];   // 把触摸的事件放到集合里
    
    UITouch *touch = [touches anyObject];   // 把事件放到触摸的对象了
    
    //把触发的这个点转成TableView二维坐标
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    
    //匹配坐标点
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:currentTouchPosition];
    
    if(indexPath){
        // 调用TableView的详情按钮点击方法
        [self tableView:self.tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
}

/**
 *  点击cell会触发的方法
 *
 */
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    //这个表示选中的那个cell上的数据
//    NSString *titileString = [[[tableView cellForRowAtIndexPath:indexPath] textLabel] text];
//    
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"message:titileString delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil];
//    [alert show];
//    
//    // 取消选择状态，选中的背景不是一直变暗
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}

/**
 *  点击TableView详情按钮会触发的方法
 *
 */
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    
    NSString *titileString = [[[tableView cellForRowAtIndexPath:indexPath] textLabel] text];
    UIAlertView *alert = [[ UIAlertView alloc]initWithTitle:@"提示" message:titileString delegate:self    cancelButtonTitle:@"OK"otherButtonTitles: nil];
    [alert show];
}

/**
 *  让点击的cell没有反应
 *
 */
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //我让第一个cell 点击的时候没有反应
    if (indexPath.row ==0) {
        return nil;
    }
    return indexPath;
}



@end
