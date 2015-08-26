//
//  JHAnimatedImagesView.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/26.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHAnimatedImagesView.h"
#import "NSTimer+EZ_Helper.h"

// 动态图的展示时间
static const NSTimeInterval kAnimatedImagesViewDefaultTimePerImage = 20.0f;

// 没有图片时的索引
static const NSInteger kNoImageDisplayingIndex  = -1;

// 动态图消失和显示的动画时间
static const CGFloat kImageSwappingAnimationDuration  = 2.0f;

// 可扩展的滚动区域
static const NSInteger kImageViewsBorderOffset  = 150;

@interface JHAnimatedImagesView()

// 是否正在滚动
@property (nonatomic, assign, getter=isAnimating) BOOL animating;

// 图片的数量
@property (nonatomic, assign) NSInteger totalImages;

// 当前播放ImageView索引
@property (nonatomic, assign) NSInteger currentlyDisplayingImageViewIndex;

// 当前播放Image索引
@property (nonatomic, assign) NSInteger currentlyDisplayingImageIndex;

@property (nonatomic, strong) NSArray *imageViews;

@property (nonatomic, weak) NSTimer *imageSwappingTimer;

@end

@implementation JHAnimatedImagesView

#pragma mark - lazy load
- (NSTimer *)imageSwappingTimer {
    if (!_imageSwappingTimer) {
        _imageSwappingTimer = [NSTimer ez_scheduledTimerWithTimeInterval:self.timePerImage block:^{
            [self bringNextImage];
        } repeats:YES];
    }
    
    return _imageSwappingTimer;
}

#pragma mark - life cycle
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)dealloc {
    [self.imageSwappingTimer invalidate];
    _imageSwappingTimer = nil;
    JHLog(@"JHAnimatedImagesView-----dealloc");
}

- (void) initViews {
    
    NSMutableArray *imageViews = [NSMutableArray array];
    
    for (int i = 0; i < 2; i++) {
        // 设置imageView的大小，比屏幕的size要大，才能滚动
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-kImageViewsBorderOffset * 3.3, -kImageViewsBorderOffset, self.width + (kImageViewsBorderOffset * 2), self.height + (kImageViewsBorderOffset * 2))];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        // 等比例填充
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        // 不切掉超出屏幕的图片
        imageView.clipsToBounds = NO;
        [self addSubview:imageView];
        
        [imageViews addObject:imageView];
        
        self.imageViews = [imageViews copy];
        // 当前滚动图片所以为-1
        _currentlyDisplayingImageIndex = kNoImageDisplayingIndex;
    }
}

#pragma mark - public method
- (void)startAnimating {
    
    if (!self.isAnimating){
        _animating = YES;
        [self.imageSwappingTimer fire];
    }
}

- (void)stopAnimating {
    if (self.isAnimating)
    {
        [_imageSwappingTimer invalidate];
        _imageSwappingTimer = nil;
        
        [UIView animateWithDuration:kImageSwappingAnimationDuration delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            for (UIImageView *imageView in self.imageViews){
                imageView.alpha = 0.0;
            }
        } completion:^(BOOL finished) {
            _currentlyDisplayingImageIndex = kNoImageDisplayingIndex;
            _animating = NO;
        }];
    }
}

- (void)reloadData {
    _totalImages = [self.delegate animatedImagesNumberOfImages:self];
    
    [self.imageSwappingTimer fire];
}

#pragma mark - private method
- (void)bringNextImage {
    
    // 取出第一个imageView
    UIImageView *imageViewToHide = [self.imageViews objectAtIndex:self.currentlyDisplayingImageViewIndex];
    
    _currentlyDisplayingImageViewIndex = self.currentlyDisplayingImageViewIndex == 0 ? 1 : 0;
    
    UIImageView *imageViewToShow = [self.imageViews objectAtIndex:self.currentlyDisplayingImageViewIndex];
    
    NSUInteger nextImageToShowIndex = self.currentlyDisplayingImageIndex;
    
    do
    {
        nextImageToShowIndex = [[self class] randomIntBetweenNumber:0 andNumber:_totalImages-1];
    }
    while (nextImageToShowIndex == self.currentlyDisplayingImageIndex);
    
    _currentlyDisplayingImageIndex = nextImageToShowIndex;
    
    imageViewToShow.image = [self.delegate animatedImagesView:self imageAtIndex:nextImageToShowIndex];
    
    static const CGFloat kMovementAndTransitionTimeOffset = 0.1;
    
    [UIView animateWithDuration:self.timePerImage + kImageSwappingAnimationDuration + kMovementAndTransitionTimeOffset delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationCurveLinear animations:^{
        NSInteger randomTranslationValueX = kImageViewsBorderOffset * 3.5 - [[self class] randomIntBetweenNumber:0 andNumber:kImageViewsBorderOffset];
        NSInteger randomTranslationValueY = 0;
        
        CGAffineTransform translationTransform = CGAffineTransformMakeTranslation(randomTranslationValueX, randomTranslationValueY);
        
        CGFloat randomScaleTransformValue = [[self class] randomIntBetweenNumber:115 andNumber:120]/100;
        
        CGAffineTransform scaleTransform = CGAffineTransformMakeScale(randomScaleTransformValue, randomScaleTransformValue);
        
        imageViewToShow.transform = CGAffineTransformConcat(scaleTransform, translationTransform);
    } completion:NULL];
    
    [UIView animateWithDuration:kImageSwappingAnimationDuration delay:kMovementAndTransitionTimeOffset options:UIViewAnimationOptionBeginFromCurrentState
     | UIViewAnimationCurveLinear animations:^{
         imageViewToShow.alpha = 1.0;
         imageViewToHide.alpha = 0.0;
     } completion:^(BOOL finished) {
         if (finished)
         {
             imageViewToHide.transform = CGAffineTransformIdentity;
         }
     }];
}

+ (NSUInteger)randomIntBetweenNumber:(NSUInteger)minNumber andNumber:(NSUInteger)maxNumber {
    if (minNumber > maxNumber) {
        return [self randomIntBetweenNumber:maxNumber andNumber:minNumber];
    }
    
    NSUInteger i = (arc4random() % (maxNumber - minNumber + 1)) + minNumber;
    
    return i;
}


#pragma mark - getter setter
- (NSTimeInterval)timePerImage{
    if (_timePerImage == 0){
        return kAnimatedImagesViewDefaultTimePerImage;
    }
    
    return _timePerImage;
}

- (void)setDelegate:(id<JHAnimatedImagesViewDelegate>)delegate {
    if (delegate != _delegate){
        _delegate = delegate;
        _totalImages = [_delegate animatedImagesNumberOfImages:self];
    }
}


@end
