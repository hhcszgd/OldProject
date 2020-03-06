//
//  YYMSocket.h
//  IOSCim
//
//  Created by apple apple on 11-8-30.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncSocket.h"


@interface YYMSocket : NSObject 
{
	AsyncSocket *mySocket;
	BOOL isConnected; //连接状态
	int reConnectMaxCount; //重连的最大次数
	int reConnectCount; //重连的次数
	NSTimer *reConnectTimer; //重连的定时器
	NSString *reConnectType; //重连的类型
	BOOL isShowRecvData; //是否显示接收到内容
	BOOL isShowSendData; //是否显示发送的内容
	
	char *m_pBuffer;
	int  m_nlength;
	
	NSString *server;
	int port;
}

@end
