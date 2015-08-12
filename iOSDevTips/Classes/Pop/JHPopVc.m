//
//  JHPopVc.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/12.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHPopVc.h"
#import <pop/POP.h>

@interface JHPopVc ()

@property (nonatomic, weak) UIView *square;
@property (nonatomic, weak) UILabel *timeLabel;

@end

@implementation JHPopVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *square = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 100, 100)];
    square.backgroundColor = [UIColor redColor];
    [self.view addSubview:square];
    self.square = square;
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 300, 150, 100)];
    timeLabel.backgroundColor = [UIColor whiteColor];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:timeLabel];
    self.timeLabel = timeLabel;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    [self testPOPBasicAnimation];
//    [self testPOPSpringAnimation];
//    [self testPOPDecayAnimation];
    
    [self testPOPPropertyAnimation];
}

/**
 *  自定义动画
 */
- (void)testPOPPropertyAnimation {
    POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"countdown" initializer:^(POPMutableAnimatableProperty *prop) {
        
        // readBlock告诉POP当前的属性值
        // writeBlock中修改变化后的属性值
        // threashold决定了动画变化间隔的阈值 值越大writeBlock的调用次数越少
        
        prop.readBlock = ^(id obj, CGFloat values[]) {
            
        };

        prop.writeBlock = ^(id obj, const CGFloat values[]) {
            UILabel *lable = (UILabel*)obj;
            lable.text = [NSString stringWithFormat:@"%02d:%02d:%02d",(int)values[0]/60,(int)values[0]%60,(int)(values[0]*100)%100];
        };
//        prop.threshold = 0.01;
        
    }];
    
    POPBasicAnimation *anBasic = [POPBasicAnimation linearAnimation];   //秒表当然必须是线性的时间函数
    anBasic.property = prop;    //自定义属性
    anBasic.fromValue = @(0);   //从0开始
    anBasic.toValue = @(3*60);  //180秒
    anBasic.duration = 3*60;    //持续3分钟
    anBasic.beginTime = CACurrentMediaTime() + 1.0f;    //延迟1秒开始
    [self.timeLabel pop_addAnimation:anBasic forKey:@"countdown"];
}

/**
 *  POPDecayAnimation提供一个过阻尼效果(其实Spring是一种欠阻尼效果) 可以实现类似UIScrollView的滑动衰减效果(是的 你可以靠它来自己实现一个UIScrollView)
 
    注意:这里对POPDecayAnimation设置toValue是没有意义的 会被忽略(因为目的状态是动态计算得到的)
 */
- (void)testPOPDecayAnimation {
    POPDecayAnimation *anDecay = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    anDecay.velocity = @(400);// 速度
    anDecay.deceleration = 0.997;// 默认值：0.998 衰减系数(越小则衰减得越快)
//    anDecay.beginTime = CACurrentMediaTime() + 1.0f;
    [self.square pop_addAnimation:anDecay forKey:@"position"];
}

/**
 *  注意:POPSpringAnimation是没有duration字段的 其动画持续时间由下面几个参数决定
 */
- (void)testPOPSpringAnimation {
    /**
        springBounciness:4.0    //[0-20] 弹力 越大则震动幅度越大
        springSpeed     :12.0   //[0-20] 速度 越大则动画结束越快
        dynamicsTension :0      //拉力  接下来这三个都跟物理力学模拟相关 数值调整起来也很费时 没事不建议使用哈
        dynamicsFriction:0      //摩擦 同上
        dynamicsMass    :0      //质量 同上
     */
    POPSpringAnimation *anSpring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    anSpring.toValue = @(self.square.center.y+100);
//    anSpring.beginTime = CACurrentMediaTime() + 1.0f;
    anSpring.springBounciness = 10.0f;
    [self.square pop_addAnimation:anSpring forKey:@"position"];
}


- (void)testPOPBasicAnimation {
    // 1.定义一个animation对象 并指定对应的动画属性
    POPBasicAnimation *anBasic = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    
    // 2.设置初始值和默认值(初始值可以不指定 会默认从当前值开始)
    anBasic.toValue = @(self.square.center.y+100);// 中心点右位移100
    anBasic.beginTime = CACurrentMediaTime() + 1.0f;// 延迟1s执行
    anBasic.duration = 1.0;// 默认0.4s
    anBasic.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    // 3.添加到想产生动画的对象上
    [self.square pop_addAnimation:anBasic forKey:@"position"];
}


@end
