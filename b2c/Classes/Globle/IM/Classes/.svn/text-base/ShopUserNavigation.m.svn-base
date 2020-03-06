//
//  ShopUserNavigation.m
//  IOSCim
//
//  Created by apple apple on 11-7-20.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "ShopUserNavigation.h"
#import "UserData.h"
#import "UserDataManage.h"
#import "UserChatViewController.h"
#import "UserChatLogViewController.h"

@implementation ShopUserNavigation
@synthesize optUserId;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	[self.navigationController setNavigationBarHidden:NO];
	[self.parentViewController.navigationController setNavigationBarHidden:YES];
    [super viewDidLoad];
}



- (void)viewWillAppear:(BOOL)animated 
{
	[self.navigationController setNavigationBarHidden:NO];
	[self.parentViewController.navigationController setNavigationBarHidden:YES];
	self.title = @"详情";
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
	tableView.scrollEnabled = NO;
	return 2;
}



- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section 
{
	if (section == 0) 
	{
		return 1;
	} 
	else 
	{
		return 2;
	}
}



- (UITableViewCell*)tableView:(UITableView *)tableView
		cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	static NSString* cellid = @"cell";
	UITableViewCell* cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellid];
	
	if (cell == nil)
	{
		cell = [[UITableViewCell alloc]
				 initWithStyle:UITableViewCellStyleSubtitle 
				 reuseIdentifier:cellid] ;
	}
	
	
	UserData *userInfo = [UserDataManage getUser:optUserId];
	
	if (indexPath.section == 0) 
	{
		cell.imageView.image = [UIImage imageNamed:@"DefaultHead.png"];
		cell.textLabel.text = [userInfo getUserName];
		cell.detailTextLabel.text = userInfo.idiograph;
	} 
	else if (indexPath.section == 1) 
	{
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
		switch (indexPath.row) 
		{
			case 0:
				cell.textLabel.text = @"发送即时消息";
				break;
//			case 1:
//				cell.textLabel.text = @"查看资料";
//				break;
			case 1:
				cell.textLabel.text = @"聊天记录";
				break;
			default:
				break;
		}
	} 
	
	return cell;
}



- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	if (indexPath.section == 0) 
	{
		return indexPath;
	}
	
	//聊天
	if (indexPath.row == 0) 
	{
		UserChatViewController *userChat = [[UserChatViewController alloc] init];
		ChatUserStruct *chatUser = [ChatUserStruct alloc];
		chatUser.dataId = optUserId;
		chatUser.chatType = @"user";
		[userChat setConcantUser:chatUser];
		[self.parentViewController.navigationController pushViewController:userChat animated:YES];
	}
	else if (indexPath.row == 1) 
	{
		UserChatLogViewController *userChatController = [UserChatLogViewController alloc];
        userChatController.chatWitherId = optUserId;
        userChatController.messageType = 1;
		[self.navigationController pushViewController:userChatController animated:YES];
	}
	
	return indexPath;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 40.0;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	if (indexPath.section == 0) 
	{
		return 70;
	}
	
	return 50;
}




@end
