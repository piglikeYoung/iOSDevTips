//
//  JHCommonItem.h
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/10.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHCommonItem : NSObject
/** 图标 */
@property (nonatomic, copy) NSString *icon;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 子标题 */
@property (nonatomic, copy) NSString *subtitle;
/** 右边显示的数字标记 */
@property (nonatomic, copy) NSString *badgeValue;
/** 点击这行cell，需要调转到哪个控制器 */
@property (nonatomic, assign) Class destVcClass;

/** 封装点击这行cell想做的事情 */
// block 只能用 copy
@property (nonatomic, copy) void (^operation)();


+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon;
+ (instancetype)itemWithTitle:(NSString *)title;
@end
