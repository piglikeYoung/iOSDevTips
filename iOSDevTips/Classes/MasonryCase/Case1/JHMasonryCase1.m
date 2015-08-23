//
//  JHMasonryCase1.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/22.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHMasonryCase1.h"

@interface JHMasonryCase1 ()
@property (weak, nonatomic) UILabel *label1;
@property (weak, nonatomic) UILabel *label2;

@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation JHMasonryCase1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
}

- (void) initViews{
    UILabel *label1 = [[UILabel alloc] init];
    label1.backgroundColor = [UIColor yellowColor];
    label1.text = @"label,";
    self.label1 = label1;
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.backgroundColor = [UIColor greenColor];
    label2.text = @"label,";
    self.label2 = label2;
    
    [self.contentView addSubview:label1];
    [self.contentView addSubview:label2];
    
    // label1
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.left.equalTo(self.contentView.mas_left).offset(2);
        
        // 40高度
        make.height.equalTo(@40);
    }];
    
    // label2
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        //左边贴着label1
        make.left.equalTo(label1.mas_right).with.offset(2);
        
        //上边贴着父view
        make.top.equalTo(self.contentView.mas_top).with.offset(5);
        
        // 右边的间隔保持大于等于2，注意是lessThanOrEqual
        // 这里的“lessThanOrEqualTo”放在从左往右的X轴上考虑会更好理解。
        // 即：label2的右边界的X坐标值“小于等于”containView的右边界的X坐标值。
        make.right.lessThanOrEqualTo(self.contentView.mas_right).offset(-2);
        
        // 40高度
        make.height.equalTo(@40);
    }];
    
    
    /**
     *  Content Compression Resistance = 不许挤我！
     *  这个属性的优先级（Priority）越高，越不“容易”被压缩。也就是说，当整体的空间装不小所有的View的时候，Content Compression Resistance优先级
     *  高的，现实的内容越完整。
     */
    
    /**
     *  Content Hugging = 抱紧！
     *  这个属性的优先级越高，整个View就要越“抱紧”View里面的内容。也就是View的大小不会随着父级View的扩大而扩大。
     */
    
    
    /**
     *  下面这个例子是，点击不同的加号，给label添加文字，
     *  设置label1的content compression 为250，设置label2的content compression 为1000
     *  当label2的长度越来越长，将要超过contentView的宽度时，会把label1挤没了
     *  
     *  注意：label都没固定宽度，让它根据内容自适应
     */
    
    // 设置label1的content hugging 为1000
    [label1 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    // 设置label1的content compression 为250
    [label1 setContentCompressionResistancePriority:UILayoutPriorityDefaultLow
                                             forAxis:UILayoutConstraintAxisHorizontal];
    
    // 设置右边的label2的content hugging 为1000
    [label2 setContentHuggingPriority:UILayoutPriorityRequired
                               forAxis:UILayoutConstraintAxisHorizontal];
    
    // 设置右边的label2的content compression 为1000
    [label2 setContentCompressionResistancePriority:UILayoutPriorityRequired
                                             forAxis:UILayoutConstraintAxisHorizontal];
}


- (IBAction)addLabelContent:(UIStepper *)sender {

    switch (sender.tag) {
        case 0:
            self.label1.text = [self getLabelContentWithCount:(NSUInteger)sender.value];
            break;
            
        case 1:
            self.label2.text = [self getLabelContentWithCount:(NSUInteger)sender.value];
            break;
            
        default:
            break;
    }
}

- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSString *)getLabelContentWithCount:(NSUInteger)count {
    NSMutableString *ret = [[NSMutableString alloc] init];
    
    // 根据点击加号的次数添加文字
    for (NSUInteger i = 0; i <= count; i++) {
        [ret appendString:@"label,"];
    }
    
    return ret.copy;
}

@end
