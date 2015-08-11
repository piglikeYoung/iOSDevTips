//
//  JHSocketServer.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/11.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHSocketServer.h"
#import "AsyncSocket.h"

@interface JHSocketServer()<AsyncSocketDelegate>

@end

@implementation JHSocketServer

// 定义一份变量(整个程序运行过程中, 只有1份)
static id _instance;

// 1.重写allocWithZone方法，因为alloc方法执行时也会调用此方法
/**
 *  重写这个方法 : 控制内存只分配一次
 */
+ (id)allocWithZone:(struct _NSZone *)zone{
    // 里面的代码永远只执行1次，线程安全的，只会一个线程进去
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    
    // 返回对象
    return _instance;
}

// 2.创建类方法，给外部调用单例模式
+ (instancetype)sharedSocketServer{
    // 里面的代码永远只执行1次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    
    // 返回对象
    return _instance;
}

- (void)startConnectSocket {
    
    self.socket = [[AsyncSocket alloc] initWithDelegate:self];
    [self.socket setRunLoopModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
    if ( ![self socketOpen:SERVER_HOST port:SERVER_PORT] ) {
        
    }
}

- (NSInteger)socketOpen:(NSString*)addr port:(NSInteger)port{
    
    if (![self.socket isConnected]){
        NSError *error = nil;
        [self.socket connectToHost:addr onPort:port withTimeout:TIME_OUT error:&error];
    }
    
    return 0;
}

-(void)cutOffSocket{
    self.socket.userData = SocketOfflineByUser;
    [self.socket disconnect];
}


- (void)sendMessage:(id)message{
    // 向服务器发送数据
    NSData *cmdData = [message dataUsingEncoding:NSUTF8StringEncoding];
    [self.socket writeData:cmdData withTimeout:WRITE_TIME_OUT tag:1];
}

#pragma mark - AsyncSocketDelegate
- (void)onSocketDidDisconnect:(AsyncSocket *)sock{
    
    JHLog(@"7878 sorry the connect is failure %ld",sock.userData);
    
    if (sock.userData == SocketOfflineByServer) {
        // 服务器掉线，重连
        [self startConnectSocket];
    }
    else if (sock.userData == SocketOfflineByUser) {
        
        // 如果由用户断开，不进行重连
        return;
    }else if (sock.userData == SocketOfflineByWifiCut) {
        
        // wifi断开，不进行重连
        return;
    }
    
}


- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err{
    NSData * unreadData = [sock unreadData]; // ** This gets the current buffer
    if(unreadData.length > 0) {
        [self onSocket:sock didReadData:unreadData withTag:0]; // ** Return as much data that could be collected
    } else {
        
        JHLog(@" willDisconnectWithError %ld   err = %@",sock.userData,[err description]);
        if (err.code == 57) {
            self.socket.userData = SocketOfflineByWifiCut;
        }
    }
    
}



- (void)onSocket:(AsyncSocket *)sock didAcceptNewSocket:(AsyncSocket *)newSocket
{
    JHLog(@"didAcceptNewSocket");
}


- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    //这是异步返回的连接成功，
    JHLog(@"didConnectToHost");
    
    //通过定时器不断发送消息，来检测长连接
    self.heartTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(checkLongConnectByServer) userInfo:nil repeats:YES];
    [self.heartTimer fire];
}

// 心跳连接
-(void)checkLongConnectByServer{
    
    // 向服务器发送固定可是的消息，来检测长连接
    NSString *longConnect = @"connect is here";
    NSData   *data  = [longConnect dataUsingEncoding:NSUTF8StringEncoding];
    [self.socket writeData:data withTimeout:1 tag:1];
}



//接受消息成功之后回调
- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    //服务端返回消息数据量比较大时，可能分多次返回。所以在读取消息的时候，设置MAX_BUFFER表示每次最多读取多少，当data.length < MAX_BUFFER我们认为有可能是接受完一个完整的消息，然后才解析
    if( data.length < MAX_BUFFER )
    {
        //收到结果解析...
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        JHLog(@"%@",dic);
        //解析出来的消息，可以通过通知、代理、block等传出去
        
    }
    
    
    [self.socket readDataWithTimeout:READ_TIME_OUT buffer:nil bufferOffset:0 maxLength:MAX_BUFFER tag:0];
    
}


//发送消息成功之后回调
- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag{
    //读取消息
    [self.socket readDataWithTimeout:-1 buffer:nil bufferOffset:0 maxLength:MAX_BUFFER tag:0];
}


@end
