//
//  DataManage.m
//  IOSCim
//
//  Created by apple apple on 11-5-17.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "DataManage.h"
#import "LoginManage.h"

@implementation DataManage

//登录
+ (void)login:(NSString *)loginId password:(NSString *)password{
	LoginManage *loginManage = [LoginManage alloc];
	[loginManage init:loginId password:password];
}



@end
