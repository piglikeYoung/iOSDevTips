//
//  JHCase4DataEntity.h
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/22.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHCase4DataEntity : NSObject

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *avatar;

// Cache
@property (assign, nonatomic) CGFloat cellHeight;

@end
