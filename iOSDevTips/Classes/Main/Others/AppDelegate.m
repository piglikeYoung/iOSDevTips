//
//  AppDelegate.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/10.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "AppDelegate.h"
#import "FXBlurView.h"

@interface AppDelegate ()

@property (nonatomic, strong) FXBlurView *blurView;/**< 毛玻璃View */

@property (nonatomic, strong) UIVisualEffectView *effectView;/**< 系统自带的毛玻璃View */

@end

@implementation AppDelegate

- (FXBlurView *)blurView {
    if (!_blurView) {
        _blurView = [[FXBlurView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _blurView.blurRadius = 40;// 模糊度
    }
    return _blurView;
}

- (UIVisualEffectView *)effectView {
    if (!_effectView) {
        // 毛玻璃view 视图
        _effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        // 设置模糊透明度
        _effectView.alpha = 1.f;
        _effectView.frame = JHScreenBounds;
    }
    
    return _effectView;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

/**
 *  APP进入后台
 *
 */
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    // 当进入后台，添加毛玻璃遮挡
    [self addBlurEffectWithUIVisualEffectView];
//    [self addBlurEffectWithFXBlurView];
    
    
}

/**
 *  APP将进入前台
 *
 */
- (void)applicationWillEnterForeground:(UIApplication *)application {

    // 进入前台移除毛玻璃
    [self removeBlurEffectWithUIVisualEffectView];
//    [self removeBlurEffectWithFXBlurView];

}

/**
 *  创建毛玻璃效果View，系统自带的API，iOS8之后可用
 */
-(void) addBlurEffectWithUIVisualEffectView {
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.effectView];
}

/**
 *  移除毛玻璃效果View，配合addBlurEffectWithUIBlurEffect使用
 */
-(void) removeBlurEffectWithUIVisualEffectView {
    [UIView animateWithDuration:0.5 animations:^{
        [self.effectView removeFromSuperview];
    }];
}


/**
 *  创建毛玻璃效果View，通过第三方库FXBlurView，iOS5之后可用
 */
-(void)addBlurEffectWithFXBlurView {
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.blurView];
}

/**
 *  移除毛玻璃效果View，配合addBlurEffectWithFXBlurView使用
 */
-(void) removeBlurEffectWithFXBlurView {
    [UIView animateWithDuration:0.5 animations:^{
        [self.blurView removeFromSuperview];
    }];
}

@end
