//
//  AppDelegate.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/10.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "AppDelegate.h"
#import "FXBlurView.h"
#import "iRate.h"

@interface AppDelegate ()<iRateDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) FXBlurView *blurView;/**< 毛玻璃View */

@property (nonatomic, strong) UIVisualEffectView *effectView;/**< 系统自带的毛玻璃View */
@property (nonatomic, strong) UIAlertView *iRateAlertView;
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

+ (void)initialize {
    // 评级APP集成
    [self setupiRateConfig];
}

- (UIAlertView *)iRateAlertView {
    if (!_iRateAlertView) {
        _iRateAlertView = [[UIAlertView alloc] initWithTitle:@"朋友们，给我个评级吧！" message:@"我是个自定义的评级框哦，能给我个评级吗?" delegate:self cancelButtonTitle:@"不了，谢谢(不给这个版本评级)" otherButtonTitles:@"立刻评级", @"以后再说", @"打开苹果官网", nil];
    }
    return _iRateAlertView;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    return YES;
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


#pragma mark - iRate评级集成
+ (void)setupiRateConfig {
    
    // 设置bundle ID，通常不需要设置，iRate会自动去Info.plist获取
    // 这里设置是为了能在AppStore上找到应用，测试的时候使用
    [iRate sharedInstance].applicationBundleID = @"com.charcoaldesign.rainbowblocks-free";
    
    // 只有在最新的版本中弹出评级框，默认是Yes
    [iRate sharedInstance].onlyPromptIfLatestVersion = NO;
    
    // 最少的使用次数，大于或等于它才弹出评级框
//    [iRate sharedInstance].usesUntilPrompt = 10;
    // 最少达成的事件(比如游戏通了10关)，大于或等于它才弹出评级框
//    [iRate sharedInstance].eventsUntilPrompt = 10;
    // 用户安装并启动之后多少天才弹出评级框
//    [iRate sharedInstance].daysUntilPrompt = 10.0f;
    // 每周至少运行APP的次数，大于或等于它才弹出评级框
//    [iRate sharedInstance].usesPerWeekForPrompt = 0.0f;
    // 当用户点击稍后提醒我后，再次弹出评级框的间隔时间，这个设置会覆盖其他配置，即使有新版本也不会弹出
//    [iRate sharedInstance].remindPeriod = 1.0f;
    
    // 是否总是弹出评级框，Yes是永远弹出，忽略所有的弹出条件，默认是NO
//    [iRate sharedInstance].previewMode = YES;
}
#pragma mark iRateDelegate
- (BOOL)iRateShouldPromptForRating {

    [self.iRateAlertView show];
    
    return NO;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == alertView.cancelButtonIndex){
        // 忽略这个版本
        [iRate sharedInstance].declinedThisVersion = YES;
    }
    else if (buttonIndex == 1) // 立刻跳转到AppStore评级
    {
        // 记录评级
        [iRate sharedInstance].ratedThisVersion = YES;
        
        // 跳转AppStore
        [[iRate sharedInstance] openRatingsPageInAppStore];
    }
    else if (buttonIndex == 2) // 以后再说
    {
        // 记录当前时间
        [iRate sharedInstance].lastReminded = [NSDate date];
    }
    else if (buttonIndex == 3) // 打开网站
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.apple.com"]];
    }
    
}

@end
