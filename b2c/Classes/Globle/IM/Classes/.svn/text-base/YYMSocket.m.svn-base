//
//  YYMSocket.m
//  IOSCim
//
//  Created by apple apple on 11-8-30.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "YYMSocket.h"
#import "YYMDebug.h"


@implementation YYMSocket


//初始化配置参数
- (void)initParam
{
	reConnectMaxCount = 3;
	server = @"";
	port = 0;
}



//创建Socket对象
- (void)initSocket
{
	m_pBuffer = NULL;
	m_nlength = 0;
	reConnectType = @"LoginReconnect";
	isConnected = NO;
	
	if (mySocket == nil)
	{
		mySocket = [[AsyncSocket alloc] initWithDelegate:self]; 
		[mySocket setRunLoopModes:[NSArray arrayWithObjects:NSRunLoopCommonModes, nil]];
	}
	
	[self connect:nil];
}



//连接socket服务器
- (void)connect:(id)sender 
{
	//过滤多余的连接
	if (isConnected) 
	{
		return;
	}
	
	NSLog(@"开始连接通讯服务器 连接次数为%d", reConnectCount);
	
	//超时 放弃重连
	if (reConnectCount > reConnectMaxCount && [reConnectType isEqualToString:@"LoginReconnect"]) 
	{		
		[reConnectTimer invalidate];
		reConnectTimer = nil;
		reConnectCount = 0;
		//连接超时处理
		[self loginTimeout];
		return;
	}
	
	
	NSError *err = nil;
	
	//网络重连需要先断开上一次连接
	[mySocket close];
	
	
	//通讯服务器不可用
	if(![mySocket connectToHost:server onPort:port error:&err]) 
	{ 
        NSLog(@"Socket 连接 错误: %@", err);
    } 
	else 
	{
		reConnectCount++;
		
		//启动重连机制  没有第一次没有成功 再尝试几次 超时后放弃 提示用户连接失败 请检查网络
		if (reConnectTimer == nil) 
		{
			reConnectTimer = [NSTimer scheduledTimerWithTimeInterval:10
															  target:self
															selector:@selector(connect:)
															userInfo:nil
															 repeats:YES];
		}
	}
}




///////////////////////////////////////////////////////////////////////////////



//连接成功
- (void)onSocket:(AsyncSocket*)sock didConnectToHost:(NSString *)host port:(UInt16)portc
{ 
    NSLog(@"Socket连接成功 服务器地址:%@ 端口:%hu", host, portc);
	isConnected = YES;
	
	//取消重连机制
	if ([reConnectTimer isValid])
	{
		[reConnectTimer invalidate];
		reConnectTimer = nil;
	}
	
	//连接成功后开始登录 处理
	[self connectSuccess];
	
	//网络重连成功 通知
	if ([reConnectType isEqualToString:@"NetErrorReconnect"])
	{
		[self reconnectSuccess];
	}
	
	[sock readDataWithTimeout:-1 tag:0];
}




//接收服务器端数据
- (void)onSocket:(AsyncSocket*)sock didReadData:(NSData *)data withTag:(long)tag 
{		
	//接收服务器发回的数据
	int nLength = m_nlength + [data length];
	char *pBuffer = (char *)malloc(nLength);
	
	if (pBuffer == NULL)
	{
		return;
	}
	
	memset(pBuffer,0,nLength);
	
	if (m_pBuffer != NULL)
	{	
		//将上次剩余的数据重新填充到本次数组中
		memcpy(pBuffer, m_pBuffer, m_nlength);
	}
	
	if ([data length] > 0)
	{	
		//将本次的数据添加进入
		char *p = [data bytes];
		memcpy(pBuffer + m_nlength, p, [data length]);
	}
	
	char *m = NULL;
	char *p = pBuffer;
	
	int i;
	int nDeleteLen = 0;
	int nOneLen = 0;
	
	for(i = 0;i<nLength;i++)
	{
		nOneLen++;
		
		if (m == NULL)
		{
			m = p;
		}
		
		if(*p == '\0')
		{
			if (p - m > 0 )
			{
				nDeleteLen = nDeleteLen + nOneLen;
				NSData *newData = [NSData dataWithBytes:m length:nOneLen];
				
				//解析单条消息
				[self recvServerData:newData];
				
				if (isShowRecvData)
				{
					[YYMDebug printNSData:newData];  
				}
				
				m = NULL;
				nOneLen  = 0;
				//延时操作 为界面控制器创造时间
				sleep(0.1);
			}
			
		}
		
		p++;
	}
	
	if (m_pBuffer != NULL)
	{
		free(m_pBuffer);
		m_pBuffer = NULL;
	}
	
	if (nLength - nDeleteLen > 0)
	{
		m_pBuffer = (char *)malloc(nLength - nDeleteLen);
		
		if (m_pBuffer == NULL)
		{
			return ;
		}
		
		memset(m_pBuffer, 0, nLength - nDeleteLen);
		memcpy(m_pBuffer, pBuffer + nDeleteLen, nLength - nDeleteLen);
		m_nlength = nLength - nDeleteLen;
	}
	
	free(pBuffer);
	
	//接收消息后上次Read会被释放  继续开启
	[sock readDataWithTimeout:-1 tag:0];
}




//向服务器发送字符串消息
- (void)send:(NSString*)content 
{
	if (!isConnected) 
	{
		return;
	}
	
	
	if (isShowSendData) 
	{
		NSLog(@"发送给服务器的数据是:%@", content);
	}
	
	//\0是结束符 必须添加
	content = [content stringByAppendingString:@"\0"];
	NSData* sendData= [content dataUsingEncoding: NSUTF8StringEncoding];
	[mySocket writeData:sendData withTimeout:-1 tag:0];
	[mySocket readDataWithTimeout:-1 tag:0];
}




//断开socket连接
- (void)close:(id)sender 
{
	if (isConnected)
	{
		//等待发完数据后断开连接
		[mySocket disconnectAfterReadingAndWriting];
	}
}



//发送数据后的回调
- (void)onSocket:(AsyncSocket*)sock didWriteDataWithTag:(long)tag 
{
	
}



//网络异常
- (void)onSocket:(AsyncSocket*)sock willDisconnectWithError:(NSError *)err 
{ 
	if (!isConnected) 
	{
		return;
	}
	
	//断线重连 
	reConnectType = @"NetErrorReconnect";
	//对异常断开的提示
	[self netError];
	//关闭本次连接 开始重连
	[self close:nil];
} 



//是否连接成功
- (BOOL)isConnected {
	return isConnected;
}



//网络正常退出
- (void)onSocketDidDisconnect:(AsyncSocket*)sock 
{ 
	if (!isConnected)
	{
		return;
	}
	
	isConnected = NO;
    //断开连接了 
    NSLog(@"Socket已经成功断开");
	
	//断线重连
	if ([reConnectType isEqualToString:@"NetErrorReconnect"]) 
	{
		[self connect:nil];
	}
}




///////////////////////////////////////////////////////////////////



//登录超时
- (void)loginTimeout 
{
}


//连接成功
- (void)connectSuccess 
{
	
}


//断线重连成功
- (void)reconnectSuccess 
{
	
}


//接收服务器返回的数据
- (void)recvServerData:(NSData*)data 
{
	
}


//网络异常中断
- (void)netError 
{
}


@end
