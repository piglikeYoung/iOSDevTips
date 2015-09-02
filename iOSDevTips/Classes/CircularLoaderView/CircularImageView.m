//
//  CircularImageView.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/9/2.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "CircularImageView.h"
#import "CircularLoaderView.h"
#import "UIImageView+WebCache.h"

@interface CircularImageView()

@property (nonatomic, weak) CircularLoaderView *progressIndicatorView;

@end

@implementation CircularImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpLoaderView];
    }
    return self;
}

- (void) setUpLoaderView {
    // 创建加载的View
    CircularLoaderView *progressIndicatorView = [[CircularLoaderView alloc] initWithFrame:CGRectZero];
    self.progressIndicatorView = progressIndicatorView;
    [self addSubview:progressIndicatorView];
}


- (void)configureImageViewWithImageURL:(NSString *)sUrl animated:(BOOL)animated {
    
    NSURL *url = [NSURL URLWithString:sUrl];
    if (animated) {
        self.progressIndicatorView.frame = self.bounds;
        [self.progressIndicatorView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        // 下载图片
        [self sd_setImageWithURL:url placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            // 更新进度条
            self.progressIndicatorView.progress = @(receivedSize).floatValue / @(expectedSize).floatValue;
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            // 加载完成reveal动画
            [self.progressIndicatorView reveal];
        }];
    } else {
        self.progressIndicatorView.frame = CGRectZero;
        [self sd_setImageWithURL:url];
    }
}
@end
