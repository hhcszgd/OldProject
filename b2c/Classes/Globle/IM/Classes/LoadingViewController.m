//
//  LoadingViewController.m
//  IOSCim
//
//  Created by fei lan on 14-10-15.
//  Copyright (c) 2014年 CIMForIOS. All rights reserved.
//

#import "LoadingViewController.h"
#import "Language.h"
#import "LoginController.h"
#import "LoginManage.h"
#import "Config.h"
#import "UINavigationDelegate.h"
#import "UITabBarDelegate.h"
#import "UserChatViewController.h"
#import "MyNotificationCenter.h"
#import "ClearLoginerData.h"
#import "ClearLoginerData.h"
#import "CIMShopListDataStruct.h"
#import "CIMFriendListDataStruct.h"
#import "CIMGuestListDataStruct.h"
#import "CimGlobal.h"
#import "CIMGuestUserTreeViewController.h"
#import "OPChatLogData.h"
#import "CIMSocketLogicExt.h"
#import "SystemVariable.h"
#import "Tool.h"
#import "SVProgressHUD.h"
#import "WSCallerBlock.h"
#import "Config.h"
#import "LoginViewController.h"

@interface LoadingViewController ()

@end

@implementation LoadingViewController
@synthesize userLoginId, userPassword;

- (void)viewWillAppear:(BOOL)animated
{
    [SVProgressHUD showWithStatus:@"登陆中..."];
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [SVProgressHUD dismiss];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    //背景图
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:[Tool screenRect]];
    backgroundView.image = [UIImage imageNamed:@"appBG"];
    [self.view addSubview:backgroundView];
    
    [super viewDidLoad];
    
    //初始化数据库
    OPChatLogData *opChatlogData = [OPChatLogData alloc];
    [opChatlogData init:userLoginId];
    [CimGlobal addClass:opChatlogData name:@"OPChatLogData"];
    
    //初始化企业列表数据结构
    CIMShopListDataStruct *cimShopListDataStruct = [[CIMShopListDataStruct alloc] init];
    [CimGlobal addClass:cimShopListDataStruct name:@"CIMShopListDataStruct"];
    
    //初始化好友列表数据结构
    CIMFriendListDataStruct *cimFriendListDataStruct = [[CIMFriendListDataStruct alloc] init];
    [CimGlobal addClass:cimFriendListDataStruct name:@"CIMFriendListDataStruct"];
    
    //初始化访客列表数据结构
    CIMGuestListDataStruct *cimGuestListDataStruct = [[CIMGuestListDataStruct alloc] init];
    [CimGlobal addClass:cimGuestListDataStruct name:@"CIMGuestListDataStruct"];
    
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"loadingbg.jpg"]];
    UINavigationDelegate *navDelegate = [UINavigationDelegate alloc];
    UITabBarDelegate *tabBarDelegate = [UITabBarDelegate alloc];
    
    
    [exitLoading setTitle:@"取消"
                 forState:UIControlStateNormal];
    
    tabBarCont = [[UITabBarController alloc] init];
    tabBarCont.delegate = tabBarDelegate;
    [CimGlobal addClass:tabBarCont name:@"UITabBarController"];
    
    cimFriendUserTreeViewController = [CIMFriendUserTreeViewController alloc];
    cimFriendUserTreeViewController.title = @"联系人";
    cimFriendUserTreeViewController.tabBarItem = [[UITabBarItem alloc]
                                                  initWithTitle:@"联系人"
                                                  image:[UIImage imageNamed:@"tabContacts"]
                                                  tag:0];
    [chatTreeViewCont.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tabContacts"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabContacts"]];
    
    
    UINavigationController *friendNav = [[UINavigationController alloc] init];
    friendNav.delegate = navDelegate;
    
    chatTreeViewCont = [ChatTreesViewController alloc];
    chatTreeViewCont.title = @"会话";
    chatTreeViewCont.tabBarItem = [[UITabBarItem alloc]
                                   initWithTitle: @"会话"
                                   image:[UIImage imageNamed:@"tabMail"]
                                   tag:0];
    [chatTreeViewCont.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tabMail"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabMail"]];
    
    //消息提示
    UINavigationController *chatNav = [[UINavigationController alloc] init];
    chatNav.delegate = navDelegate;
    
    
    cimShopUserTreeViewController = [CIMShopUserTreeViewController alloc];
    cimShopUserTreeViewController.title = @"团队";
    cimShopUserTreeViewController.tabBarItem = [[UITabBarItem alloc]
                                                initWithTitle: @"团队"
                                                image:[UIImage imageNamed:@"HOME_32x32-32.png"]
                                                tag:0];
    
    
    UINavigationController *shopNav = [[UINavigationController alloc] init];
    shopNav.delegate = navDelegate;
    
    CIMGuestUserTreeViewController *cimGuestUserTreeViewController = [CIMGuestUserTreeViewController alloc];
    cimGuestUserTreeViewController.title = @"访客";
    cimGuestUserTreeViewController.tabBarItem = [[UITabBarItem alloc]
                                                 initWithTitle: @"访客"
                                                 image:[UIImage imageNamed:@"SECUNIA PS_32x32-32.png"]
                                                 tag:0];
    
    UINavigationController *guestNav = [[UINavigationController alloc] init];
    guestNav.delegate = navDelegate;
    
    
    groupTreeViewCont = [GroupTreeViewController alloc];
    groupTreeViewCont.title = [Language getLanguage:@"tabBar_groupButton"];
    groupTreeViewCont.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"群"
                                                                 image:[UIImage imageNamed:@"MESSENGER - MSN_32x32-32.png"]
                                                                   tag:0];
    UINavigationController *groupNav = [[UINavigationController alloc] init];
    groupNav.delegate = navDelegate;
    
    
    setting = [SettingController alloc];
    setting.title = @"系统设置";
    setting.tabBarItem = [[UITabBarItem alloc]
                          initWithTitle: @"系统设置"
                          //image:[UIImage imageNamed:@"MESSENGER - MSN_32x32-32.png"]
                          image:[UIImage imageNamed:@"TOOLS_32x32-32.png"]
                          tag:0];
    
    UINavigationController *settingNav = [[UINavigationController alloc] init];
    settingNav.delegate = navDelegate;
    
    //	navCont = [[UINavigationController alloc] init];
    //	navCont.delegate = navDelegate;
    //	[navCont setNavigationBarHidden:YES];
    
    [chatNav pushViewController:chatTreeViewCont animated:NO];
    [shopNav pushViewController:cimShopUserTreeViewController animated:NO];
    [friendNav pushViewController:cimFriendUserTreeViewController animated:NO];
    [guestNav pushViewController:cimGuestUserTreeViewController animated:NO];
    [settingNav pushViewController:setting animated:NO];
    [groupNav pushViewController:groupTreeViewCont animated:NO];
    
    tabBarCont.viewControllers = [NSArray arrayWithObjects:chatNav, friendNav, settingNav, nil];
    
    UserChatViewController *userChatCont = [UserChatViewController alloc];
    //[navCont pushViewController:groupTreeViewCont animated:NO];
    
    
    //在通知中心注册 登录完了通知自己
    [MyNotificationCenter addObserver:self
                             selector:@selector(gotoUsersWindow:)
                                 name:SocketDidLogin
                           obServerId:@"LoadingController_gotoUsersWindow"];
    
    //在通知中心注册 需要消息提示未读消息的数量
    [MyNotificationCenter addObserver:chatTreeViewCont
                             selector:@selector(addMessageTips:)
                                 name:SockeTypeTipsMessage
                           obServerId:@"ChatTreeViewController_addMessageTips"];
    
    //在通知中心注册 更新会话列表
    [MyNotificationCenter addObserver:chatTreeViewCont
                             selector:@selector(updateChatListUser:)
                                 name:SystemEventUpdateChatListData
                           obServerId:@"ChatTreeViewController_updateChatListUser"];
    
    //在通知中心注册 清除消息提醒
    [MyNotificationCenter addObserver:chatTreeViewCont
                             selector:@selector(clearMessageTips:)
                                 name:SystemEventClearMessageTips
                           obServerId:@"ChatTreeViewController_clearMessageTips"];
    
    
    //在通知中心注册 需要消息接收时通知聊天面板 窗口加载后需要重新注册
    [MyNotificationCenter addObserver:userChatCont
                             selector:@selector(updateChatMessage:)
                                 name:SocketRecvMessage
                           obServerId:@"UserChatViewController_updateChatMessage"];
    
    
    //在通知中心注册 状态变化时更新企业视图
    [MyNotificationCenter addObserver:cimShopUserTreeViewController
                             selector:@selector(updateUserStatus:)
                                 name:SocketUpdateStatus
                           obServerId:@"cimShopUserTreeViewController_updateChatMessage"];
    
    
    //在通知中心注册 收到消息时通知聊天窗口
    [MyNotificationCenter addObserver:cimFriendUserTreeViewController
                             selector:@selector(updateUserStatus:)
                                 name:SocketUpdateStatus
                           obServerId:@"cimFriendUserTreeViewController_updateUserStatus"];
    
    
    //在通知中心注册 挤下线的时候执行此操作
    [MyNotificationCenter addObserver:self
                             selector:@selector(exitLoading:)
                                 name:SystemEventCrowdedOffline
                           obServerId:@"LoadingController_exitLoading"];
    
    
    [Config agreeCallHttpHander];
    LoginManage *http = [LoginManage alloc];
    [http init:self.userLoginId password:self.userPassword];
    tabBarCont.tabBar.tintColor = [Tool colorWithHexString:@"FFFFFF"];
    tabBarCont.tabBar.selectedImageTintColor = [Tool colorWithHexString:@"FFFFFF"];
    [self setTabBarBackgroundColor];
}



- (void)gotoUsersWindow:(NSString *)code
{
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(toShopUserWindow:)
                                   userInfo:nil
                                    repeats:NO];
}



//转到用户列表窗口
- (void)toShopUserWindow:(id)sender
{
    for (UIViewController *viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[UITabBarController class]]) {
            return;
        }
    }
    //防止重复添加试图控制器到导航控件中
    if ([self.navigationController.topViewController isMemberOfClass:[UITabBarController class]]) {
        return;
    }
    //连接服务器查询头像
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:[userDefault objectForKey:@"sessionId"] forKey:@"sessionId"];
    [param setObject:[userDefault objectForKey:@"userId"] forKey:@"userId"];
    WSCallerBlock *getHeadImg = [[WSCallerBlock alloc] init];
    [getHeadImg callPost:[NSString stringWithFormat:@"%@/service/GetUserHeadImg", [Config getProjectPath]] params:param delegate:self usingBlock:^(NSData *data) {
        if (data) {
            UIImage *headImg = [UIImage imageWithData:data];
            //有头像时 保存到本地
            if (headImg) {
                NSString *imgageName = [NSString stringWithFormat:@"%@%@", [userDefault objectForKey:@"userId"], @"Avatar.png"];
                NSString *fullPath = [Tool getImagePath:imgageName];
                NSData *imageData = UIImageJPEGRepresentation(headImg, 1.0);
                [imageData writeToFile:fullPath atomically:NO];
            }
        }
    }];
    [self.navigationController pushViewController:tabBarCont animated:YES];
}



//取消登录 终止加载
- (void)exitLoading:(id)sender {
    [Config canelCallHttpHander];
    [ClearLoginerData clear];
    [self.navigationController setNavigationBarHidden:YES];
    //延迟执行
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(exitLoadingAfter:) userInfo:nil repeats:NO];
}
- (void)exitLoadingAfter:(id)info {
    NSArray *viewControllers = self.navigationController.viewControllers;
    for (UIViewController *viewControllerOne in viewControllers) {
        if ([viewControllerOne isKindOfClass:[LoginViewController class]]) {
            [self.navigationController popToViewController:viewControllerOne animated:YES];
            return;
        }
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}
//设置ios7以下的tabbar的背景色
- (void)setTabBarBackgroundColor {
    [[UITabBarItem appearance] setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor whiteColor] } forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor whiteColor] } forState:UIControlStateHighlighted];
    tabBarCont.tabBar.selectionIndicatorImage = [UIImage imageNamed:@"system_tabbar_item_selected.png"];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent animated:YES];
    [tabBarCont.tabBar setBackgroundImage:[UIImage imageNamed:@"tab_bar_background.png"]];
    //tabBarCont.tabBar.alpha = 0.3;
    if (IS_GTE_IOS7) {
    } else {
        CGRect tabBarRect = tabBarCont.tabBar.frame;
        tabBarRect.origin.x = 0;
        tabBarRect.origin.y = 0;
        //当bgNavigationBar的背景色不是黑色的时候 会在视图中间生成一条灰色的线,高度+1可让其消失,出现原因不明
        tabBarRect.size.height += 1;
        UINavigationBar *bgNavigationBar = [[UINavigationBar alloc] initWithFrame:tabBarRect];
        [tabBarCont.tabBar insertSubview:bgNavigationBar atIndex:[[[UIDevice currentDevice] systemVersion] floatValue] < 5 ? 0 : 1];
        //在tabBar顶层设置高亮选择时的文字颜色, 直接对当前tabBar设置无效
        [[UITabBarItem appearance] setTitleTextAttributes:@{ UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextColor: [Tool colorWithHexString:@"#FFFFFF"] } forState:UIControlStateSelected];
    }
}

@end
