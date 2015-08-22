//
//  NSTimer+EZ_Helper.h
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/14.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (EZ_Helper)

/**
 *  下面这两种创建方式都需要在viewController的dealloc中销毁定时器
 *
 *  [self.timer invalidate];
 *  self.timer = nil;
 *
 */

/**
 *  这种创建方式，会主动添加到主循环中，即默认会执行，但当用户按住其他控件的时候，它就会停止执行，当放开控件，它才继续执行
 *
 */
+ (NSTimer *)ez_scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats;

/**
 *  这种创建方式，不会主动添加到主循环中，得手动添加
 *
 */
+ (NSTimer *)ez_timerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats;

@end
