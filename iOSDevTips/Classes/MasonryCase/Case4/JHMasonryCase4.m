//
//  JHMasonryCase4.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/22.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHMasonryCase4.h"
#import "JHCase4Cell.h"
#import "JHCase4DataEntity.h"

// 注释掉下面的宏定义，就是用“传统”的模板Cell计算高度
//#define IOS_8_NEW_FEATURE_SELF_SIZING

@interface JHMasonryCase4 ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *data;

@end

@implementation JHMasonryCase4

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.estimatedRowHeight = 80.0f;
    
#ifdef IOS_8_NEW_FEATURE_SELF_SIZING
    // iOS 8 的Self-sizing特性
    if ([UIDevice currentDevice].systemVersion.integerValue > 7) {
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
#endif
    
    // 注册Cell
    [_tableView registerClass:[JHCase4Cell class] forCellReuseIdentifier:NSStringFromClass([JHCase4Cell class])];
    
    [self generateData];
    
    [_tableView reloadData];
}

#pragma mark - Private methods

// 生成数据
- (void)generateData {
    NSMutableArray *tmpData = [NSMutableArray array];
    
    for (int i = 0; i < 20; i++) {
        JHCase4DataEntity *dataEntity = [[JHCase4DataEntity alloc] init];
        dataEntity.avatar = [NSString stringWithFormat:@"bluefaces_%d", (i % 4) + 1];
        dataEntity.title = [NSString stringWithFormat:@"Title: %d", i];
        dataEntity.content = [self getText:@"content-" withRepeat:i * 2 + 1];
        [tmpData addObject:dataEntity];
    }
    
    _data = tmpData;
}

// 重复text字符串repeat次
- (NSString *)getText:(NSString *)text withRepeat:(int)repeat {
    NSMutableString *tmpText = [NSMutableString new];
    
    for (int i = 0; i < repeat; i++) {
        [tmpText appendString:text];
    }
    
    return tmpText;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
#ifdef IOS_8_NEW_FEATURE_SELF_SIZING
    // iOS 8 的Self-sizing特性
    return UITableViewAutomaticDimension;
#else
    static JHCase4Cell *templateCell;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        templateCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JHCase4Cell class])];
    });
    
    // 获取对应的数据
    JHCase4DataEntity *dataEntity = _data[indexPath.row];
    
    // 填充数据
    [templateCell setupData:dataEntity];
    
    // 判断高度是否已经计算过
    if (dataEntity.cellHeight <= 0) {
        // 根据当前数据，计算Cell的高度，注意+1
        dataEntity.cellHeight = [templateCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
        JHLog(@"Calculate height: %ld", (long) indexPath.row);
    } else {
        JHLog(@"Get cache %ld", (long) indexPath.row);
    }
    
    return dataEntity.cellHeight;
#endif
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JHCase4Cell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JHCase4Cell class]) forIndexPath:indexPath];
    [cell setupData:_data[indexPath.row]];
    return cell;
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
