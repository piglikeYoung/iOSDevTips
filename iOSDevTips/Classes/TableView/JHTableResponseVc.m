//
//  JHTableResponseVc.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/13.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHTableResponseVc.h"

@interface JHTableResponseVc ()<UIAlertViewDelegate>

@end

@implementation JHTableResponseVc

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
//    UITableViewCellAccessoryNone,                   // 默认，什么都没有
//    UITableViewCellAccessoryDisclosureIndicator,    // 向右箭头
//    UITableViewCellAccessoryDetailDisclosureButton, // 详情按钮+向右箭头
//    UITableViewCellAccessoryCheckmark,              // 打钩
//    UITableViewCellAccessoryDetailButton            // 详情按钮 iOS7之后推出
    
    /**
     *  accessoryType有详情按钮的，点击详情按钮不会触发didSelectRowAtIndexPath方法
     *  会触发accessoryButtonTappedForRowWithIndexPath方法
     */
    cell.accessoryType = UITableViewCellAccessoryDetailButton;
    
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
 *  点击TableView详情按钮会触发的方法
 *
 */
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    
    NSString *titileString = [[[tableView cellForRowAtIndexPath:indexPath] textLabel] text];
    UIAlertView *alert = [[ UIAlertView alloc]initWithTitle:@"提示" message:titileString delegate:self    cancelButtonTitle:@"OK"otherButtonTitles: nil];
    [alert show];
}



@end
