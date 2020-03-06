//
//  RecvGuestComeMessage.m
//  IOSCim
//
//  Created by apple apple on 11-8-17.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "RecvGuestComeMessage.h"
#import "UserDataManage.h"
#import "UserData.h"
#import "MyNotificationCenter.h"
#import "CIMGuestListDataStruct.h"
#import "CimGlobal.h"
#import "UserListKindDataStruct.h"
#import "CIMSocketLogicExt.h"


@implementation RecvGuestComeMessage
@synthesize message;


- (instancetype)init
{
	//检测是否已经存在数据
	if ([UserDataManage isExist:message.userId]) 
	{
		return nil ;
	}
	
	NSString *content = [message getContent];
	NSArray *arrtibuteArray = [content componentsSeparatedByString:@"{}"];
	UserData *user = [UserData alloc];
	user.userId = message.userId;
    
    if (arrtibuteArray.count > 2) {
        if (arrtibuteArray.count > 4) {
            user.nickname = [arrtibuteArray objectAtIndex:4];
        }
    
        user.guestCode = [arrtibuteArray objectAtIndex:2];
        user.lastAcessPage = [arrtibuteArray objectAtIndex:0];
    }
	[user setUserType:@"guest"];
	[user setStatus:@"10"];
	//保存数据到内存中
	[UserDataManage addUser:user];
	
	CIMGuestListDataStruct *cimGuestListDataStruct = [CimGlobal getClass:@"CIMGuestListDataStruct"];
	//更新好友列表
	[[cimGuestListDataStruct getListKind:@"1"] addUser:user];
	
	[MyNotificationCenter postNotification:SystemEventUpdateGuestView setParam:user];
	
	//获取访客状态
	CIMSocketLogicExt *cimSocketLogicExt = [CimGlobal getClass:@"CIMSocketLogicExt"];
	[cimSocketLogicExt queryStatusForUser:user.userId];
    return nil ;
}

@end
