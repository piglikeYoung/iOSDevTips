//
//  JHMovLoginVc.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/26.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHMovLoginVc.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface JHMovLoginVc ()

@property (nonatomic, strong) MPMoviePlayerController *mpc;

@end

@implementation JHMovLoginVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建播放器
    [self moviewPlayerController];
    
    // logo
    UIImageView *logoIv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"keep6"]];
    [self.view addSubview:logoIv];
    [logoIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(padding * 10);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES];

    // 调用MPMoviePlayerController播放
    [self.mpc play];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    // 停止播放
    [self.mpc stop];
}

- (BOOL) prefersStatusBarHidden {
    return YES;
}

- (void)moviewPlayerController {
    // 创建播放器对象
    MPMoviePlayerController *mpc = [[MPMoviePlayerController alloc] init];
    // 设置URL
    mpc.contentURL = [[NSBundle mainBundle] URLForResource:@"start.mov" withExtension:nil];
    // 设置播放模式，重复播放
    [mpc setRepeatMode:MPMovieRepeatModeOne];
    
    // 添加播放器界面到控制器的view上面
    mpc.view.frame = self.view.bounds;
    [self.view addSubview:mpc.view];
    
    // 隐藏自动自带的控制面板
    mpc.controlStyle = MPMovieControlStyleNone;
    
    // 设置视频播放的适配
    mpc.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.mpc = mpc;
}


- (void)dealloc {

    if (self.mpc) {
        [self.mpc stop];
    }
    [self.mpc.view removeFromSuperview];
    self.mpc = nil;
    JHLog(@"JHMovLoginVc-----dealloc");
}

@end
