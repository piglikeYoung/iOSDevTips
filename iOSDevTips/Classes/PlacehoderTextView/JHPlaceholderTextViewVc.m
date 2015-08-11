//
//  JHPlaceholderTextViewVc.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/11.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHPlaceholderTextViewVc.h"
#import "JHTextView.h"

@interface JHPlaceholderTextViewVc ()

@end

@implementation JHPlaceholderTextViewVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = JHGlobalBg;
    
    JHTextView *textView = [[JHTextView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    textView.placehoder = @"请输入内容。。。。。";
    textView.placehoderColor = [UIColor blueColor];
    textView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:textView];
}



@end
