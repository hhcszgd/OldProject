//
//  RecvSocketMessage.h
//  IOSCim
//
//  Created by apple apple on 11-6-7.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageStruct.h"
#import "ParseXMLString.h"

enum SocketMessageType 
{
	
	//客户端消息
	SocketMessageTypeWindowsUser = 1,
	
	//网页访客消息
	SocketMessageTypeBowserUser = 22,
	
	//来访消息
	SocketMessageTypeGuestCome = 6,
	
	//群消息
	SocketMessageTypeGroupUser = 1004,
	
	//请求加好友消息  消息内容：如果没有说明测发'@' ，如果有说明就发说明。
	SocketMessageRequestAddFriend = 3,
	
	//同意对方加我为好友消息 消息内容：如果没有说明测发'- '
	SocketMessageAgreeAddFriend = 4,
	
	//拒绝对方加为好友 消息内容：如果没有说明测发'- '
	SocketMessageRefuseAddFriend = 5,
	
	//删除群成员
	SocketMessageRemoveGroupUser = 1010,
	
	//删除群成员 兼容旧客户端
	SocketMessageOldRemoveGroupUser = 19,
	
	//退出群
	SocketMessageExitGroup = 1012,
	
	//退出群 兼容旧客户端
	SocketMessageOldExitGroup = 44,
	
	//解散群
	SocketMessageDissolveGroup = 1013,
	
	//解散群 兼容旧客户端
	SocketMessageOldDissolveGroup = 21,
	
	//创建者邀请我加入了群
	SocketMessageInviteAddGroup = 1009,
	
	//创建者邀请我加入了群 兼容旧客户端
	SocketMessageOldInviteAddGroup = 18,
	
	//接收图片
	SocketRecvImage = 30,
	
	//接收群图片
	SocketRecvGroupImage = 1008
};


@interface RecvSocketMessage : ParseXMLString {
	BOOL isLoginSuccess;
}
- (void)clearData;
+ (void)recvSystemGroupMessage:(NSString*)type groupId:(NSString*)groupId message:(MessageStruct*)message content:(NSString*)content;

- (void)loginResult:(NSString *)code;
- (void)recvUserMessage:(MessageStruct*)message;
- (void)recvUserImageMessage:(MessageStruct*)message;
- (void)saveTempUserMessage:(MessageStruct*)message;
- (void)saveTempGuestMessage:(MessageStruct*)message;
- (void)recvGroupMessage:(MessageStruct*)message;
- (void)recvGroupImageMessage:(MessageStruct*)message;
- (void)recvMessage:(MessageStruct*)message;

@end
