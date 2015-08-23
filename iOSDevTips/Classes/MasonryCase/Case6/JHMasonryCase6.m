//
//  JHMasonryCase6.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/23.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHMasonryCase6.h"
#import "JHCase6ItemView.h"

@interface JHMasonryCase6 ()

@end

@implementation JHMasonryCase6

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void) initView {
    
    // 初始化资源
    // 图片
    NSArray *images = @[@"dog_small", @"dog_middle", @"dog_big"];
    // 文字
    NSArray *textArr = @[@"Auto layout is a system", @"Auto Layout is a system that lets you lay out", @"Auto Layout is a system that lets you lay out your app’s user interface"];
    
    // 创建3个Item
    JHCase6ItemView *itemView0 = [[JHCase6ItemView alloc] init];
    itemView0.text = textArr[0];
    itemView0.imageName = images[0];
    [self.view addSubview:itemView0];
    
    JHCase6ItemView *itemView1 = [[JHCase6ItemView alloc] init];
    itemView1.text = textArr[1];
    itemView1.imageName = images[1];
    [self.view addSubview:itemView1];
    
    JHCase6ItemView *itemView2 = [[JHCase6ItemView alloc] init];
    itemView2.text = textArr[2];
    itemView2.imageName = images[2];
    [self.view addSubview:itemView2];
    
    [itemView0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(8);
        make.top.mas_equalTo(self.view.mas_top).with.offset(200);
    }];
    
    // 跟第一个item的baseline对其
    [itemView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(itemView0.mas_right).with.offset(10);
        make.baseline.mas_equalTo(itemView0.mas_baseline);
    }];
    
    // 跟第一个item的baseline对其
    [itemView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(itemView1.mas_right).with.offset(10);
        make.baseline.mas_equalTo(itemView1.mas_baseline);
    }];
}


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
