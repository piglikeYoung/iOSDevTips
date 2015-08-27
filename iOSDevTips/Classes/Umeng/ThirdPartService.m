//
//  ThirdPartService.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/27.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "ThirdPartService.h"
#import "MobClick.h"


@implementation ThirdPartService

/**
 *  load方法在APP加载的时候就会调用，所以可以把这些集成服务单独写到这，不用都写到AppDelegate里面
 */
+ (void)load {

    // 设置友盟appkey
    [MobClick startWithAppkey:@"55de7470e0f55a8b63004dda"];
    
    // 设置版本号
    [MobClick setAppVersion:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    
    // 开启日志
    [MobClick setLogEnabled:YES];
}

@end
