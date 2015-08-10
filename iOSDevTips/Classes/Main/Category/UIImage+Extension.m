//
//  UIImage+Extension.m
//  iOSCategoryDemo
//
//  Created by piglikeyoung on 15/8/8.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (UIImage *)captureWithStyle:(JHCaptureImageStyle)style Image:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name];
    CGRect rect;
    switch (style) {
        case JHCaptureImageStyleLeft:
            rect = CGRectMake(0, 0, image.size.width/2, image.size.height);
            break;
        case JHCaptureImageStyleCenter:
            rect = CGRectMake(image.size.width/4, 0, image.size.width/2, image.size.height);
            break;
        case JHCaptureImageStyleRight:
            rect = CGRectMake(image.size.width/2, 0, image.size.width/2, image.size.height);
            break;
        case JHCaptureImageStyleLeftOneOfThird:
            rect = CGRectMake(0, 0, image.size.width/3, image.size.height);
            break;
        case JHCaptureImageStyleCenterOneOfThird:
            rect = CGRectMake(image.size.width/3, 0, image.size.width/3, image.size.height);
            break;
        case JHCaptureImageStyleRightOneOfThird:
            rect = CGRectMake(image.size.width/3*2, 0, image.size.width/3, image.size.height);
            break;
        case JHCaptureImageStyleLeftQuarter:
            rect = CGRectMake(0, 0, image.size.width/4, image.size.height);
            break;
        case JHCaptureImageStyleCenterLeftQuarter:
            rect = CGRectMake(image.size.width/4, 0, image.size.width/4, image.size.height);
            break;
        case JHCaptureImageStyleCenterRightQuarter:
            rect = CGRectMake(image.size.width/4*2, 0, image.size.width/4, image.size.height);
            break;
        case JHCaptureImageStyleRightQuarter:
            rect = CGRectMake(image.size.width/4*3, 0, image.size.width/4, image.size.height);
            break;
        default:
            break;
    }
    CGImageRef imagePartRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    image = [UIImage imageWithCGImage:imagePartRef];
    CGImageRelease(imagePartRef);
    return image;
}

+ (UIImage *)captureWithRect:(CGRect)rect Image:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name];
    CGImageRef imagePartRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    image = [UIImage imageWithCGImage:imagePartRef];
    CGImageRelease(imagePartRef);
    return image;
    
}


+(UIImage *)resizedImage:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    return[image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

@end
