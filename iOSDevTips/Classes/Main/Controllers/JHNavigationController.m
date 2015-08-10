//
//  JHNavigationController.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/10.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHNavigationController.h"

@interface JHNavigationController ()

@end

@implementation JHNavigationController

/**
 *  当导航控制器的view创建完毕就调用
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 清空弹出手势的代理，就可以恢复弹出手势
    self.interactivePopGestureRecognizer.delegate = nil;
}

/**
 *  当第一次使用这个类的时候调用1次
 */
+ (void)initialize
{
    //设置UIBarButtonItem的主题
    [self setupBarButtonItemTheme];
    
    //设置UINavigationBar的主题
    [self setupNavigationBarTheme];
    
}

/**
 *设置UINavigationBar的主题
 */
+ (void)setupNavigationBarTheme
{
    
    //通过设置appearance对象，能够修改整个项目中所有UINavigationBar的样式
    UINavigationBar *appearance=[UINavigationBar appearance];
    
    //设置导航栏的背景
    if (!iOS7) {
        // 设置状态栏的颜色
        //        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
        [appearance setBackgroundImage:[UIImage imageNamed:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
    } else {
        [appearance setBackgroundImage:[UIImage imageNamed:@"navigationbar_background_tall"] forBarMetrics:UIBarMetricsDefault];
    }
    
    //设置文字属性
    NSMutableDictionary *textAttrs=[NSMutableDictionary dictionary];
    //设置字体颜色
    textAttrs[NSForegroundColorAttributeName]=[UIColor blackColor];
    //设置字体
    textAttrs[NSFontAttributeName]=JHNavigationTitleFont;
    //设置字体的阴影
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowBlurRadius = 5;// 模糊度
    shadow.shadowColor = [UIColor blackColor];
    //偏移量为0
    shadow.shadowOffset = CGSizeZero;
    textAttrs[NSShadowAttributeName] = shadow;
    //0 表示横排文本。1 表示竖排文本。在 iOS 中，总是使用横排文本，0 以外的值都未定义。
    textAttrs[NSVerticalGlyphFormAttributeName] = @0;
    [appearance setTitleTextAttributes:textAttrs];
}


/**
 *设置UIBarButtonItem的主题
 */
+ (void)setupBarButtonItemTheme
{
    //通过设置appearance对象，能够修改整个项目中所有UIBarButtonItem的样式
    UIBarButtonItem *appearance=[UIBarButtonItem appearance];
    
    //设置文字的属性
    //1.设置普通状态下文字的属性
    NSMutableDictionary *textAttrs=[NSMutableDictionary dictionary];
    //设置字体
    textAttrs[NSFontAttributeName]=[UIFont systemFontOfSize:15];
    //这是偏移量为0
    textAttrs[NSShadowAttributeName]=[NSValue valueWithUIOffset:UIOffsetZero];
    //设置颜色为橙色
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    
    //2.设置高亮状态下文字的属性
    //使用1中的textAttrs进行通用设置
    NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    highTextAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    [appearance setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
    
    
    //3.设置不可用状态下文字的属性
    //使用1中的textAttrs进行通用设置
    NSMutableDictionary *disabletextAttrs=[NSMutableDictionary dictionaryWithDictionary:textAttrs];
    //设置颜色为灰色
    disabletextAttrs[NSForegroundColorAttributeName]=[UIColor lightGrayColor];
    [appearance setTitleTextAttributes:disabletextAttrs forState:UIControlStateDisabled];
    
    
    //设置背景
    //技巧提示：为了让某个按钮的背景消失，可以设置一张完全透明的背景图片
    [appearance setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background"]forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}



/**
 *  能拦截所有push进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 只有第一次push的控制器显示bottomBar，别的都隐藏
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 导航栏的左上角和右上角按钮
        viewController.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithImageName:@"navigationbar_back" highImageName:@"navigationbar_back_highlighted" target:self action:@selector(back)];
//        viewController.navigationItem.rightBarButtonItem=[UIBarButtonItem itemWithImageName:@"navigationbar_more" highImageName:@"navigationbar_more_highlighted" target:self action:@selector(more)];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

@end
