//
//  GroupAddMemberViewController.m
//  IOSCim
//
//  Created by fei lan on 14-10-23.
//  Copyright (c) 2014年 CIMForIOS. All rights reserved.
//

#import "GroupAddMemberViewController.h"
#import "SystemVariable.h"
#import "Tool.h"
#import "WSCallerBlock.h"
#import "ChatListDataStruct.h"
#import "Config.h"
#import "ChatTreesViewCell.h"
#import "SVProgressHUD.h"
#import "CimGlobal.h"
#import "WSCallerBlock.h"
#import "MyNotificationCenter.h"
#import "CIMSocketLogicExt.h"
#import "UserDataManage.h"

@interface GroupAddMemberViewController ()

@end

@implementation GroupAddMemberViewController

- (void)viewDidLoad {
    //getGroupUser
    title = @"添加群用户";
    isShowBackButton = YES;
    mainRect = [Tool screenRect];
    //状态栏高度
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    //导航栏高度
    CGFloat navigationBarHeight = self.navigationController.navigationBar.bounds.size.height;
    //背景图
    CGRect backgroundViewRect = [Tool screenRect];
    if (IS_GTE_IOS7) {
        backgroundViewRect.origin.y -= (statusBarHeight + navigationBarHeight);
    }
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:backgroundViewRect];
    backgroundView.image = [UIImage imageNamed:@"appBG"];
    [self.view addSubview:backgroundView];
    
    //保存群用户按钮
    UIButton *saveUsersButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [saveUsersButton setBackgroundImage:[UIImage imageNamed:@"icon_save"] forState:UIControlStateNormal];
    [saveUsersButton setBackgroundImage:[UIImage imageNamed:@"icon_save"] forState:UIControlStateHighlighted];
    [saveUsersButton addTarget:self action:@selector(saveUsersClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItemOne = [[UIBarButtonItem alloc] initWithCustomView:saveUsersButton];
    self.navigationItem.rightBarButtonItem =rightBarButtonItemOne;
    
    cimUserListDataStruct = (CIMUserListDataStruct *)[CimGlobal getClass:@"CIMFriendListDataStruct"];
    
    [super viewDidLoad];
    
    selectedUsers = [[NSMutableDictionary alloc] init];
    users = [[NSMutableArray alloc] init];
    
    CGRect tableRect;
    if (IS_GTE_IOS7) {
        tableRect = CGRectMake(0, 0, mainRect.size.width, mainRect.size.height - (statusBarHeight + navigationBarHeight));
    } else {
        tableRect = CGRectMake(0, navigationBarHeight, mainRect.size.width, mainRect.size.height - (statusBarHeight + navigationBarHeight));
    }
    table = [[UITableView alloc] initWithFrame:tableRect style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    table.layer.opacity = 0.8;
    [self.view addSubview:table];
    [self buildData];
}
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [SVProgressHUD dismiss];
    [super viewWillDisappear:animated];
}
//设置群用户
- (void)setGroupUsers:(NSMutableArray *)groupUsersc {
    groupUsers = groupUsersc;
}
//获取用户信息
- (void)buildData {
    if (userTree == nil) {
        userTree = [[TreeNode alloc] init];
        userTree.expanded = YES;
        userTree.isRoot = YES;
    }
    if (!users) {
        users = [[NSMutableArray alloc] init];
    }
    
    NSMutableArray *kinds = [cimUserListDataStruct getListKinds];
    for (UserListKindDataStruct *kind in kinds) {
        [self buildKindUser:kind];
    }
    [table reloadData];
}
//获取用户信息
- (void)buildKindUser:(UserListKindDataStruct*)userKind {
    //过滤空分组
    if ([userKind getUsers] == nil) {
        return;
    }
    //分组中的用户
    NSMutableArray *kindUsers = [[userKind getUsers] mutableCopy];
    for (UserData *kindUser in kindUsers) {
        UserData *userDataOne = [[UserData alloc] init];
        userDataOne.userId = kindUser.userId;
        userDataOne.nickname = [kindUser getUserName];
        userDataOne.faceIndex = [kindUser faceIndex];
        BOOL flag = YES;
        if (groupUsers && [groupUsers count] > 0) {
            for (UserData *groupUserData in groupUsers) {
                if ([groupUserData.userId isEqualToString:userDataOne.userId]) {
                    flag = NO;
                }
            }
        }
        if (flag) {
           [users addObject:userDataOne];
        }
    }
}
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [users count];
}
//生成行
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    ChatTreesViewCell *cell = (ChatTreesViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ChatTreesViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    }
    UserData *userData = [users objectAtIndex:indexPath.row];
    [cell initUserData:userData];
    return cell;
}
//行点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatTreesViewCell *cell = (ChatTreesViewCell*)[table cellForRowAtIndexPath:indexPath];
    UserData *userData = [users objectAtIndex:indexPath.row];
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        [selectedUsers removeObjectForKey:userData.userId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        [selectedUsers setObject:[userData getUserName] forKey:userData.userId];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
}
//保存按钮事件
- (void)saveUsersClick:(id)sender {
    if ([selectedUsers count] == 0) {
        return;
    }
    NSArray *userIds = [selectedUsers allKeys];
    NSString *userIdsStr = @"";
    for (int x = 0; x < [userIds count]; x++) {
        NSString *userIdOne = [userIds objectAtIndex:x];
        userIdsStr = [userIdsStr stringByAppendingString:userIdOne];
        if (x != [userIds count] - 1) {
            userIdsStr = [userIdsStr stringByAppendingString:@","];
        }
    }
    ChatUserStruct *curGroup = [ChatListDataStruct getCurrentChatUserId];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"] forKey:@"sessionId"];
    [param setObject:@"group.user.set" forKey:@"function"];
    [param setObject:curGroup.dataId forKey:@"groupId"];
    [param setObject:userIdsStr forKey:@"addUserId"];
    WSCallerBlock *saveUserCall = [[WSCallerBlock alloc] init];
    [SVProgressHUD showWithStatus:@"保存中..."];
    [saveUserCall callPost:[Config getPath] params:param delegate:self usingBlock:^(NSData *data) {
        [SVProgressHUD dismiss];
        if (data) {
            NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSRegularExpression *xmlRegex = [NSRegularExpression regularExpressionWithPattern:@"<result code=[\"|']([\\d]*)[\"|']" options:NSRegularExpressionCaseInsensitive error:nil];
            NSArray *arrayRange = [xmlRegex matchesInString:dataStr options:NSMatchingReportCompletion range:NSMakeRange(0, dataStr.length)];
            BOOL isFail = YES;
            for (NSTextCheckingResult *match in arrayRange) {
                NSString *code = [dataStr substringWithRange:[match rangeAtIndex:1]];
                if (code.intValue == 0) {
                    isFail = NO;
                }
            }
            if (isFail) {
                NSRegularExpression *xmlRegex2 = [NSRegularExpression regularExpressionWithPattern:@"msg=[\"|']([^\"|^']*)[\"|']" options:NSRegularExpressionCaseInsensitive error:nil];
                NSArray *arrayRange2 = [xmlRegex2 matchesInString:dataStr options:NSMatchingReportCompletion range:NSMakeRange(0, dataStr.length)];
                NSString *error = @"保存成员失败";
                for (NSTextCheckingResult *match in arrayRange2) {
                    error = [dataStr substringWithRange:[match rangeAtIndex:1]];
                }
                [SVProgressHUD showErrorWithStatus:error duration:3];
                return;
            }
            CIMSocketLogicExt *cimSocket = [CimGlobal getClass:@"CIMSocketLogicExt"];
            NSMutableArray *userIdsArray = [[NSMutableArray alloc] init];
            [userIdsArray addObjectsFromArray:userIds];
            if (groupUsers && [groupUsers count] > 0) {
                for (UserData *groupUserData in groupUsers)  {
                    [userIdsArray addObject:groupUserData.userId];
                }
            }
            for (NSString *userOne in userIds) {
                [cimSocket sendMessageToUsers:[NSString stringWithFormat:@"%@,0", userOne] usersId:userIdsArray messageType:1009 groupId:curGroup.dataId remark:[NSString stringWithFormat:@"%@,%@", [selectedUsers objectForKey:userOne], [[UserDataManage getSelfUser] getUserName]]];
            }
            [MyNotificationCenter postNotification:GroupMemberTableUpdate setParam:nil];
            [SVProgressHUD showSuccessWithStatus:@"保存成功"];
            [self back:nil];
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
