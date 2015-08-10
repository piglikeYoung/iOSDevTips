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


@end
