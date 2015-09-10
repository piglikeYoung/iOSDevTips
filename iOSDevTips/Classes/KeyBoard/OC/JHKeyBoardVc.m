//
//  JHKeyBoardVc.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/9/10.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHKeyBoardVc.h"

@interface JHKeyBoardVc ()
@property (weak, nonatomic) IBOutlet UIView *keyBaordView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation JHKeyBoardVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建手势，当点击viewcontroller的View时，隐藏键盘
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTouches:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    // 注册键盘尺寸监听的通知
    [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification  object:nil];
}

/**
 *  移除键盘监听
 */
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}


- (void)keyboardWillChange:(NSNotification *)notification {
    
    // 1.获取键盘的Y值
    NSDictionary *dict = notification.userInfo;
    CGRect keyboardFrame = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = keyboardFrame.origin.y;
    // 获取动画执行时间
    CGFloat duration = [dict[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    // 获取动画节奏
    NSInteger curve = (NSInteger)dict[UIKeyboardAnimationCurveUserInfoKey];
    
    // 2.计算需要移动的距离
    CGFloat translationY = keyboardY - self.view.frame.size.height;
    
    // 通过动画移动view
    /*
     输入框和键盘之间会由一条黑色的线条, 产生线条的原因是键盘弹出时执行动画的节奏和我们让控制器view移动的动画的节奏不一致导致
     增加options:7 << 16后可以消除
     */
    [UIView animateWithDuration:duration delay:0.0 options:curve << 16 animations:^{
        // 需要执行动画的代码，view整体向上位移，给键盘腾出位置
        self.keyBaordView.transform = CGAffineTransformMakeTranslation(0, translationY);
    } completion:^(BOOL finished) {
        // 动画执行完毕执行的代码
    }];
}

/**
 *  当用户使用UItableView时，可以通过拖拽关闭键盘
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 关闭键盘
    [self.textField endEditing:YES];
}

/**
 *  当点击viewcontroller的View时，隐藏键盘
 */
- (void) handleTouches:(UITapGestureRecognizer *)gesture {

    // 关闭键盘
    [self.textField endEditing:YES];
}



@end
