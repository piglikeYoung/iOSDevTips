//
//  UIImage+Extension.h
//  iOSCategoryDemo
//
//  Created by piglikeyoung on 15/8/8.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JHCaptureImageStyle){
    JHCaptureImageStyleRight               =0,      // 右半部分
    JHCaptureImageStyleCenter              =1,      // 中间部分
    JHCaptureImageStyleLeft                =2,      // 左半部分
    JHCaptureImageStyleRightOneOfThird     =3,      // 右侧三分之一部分
    JHCaptureImageStyleCenterOneOfThird    =4,      // 中间三分之一部分
    JHCaptureImageStyleLeftOneOfThird      =5,      // 左侧三分之一部分
    JHCaptureImageStyleRightQuarter        =6,      // 右侧四分之一部分
    JHCaptureImageStyleCenterRightQuarter  =7,      // 中间右侧四分之一部分
    JHCaptureImageStyleCenterLeftQuarter   =8,      // 中间左侧四分之一部分
    JHCaptureImageStyleLeftQuarter         =9,      // 左侧四分之一部分
};

@interface UIImage (Extension)

/**
 *  根据默认样式截取图片的位置
 *
 */
+ (UIImage *)captureWithStyle:(JHCaptureImageStyle)style Image:(NSString *)name;


/**
 *  自定义截取图片的位置
 *
 */
+ (UIImage *)captureWithRect:(CGRect)rect Image:(NSString *)name;


/**
 *  根据图片名返回一张能够自由拉伸的图片
 */
+ (UIImage *)resizedImage:(NSString *)name;

@end
