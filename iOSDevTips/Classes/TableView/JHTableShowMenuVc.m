//
//  JHTableShowMenuVc.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/13.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHTableShowMenuVc.h"

@interface JHTableShowMenuVc ()

@end

@implementation JHTableShowMenuVc

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
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}

/**
 *  点击cell会触发的方法
 *
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //这个表示选中的那个cell上的数据
    NSString *titileString = [[[tableView cellForRowAtIndexPath:indexPath] textLabel] text];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"message:titileString delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil];
    [alert show];
}

/**
 *  点击菜单上的按钮触发方法
 *
 */
-(void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    
    if (action ==@selector(copy:)) {
        JHLog(@"copy");
    } else if (action ==@selector(cut:)) {
        JHLog(@"cut");
    } else if (action ==@selector(paste:)) {
        JHLog(@"paste");
    }
}

/**
 *  允许Menu菜单
 *  可以单独设置某行
 */
-(BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  YES;
}


/**
 *  每个cell都可以点击出现Menu菜单
 *
 */
-(BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    
   return YES;  // 全部显示
    
    // 只显示 copy
//    if (action == @selector(cut:)){
//        return NO;
//        
//    }  else if(action == @selector(copy:)){
//        return YES;
//        
//    } else if(action == @selector(paste:)){
//        return NO;
//        
//    } else if(action == @selector(select:)){
//        return NO;
//        
//    } else if(action == @selector(selectAll:)){
//        return NO;    
//        
//    } else  {
//        return [super canPerformAction:action withSender:sender];    
//        
//    }  
}


@end
