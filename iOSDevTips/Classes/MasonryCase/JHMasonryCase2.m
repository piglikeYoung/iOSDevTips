//
//  JHMasonryCase2.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/22.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHMasonryCase2.h"

static const CGFloat IMAGE_SIZE = 32;

@interface JHMasonryCase2 ()

@property (weak, nonatomic) UIView *containerView;/**< 装载表情的容器 */
@property (strong, nonatomic) NSMutableArray *imageViews;/**< 表情Iv数组 */
@property (strong, nonatomic) NSMutableArray *widthConstraints;/**< 每个表情的宽度约束数组 */
@property (strong, nonatomic) NSArray *imageNames;/**< 表情的图片名 */

@end

@implementation JHMasonryCase2

- (void)viewDidLoad {
    [super viewDidLoad];

    _imageViews = [NSMutableArray array];
    _widthConstraints = [NSMutableArray array];
    _imageNames = @[@"bluefaces_1", @"bluefaces_2", @"bluefaces_3", @"bluefaces_4"];
    
    // 初始装载表情的容器
    [self initContainerView];
    
    // 初始化表情
    [self initChildrenViews];
}

- (IBAction)showOrHideImage:(UISwitch *)sender {
    // 取出宽度约束，宽度约束为0，即不显示
    MASConstraint *width = _widthConstraints[sender.tag];
    if (sender.on) {
        width.mas_equalTo(IMAGE_SIZE);
    } else {
        width.mas_equalTo(0);
    }
}

#pragma mark - Private methods
- (void)initContainerView {
    UIView *containerView = [[UIView alloc] init];
    [self.view addSubview:containerView];
    self.containerView = containerView;
    
    containerView.backgroundColor = [UIColor redColor];
    
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        //只设置高度，宽度由子View决定，没设置高度，所以在界面上不显示
        make.height.mas_equalTo(IMAGE_SIZE);
        //水平居中
        make.centerX.equalTo(self.view.mas_centerX);
        //距离父View顶部400点
        make.top.equalTo(self.view.mas_top).offset(200);
    }];
}

- (void)initChildrenViews {
    // 循环创建、添加imageView
    for (NSUInteger i = 0; i < 4; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_imageNames[i]]];
        [_imageViews addObject:imageView];
        [_containerView addSubview:imageView];
    }
    
    // 设定大小
    CGSize imageViewSize = CGSizeMake(IMAGE_SIZE, IMAGE_SIZE);
    
    // 分别设置每个imageView的宽高、左边、垂直中心约束，注意约束的对象
    // 每个View的左边约束和左边的View的右边相等=。=，有点绕口...
    
    UIImageView *imageView1 = _imageViews[0];
    MASConstraint *width = [self setView:imageView1 size:imageViewSize left:_containerView.mas_left centerY:_containerView.mas_centerY];
    [_widthConstraints addObject:width];
    
    UIImageView *imageView2 = _imageViews[1];
    width = [self setView:imageView2 size:imageViewSize left:imageView1.mas_right centerY:_containerView.mas_centerY];
    [_widthConstraints addObject:width];
    
    UIImageView *imageView3 = _imageViews[2];
    width = [self setView:imageView3 size:imageViewSize left:imageView2.mas_right centerY:_containerView.mas_centerY];
    [_widthConstraints addObject:width];
    
    UIImageView *imageView4 = _imageViews[3];
    width = [self setView:imageView4 size:imageViewSize left:imageView3.mas_right centerY:_containerView.mas_centerY];
    [_widthConstraints addObject:width];
    
    // 最后设置最右边的imageView的右边与父view右对齐
    // 必须加上这句，因为_containerView的宽度没约束，所以加上这句可确定_containerView的宽度
    [imageView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_containerView.mas_right);
    }];
}

/**
 *  设置view的宽高、左边约束，垂直中心约束
 *
 *  @param view    要设置约束的view
 *  @param size    图片的size
 *  @param left    左边对齐的约束
 *  @param centerY 垂直中心对齐的约束
 *
 *  @return 返回宽约束，用于显示、隐藏单个view
 */
- (MASConstraint *)setView:(UIView *)view size:(CGSize)size left:(MASViewAttribute *)left centerY:(MASViewAttribute *)centerY {
    
    __block MASConstraint *widthConstraint;
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        // 宽高固定
        widthConstraint = make.width.mas_equalTo(size.width);
        make.height.mas_equalTo(size.height);
        // 左边约束
        make.left.equalTo(left);
        // 垂直中心对齐
        make.centerY.equalTo(centerY);
    }];
    
    return widthConstraint;
}



- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
