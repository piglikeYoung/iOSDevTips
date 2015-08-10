//
//  UIBarButtonItem+Extension.h
//  iOSCategoryDemo
//
//  Created by piglikeyoung on 15/8/9.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)


/**
 *  快速创建BarButton
 *
 */
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action;

@end
