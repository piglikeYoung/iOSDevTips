//
//  JHSocketServer.h
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/11.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AsyncSocket;

typedef enum {
    SocketOfflineByServer,      //服务器掉线
    SocketOfflineByUser,        //用户断开
    SocketOfflineByWifiCut      //wifi 断开

} SocketOfflineStyle;

@interface JHSocketServer : NSObject

@property (nonatomic, strong) AsyncSocket *socket;// socket
@property (nonatomic, strong) NSTimer *heartTimer;// 心跳计时器;

+ (JHSocketServer *)sharedSocketServer;

//  socket连接
- (void)startConnectSocket;

// 断开socket连接
-(void)cutOffSocket;

// 发送消息
- (void)sendMessage:(id)message;

@end
