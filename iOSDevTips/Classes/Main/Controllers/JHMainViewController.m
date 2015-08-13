//
//  JHMainViewController.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/10.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHMainViewController.h"
#import "JHCommonGroup.h"
#import "JHCommonArrowItem.h"
#import "JHSysPhotoAlbumVc.h"
#import "JHCustomPhotoAlbumVc.h"
#import "JHImageCaptureViewController.h"
#import "JHAsyncSocketVc.h"
#import "JHPlaceholderTextViewVc.h"
#import "JHPopVc.h"
#import "JHTableResponseVc.h"
#import "JHTableCustomBtnVc.h"
#import "JHTableCheckmarkVc.h"
#import "JHTableEditVc.h"

@interface JHMainViewController ()

@end

@implementation JHMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"主页";
    
    [self setupGroups];
}


/**
 *  初始化模型数据
 */
- (void)setupGroups
{
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
    [self setupGroup3];
    [self setupGroup4];
    [self setupGroup5];
}

- (void)setupGroup0
{
    // 1.创建组
    JHCommonGroup *group = [JHCommonGroup group];
    group.header = @"相册相关";
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    JHCommonArrowItem *saveToSysPhotoAlbum = [JHCommonArrowItem itemWithTitle:@"保存照片到系统相册"];
    saveToSysPhotoAlbum.destVcClass = [JHSysPhotoAlbumVc class];
    JHCommonArrowItem *saveToCustomPhotoAlbum = [JHCommonArrowItem itemWithTitle:@"保存照片到自己创建的相簿"];
    saveToCustomPhotoAlbum.destVcClass = [JHCustomPhotoAlbumVc class];

    
    group.items = @[saveToSysPhotoAlbum, saveToCustomPhotoAlbum];
}

- (void)setupGroup1
{
    // 1.创建组
    JHCommonGroup *group = [JHCommonGroup group];
    group.header = @"截取图片";
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    JHCommonArrowItem *imageCapture = [JHCommonArrowItem itemWithTitle:@"截取图片"];
    imageCapture.destVcClass = [JHImageCaptureViewController class];
    
    group.items = @[imageCapture];
}

- (void)setupGroup2
{
    // 1.创建组
    JHCommonGroup *group = [JHCommonGroup group];
    group.header = @"AsyncSocket长链接";
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    JHCommonArrowItem *asyncSocket = [JHCommonArrowItem itemWithTitle:@"AsyncSocket长链接"];
    asyncSocket.destVcClass = [JHAsyncSocketVc class];
    
    group.items = @[asyncSocket];
}

- (void)setupGroup3
{
    // 1.创建组
    JHCommonGroup *group = [JHCommonGroup group];
    group.header = @"实现placeholder属性的UITextView";
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    JHCommonArrowItem *placeholderTextView = [JHCommonArrowItem itemWithTitle:@"实现placeholder属性的UITextView"];
    placeholderTextView.destVcClass = [JHPlaceholderTextViewVc class];
    
    group.items = @[placeholderTextView];
}

- (void)setupGroup4
{
    // 1.创建组
    JHCommonGroup *group = [JHCommonGroup group];
    group.header = @"POP使用实践";
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    JHCommonArrowItem *pop = [JHCommonArrowItem itemWithTitle:@"POP使用实践"];
    pop.destVcClass = [JHPopVc class];
    
    group.items = @[pop];
}

- (void)setupGroup5
{
    // 1.创建组
    JHCommonGroup *group = [JHCommonGroup group];
    group.header = @"tableView";
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    JHCommonArrowItem *tableResponse = [JHCommonArrowItem itemWithTitle:@"tableView原生详情按钮响应事件"];
    tableResponse.destVcClass = [JHTableResponseVc class];
    
    JHCommonArrowItem *tableCheckmark = [JHCommonArrowItem itemWithTitle:@"tableViewCheckmark"];
    tableCheckmark.destVcClass = [JHTableCheckmarkVc class];
    
    JHCommonArrowItem *tableCustomBtnResponse = [JHCommonArrowItem itemWithTitle:@"tableView自定义Btn响应事件"];
    tableCustomBtnResponse.destVcClass = [JHTableCustomBtnVc class];
    
    JHCommonArrowItem *tableEdit = [JHCommonArrowItem itemWithTitle:@"tableView插入"];
    tableEdit.destVcClass = [JHTableEditVc class];
    
    group.items = @[tableResponse, tableCheckmark, tableCustomBtnResponse, tableEdit];
}


@end
