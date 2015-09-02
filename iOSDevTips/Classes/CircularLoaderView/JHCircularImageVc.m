//
//  JHCircularImageVc.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/9/2.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHCircularImageVc.h"
#import "CircularImageView.h"

@interface JHCircularImageVc ()

@end

@implementation JHCircularImageVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建ImageView
    CircularImageView *paintImageView = [[CircularImageView alloc] initWithFrame:self.view.bounds];
    paintImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    // 加载图片
    [paintImageView configureImageViewWithImageURL:@"http://g.hiphotos.baidu.com/image/pic/item/ae51f3deb48f8c547a9c532e38292df5e0fe7f60.jpg" animated:YES];
    paintImageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:paintImageView];

    
}


@end
