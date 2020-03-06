//
//  LoginHttp.m
//  IOSCim
//
//  Created by apple apple on 11-8-9.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "LoginHttp.h"
#import "XMLElementParam.h"
#import "MyNotificationCenter.h"
#import "ErrorParam.h"
#import "Debuger.h"
#import "ShopDeptStruct.h"
#import "IOSCimAppDelegate.h"
#import "UserData.h"
#import "UserDataManage.h"
#import "ChatListDataStruct.h"
#import "FriendKindStruct.h"
#import "SystemConfig.h"
#import "UserListKindDataStruct.h"
#import "CIMShopListDataStruct.h"
#import "CIMFriendListDataStruct.h"
#import "CimGlobal.h"
#import "LoginManage.h"
#import "CIMGuestListDataStruct.h"
#import "Config.h"
#import "CimGlobal.h"
#import "OPChatLogData.h"
#import "FillStrangerData.h"
#import "GroupDataManage.h"


@implementation LoginHttp
@synthesize delegate;

- (void)init:(NSString*)loginId password:(NSString*)password 
{
    [ChatListDataStruct removeAllChatUsers];
    
	//为登录帐号添加 域名后缀
	loginId = [loginId stringByAppendingString:[Config getDomain]];
	
	//url参数
	additionalParam = [[NSString alloc]
					   initWithFormat:@"&function=%@&loginId=%@&password=%@&includeShop=%@&clientType=%@&includeFriend=%@", 
					   @"login", loginId, password, @"true", @"3", @"true"];
	httpType = @"login";
	isPrintXML = NO;
	[self call];
	
	if (cimShopListDataStruct == nil)
	{
		cimShopListDataStruct = [CimGlobal getClass:@"CIMShopListDataStruct"];
	}
	
	
	if (cimFriendListDataStruct == nil)
	{
		cimFriendListDataStruct = [CimGlobal getClass:@"CIMFriendListDataStruct"];
	}
}




- (void)parseXMLFunction:(XMLElementParam*)xmlParam 
{
	
    //登录成功后 记忆帐号
    if ([SystemConfig isRememberParssword])
    {
        NSString *loginId = [LoginManage getLoginId];
        NSString *password = [LoginManage getPassword];
        [SystemConfig addLoginUser:loginId password:password];
    }
	
	//保存sessionId
	if ([xmlParam.elementName isEqualToString:@"result"]) 
	{
		sessionId = [xmlParam.attributeDict objectForKey:@"sessionid"];
		[[NSUserDefaults standardUserDefaults] setObject:sessionId forKey:@"sessionId"];
	}
	
	//保存自己的信息
	if ([xmlParam.elementName isEqualToString:@"user"] && parentElementName == nil) 
	{
		UserData *user = [UserData alloc];
		user.userId = [xmlParam.attributeDict objectForKey:@"id"];
		user.loginId = [xmlParam.attributeDict objectForKey:@"loginId"];
		user.nickname = [xmlParam.attributeDict objectForKey:@"nickname"];
		user.idiograph = [xmlParam.attributeDict objectForKey:@"idiograph"];
        user.faceIndex = [xmlParam.attributeDict objectForKey:@"faceIndex"];
        user.friendVerifyType = [xmlParam.attributeDict objectForKey:@"friendVerifyType"];
        [UserDataManage addUser:user];
		[UserDataManage setSelfUserId:user.userId];
        
        [[NSUserDefaults standardUserDefaults] setObject:user.userId forKey:@"userId"];
        [[NSUserDefaults standardUserDefaults] setObject:user.loginId forKey:@"loginId"];
        [[NSUserDefaults standardUserDefaults] setObject:user.nickname forKey:@"nickname"];
	}
	
	//记录shopId
	if ([xmlParam.elementName isEqualToString:@"shop"]) 
	{
		shopId = [xmlParam.attributeDict objectForKey:@"id"];
	}
	
	//把shop当作dept统一处理	
	if ([xmlParam.elementName isEqualToString:@"shop"] || [xmlParam.elementName isEqualToString:@"dept"]) 
	{
		parentElementName = @"dept";
		UserListKindDataStruct *shopDept = [UserListKindDataStruct alloc];
		shopDept.dataId = [xmlParam.attributeDict objectForKey:@"id"];
		shopDept.kindName = [xmlParam.attributeDict objectForKey:@"name"];
		shopDept.parentId = [xmlParam.attributeDict objectForKey:@"parentId"];
		[cimShopListDataStruct addListKind:shopDept];
		deptId = shopDept.dataId;
	} 
	else if ([xmlParam.elementName isEqualToString:@"user"] && [parentElementName isEqualToString:@"dept"]) 
	{
		
		UserData *user = [UserData alloc];
		user.userId = [xmlParam.attributeDict objectForKey:@"id"];
		user.loginId = [xmlParam.attributeDict objectForKey:@"loginId"];
		user.nickname = [xmlParam.attributeDict objectForKey:@"nickname"];
		user.idiograph = [xmlParam.attributeDict objectForKey:@"idiograph"];
        user.faceIndex = [xmlParam.attributeDict objectForKey:@"faceIndex"];
        user.friendVerifyType = [xmlParam.attributeDict objectForKey:@"friendVerifyType"];
		user.deptId = deptId;
		[cimShopListDataStruct addListUser:user];

	}
	
	if ([xmlParam.elementName isEqualToString:@"friendKind"])
	{
        if ([[xmlParam.attributeDict objectForKey:@"name"] isEqualToString:@"陌生人"]) {
            return;
        }
		parentElementName = @"kind";
		UserListKindDataStruct *friendKind = [UserListKindDataStruct alloc];
		friendKind.dataId = [xmlParam.attributeDict objectForKey:@"id"];
		friendKind.kindName = [xmlParam.attributeDict objectForKey:@"name"];
		friendKind.parentId = [xmlParam.attributeDict objectForKey:@"parentId"];
		[cimFriendListDataStruct addListKind:friendKind];
		kindId = friendKind.dataId;
    } else if ([xmlParam.elementName isEqualToString:@"fixusers"]) {
        parentElementName = @"kind";
        UserListKindDataStruct *friendKind = [UserListKindDataStruct alloc];
        friendKind.dataId = @"-99";
        friendKind.kindName = @"客服";
        friendKind.parentId = @"";
        [cimFriendListDataStruct addListKind:friendKind];
        kindId = @"-99";
    } else if ([xmlParam.elementName isEqualToString:@"user"] && [parentElementName isEqualToString:@"kind"]) {
		UserData *user = [UserData alloc];
		user.userId = [xmlParam.attributeDict objectForKey:@"id"];
		user.loginId = [xmlParam.attributeDict objectForKey:@"loginId"];
		user.nickname = [xmlParam.attributeDict objectForKey:@"nickname"];
		user.idiograph = [xmlParam.attributeDict objectForKey:@"idiograph"];
        user.faceIndex = [xmlParam.attributeDict objectForKey:@"faceIndex"];
        user.friendVerifyType = [xmlParam.attributeDict objectForKey:@"friendVerifyType"];
        if ([user.friendVerifyType isEqualToString:@"0"]) {
            //user.friendVerifyType = @"-99";
        }
		user.kindId = kindId;
		[cimFriendListDataStruct addListUser:user];
	}
}



//解析完成后通知
- (void)postEndFunction:(id)sender 
{
    [GroupDataManage clearGroupData];
	NSLog(@"登录成功");
	UserListKindDataStruct *stranger = [UserListKindDataStruct alloc];
	stranger.dataId = @"stranger";
	stranger.kindName = @"陌生人";
	[cimFriendListDataStruct addListKind:stranger];
	
	OPChatLogData *opChatLogData = [CimGlobal getClass:@"OPChatLogData"];
	//获取陌生人的Id
	NSMutableArray *strangerIdArray = [opChatLogData getStrangers];
	
	if ([strangerIdArray count] != 0) 
	{
		NSString *strangerIdString = [strangerIdArray componentsJoinedByString:@","];
		FillStrangerData *fillStrangerData = [FillStrangerData alloc];
		[fillStrangerData init:strangerIdString];
	}
	
	UserListKindDataStruct *guestKind1 = [UserListKindDataStruct alloc];
	guestKind1.dataId = @"1";
	guestKind1.kindName = @"新产生的访客";
	
	UserListKindDataStruct *guestKind2 = [UserListKindDataStruct alloc];
	guestKind2.dataId = @"2";
	guestKind2.kindName = @"沟通过的访客";
	
	CIMGuestListDataStruct *cimGuestListDataStruct = [CimGlobal getClass:@"CIMGuestListDataStruct"];
	[cimGuestListDataStruct addListKind:guestKind1];
	[cimGuestListDataStruct addListKind:guestKind2];
	
	//添加数据库中的访客到沟通过的访客分组中
	[cimGuestListDataStruct batchAddListUser:[opChatLogData getGuestsInfo]];
	[delegate performSelector:@selector(recvLoginData:) withObject:sessionId];
}

//错误处理
- (void)errorFunction:(ErrorParam*)error {
	[delegate performSelector:@selector(errorLogin:) withObject:error];
}


@end
