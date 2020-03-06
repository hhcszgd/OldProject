//
//  FillStrangerData.m
//  IOSCim
//
//  Created by apple apple on 11-8-18.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "FillStrangerData.h"
#import "ErrorParam.h"
#import "GetUsersWithIdHttp.h"
#import "UserData.h"
#import "UserDataManage.h"
#import "Debuger.h"
#import "CIMFriendListDataStruct.h"
#import "CimGlobal.h"



@implementation FillStrangerData


- (void)init:(NSString*)usersId 
{
	GetUsersWithIdHttp *http = [GetUsersWithIdHttp alloc];
	http.delegate = self;
	[http init:usersId];
}




- (void)recvGetUserData:(UserData*)user 
{
	CIMFriendListDataStruct *cimFriendListDataStruct = [CimGlobal getClass:@"CIMFriendListDataStruct"];
	[cimFriendListDataStruct addStranger:user];
}




- (void)errorGetUsersData:(ErrorParam*)error 
{
	[Debuger systemAlert:error.errorInfo];
}

@end
