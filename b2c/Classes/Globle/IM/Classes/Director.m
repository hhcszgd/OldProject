//
//  Director.m
//  IOSCim
//
//  Created by apple apple on 11-6-1.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "Director.h"
#import "ChatTreesViewController.h"
#import "UserChatViewController.h"
#import "LoginViewController.h"
#import "SettingController.h"

@implementation Director
static UIViewController *currentViewController;


+ (void)markCurrentViewController:(UIViewController *)viewController 
{
	//NSLog(@"Root ViewController Is: %@", [viewController description]);
	currentViewController = viewController;
	
	//切换为 企业面板时 更新企业人员状态
	if ([viewController isMemberOfClass:[ChatTreesViewController class]])
	{
		//ChatTreeViewController *chatTreeController = (ChatTreeViewController*)viewController;
		//[chatTreeController updateData:nil];
	//切换为 聊天窗口面板时 更新聊天消息	
	} 
	else if ([viewController isMemberOfClass:[UserChatViewController class]]) 
	{
		//UserChatController *userChatController = (UserChatController*)viewController;
		//[userChatController updateChatMessage:nil];
	} 
	else if ([viewController isMemberOfClass:[LoginViewController class]])
	{
		//LoginViewController *loginController = (LoginViewController*)viewController;
		//[loginController updateLoginStatus];
	} else if ([viewController isMemberOfClass:[SettingController class]]) 
	{
		SettingController *settingController = (SettingController*)viewController;
		[settingController updateData];
	}
}



+ (BOOL)isCurrentViewController:(UIViewController*)viewController 
{
	return [[currentViewController description] isEqualToString:[viewController description]];
}


@end
