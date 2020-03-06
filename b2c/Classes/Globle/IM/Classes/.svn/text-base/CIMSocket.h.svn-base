//
//  CIMSocket.h
//  IOSCim
//
//  Created by apple apple on 11-8-19.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncSocket.h"


@interface CIMSocket : NSObject {
	AsyncSocket *cimSocket;
	BOOL isConnected;
	int reConnectMaxCount; //重连的最大次数
	int reConnectCount; //重连的次数
	NSTimer *reConnectTimer;
	NSString *reConnectType;
	BOOL isShowRecvData; //是否显示接收到内容
	BOOL isShowSendData; //是否显示发送的内容
	char *m_pBuffer;
	int  m_nlength;
	BOOL *threadEnable;
}
- (void)send:(NSString*)content;
- (void)close:(id)sender;
- (void)initSocket;
@end
