//
//  AppMacro.h
//  ForestAll
//
//  Created by piglikeyoung on 15/8/19.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//


// 屏幕横屏时的宽度
extern const NSInteger padding;

// NavigationBarH
extern const CGFloat kNavigationBarH;
// TableBarH
extern const CGFloat kTableBarH;
// TableViewCellH
extern const CGFloat kTableViewCellH;


// 随机色
#define JHRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

// 颜色
#define JHColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define JHColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

// 是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

// 是否为iOS8
#define iOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)

// 屏幕尺寸
#define JHScreenW [UIScreen mainScreen].bounds.size.width
#define JHScreenH [UIScreen mainScreen].bounds.size.height
#define JHScreenBounds [UIScreen mainScreen].bounds


//----------------界面设置相关---------------
// 全局背景色
#define JHGlobalBg JHColor(243, 243, 243)


// 导航栏标题的字体
#define JHNavigationTitleFont [UIFont boldSystemFontOfSize:20]


// cell的内边距
#define JHStatusCellInset 20



//----------------AsyncSocket相关-----------
//自己设定
#define SERVER_HOST @"192.168.0.1"
#define SERVER_PORT 8080

//设置连接超时
#define TIME_OUT 20

//设置读取超时, -1:表示不会使用超时
#define READ_TIME_OUT -1

//设置写入超时, -1:表示不会使用超时
#define WRITE_TIME_OUT -1

//每次最多读取多少
#define MAX_BUFFER 1024

