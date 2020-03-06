//
//  CIMSocketLogic.m
//  IOSCim
//
//  Created by apple apple on 11-8-19.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "CIMSocketLogic.h"
#import "Debuger.h"
#import "MyNotificationCenter.h"
#import "SendSocketContent.h"
#import "ParseSocketData.h"


@implementation CIMSocketLogic


//初始化配置参数
- (void)initParam
{
	reConnectMaxCount = 3;
	isShowRecvData = YES;
	isShowSendData = NO;
}


//登录超时
- (void)loginTimeout 
{
	[Debuger systemAlert:@"登录超时， 请检查网络"];
    [MyNotificationCenter postNotification:SystemEventCrowdedOffline setParam:nil];
}


//连接成功
- (void)connectSuccess 
{
	//默认隐身登录  当登录成功后状态回重置
	[self loginSocket:40];
}


//接收服务器返回的数据
- (void)recvServerData:(NSData*)data 
{
	//对消息的xml解析
	if (parseSocketData == nil) {
		parseSocketData = [ParseSocketData alloc];
	}
	
	[parseSocketData create:data];
	
}


//网络异常中断
- (void)netError 
{
	//[Debuger systemAlert:@"网络意外中断"];
}


////////////////////////////////////////////////////


//发送消息给多个用户
- (void)sendMessageToUsers:(NSString*)message 
				   usersId:(NSMutableArray*)usersId 
			   messageType:(int)messageType 
				   groupId:(NSString*)groupId
{
	
	NSString *content = [SendSocketContent getSendMessageXML:message
													 usersId:usersId
												 messageType:messageType 
													 groupId:groupId];
	
	[self send:content];
}
//发送消息给多个用户
- (void)sendMessageToUsers:(NSString*)message
                   usersId:(NSMutableArray*)usersId
               messageType:(int)messageType
                   groupId:(NSString*)groupId
                    remark:(NSString *)remark
{
    
    NSString *content = [SendSocketContent getSendMessageXML:message
                                                     usersId:usersId
                                                 messageType:messageType
                                                     groupId:groupId
                                                    remark:remark];
    
    [self send:content];
}




//发送消息给单个用户
- (void)sendMessageToUser:(NSString*)message 
				  userId:(NSString*)userId 
			  messageType:(int)messageType 
				  groupId:(NSString*)groupId
{
	
	NSString *content = [SendSocketContent getSendMessageXML:message 
													 usersId:[NSMutableArray arrayWithObject:userId]
												 messageType:messageType 
													 groupId:groupId];
	[self send:content];
}



//发送群消息
- (void)sendGroupMessage:(NSString*)message
				 groupId:(int)groupId
{
	
	[self send:[SendSocketContent getGroupMessageXML:message groupId:groupId messageType:@"1004"]];
}



//发送群系统消息
- (void)sendSystemGroupMessage:(NSString*)message
					   groupId:(NSString*)groupId
				   messageType:(NSString*)messageType 
{
	
	[self send:[SendSocketContent getGroupMessageXML:message groupId:groupId messageType:messageType]];
}



//登录通讯服务器
- (void)loginSocket:(int)userStatus 
{
	[self send:[SendSocketContent getLoginXML:0 userStatus:userStatus]];
}



//获取用户登录状态
- (void)queryStatusForUsers:(NSMutableArray*)usersId 
{
	[self send:[SendSocketContent getQueryUserStatusXML:usersId]];
}



//获取单个用户的登录状态
- (void)queryStatusForUser:(NSString*)userId 
{
	[self send:[SendSocketContent getQueryUserStatusXML:[NSMutableArray arrayWithObject:userId]]];
}



//设置自己的状态
- (void)setMyStatus:(int)status
{
	[self send:[SendSocketContent setMyStatus:status]];
	
	//设置为离线时 断开socket连接
	if (status == 50) 
	{
		[NSTimer scheduledTimerWithTimeInterval:0.1
										 target:self
									   selector:@selector(close:)
									   userInfo:nil
										repeats:NO];
	}
}

//停止发送心跳包
- (void)stopCheckPackageTimer {
    if (checkTimer) {
        [checkTimer invalidate];
        checkTimer = nil;
    }
}
//启动发送检测包的Timer
- (void)startCheckPackageTimer {
    //发送前先判断是否有在运行,有则关闭
    [self stopCheckPackageTimer];
    if (!checkTimer) {
        checkTimer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(sendCheckPackage:) userInfo:nil repeats:YES];
    }
}
//发送检测包
- (void)sendCheckPackage:(id)sender {
    [self send:[SendSocketContent getSendCheckPackageXML]];
}
@end
