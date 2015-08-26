//
//  JHAnimatedImagesVc.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/26.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHAnimatedImagesVc.h"
#import "JHAnimatedImagesView.h"

@interface JHAnimatedImagesVc ()<JHAnimatedImagesViewDelegate>

@property (nonatomic, weak) JHAnimatedImagesView *animatedImagesView;

@end

@implementation JHAnimatedImagesVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加动态图
    JHAnimatedImagesView *animatedImagesView =
    [[JHAnimatedImagesView alloc] initWithFrame:self.view.bounds];
    animatedImagesView.delegate = self;
    [self.view addSubview:animatedImagesView];
    self.animatedImagesView = animatedImagesView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES];
    // 动态图开始滚动
    [self.animatedImagesView startAnimating];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    // 动态图停止滚动
    [self.animatedImagesView stopAnimating];
}

- (void)dealloc {
    self.animatedImagesView = nil;
}

#pragma mark - JHAnimatedImagesViewDelegate
- (NSUInteger)animatedImagesNumberOfImages:(JHAnimatedImagesView*)animatedImagesView{
    return 2;
}

- (UIImage*)animatedImagesView:(JHAnimatedImagesView*)animatedImagesView imageAtIndex:(NSUInteger)index {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"login_background.png" ofType:nil];
    return [UIImage imageWithContentsOfFile:path];
}


@end
