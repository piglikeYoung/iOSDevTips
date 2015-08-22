//
//  JHMasonryCase3.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/22.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHMasonryCase3.h"

@interface JHMasonryCase3 ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewWidthConstraint;
@property (assign, nonatomic) CGFloat maxWidth;

@end

@implementation JHMasonryCase3

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
    //保存最大宽度
    _maxWidth = _containerViewWidthConstraint.constant;
    
}

#pragma mark - Private methods
- (void) initView {
    UIView *subView = [[UIView alloc] init];
    subView.backgroundColor = [UIColor redColor];
    
    [_containerView addSubview:subView];
    
    [subView mas_makeConstraints:^(MASConstraintMaker *make) {
        //上下左贴边
        make.left.equalTo(_containerView.mas_left);
        make.top.equalTo(_containerView.mas_top);
        make.bottom.equalTo(_containerView.mas_bottom);
        
        // 宽度为父view的宽度的一半
        make.width.equalTo(_containerView.mas_width).multipliedBy(0.5);
    }];
}

- (IBAction)modifyContainerViewWidth:(UISlider *)sender {
    if (sender.value) {
        // 改变containerView的宽度，比例乘以总宽度
        _containerViewWidthConstraint.constant = sender.value * _maxWidth;
    }
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
