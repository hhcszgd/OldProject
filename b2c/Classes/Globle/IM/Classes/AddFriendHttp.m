//
//  AddFriendHttp.m
//  IOSCim
//
//  Created by apple apple on 11-8-9.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "AddFriendHttp.h"
#import "XMLElementParam.h"
#import "ErrorParam.h"
#import "UserData.h"
#import "UserDataManage.h"
@implementation AddFriendHttp
@synthesize delegate;

- (void)init:(NSString*)friendId kindName:(NSString*)kindName option:(NSString*)option 
{
	_friendId = friendId;
	//url参数
	additionalParam = [[NSString alloc] 
					   initWithFormat:@"&function=%@&friendId=%@&kindName=%@&op=%@", 
					   @"setFriend", friendId, kindName, option];
    if ([option isEqualToString:@"deleteFriend"]) {
        additionalParam = [[NSString alloc] initWithFormat:@"&function=%@&friendUserId=%@", @"friend.delete", friendId];
    }
	httpType = @"setFriend";
	isPrintXML = YES;
	[self call];
}



- (void)parseXMLFunction:(XMLElementParam*)xmlParam {
	UserData *user = [UserDataManage getUser:_friendId];
	[delegate performSelector:@selector(successAddFriend:) withObject:user];
}



//解析完成后通知
- (void)postEndFunction:(id)sender 
{
	
}


- (void)errorFunction:(ErrorParam*)error 
{
	[delegate performSelector:@selector(errorAddFriend:) withObject:error];
}


@end
