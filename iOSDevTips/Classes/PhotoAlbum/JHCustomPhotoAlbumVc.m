//
//  JHCustomPhotoAlbumVc.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/10.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHCustomPhotoAlbumVc.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"


static NSString *albumName = @"ppppppkkkkkk";

@interface JHCustomPhotoAlbumVc ()

@property (nonatomic, strong) ALAssetsLibrary *library;

@end

@implementation JHCustomPhotoAlbumVc

#pragma mark - lazy load
- (ALAssetsLibrary *)library {
    if (!_library) {
        _library = [[ALAssetsLibrary alloc] init];
    }
    return _library;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = JHGlobalBg;
    
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem itemWithImageName:@"navigationbar_more" highImageName:@"navigationbar_more_highlighted" target:self action:@selector(more)];
}

- (void) more {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选中你要打开的内容" message:@"别怕随便点" preferredStyle:UIAlertControllerStyleActionSheet];
    
    // 创建相册
    [alert addAction:[UIAlertAction actionWithTitle:@"创建自己的相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self.library addAssetsGroupAlbumWithName:albumName resultBlock:^(ALAssetsGroup *group)    {
            //创建相簿成功
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"创建成功"
                                                           message:@"在相簿中可以看到"
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil, nil];
            [alert show];
        } failureBlock:^(NSError *error) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"创建失败"
                                                           message:@"请打开 设置-隐私-照片 来进行设置"
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil, nil];
            [alert show];
        }];
    }]];
    
    // 保存相片到自定义相册，代码过于复杂，所以使用github上ALAssetsLibrary+CustomPhotoAlbum
    [alert addAction:[UIAlertAction actionWithTitle:@"保存相片到自定义相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        
        UIImage *image = [UIImage imageNamed:@"navigationbar_back_highlighted"];
        
        [self.library saveImage:image toAlbum:albumName completion:^(NSURL *assetURL, NSError *error) {
            if (!error) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"保存成功"
                                                               message:@"在相册中可以看到"
                                                              delegate:nil
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles:nil, nil];
                [alert show];
            }
        } failure:^(NSError *error) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"相册不存在"
                                                           message:@"需要先创建相册"
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil, nil];
            [alert show];
        }];
    }]];

    // 取消
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"点击了取消按钮");
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}



@end
