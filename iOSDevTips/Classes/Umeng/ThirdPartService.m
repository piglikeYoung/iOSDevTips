//
//  ThirdPartService.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/27.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "ThirdPartService.h"
#import "MobClick.h"
#import "UMSocial.h"

static NSString *const kUmengAppKey = @"55de7470e0f55a8b63004dda";

@interface ThirdPartService()<UIAlertViewDelegate>

@end


@implementation ThirdPartService

/**
 *  load方法在APP加载的时候就会调用，所以可以把这些集成服务单独写到这，不用都写到AppDelegate里面
 */
+ (void)load {

    [ThirdPartService setupUmengConfig];
    
}


#pragma mark - 友盟集成
+ (void)setupUmengConfig {
    // 设置友盟统计分析appkey
    [MobClick startWithAppkey:kUmengAppKey];
    // 设置友盟社会化分享appkey
    [UMSocialData setAppKey:kUmengAppKey];
    
    // 设置版本号
    [MobClick setAppVersion:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    
    // 开启日志
    [MobClick setLogEnabled:YES];
    
    // 自动更新检测
    //    [MobClick checkUpdate:@"New version" cancelButtonTitle:@"Skip" otherButtonTitles:@"Goto Store"];
    
    // 自定义方法
    [MobClick checkUpdateWithDelegate:self selector:@selector(appUpdate:)];
}


+ (void)appUpdate:(NSDictionary *)appInfo {
//    JHLog(@"appInfo---%@", appInfo);
    
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您有新的版本更新，请到AppStore更新" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", @"别再提示老子", nil];
//    
//    [alertView show];
}

@end
