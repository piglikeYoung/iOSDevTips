//
//  HMNavigationController.m
//  iOSDevTips
//
//  Created by apple on 14/12/4.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMNavigationController.h"

@interface HMNavigationController ()
/** 存放每一个控制器的全屏截图 */
@property (nonatomic, strong) NSMutableArray *images;
/** 拖动时，添加到后面的imageView */
@property (nonatomic, strong) UIImageView *lastVcView;
/** 遮盖 */
@property (nonatomic, strong) UIView *cover;
@end

@implementation HMNavigationController

- (UIImageView *)lastVcView
{
    if (!_lastVcView) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        UIImageView *lastVcView = [[UIImageView alloc] init];
        lastVcView.frame = window.bounds;
        self.lastVcView = lastVcView;
    }
    return _lastVcView;
}

- (UIView *)cover
{
    if (!_cover) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        UIView *cover = [[UIView alloc] init];
        cover.backgroundColor = [UIColor blackColor];
        cover.frame = window.bounds;
        cover.alpha = 0.5;
        self.cover = cover;
    }
    return _cover;
}

- (NSMutableArray *)images
{
    if (!_images) {
        self.images = [[NSMutableArray alloc] init];
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 拖拽手势
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragging:)];
    [self.view addGestureRecognizer:recognizer];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.images.count > 0) return;
    
    // 因为刚显示导航控制器不会调用push方法，所以在这手动截图
    [self createScreenShot];
}

- (void)dragging:(UIPanGestureRecognizer *)recognizer
{
    // 如果只有1个子控制器,停止拖拽
    if (self.viewControllers.count <= 1) return;
    
    // 在x方向上移动的距离
    CGFloat tx = [recognizer translationInView:self.view].x;
    
    // 往左拖拽，停止执行
    if (tx < 0) return;
    
    // 手指抬起
    if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        // 决定pop还是还原
        CGFloat x = self.view.frame.origin.x;
        // 超过屏幕一半pop
        if (x >= self.view.frame.size.width * 0.5) {
            [UIView animateWithDuration:0.25 animations:^{
                // 移动到最右边，再pop控制器
                self.view.transform = CGAffineTransformMakeTranslation(self.view.frame.size.width, 0);
            } completion:^(BOOL finished) {
                [self popViewControllerAnimated:NO];// 弹出控制器
                [self.lastVcView removeFromSuperview];
                [self.cover removeFromSuperview];
                self.view.transform = CGAffineTransformIdentity;
                [self.images removeLastObject];
            }];
        } else {
            [UIView animateWithDuration:0.25 animations:^{
                self.view.transform = CGAffineTransformIdentity;
            }];
        }
    }
    // 正在拖拽中
    else {
        // 移动view
        self.view.transform = CGAffineTransformMakeTranslation(tx, 0);
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        // 添加截图到最后面
        self.lastVcView.image = self.images[self.images.count - 2];
        [window insertSubview:self.lastVcView atIndex:0];
        // 添加遮盖到imageView前面
        [window insertSubview:self.cover aboveSubview:self.lastVcView];
    }
}

/**
 *  产生截图
 */
- (void)createScreenShot
{
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, YES, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    [self.images addObject:image];
}



- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    
    [self createScreenShot];
}

@end
