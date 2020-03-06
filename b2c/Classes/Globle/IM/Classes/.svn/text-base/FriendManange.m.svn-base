//
//  FriendManange.m
//  IOSCim
//
//  Created by apple apple on 11-7-12.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "FriendManange.h"
#import "Config.h"
#import "Debuger.h"
#import "HttpGetData.h"
#import "ParseFriend.h"
#import "ParseDeleteFriend.h"
#import "UserData.h"
#import "UserDataManage.h"
#import "ChatListDataStruct.h"
#import "MyNotificationCenter.h"

@implementation FriendManange



//删除好友
- (void)deleteFriend:(NSString*)friendId {
	myFriendId = friendId;
	NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];
	HttpGetData *addFriendHttp = [HttpGetData alloc];
	//对密码加密
	NSString *urlParam = [NSString stringWithFormat:@"function=%@&sessionId=%@&op=del&friendId=%@", 
						  @"setFriend", sessionId, friendId];
	
	NSLog(@"请求地址为:%@", urlParam);
	
	[addFriendHttp request:[Config getPath]
					 param:urlParam 
				  delegate:self 
				  selector:@selector(recvDeleteFriend:)];
}


- (void)recvDeleteFriend:(NSData*)xmlData {
	ParseDeleteFriend *parseDeleteFriend = [ParseDeleteFriend alloc];
	[parseDeleteFriend create:xmlData];
}



@end
