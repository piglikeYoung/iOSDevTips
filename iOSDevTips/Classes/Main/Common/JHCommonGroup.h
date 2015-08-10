//
//  JHCommonGroup.h
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/10.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHCommonGroup : NSObject
/** 组头 */
@property (nonatomic, copy) NSString *header;
/** 组尾 */
@property (nonatomic, copy) NSString *footer;
/** 这组的所有行模型(数组中存放的都是JHCommonItem模型) */
@property (nonatomic, strong) NSArray *items;

+ (instancetype)group;
@end
