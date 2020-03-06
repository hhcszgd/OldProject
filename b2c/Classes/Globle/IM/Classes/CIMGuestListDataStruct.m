//
//  CIMGuestListDataStruct.m
//  IOSCim
//
//  Created by apple apple on 11-8-16.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "CIMGuestListDataStruct.h"


@implementation CIMGuestListDataStruct


- (id)init 
{
	//设置用户列表的类型 shop / friend / guest
	userListType = @"guest";
	return self;
}


@end
