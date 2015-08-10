//
//  NSString+File.m
//  iOSCategoryDemo
//
//  Created by piglikeyoung on 15/8/9.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "NSString+File.h"

@implementation NSString (File)

- (long long)fileSize
{
    // 1.文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 2.判断file是否存在
    BOOL isDirectory = NO;
    BOOL fileExists = [mgr fileExistsAtPath:self isDirectory:&isDirectory];
    
    // 文件\文件夹不存在
    if (fileExists == NO) return 0;
    
    
    // 3.判断file是否为文件夹
    if (isDirectory) {
        // 只能获得当前文件夹里面的子文件\子文件夹
        NSArray *subpaths = [mgr contentsOfDirectoryAtPath:self error:nil];
        long long totalSize = 0;
        for (NSString *subpath in subpaths) {
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            totalSize += [fullSubpath fileSize]; // 递归
        }
        return totalSize;
    } else { // 不是文件夹, 文件
        // 直接计算当前文件的尺寸
        NSDictionary *attr = [mgr attributesOfItemAtPath:self error:nil];
        return [attr[NSFileSize] longLongValue];
    }
}

@end
