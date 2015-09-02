//
//  CircularImageView.h
//  iOSDevTips
//
//  Created by piglikeyoung on 15/9/2.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircularImageView : UIImageView


/**
 *  根据URL加载图片
 *
 *  @param sUrl     图片地址
 *  @param animated 是否开启动画
 */
- (void)configureImageViewWithImageURL:(NSString *)sUrl animated:(BOOL)animated;

@end
