//
//  JHCase6ItemView.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/23.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHCase6ItemView.h"

@interface JHCase6ItemView ()
@property (weak, nonatomic) UIImageView *itemIv;
@property (weak, nonatomic) UILabel *textLabel;
@end

@implementation JHCase6ItemView


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}

- (void) initView {
    
    self.backgroundColor = [UIColor lightGrayColor];
    
    UIImageView *itemIv = [[UIImageView alloc] init];
    [self addSubview:itemIv];
    self.itemIv = itemIv;
    [itemIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(4);
        make.top.equalTo(self.mas_top).with.offset(4);
        make.right.equalTo(self.mas_right).with.offset(-4);
    }];
    [itemIv setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [itemIv setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    
    UILabel *textLabel = [[UILabel alloc] init];
    [self addSubview:textLabel];
    textLabel.numberOfLines = 0;
    textLabel.textColor = [UIColor whiteColor];
    self.textLabel = textLabel;
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(itemIv.mas_width);
        make.left.equalTo(itemIv.mas_left);
        make.top.equalTo(itemIv.mas_bottom).with.offset(4);
        make.bottom.equalTo(self.mas_bottom).with.offset(-4);
    }];
    [textLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
}

// 返回自定义的baseline的view
- (UIView *)viewForBaselineLayout {
    return self.itemIv;
}

- (void)setText:(NSString *)text {
    _text = [text copy];
    self.textLabel.text = _text;
}

- (void)setImageName:(NSString *)imageName {
    _imageName = [imageName copy];
    self.itemIv.image = [UIImage imageNamed:_imageName];
}

@end
