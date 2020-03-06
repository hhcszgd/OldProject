//
//  GroupMemberViewController.m
//  IOSCim
//
//  Created by fei lan on 14-10-23.
//  Copyright (c) 2014年 CIMForIOS. All rights reserved.
//

#import "GroupMemberViewController.h"
#import "SystemVariable.h"
#import "Tool.h"
#import "WSCallerBlock.h"
#import "ChatListDataStruct.h"
#import "Config.h"
#import "ChatTreesViewCell.h"
#import "SVProgressHUD.h"
#import "GroupAddMemberViewController.h"
#import "MyNotificationCenter.h"
#import "UserDataManage.h"
#import "WebViewController.h"
#import "SystemConfig.h"
#import "CIMSocketLogicExt.h"
#import "CimGlobal.h"

@interface GroupMemberViewController ()

@end

@implementation GroupMemberViewController

- (void)viewDidLoad {
    //刷新table用
    [MyNotificationCenter addObserver:self selector:@selector(getGroupUsers) name:GroupMemberTableUpdate obServerId:@"GroupMemberViewController_getGroupUsers"];
    
    //getGroupUser
    title = @"群成员管理";
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
    
    //管理群用户按钮
    /*UIButton *editUserButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [editUserButton setBackgroundImage:[UIImage imageNamed:@"icon_edit"] forState:UIControlStateNormal];
    [editUserButton setBackgroundImage:[UIImage imageNamed:@"icon_edit"] forState:UIControlStateHighlighted];
    [editUserButton addTarget:self action:@selector(editUserClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItemOne = [[UIBarButtonItem alloc] initWithCustomView:editUserButton];*/
    //添加群用户按钮
    UIButton *addUserButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [addUserButton setBackgroundImage:[UIImage imageNamed:@"icon_add"] forState:UIControlStateNormal];
    [addUserButton setBackgroundImage:[UIImage imageNamed:@"icon_add"] forState:UIControlStateHighlighted];
    [addUserButton addTarget:self action:@selector(addUserClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItemTwo = [[UIBarButtonItem alloc] initWithCustomView:addUserButton];
    self.navigationItem.rightBarButtonItem = rightBarButtonItemTwo;
    
    [super viewDidLoad];
    
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
    [self getGroupUsers];
}
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [SVProgressHUD dismiss];
    [table setEditing:NO];
    [super viewWillDisappear:animated];
}
//获取群用户
- (void)getGroupUsers {
    [SVProgressHUD show];
    ChatUserStruct *curGroup = [ChatListDataStruct getCurrentChatUserId];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:@"getGroupUser" forKey:@"function"];
    [param setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"] forKey:@"sessionId"];
    [param setObject:curGroup.dataId forKey:@"groupId"];
    WSCallerBlock *getUser = [[WSCallerBlock alloc] init];
    [getUser callPost:[Config getPath] params:param delegate:self usingBlock:^(NSData *data) {
        [SVProgressHUD dismiss];
        if (data) {
            users = [[NSMutableArray alloc] init];
            NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            dataStr = [dataStr substringWithRange:NSMakeRange(16, [dataStr length] - 17)];
            NSXMLParser *xmlPaser = [[NSXMLParser alloc] initWithData:[dataStr dataUsingEncoding:NSUTF8StringEncoding]];
            [xmlPaser setDelegate:self];
            [xmlPaser parse];
            [table reloadData];
        }
    }];
}
//获得节点头
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:@"user"]) {
        curElementName = elementName;
        UserData *user = [[UserData alloc] init];
        user.userId = [attributeDict objectForKey:@"id"];
        user.nickname = [attributeDict objectForKey:@"nickname"];
        user.groupUserType = [attributeDict objectForKey:@"groupUserType"];
        user.idiograph = [attributeDict objectForKey:@"idiograph"];
        user.faceIndex = [attributeDict objectForKeyedSubscript:@"faceIndex"];
        NSString *myUserId = [UserDataManage getSelfUser].userId;
        if ([myUserId isEqualToString:user.userId] && [user.groupUserType isEqualToString:@"1"]) {
            canOP = YES;
        }
        [users addObject:user];
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
    int tag = indexPath.row;
    UserData *user = [users objectAtIndex:tag];
    NSMutableDictionary *loginData = [SystemConfig getLassLoginData];
    WebViewController *wvc = [[WebViewController alloc] init];
    wvc.hideNavWhenBack = YES;
    [wvc initData:user.nickname url:[NSString stringWithFormat:@"%@/ClientPage/userinfo_phone.html?sessionId=%@&userId=%@&loginId=%@",[Config getProjectPath], [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"], user.userId, [loginData objectForKey:@"loginId"]]];
    [self.navigationController pushViewController:wvc animated:YES];
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
//提交删除成员
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!canOP) {
        [SVProgressHUD showErrorWithStatus:@"您没有权限使用该功能" duration:2];
        return;
    }
    UserData *userData = [users objectAtIndex:indexPath.row];
    //群主不可以删除
    if ([userData.groupUserType isEqualToString:@"1"]) {
        [SVProgressHUD showErrorWithStatus:@"群主不可以被删除" duration:2];
        return;
    }
    ChatUserStruct *curGroup = [ChatListDataStruct getCurrentChatUserId];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"] forKey:@"sessionId"];
    [param setObject:@"group.user.set" forKey:@"function"];
    [param setObject:curGroup.dataId forKey:@"groupId"];
    [param setObject:userData.userId forKey:@"delUserId"];
    WSCallerBlock *saveUserCall = [[WSCallerBlock alloc] init];
    [SVProgressHUD showWithStatus:@"删除中..."];
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
                NSString *error = @"删除成员失败";
                for (NSTextCheckingResult *match in arrayRange2) {
                    error = [dataStr substringWithRange:[match rangeAtIndex:1]];
                }
                [SVProgressHUD showErrorWithStatus:error duration:3];
                return;
            }
            NSMutableArray *userIdsArray = [[NSMutableArray alloc] init];
            for (UserData *groupUserData in users)  {
                [userIdsArray addObject:groupUserData.userId];
            }
            CIMSocketLogicExt *cimSocket = [CimGlobal getClass:@"CIMSocketLogicExt"];
            [cimSocket sendMessageToUsers:[NSString stringWithFormat:@"%@,0", userData.userId] usersId:userIdsArray messageType:1010 groupId:curGroup.dataId remark:[NSString stringWithFormat:@"%@,%@", [userData getUserName], [[UserDataManage getSelfUser] getUserName]]];
           
            [SVProgressHUD showSuccessWithStatus:@"删除成员成功"];
            [self getGroupUsers];
        }
    }];
}
//编辑群用户按钮事件
- (void)editUserClick:(id)sender {
    if (!canOP) {
        [SVProgressHUD showErrorWithStatus:@"您没有权限使用该功能" duration:2];
        return;
    }
    if (table.isEditing) {
        [table setEditing:NO animated:YES];
    } else {
        [table setEditing:YES animated:YES];
    }
}
//添加群用户按钮事件
- (void)addUserClick:(id)sender {
    if (!canOP) {
        [SVProgressHUD showErrorWithStatus:@"您没有权限使用该功能" duration:2];
        return;
    }
    GroupAddMemberViewController *gvc = [[GroupAddMemberViewController alloc] init];
    [gvc setGroupUsers:users];
    [self.navigationController pushViewController:gvc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
