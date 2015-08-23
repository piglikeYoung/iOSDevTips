//
//  JHCase4Cell.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/22.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHCase4Cell.h"
#import "JHCase4DataEntity.h"

@interface JHCase4Cell()

@property(nonatomic, weak) UIImageView *avatarImageView;
@property(nonatomic, weak) UILabel *titleLabel;
@property(nonatomic, weak) UILabel *contentLabel;

@property(nonatomic, weak) JHCase4DataEntity *dataEntity;

@end

@implementation JHCase4Cell


// 调用UITableView的dequeueReusableCellWithIdentifier方法时会通过这个方法初始化Cell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark - Private methods
- (void)initView {
    
    // Avatar头像
    UIImageView *avatarImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:avatarImageView];
    self.avatarImageView = avatarImageView;
    [avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(@44);
        make.left.and.top.equalTo(self.contentView).with.offset(4);
    }];
    
    // Title - 单行
    UILabel *titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@22);
        make.top.equalTo(self.contentView).with.offset(4);
        make.left.equalTo(_avatarImageView.mas_right).with.offset(4);
        make.right.equalTo(self.contentView).with.offset(-4);
    }];
    
    // 计算UILabel的preferredMaxLayoutWidth值，多行时必须设置这个值，否则系统无法决定Label的宽度
    // 自动布局Cell的最大宽度=屏幕的宽度-头像左间距4-头像width44-文字左间距4-文字右间距4
    CGFloat preferredMaxWidth = [UIScreen mainScreen].bounds.size.width - 4 - 44 - 4 - 4;
    
    // Content - 多行
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines = 0;
    contentLabel.backgroundColor = [UIColor redColor];
    contentLabel.preferredMaxLayoutWidth = preferredMaxWidth; // 多行时必须设置
    self.contentLabel = contentLabel;
    [self.contentView addSubview:contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(4);
        make.left.equalTo(_avatarImageView.mas_right).with.offset(4);
        make.right.equalTo(self.contentView).with.offset(-4);
        make.bottom.equalTo(self.contentView).with.offset(-4);
    }];
    
    [_contentLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
}

#pragma mark - Public methods
- (void)setupData:(JHCase4DataEntity *)dataEntity {
    _dataEntity = dataEntity;
    
    _avatarImageView.image = [UIImage imageNamed:dataEntity.avatar] ;
    _titleLabel.text = dataEntity.title;
    _contentLabel.text = dataEntity.content;
}

@end
