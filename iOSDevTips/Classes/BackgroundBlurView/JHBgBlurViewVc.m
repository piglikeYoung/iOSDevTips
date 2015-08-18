//
//  JHBgBlurViewVc.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/18.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHBgBlurViewVc.h"

@interface JHBgBlurViewVc ()


@end

@implementation JHBgBlurViewVc



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 加载图片
    UIImageView *bgIv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cat2"]];
    
    // 撑满整个屏幕
    bgIv.contentMode = UIViewContentModeScaleAspectFill;
    // 切除超出屏幕的部分
    bgIv.clipsToBounds = YES;
    bgIv.frame = self.view.bounds;
    [self.view addSubview:bgIv];
    
}



@end
