//
//  JHAsyncSocketVc.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/11.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHAsyncSocketVc.h"
#import "JHSocketServer.h"
#import "AsyncSocket.h"

@interface JHAsyncSocketVc ()

@end

@implementation JHAsyncSocketVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = JHGlobalBg;
    
    JHSocketServer *server = [JHSocketServer sharedSocketServer];
    //socket连接前先断开连接以免之前socket连接没有断开导致闪退
    [server cutOffSocket];
    server.socket.userData = SocketOfflineByServer;
    [server startConnectSocket];
    
    //发送消息 @"hello world"只是举个列子，具体根据服务端的消息格式
    [server sendMessage:@"hello world"];
}


@end
