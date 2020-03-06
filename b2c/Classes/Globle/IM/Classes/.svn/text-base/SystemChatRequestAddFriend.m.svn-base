//
//  SystemChatRequestAddFriend.m
//  IOSCim
//
//  Created by apple apple on 11-8-4.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "SystemChatRequestAddFriend.h"
#import "UserDataManage.h"
#import "UserData.h"
#import "ChatUserStruct.h"
#import "Debuger.h"
#import "ChatListDataStruct.h"
#import "AddFriendHttp.h"
#import "MyNotificationCenter.h"
#import "ErrorParam.h"
#import "CIMFriendListDataStruct.h"
#import "CimGlobal.h"
#import "CIMSocketLogicExt.h"
#import "Tool.h"
#import "SystemVariable.h"

@implementation SystemChatRequestAddFriend

@synthesize table,buttonOne,buttonTwo, userHeadImage, userLoginId, userSignature, verificationMessage, currentChatUser;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    
    title = @"加好友请求";
    //全屏大小
    CGRect mainRect = [Tool screenRect];
    isShowBackButton = YES;
    //状态栏高度
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    //导航栏高度
    CGFloat navigationBarHeight = self.navigationController.navigationBar.bounds.size.height;
    
    //背景图
    CGRect backgroundViewRect = mainRect;
    if (IS_GTE_IOS7) {
        backgroundViewRect.origin.y -= (statusBarHeight + navigationBarHeight);
    }
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:backgroundViewRect];
    backgroundView.image = [UIImage imageNamed:@"appBG"];
    [self.view addSubview:backgroundView];
    
	cimSocketLogicExt = [CimGlobal getClass:@"CIMSocketLogicExt"];
    table.layer.opacity = 0.8;
    [[table superview] bringSubviewToFront:table];
    [[buttonOne superview] bringSubviewToFront:buttonOne];
    [[buttonTwo superview] bringSubviewToFront:buttonTwo];
    [[userHeadImage superview] bringSubviewToFront:userHeadImage];
    [[userLoginId superview] bringSubviewToFront:userLoginId];
    [[userSignature superview] bringSubviewToFront:userSignature];
    [[verificationMessage superview] bringSubviewToFront:verificationMessage];
    
    [super viewDidLoad];
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
	
	UserData *user = [UserDataManage getUser:currentChatUser.dataId];

	cell.imageView.image = [UIImage imageNamed:[user getHeadImage]];
	cell.textLabel.text = [user getUserName];
	cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"验证消息:%@", currentChatUser.additionalMessage];
	return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 100;
}

- (IBAction)agreeAddFriend:(id)sender {
	AddFriendHttp *http = [AddFriendHttp alloc];
	http.delegate = self;
	[http init:currentChatUser.dataId kindName:@"" option:@"add"];
	//发送同意消息
	[ChatListDataStruct removeChatUser:currentChatUser];
	[self.navigationController popViewControllerAnimated:YES];
}
//添加好友成功
- (void)successAddFriend:(UserData*)user {
	//发送确认消息让对方的好友列表中消息自己
	[cimSocketLogicExt sendAgreeAddFriendMessage:currentChatUser.dataId];
	
	user.kindId = @"1"; //默认添加到我的好友列表中
	CIMFriendListDataStruct *cimUserListDataStruct = [CimGlobal getClass:@"CIMFriendListDataStruct"];
	[cimUserListDataStruct addListUser:user];
	
	//刷新好友列表
	[MyNotificationCenter postNotification:SystemEventDynamicAddFriend setParam:user];	
}
- (void)errorAddFriend:(ErrorParam*)error {
	[Debuger systemAlert:error.errorInfo];
}
- (IBAction)refuseAddFriend:(id)sender {
	//发送拒绝消息
	[cimSocketLogicExt sendRefuseAddFriendMessage:currentChatUser.dataId];
	[ChatListDataStruct removeChatUser:currentChatUser];
	[self.navigationController popViewControllerAnimated:YES];
}




- (void)viewDidUnload {
    [self setTable:nil];
    [self setButtonOne:nil];
    [self setButtonTwo:nil];
    [super viewDidUnload];
}
@end
