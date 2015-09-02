//
//  CircularLoaderView.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/9/2.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "CircularLoaderView.h"

// 动画的弧度
static const CGFloat kCircleRadius = 20.0f;

// 加载图片圈圈颜色
#define LoadingCircleColor JHColor(132, 132, 132) // #848484

@interface CircularLoaderView()

@property (nonatomic, weak) CAShapeLayer *circlePathLayer;

@end

@implementation CircularLoaderView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self configure];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configure];
    }
    return self;
}

#pragma mark - Private Method
- (void)configure {
    CAShapeLayer *circlePathLayer = [[CAShapeLayer alloc] init];
    circlePathLayer.frame = self.bounds;
    circlePathLayer.lineWidth = 5;
    circlePathLayer.fillColor = [UIColor clearColor].CGColor;
    circlePathLayer.strokeColor = LoadingCircleColor.CGColor;
    self.circlePathLayer = circlePathLayer;
    [self.layer addSublayer:circlePathLayer];
    self.backgroundColor = [UIColor whiteColor];
    self.progress = 0;
}

- (CGRect)circleFrame {
    CGRect circleFrame = CGRectMake(0, 0, 2 * kCircleRadius, 2 * kCircleRadius);
    circleFrame.origin.x = CGRectGetMidX(self.circlePathLayer.bounds) - CGRectGetMidX(circleFrame);
    circleFrame.origin.y = CGRectGetMidY(self.circlePathLayer.bounds) - CGRectGetMidY(circleFrame);
    
    return circleFrame;
}

- (UIBezierPath *)circlePath {
    return [UIBezierPath bezierPathWithOvalInRect:[self circleFrame]];
}

- (CGFloat)progress {
    return self.circlePathLayer.strokeEnd;
}

- (void)setProgress:(CGFloat)progress {
    if (progress > 1) {
        self.circlePathLayer.strokeEnd = 1;
    } else if (progress < 0) {
        self.circlePathLayer.strokeEnd = 0;
    } else {
        self.circlePathLayer.strokeEnd = progress;
    }
}

#pragma mark - Public Method

- (void)reveal {

    self.backgroundColor = [UIColor clearColor];
    self.progress = 1;
    [self.circlePathLayer removeAnimationForKey:@"strokeEnd"];
    [self.circlePathLayer removeFromSuperlayer];
    
    if (self.superview) {
        self.superview.layer.mask = self.circlePathLayer;
    }
    
    // 1
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    double finalRadius = sqrt((center.x * center.x) + (center.y * center.y));
    double radiusInset = finalRadius - kCircleRadius;
    CGRect outerRect = CGRectInset([self circleFrame], -radiusInset, -radiusInset);
    CGPathRef toPath = [UIBezierPath bezierPathWithOvalInRect:outerRect].CGPath;
    
    // 2
    CGPathRef fromPath = self.circlePathLayer.path;
    CGFloat fromLineWidth = self.circlePathLayer.lineWidth;
    
    // 3
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    self.circlePathLayer.lineWidth = 2 * finalRadius;
    self.circlePathLayer.path = toPath;
    [CATransaction commit];
    
    // 4
    CABasicAnimation *lineWidthAnimation = [CABasicAnimation animationWithKeyPath:@"lineWidth"];
    lineWidthAnimation.fromValue = @(fromLineWidth);
    lineWidthAnimation.toValue = @(2 * finalRadius);
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.fromValue = (__bridge id)fromPath;
    pathAnimation.toValue = (__bridge id)(toPath);
    
    // 5
    CAAnimationGroup *groupAnimation = [[CAAnimationGroup alloc] init];
    groupAnimation.duration = 1;
    groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    groupAnimation.animations = @[pathAnimation, lineWidthAnimation];
    groupAnimation.delegate = self;
    [groupAnimation setRemovedOnCompletion:NO];
    [groupAnimation setFillMode:kCAFillModeForwards];
    [self.circlePathLayer addAnimation:groupAnimation forKey:@"strokeWidth"];
}

#pragma mark - Override

- (void)layoutSubviews {
    [super layoutSubviews];
    self.circlePathLayer.frame = self.bounds;
    self.circlePathLayer.path = [self circlePath].CGPath;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (self.superview) {
        [self.circlePathLayer removeAllAnimations];
        self.superview.layer.mask = nil;
    }
}

@end
