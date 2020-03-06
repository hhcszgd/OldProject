//
//  ChatTreesViewController.m
//  IOSCim
//
//  Created by fei lan on 14-9-25.
//  Copyright (c) 2014年 CIMForIOS. All rights reserved.
//

#import "ChatTreesViewController.h"
#import "TreeKindCell.h"
#import "TreeEndCell.h"
#import "UserChatViewController.h"
#import "Director.h"
#import "MyNotificationCenter.h"
#import "Director.h"
#import "ChatListDataStruct.h"
#import "UserDataManage.h"
#import "GroupDataManage.h"
#import "UserData.h"
#import "Director.h"
#import "ChatUserStruct.h"
#import "GroupStruct.h"
#import "SystemChatRequestAddFriend.h"
#import "SystemMessage.h"
#import "SystemChatRequestAddGroup.h"
#import "SystemVariable.h"
#import "Tool.h"
#import "ChatTreesViewCell.h"
#import "WebViewController.h"
#import "SystemConfig.h"
#import "Config.h"

@interface ChatTreesViewController ()

@end

@implementation ChatTreesViewController

- (void)viewWillAppear:(BOOL)animated {
    [table reloadData];
    [self showTotalHoldReadNumber];
    [self.navigationController setNavigationBarHidden:NO];
    [self.parentViewController.navigationController setNavigationBarHidden:YES];
    
}

//接收添加好友的消息
- (void)recvAddFriendRequest:(ChatUserStruct*)chatUser
{
    
}
//添加消息提醒
- (void)addMessageTips:(ChatUserStruct*)chatUser
{
    NSInteger oldBadge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    oldBadge++;
    self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", oldBadge];
    [UIApplication sharedApplication].applicationIconBadgeNumber = oldBadge;
}



- (void)setMessageTips:(int)tipsMember
{
    if (tipsMember == 0)
    {
        self.tabBarItem.badgeValue = nil;
    }
    else
    {
        self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", tipsMember];
    }
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = tipsMember;
}



- (void)clearMessageTips:(id)sender
{
    self.tabBarItem.badgeValue = nil;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}



- (void)updateChatListUser:(ChatUserStruct*)chatUser
{
    if (self.isViewLoaded)
    {
        [table reloadData];
    }
    
    [self showTotalHoldReadNumber];
}



- (void)showTotalHoldReadNumber  {
    [self setMessageTips:[ChatListDataStruct getTotalUnReadAmount]];
}
- (void)viewDidLoad {
    title = @"会话";
    //全屏大小
    CGRect mainRect = [Tool screenRect];
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
    
    [super viewDidLoad];
    
    //[MyNotificationCenter recoveObserver:self selector:@selector(updateData:)];
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mainbg.jpg"]];
    
    //清除全部按钮
    UIButton *clearButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [clearButton setBackgroundImage:[UIImage imageNamed:@"icon_trash"] forState:UIControlStateNormal];
    [clearButton setBackgroundImage:[UIImage imageNamed:@"icon_trash"] forState:UIControlStateHighlighted];
    [clearButton addTarget:self action:@selector(removeAllChatUsers:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *clearBarButton = [[UIBarButtonItem alloc] initWithCustomView:clearButton];
    self.navigationItem.rightBarButtonItem = clearBarButton;
    
    //编辑按钮
    /*UIButton * editButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [editButton setBackgroundImage:[UIImage imageNamed:@"icon_edit"] forState:UIControlStateNormal];
    [editButton setBackgroundImage:[UIImage imageNamed:@"icon_edit"] forState:UIControlStateHighlighted];
    [editButton addTarget:self action:@selector(changeToEditMode:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *editBarButton = [[UIBarButtonItem alloc] initWithCustomView:editButton];
    self.navigationItem.rightBarButtonItem = editBarButton;*/
    
    CGRect tableRect;
    if (IS_GTE_IOS7) {
        tableRect = CGRectMake(0, 0, mainRect.size.width, mainRect.size.height - (statusBarHeight + navigationBarHeight + self.tabBarController.tabBar.frame.size.height + 5));
    } else {
        tableRect = CGRectMake(0, navigationBarHeight, mainRect.size.width, mainRect.size.height - (statusBarHeight + navigationBarHeight + self.tabBarController.tabBar.frame.size.height + 5));
    }
    table = [[UITableView alloc] initWithFrame:tableRect];
    table.dataSource = self;
    table.delegate = self;
    table.layer.opacity = 0.8;
    UIView *backView = [[UIView alloc] initWithFrame:CGRectZero];
    backView.backgroundColor = [UIColor clearColor];
    table.backgroundView = backView;
    [self.view addSubview:table];
}
//切换的编辑模式
- (void)changeToEditMode:(UIBarButtonItem*)sender  {
    if (table.editing) {
        table.editing = NO;
    } else {
        table.editing = YES;
    }
    [table reloadData];
}

//删除当前所有联系人
- (void)removeAllChatUsers:(id)sender  {
    if (!clearAlertView) {
        clearAlertView = [[UIAlertView alloc] initWithTitle:@"商盟通提示" message:@"您确定要清除所有会话记录吗?" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        clearAlertView.tag = 2;
    }
    [clearAlertView show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 2 && buttonIndex == 0) {
        [ChatListDataStruct removeAllChatUsers];
        [self clearMessageTips:nil];
        [table reloadData];
    }
}


#pragma mark ===table view datasource methods====
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView = tableView;
    return 1;
}

//行数
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    usersIdArray = [ChatListDataStruct getCurrentlyChatWithers];
    return [usersIdArray count];
}
//生成行
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    ChatTreesViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ChatTreesViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    ChatUserStruct *chatUser = [[ChatListDataStruct getCurrentlyChatWithers] objectAtIndex:indexPath.row];
    [cell initData:chatUser];
    for (UIView *subView in cell.contentView.subviews) {
        if (subView.tag == -1) {
            subView.tag = indexPath.row;
            [subView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headClick:)]];
        }
    }
    return cell;
}
//头像点击事件
- (void)headClick:(UITapGestureRecognizer *)tap {
    int tag = tap.view.tag;
    ChatUserStruct *chatUser = [[ChatListDataStruct getCurrentlyChatWithers] objectAtIndex:tag];
    UserData *user = [UserDataManage getUser:chatUser.dataId];
    NSMutableDictionary *loginData = [SystemConfig getLassLoginData];
    WebViewController *wvc = [[WebViewController alloc] init];
    wvc.hideNavWhenBack = YES;
    [wvc initData:user.nickname url:[NSString stringWithFormat:@"%@/ClientPage/userinfo_phone.html?sessionId=%@&userId=%@&loginId=%@",[Config getProjectPath], [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"], user.userId, [loginData objectForKey:@"loginId"]]];
    [self.parentViewController.navigationController pushViewController:wvc animated:YES];
}

//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
//即将点击
- (NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserChatViewController *userChat = [UserChatViewController alloc];
    ChatUserStruct *chatUser = [[ChatListDataStruct getCurrentlyChatWithers] objectAtIndex:indexPath.row];
    
    if ([chatUser.chatType isEqualToString:@"addFriendRequest"])
    {
        SystemChatRequestAddFriend *systemChatRequestAddFriend = [SystemChatRequestAddFriend alloc];
        systemChatRequestAddFriend.currentChatUser = chatUser;
        [self.navigationController pushViewController:systemChatRequestAddFriend animated:YES];
        return indexPath;
    }
    else if ([chatUser.chatType isEqualToString:@"agreeAddFriend"])
    {
        [self openUserSystemView:chatUser.dataId tips:@"系统消息: 用户 %@ 同意添加您为好友" chatUser:chatUser];
        return indexPath;
    }
    else if ([chatUser.chatType isEqualToString:@"refuseAddFriend"])
    {
        [self openUserSystemView:chatUser.dataId tips:@"系统消息: 用户 %@ 拒绝了您的好友请求" chatUser:chatUser];
        return indexPath;
        //同意加入群
    }
    else if ([chatUser.chatType isEqualToString:@"agreeAddGroup"])
    {
        [self openGroupSystemView:chatUser.dataId tips:@"系统消息: 群 %@ 同意了您加群请求" chatUser:chatUser];
        return indexPath;
    }
    else if ([chatUser.chatType isEqualToString:@"refuseAddGroup"])
    {
        [self openGroupSystemView:chatUser.dataId tips:@"系统消息: 群 %@ 拒绝了您加群请求" chatUser:chatUser];
        return indexPath;
    }
    else if ([chatUser.chatType isEqualToString:@"dissolveGroup"])
    {
        [self openGroupSystemView:chatUser.dataId tips:@"系统消息: 群 %@ 的创建者解散了该群" chatUser:chatUser];
        return indexPath;
        
    }
    else if ([chatUser.chatType isEqualToString:@"removeMeFromGroup"])
    {
        [self openGroupSystemView:chatUser.dataId tips:@"系统消息: 群 %@ 的创建者将您移除了该群" chatUser:chatUser];
        return indexPath;
    }
    else if ([chatUser.chatType isEqualToString:@"removeOtherFromGroup"])
    {
        NSString *tips = [[NSString alloc] initWithFormat:@"群 %@ 的创建者将用户%@移除了该群", chatUser.additionalMessage, @""];
        [self openGroupSystemView:chatUser.dataId tips:tips chatUser:chatUser];
        return indexPath;
    }
    else if ([chatUser.chatType isEqualToString:@"inviteMeToGroup"])
    {
        [self openGroupSystemView:chatUser.dataId tips:@"群 %@ 的创建者将您加入了该群" chatUser:chatUser];
        return indexPath;
    }
    else if ([chatUser.chatType isEqualToString:@"addGroupRequest"])
    {
        SystemChatRequestAddGroup *systemChatRequestAddGroup = [SystemChatRequestAddGroup alloc];
        systemChatRequestAddGroup.currentChatUser = chatUser;
        [self.navigationController pushViewController:systemChatRequestAddGroup animated:YES];
        return indexPath;
    }
    
    [userChat setConcantUser:chatUser];
    if ([chatUser.chatType isEqualToString:@"group"]) {
        GroupStruct *group = [GroupDataManage getGroup:chatUser.dataId];
        if (group) {
            userChat.chatTitle = group.groupName;
        }
    } else if ([chatUser.chatType isEqualToString:@"user"]) {
        UserData *user = [UserDataManage getUser:chatUser.dataId];
        if (user) {
            userChat.chatTitle = [user getUserName];
        }
    }
    [self.parentViewController.navigationController pushViewController:userChat animated:YES];
    return indexPath;
}



- (void)openGroupSystemView:(NSString*)groupId tips:(NSString*)tips  chatUser:(ChatUserStruct*)chatUser
{
    GroupStruct *group = [GroupDataManage getSystemGourpData:groupId];
    SystemMessage *systemMessage = [SystemMessage alloc];
    systemMessage.content = [[NSString alloc] initWithFormat:tips, group.groupName];
    [self.navigationController pushViewController:systemMessage animated:YES];
    [ChatListDataStruct removeChatUser:chatUser];
    [self showTotalHoldReadNumber];
    [myTableView reloadData];
}



- (void)openUserSystemView:(NSString*)userId tips:(NSString*)tips chatUser:(ChatUserStruct*)chatUser
{
    UserData *user = [UserDataManage getUser:userId];
    SystemMessage *systemMessage = [SystemMessage alloc];
    systemMessage.content = [[NSString alloc] initWithFormat:tips, [user getUserName]];
    [self.navigationController pushViewController:systemMessage animated:YES];
    [ChatListDataStruct removeChatUser:chatUser];
    [self showTotalHoldReadNumber];
    [myTableView reloadData];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatUserStruct *chatUser = [[ChatListDataStruct getCurrentlyChatWithers] objectAtIndex:indexPath.row];
    [ChatListDataStruct removeChatUser:chatUser];
    [table reloadData];
}

@end
