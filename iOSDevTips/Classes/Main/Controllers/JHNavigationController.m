//
//  JHNavigationController.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/10.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHNavigationController.h"

@interface JHNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation JHNavigationController

/**
 *  当导航控制器的view创建完毕就调用
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 清空弹出手势的代理，就可以恢复弹出手势
//    self.interactivePopGestureRecognizer.delegate = nil;
    
    // 获取系统自带滑动手势的target对象
    id target = self.interactivePopGestureRecognizer.delegate;
    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
    // handleNavigationTransition方法是系统自带的，不需要自己创建
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    // 设置手势代理，拦截手势触发
    pan.delegate = self;
    // 给导航控制器的view添加全屏滑动手势
    [self.view addGestureRecognizer:pan];
    // 禁止使用系统自带的滑动手势
    self.interactivePopGestureRecognizer.enabled = NO;
}

// 什么时候调用：每次触发手势之前都会询问下代理，是否触发。
// 作用：拦截手势触发
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 注意：只有非根控制器才有滑动返回功能，根控制器没有。
    // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
    if (self.childViewControllers.count == 1) {
        // 表示用户在根控制器界面，就不需要触发滑动手势，
        return NO;
    }
    return YES;
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
    textAttrs[UITextAttributeTextColor]=[UIColor blackColor];
    //设置字体
    textAttrs[UITextAttributeFont]=JHNavigationTitleFont;
    //设置字体的偏移量（0）
    //说明：UIOffsetZero是结构体，只有包装成NSValue对象才能放进字典中
    textAttrs[UITextAttributeTextShadowOffset]=[NSValue valueWithUIOffset:UIOffsetZero];
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
    textAttrs[UITextAttributeFont]=[UIFont systemFontOfSize:15];
    //这是偏移量为0
    textAttrs[UITextAttributeTextShadowOffset]=[NSValue valueWithUIOffset:UIOffsetZero];
    //设置颜色为橙色
    textAttrs[UITextAttributeTextColor] = [UIColor orangeColor];
    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    
    //2.设置高亮状态下文字的属性
    //使用1中的textAttrs进行通用设置
    NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    highTextAttrs[UITextAttributeTextColor] = [UIColor redColor];
    [appearance setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
    
    
    //3.设置不可用状态下文字的属性
    //使用1中的textAttrs进行通用设置
    NSMutableDictionary *disabletextAttrs=[NSMutableDictionary dictionaryWithDictionary:textAttrs];
    //设置颜色为灰色
    disabletextAttrs[UITextAttributeTextColor]=[UIColor lightGrayColor];
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
        // 导航栏的左上角和右上角按钮
    viewController.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithImageName:@"navigationbar_back" highImageName:@"navigationbar_back_highlighted" target:self action:@selector(back)];
    
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

@end
