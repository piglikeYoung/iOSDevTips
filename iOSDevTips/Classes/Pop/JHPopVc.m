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

@end

@implementation JHPopVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *square = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 100, 100)];
    square.backgroundColor = [UIColor redColor];
    [self.view addSubview:square];
    self.square = square;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self testPop];
}

- (void)testPop {
    POPBasicAnimation *anBasic = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    anBasic.toValue = @(self.square.center.y+100);
    anBasic.beginTime = CACurrentMediaTime() + 1.0f;
    [self.square pop_addAnimation:anBasic forKey:@"position"];
}


@end
