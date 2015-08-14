//
//  JHTableMovingCellVc.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/14.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHTableMovingCellVc.h"

@interface JHTableMovingCellVc ()

@property (strong, nonatomic) NSMutableArray *objects;/**< 第一个section数组 */

@property (strong, nonatomic) NSMutableArray *otherObjects;/**< 第二个section数组 */

@property (strong, nonatomic) NSMutableArray *anotherObjects;/**< 第三个section数组 */

@property (nonatomic, strong) NSMutableArray *total;/**< 总数组 */

@end

@implementation JHTableMovingCellVc

- (NSMutableArray *)objects {
    if (!_objects) {
        _objects = [@[@"黑猫警长!", @"葫芦娃", @"舒克与贝塔!", @"猫和老鼠", @"海贼王", @"西游记", @"火影忍者!", @"小苹果"] mutableCopy];
    }
    return _objects;
}

- (NSMutableArray *)otherObjects {
    if (!_otherObjects) {
        _otherObjects = [@[@"别逗我", @"还是朋友", @"么么哒", @"你他喵的", @"100块都不给我", @"再见"] mutableCopy];
    }
    return _otherObjects;
}

- (NSMutableArray *)anotherObjects {
    if (!_anotherObjects) {
        _anotherObjects = [@[@"Get Milk!", @"Go to gym", @"Breakfast with Rita!", @"Call Bob", @"Pick up newspaper", @"Send an email to Joe", @"Read this tutorial!", @"Pick up flowers"] mutableCopy];
    }
    return _anotherObjects;
}

- (NSMutableArray *)total {
    if (!_total) {
        _total = [NSMutableArray arrayWithObjects:self.objects, self.otherObjects, self.anotherObjects, nil];
    }
    return _total;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 给tableView添加长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                               initWithTarget:self action:@selector(longPressGestureRecognized:)];
    [self.tableView addGestureRecognizer:longPress];
}

/** 屏蔽tableView的样式 */
- (id)init{
    return [self initWithStyle:UITableViewStyleGrouped];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.total.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.total[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellStyleDefault;
    }
    
    cell.textLabel.text = self.total[indexPath.section][indexPath.row];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.objects removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}


/**
 *  长按手势触发
 *
 */
- (void)longPressGestureRecognized:(id)sender {
    
    UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
    // 手势状态
    UIGestureRecognizerState state = longPress.state;
    
    /**
     *  该方法首先应该获取到在 table view 中长按的位置，然后找出这个位置对应的 cell 的 index。记住：这里获取到的 index path 有可能为 nil(例如，如果用户长按在 table view的section header上)。
     */
    // 转换为tableView坐标的点
    CGPoint location = [longPress locationInView:self.tableView];
    // 获取点所在的indexPath
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    
    // 移动的Cell的快照
    static UIView       *snapshot = nil;
    // 没移动前Cell的indexPath
    static NSIndexPath  *sourceIndexPath = nil;
    
    switch (state) {
        // 开始移动
        case UIGestureRecognizerStateBegan: {
            if (indexPath) {
                sourceIndexPath = indexPath;
                
                UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
                
                // 创建移动Cell的快照
                snapshot = [self customSnapshoFromView:cell];
                
                // Add the snapshot as subview, centered at cell's center...
                // 添加快照到tableView上，和移动的Cell的中心X一致
                __block CGPoint center = cell.center;
                snapshot.center = center;
                snapshot.alpha = 0.0;
                [self.tableView addSubview:snapshot];
                [UIView animateWithDuration:0.25 animations:^{
                    
                    // 将它的Y坐标偏移量与手势的位置的Y轴对齐
                    center.y = location.y;
                    snapshot.center = center;
                    snapshot.transform = CGAffineTransformMakeScale(1.05, 1.05);
                    snapshot.alpha = 0.98;
                    cell.alpha = 0.0;
                    
                } completion:^(BOOL finished) {
                    
                    cell.hidden = YES;
                    
                }];
            }
            break;
        }
        
        // 当位置改变
        /**
         *  此时需要移动 snapshot view(只需要设置它的 Y 轴偏移量即可)。如果手势移动的距离对应到另外一个 index path，就需要告诉 table view，让其移动 rows。同时，你需要对 data source 进行更新
         */
        case UIGestureRecognizerStateChanged: {
            CGPoint center = snapshot.center;
            center.y = location.y;
            snapshot.center = center;
            
            // 判断Cell移动的位置是否改变
            if (indexPath && ![indexPath isEqual:sourceIndexPath]) {
                // 下面做了分组时候的处理
                
                // 在不同的section中移动
                if (indexPath.section != sourceIndexPath.section) {
                    // 取出对应数组的对象
                    id obj = self.total[sourceIndexPath.section][sourceIndexPath.row];
                    // 原数组移除对象
                    [self.total[sourceIndexPath.section] removeObject:obj];
                    // 要进入的数组添加对象到指定位置
                    [self.total[indexPath.section] insertObject:obj atIndex:indexPath.row];
                    
                }
                // 在同一section移动
                else {
                    // 改变数组中数据的位置
                    [self.total[indexPath.section] exchangeObjectAtIndex:indexPath.row withObjectAtIndex:sourceIndexPath.row];
                }
                
                // 改变tableView中Cell的位置
                [self.tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:indexPath];
                
                // 移动完成改变原indexPath
                sourceIndexPath = indexPath;
                
            }
            break;
        }
            
        /**
         *  当手势结束或者取消时，table view 和 data source 都是最新的。你所需要做的事情就是将 snapshot view 从 table view 中移除，并把 cell 的背景色还原为白色。
         */
        default: {
            // Clean up.
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:sourceIndexPath];
            cell.hidden = NO;
            cell.alpha = 0.0;
            
            [UIView animateWithDuration:0.25 animations:^{
                
                snapshot.center = cell.center;
                snapshot.transform = CGAffineTransformIdentity;
                snapshot.alpha = 0.0;
                cell.alpha = 1.0;
                
            } completion:^(BOOL finished) {
                
                sourceIndexPath = nil;
                [snapshot removeFromSuperview];
                snapshot = nil;
                // 刷新tableView
                [self.tableView reloadData];
            }];
            
            break;
        }
    }
}

#pragma mark - Helper methods
/**
 *  该方法会根据传入的 view，返回一个对应的 snapshot view。
 *
 */
- (UIView *)customSnapshoFromView:(UIView *)inputView {
    
    // Make an image from the input view.
    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, 0);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Create an image view.
    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    
    return snapshot;
}

@end
