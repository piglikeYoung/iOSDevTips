//
//  UIViewController+AOP.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/27.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "UIViewController+AOP.h"
#import <objc/runtime.h>
#import "MobClick.h"

@implementation UIViewController (AOP)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        // When swizzling a class method, use the following:
        // Class class = object_getClass((id)self);
        swizzleMethod(class, @selector(viewDidLoad), @selector(aop_viewDidLoad));
        swizzleMethod(class, @selector(viewDidAppear:), @selector(aop_viewDidAppear:));
        swizzleMethod(class, @selector(viewWillAppear:), @selector(aop_viewWillAppear:));
        swizzleMethod(class, @selector(viewWillDisappear:), @selector(aop_viewWillDisappear:));
    });
}

void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector)   {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
- (void)aop_viewDidAppear:(BOOL)animated {
    [self aop_viewDidAppear:animated];
    
    
}

-(void)aop_viewWillAppear:(BOOL)animated {
    [self aop_viewWillAppear:animated];
    
#ifndef DEBUG
    [MobClick beginLogPageView:NSStringFromClass([self class])];
#endif
    
}

-(void)aop_viewWillDisappear:(BOOL)animated {
    [self aop_viewWillDisappear:animated];
    
#ifndef DEBUG
    [MobClick endLogPageView:NSStringFromClass([self class])];
#endif
    
}


- (void)aop_viewDidLoad {
    [self aop_viewDidLoad];
    
    if ([self isKindOfClass:[UINavigationController class]]) {
//        UINavigationController *nav = (UINavigationController *)self;

    }

}

@end
