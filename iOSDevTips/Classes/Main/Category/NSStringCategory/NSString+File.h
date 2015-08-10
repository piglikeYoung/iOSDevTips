//
//  NSString+File.h
//  iOSCategoryDemo
//
//  Created by piglikeyoung on 15/8/9.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (File)

/**
 *  获取当前路径下的文件/文件夹里面的文件大小，使用了递归遍历
 */
- (long long)fileSize;

@end
