//
//  JHMasonryCase5.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/23.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHMasonryCase5.h"

// 注释掉这个宏定义，就直接使用length值做约束，否则的话，使用新的mas_topLayoutGuide和mas_bottomLayoutGuide
#define NEW_FEATURE

@interface JHMasonryCase5 ()
@property (weak, nonatomic) UIView *topView;
@property (weak, nonatomic) UIView *bottomView;
@end

@implementation JHMasonryCase5

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Case 5";
    // 显示Navigation的Toolbar
    [self.navigationController setToolbarHidden:NO];
    
    [self initView];
    
    JHLog(@"[viewDidLoad] top: %g", self.topLayoutGuide.length);
    JHLog(@"[viewDidLoad] top: %g", self.bottomLayoutGuide.length);
}

#pragma mark - Private methods

- (void)initView {
    
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:topView];
    self.topView = topView;
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@40);
        make.left.and.right.equalTo(self.view);
#ifdef NEW_FEATURE
        make.top.equalTo(self.mas_topLayoutGuide);
#endif
    }];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:bottomView];
    self.bottomView = bottomView;
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.left.and.right.equalTo(self.view);
        
#ifdef NEW_FEATURE
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
#endif
    }];
}

#pragma mark - Override

- (void)updateViewConstraints {
    
    // 未定义NEW_FEATURE执行这段代码
#ifndef NEW_FEATURE
    // 根据新的length值更新约束
    [self.topView mas_updateConstraints:^(MASConstraintMaker *make) {
        // 直接利用其length属性，避免iOS、SDK版本升级后topLayoutGuide不再是UIView
        make.top.equalTo(self.view.mas_top).with.offset(self.topLayoutGuide.length);
    }];
    
    // 根据新的length值更新约束
    [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        // 直接利用其length属性，避免iOS、SDK版本升级后topLayoutGuide不再是UIView
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-(self.bottomLayoutGuide.length));
    }];
#endif

    [super updateViewConstraints];
}

#pragma mark - Actions

- (IBAction)showOrHideTopBar:(id)sender {
    [self.navigationController setNavigationBarHidden:!self.navigationController.navigationBarHidden animated:YES];
    // 隐藏、显示了NavigationBar以后，要手动触发updateViewConstraints，更新约束
    [self updateViewConstraints];
}

- (IBAction)showOrHideBottomBar:(id)sender {
    [self.navigationController setToolbarHidden:!self.navigationController.toolbarHidden animated:YES];
    // 手动触发updateViewConstraints
    [self updateViewConstraints];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}





@end
