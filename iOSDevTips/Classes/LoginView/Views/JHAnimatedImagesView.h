//
//  JHAnimatedImagesView.h
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/26.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JHAnimatedImagesView;

@protocol JHAnimatedImagesViewDelegate

- (NSUInteger)animatedImagesNumberOfImages:(JHAnimatedImagesView *)animatedImagesView;
- (UIImage *)animatedImagesView:(JHAnimatedImagesView *)animatedImagesView imageAtIndex:(NSUInteger)index;

@end

@interface JHAnimatedImagesView : UIView

@property (nonatomic, weak) id<JHAnimatedImagesViewDelegate> delegate;

@property (nonatomic, assign) NSTimeInterval timePerImage;

- (void)startAnimating;
- (void)stopAnimating;

- (void)reloadData;

@end
