//
//  SystemChatRequestAddGroup.m
//  IOSCim
//
//  Created by apple apple on 11-8-12.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "SystemChatRequestAddGroup.h"
#import "UserDataManage.h"
#import "UserData.h"
#import "GroupDataManage.h"
#import "GroupStruct.h"
#import "SetGroupUserHttp.h"
#import "ErrorParam.h"
#import "Debuger.h"
#import "ChatListDataStruct.h"
#import "CIMSocketLogicExt.h"
#import "CimGlobal.h"


@implementation SystemChatRequestAddGroup
@synthesize currentChatUser;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	self.title = @"加群请求";
    [super viewDidLoad];
	cimSocketLogicExt = [CimGlobal getClass:@"CIMSocketLogicExt"];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	tableView.backgroundColor = [UIColor clearColor];
	tableView.scrollEnabled = NO;
	return 1;
}


- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	return 1;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {	
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
	
	UserData *user = [UserDataManage getUser:currentChatUser.additionalUserId];
	
	cell.imageView.image = [UIImage imageNamed:[user getHeadImage]];
	cell.textLabel.text = [user getUserName];
	cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"验证消息:%@", currentChatUser.additionalMessage];
	return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 100;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	GroupStruct *group = [GroupDataManage getGroup:currentChatUser.dataId];
	UserData *user = [UserDataManage getUser:currentChatUser.additionalUserId];
	return [[NSString alloc] initWithFormat:@"有用户 %@ 请求加入群 %@", [user getUserName], group.groupName];
}



- (IBAction)agreeAddGroup:(id)sender {
	SetGroupUserHttp *http = [SetGroupUserHttp alloc];
	http.delegate = self;
	[http addUser:currentChatUser.additionalUserId groupId:currentChatUser.dataId];
}




- (IBAction)refuseAddGroup:(id)sender {
	[cimSocketLogicExt sendRefuseAddGroupMessage:currentChatUser.dataId userId:currentChatUser.additionalUserId];
	//发送同意消息
	[ChatListDataStruct removeChatUser:currentChatUser];
	[self.navigationController popViewControllerAnimated:YES];
}



//添加成功
- (void)recvSetGroupUserData:(id)sender {
	[cimSocketLogicExt sendAgreeAddGroupMessage:currentChatUser.dataId userId:currentChatUser.additionalUserId];
	
	//发送同意消息
	[ChatListDataStruct removeChatUser:currentChatUser];
	[self.navigationController popViewControllerAnimated:YES];
}



- (void)errorSetGroupUser:(ErrorParam*)error {
	[Debuger systemAlert:error.errorInfo];
}



@end
