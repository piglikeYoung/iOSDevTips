//
//  ImageCaptureViewController.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/10.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHImageCaptureViewController.h"

@interface JHImageCaptureViewController ()

@end

@implementation JHImageCaptureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = JHGlobalBg;
    
    [self testImageCapture];
}

/**
 *  测试截取图片
 */
- (void) testImageCapture{
    
    // 原始图片
    UIImageView *originalIv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cat"]];
    originalIv.frame = CGRectMake(20, 70, 120, 120);
    [self.view addSubview:originalIv];
    
    // 截取左半部分
    UIImageView *changeIv1 = [[UIImageView alloc] initWithImage:[UIImage captureWithStyle:JHCaptureImageStyleLeft Image:@"cat"]];
    changeIv1.frame = CGRectMake(20, CGRectGetMaxY(originalIv.frame) + 10, 120, 120);
    [self.view addSubview:changeIv1];
    
    // 截取指定位置
    UIImageView *changeIv2 = [[UIImageView alloc] initWithImage:[UIImage captureWithRect:CGRectMake(20, 10, 50, 50) Image:@"cat"]];
    changeIv2.frame = CGRectMake(20, CGRectGetMaxY(changeIv1.frame) + 10, 120, 120);
    [self.view addSubview:changeIv2];
}

@end
