//
//  UIBarButtonItem+Extension.m
//  iOSCategoryDemo
//
//  Created by piglikeyoung on 15/8/9.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"

@implementation UIBarButtonItem (Extension)

+(UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    
    // 设置按钮的尺寸为背景图片的尺寸
    button.size = button.currentBackgroundImage.size;
    
    // 监听按钮点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
