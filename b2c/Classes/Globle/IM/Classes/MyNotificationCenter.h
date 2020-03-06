//
//  MyNotificationCenter.h
//  IOSCim
//
//  Created by apple apple on 11-6-14.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

enum MyNotificationObServerType {
	SocketDidLogin = 0,
	SocketUpdateStatus = 10,
	SocketRecvMessage = 20,
	SockeTypeTipsMessage = 30,
	SocketRecvImageMessage = 35,
	
	HttpGroupDataComplete = 40,
	HttpGroupUserDataComplete = 50,
	HttpGetUserDataComplete = 60,
	HttpAddFriendDataComplete = 70,
	HttpAgreeFriendDataCompete = 80,
	
	SystemEventChooseFace = 90,
	SystemEventChooseMemberLoginId = 100,
	SystemEventUpdateChatListData = 110,
	SystemEventClearMessageTips = 120,
	SystemEventCrowdedOffline = 130,
	
	
	//收到有人请求加我为好友的消息
	SystemEventRecvAddFriendRquest = 140,
	//收到有人同意加为好友的消息
	SystemEventRecvAgreeAddFriend = 150,
	//收到有人决绝我的加好友请求的消息
	SystemEventRecvRefuseAddFriend = 160,
	
	//动态添加好友到列表中
	SystemEventDynamicAddFriend = 170,
	//动态删除好友
	SystemEventDynamicRemoveFriend = 180,
	//通知更新群视图
	SystemEventUpdateGroupView = 190,
	//通知更访客视图
	SystemEventUpdateGuestView = 200,
    //刷新群用户列表
    GroupMemberTableUpdate = 201,
    //动态添加群到列表中
    SystemEventDynamicAddGroup = 205,
    //刷新联系人列表
    SystemEventDynamicUpdate = 206,
	
	//提示网络异常中断
	SystemEventNetError = 210,
	
	//网络重连成功
	SystemEventReConnectSucess = 220
};

typedef enum MyNotificationObServerType MyNotificationObServerType;

@interface MyNotificationCenter : NSObject {

}


+ (void)addObserver:(id)notificationObserver
		   selector:(SEL)notificationSelector
			   name:(MyNotificationObServerType)notificationName
		 obServerId:(NSString*)obServerId;


//覆盖观察者
+ (void)recoveObserver:(id)notificationObserver
			  selector:(SEL)notificationSelector 
			obServerId:(NSString*)obServerId;


//删除观察者
+ (void)removeObserver:(id)notificationObserver 
			obServerId:(NSString*)obServerId;


//提交消息通知
+ (void)postNotification:(MyNotificationObServerType)notificationName 
				setParam:(id)param;


+ (void)clearAllObserver;

@end
