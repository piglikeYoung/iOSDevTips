//
//  NSString+TransformToPinyin.h
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/14.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TransformToPinyin)

/**
 *  字符串转拼音
 *
 */
- (NSString *)transformToPinyin;

/**
 *  返回字符串拼音首字母
 *
 */
- (NSString *)getPinYinFirstLetter;
@end
