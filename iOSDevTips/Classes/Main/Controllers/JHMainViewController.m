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
#import "JHTableSwipeToPerformActionsVc.h"
#import "JHTableShowMenuVc.h"
#import "JHTableHairGlassVc.h"
#import "JHTableSwipeToPerformActionsVc2.h"
#import "JHTableMovingCellVc.h"
#import "JHCheckMobileOperator.h"
#import "JHBgBlurViewVc.h"
#import "JHMasonryCaseVc.h"
#import "JHAnimatedImagesVc.h"
#import "JHMovLoginVc.h"
#import "JHUmengSocialVc.h"
#import "JHCircularImageVc.h"
#import "JHKeyBoardVc.h"

@interface JHMainViewController ()

@end

@implementation JHMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"主页";
    
    [self setupGroups];
    
    JHLog(@"%@", [JHCheckMobileOperator checkMobileOperator]);
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
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
    [self setupGroup6];
    [self setupGroup7];
    [self setupGroup8];
    [self setupGroup9];
    [self setupGroup10];
    [self setupGroup11];
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
    
    JHCommonArrowItem *tableEdit = [JHCommonArrowItem itemWithTitle:@"tableView编辑模式"];
    tableEdit.destVcClass = [JHTableEditVc class];
    
    JHCommonArrowItem *tableSwipeToPerformActions = [JHCommonArrowItem itemWithTitle:@"tableView滑动操作"];
    tableSwipeToPerformActions.destVcClass = [JHTableSwipeToPerformActionsVc class];
    
    JHCommonArrowItem *tableShowMenu = [JHCommonArrowItem itemWithTitle:@"tableView长按快捷菜单"];
    tableShowMenu.destVcClass = [JHTableShowMenuVc class];
    
    JHCommonArrowItem *tableHairGlass = [JHCommonArrowItem itemWithTitle:@"tableview+毛玻璃效果"];
    tableHairGlass.destVcClass = [JHTableHairGlassVc class];
    
    JHCommonArrowItem *tableSwipeToPerformActions2 = [JHCommonArrowItem itemWithTitle:@"tableview滑动操作iOS8版本"];
    tableSwipeToPerformActions2.destVcClass = [JHTableSwipeToPerformActionsVc2 class];
    
    JHCommonArrowItem *movingTableViewCell= [JHCommonArrowItem itemWithTitle:@"长按移动tableViewCell"];
    movingTableViewCell.destVcClass = [JHTableMovingCellVc class];
    
    group.items = @[tableResponse, tableCheckmark, tableCustomBtnResponse, tableEdit, tableSwipeToPerformActions,tableSwipeToPerformActions2, tableShowMenu, tableHairGlass, movingTableViewCell];
}

- (void)setupGroup6
{
    // 1.创建组
    JHCommonGroup *group = [JHCommonGroup group];
    group.header = @"模仿金融APP进入后台模糊效果";
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    JHCommonArrowItem *bgBlurView = [JHCommonArrowItem itemWithTitle:@"模糊效果"];
    bgBlurView.destVcClass = [JHBgBlurViewVc class];
    
    group.items = @[bgBlurView];
}

- (void)setupGroup7
{
    // 1.创建组
    JHCommonGroup *group = [JHCommonGroup group];
    group.header = @"有趣的Autolayout示例-Masonry实现";
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    JHCommonArrowItem *masonryCase = [JHCommonArrowItem itemWithTitle:@"MasonryCase"];
    masonryCase.destVcClass = [JHMasonryCaseVc class];
    masonryCase.initByStoryBoard = YES;// 通过storyboard创建控制器
    
    group.items = @[masonryCase];
}

- (void)setupGroup8
{
    // 1.创建组
    JHCommonGroup *group = [JHCommonGroup group];
    group.header = @"一些有趣的登录界面效果";
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    JHCommonArrowItem *animatedImages = [JHCommonArrowItem itemWithTitle:@"动态图登录界面"];
    animatedImages.destVcClass = [JHAnimatedImagesVc class];
    
    JHCommonArrowItem *mov = [JHCommonArrowItem itemWithTitle:@"短片登录界面"];
    mov.destVcClass = [JHMovLoginVc class];

    
    group.items = @[animatedImages, mov];
}

- (void)setupGroup9
{
    // 1.创建组
    JHCommonGroup *group = [JHCommonGroup group];
    group.header = @"一些有用的集成";
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    JHCommonArrowItem *umengSocial = [JHCommonArrowItem itemWithTitle:@"友盟社会化分享"];
    umengSocial.destVcClass = [JHUmengSocialVc class];
    
    group.items = @[umengSocial];
}

- (void)setupGroup10
{
    // 1.创建组
    JHCommonGroup *group = [JHCommonGroup group];
    group.header = @"转圈圈图片加载";
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    JHCommonArrowItem *circularImageOC = [JHCommonArrowItem itemWithTitle:@"转圈圈图片加载-OC版"];
    circularImageOC.destVcClass = [JHCircularImageVc class];
    JHCommonArrowItem *circularImageSwift = [JHCommonArrowItem itemWithTitle:@"转圈圈图片加载-Swift版(请自行测试)"];
    
    group.items = @[circularImageOC, circularImageSwift];
}

- (void)setupGroup11
{
    // 1.创建组
    JHCommonGroup *group = [JHCommonGroup group];
    group.header = @"键盘弹出隐藏";
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    JHCommonArrowItem *keyBoardOC = [JHCommonArrowItem itemWithTitle:@"键盘弹出隐藏-OC版"];
    keyBoardOC.destVcClass = [JHKeyBoardVc class];
    keyBoardOC.initByStoryBoard = YES;
    
    group.items = @[keyBoardOC];
}



@end
