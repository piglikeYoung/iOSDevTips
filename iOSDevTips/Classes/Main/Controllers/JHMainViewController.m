//
//  MainVc.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/10.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHMainViewController.h"
#import "JHCommonGroup.h"
#import "JHCommonArrowItem.h"

@interface JHMainViewController ()

@end

@implementation JHMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"分类";
    
    [self setupGroups];
}

/**
 *  初始化模型数据
 */
- (void)setupGroups
{
    [self setupGroup0];
//    [self setupGroup1];
}

- (void)setupGroup0
{
    // 1.创建组
    JHCommonGroup *group = [JHCommonGroup group];
    group.header = @"相册相关";
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    JHCommonArrowItem *newFriend = [JHCommonArrowItem itemWithTitle:@"帐号管理"];
    
    group.items = @[newFriend];
}

//- (void)setupGroup1
//{
//    // 1.创建组
//    JHCommonGroup *group = [JHCommonGroup group];
//    [self.groups addObject:group];
//    
//    // 2.设置组的所有行数据
//    JHCommonArrowItem *newFriend = [JHCommonArrowItem itemWithTitle:@"主题、背景"];
//        generalSetting.destVcClass = [JHGeneralSettingViewController class];
//    group.items = @[newFriend];
//}

@end
