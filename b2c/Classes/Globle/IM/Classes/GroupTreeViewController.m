//
//  GroupTreeViewController.m
//  IOSCim
//
//  Created by fukq helpsoft on 11-4-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GroupTreeViewController.h"
#import "MyNotificationCenter.h"
#import "GroupDataManage.h"
#import "UserChatViewController.h"
#import "ChatUserStruct.h"
#import "GroupNavigation.h"
#import "SearchGroupViewController.h"

@implementation GroupTreeViewController

@synthesize myTableView;

- (void)viewWillAppear:(BOOL)animated 
{
	[self.parentViewController.navigationController setNavigationBarHidden:YES];
	[self.navigationController setNavigationBarHidden:NO];
}



- (void)viewDidLoad 
{
	self.title = @"群组";
	[self.parentViewController.navigationController setNavigationBarHidden:YES];
	[self.navigationController setNavigationBarHidden:NO];
	
	UIBarButtonItem *searchGroupButton = [[UIBarButtonItem alloc]
										  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
															   target:self
															   action:@selector(searchGroup:)];
	[MyNotificationCenter addObserver:self
							 selector:@selector(showGroups:)
								 name:SystemEventUpdateGroupView
						   obServerId:@"GroupTreeViewController_showGroups"];
	 
	self.navigationItem.rightBarButtonItem = searchGroupButton;
	[super viewDidLoad];
}



//转向搜索群窗口
- (void)searchGroup:(id)sender 
{
	SearchGroupViewController *searchGroupViewController = [SearchGroupViewController alloc];
	[self.navigationController pushViewController:searchGroupViewController animated:YES];
}



#pragma mark ===table view datasource methods====


- (void)showGroups:(id)sender 
{
	[self.myTableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
	return 1;
}


- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section 
{
	return [[GroupDataManage getMyGroups] count];
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
	
	GroupStruct *group = [[GroupDataManage getMyGroups] objectAtIndex:indexPath.row];
	cell.textLabel.text = group.groupName;
	cell.imageView.image = [UIImage imageNamed:@"grouphead.png"];
	UIButton *assessoryButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	[assessoryButton setTitle:group.groupId forState:UIControlStateNormal];
	
	[assessoryButton addTarget:self
						action:@selector(lookGroupInfo:)
			  forControlEvents:UIControlEventTouchUpInside];
	cell.accessoryView = assessoryButton;
	return cell;
}


//////////////////////////////////////////////////////////


//查看群信息菜单
- (void)lookGroupInfo:(UIButton*)sender 
{
	GroupNavigation *groupNavigation = [GroupNavigation alloc];
	groupNavigation.optGroupId = [sender titleForState:UIControlStateNormal];
	[self.navigationController pushViewController:groupNavigation animated:YES];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	return 50;
}


- (NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	UserChatViewController *userChat = [[UserChatViewController alloc] init];
	
	GroupStruct *group = [[GroupDataManage getMyGroups] objectAtIndex:indexPath.row];
	ChatUserStruct *chatUser = [ChatUserStruct alloc];
	chatUser.dataId = group.groupId;
	chatUser.chatType = @"group";
	[userChat setConcantUser:chatUser];
	//[self.navigationController pushViewController:userChat animated:YES];
	[self.parentViewController.navigationController pushViewController:userChat animated:YES];
	return indexPath;
}




@end




