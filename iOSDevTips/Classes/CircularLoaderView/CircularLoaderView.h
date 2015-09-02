//
//  CircularLoaderView.h
//  iOSDevTips
//
//  Created by piglikeyoung on 15/9/2.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircularLoaderView : UIView

@property (nonatomic, assign) CGFloat progress;

- (void)reveal;

@end
