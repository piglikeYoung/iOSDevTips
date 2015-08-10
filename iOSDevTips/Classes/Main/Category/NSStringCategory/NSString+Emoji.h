//
//  NSString+Emoji.h
//  iOSCategoryDemo
//
//  Created by piglikeyoung on 15/8/9.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Emoji)
/**
 *  将十六进制的编码转为emoji字符
 */
+ (NSString *)emojiWithIntCode:(int)intCode;

/**
 *  将十六进制的编码转为emoji字符
 */
+ (NSString *)emojiWithStringCode:(NSString *)stringCode;

/**
 *  是否为emoji字符
 */
- (BOOL)isEmoji;
@end
