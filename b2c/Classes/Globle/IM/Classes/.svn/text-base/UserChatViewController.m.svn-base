//
//  UserChatViewController.m
//  IOSCim
//
//  Created by fei lan on 14-9-26.
//  Copyright (c) 2014年 CIMForIOS. All rights reserved.
//

#import "UserChatViewController.h"
#import "Config.h"
#import "ChatLogCell.h"
#import "IOSCimAppDelegate.h"
#import "UserChatData.h"
#import "ChatListDataStruct.h"
#import "UserDataManage.h"
#import "GroupDataManage.h"
#import "Director.h"
#import "MyNotificationCenter.h"
#import "Director.h"
#import "ChatWebLog.h"
#import "UserChatLog.h"
#import "OPChatLogData.h"
#import "ChatUserStruct.h"
#import "RegexKitLite.h"
#import "SystemAttributes.h"
#import "CimGlobal.h"
#import "CIMSocketLogicExt.h"
#import "CIMChatFacePanel.h"
#import "CIMShowImage.h"
#import "SystemVariable.h"
#import "Tool.h"
#import "SVProgressHUD.h"
#import "HttpUpFile.h"
#import "GroupManageViewController.h"
#import "AsynImageView.h"
#import "Base64.h"

#define toolBarS 5
#define toolBarHeight 50
#define toolBarSize (toolBarHeight - 2 * toolBarS)
#define menuButtonSize 45

@interface UserChatViewController ()

@end

@implementation UserChatViewController
@synthesize chatUserId, inputBar, chatTitle;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    
    //在通知中心注册 需要消息接收时通知聊天面板 窗口加载后需要重新注册
    [MyNotificationCenter addObserver:self
                             selector:@selector(updateChatMessage:)
                                 name:SocketRecvMessage
                           obServerId:@"UserChatViewController_updateChatMessage"];
    
    isShowBackButton = YES;
    //状态栏高度
    statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    //导航栏高度
    navigationBarHeight = self.navigationController.navigationBar.bounds.size.height;
    
    //背景图
    CGRect backgroundViewRect = [Tool screenRect];
    if (IS_GTE_IOS7) {
        backgroundViewRect.origin.y -= (statusBarHeight + navigationBarHeight);
    }
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:backgroundViewRect];
    backgroundView.image = [UIImage imageNamed:@"appBG"];
    [self.view addSubview:backgroundView];
    
    if ([windowChatType isEqualToString:@"group"]) {
        if (chatTitle) {
            title = chatTitle;
        } else {
            title = @"群对话";
        }
        //管理群按钮
        UIButton *manageGrouButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
        [manageGrouButton setBackgroundImage:[UIImage imageNamed:@"icon_set"] forState:UIControlStateNormal];
        [manageGrouButton setBackgroundImage:[UIImage imageNamed:@"icon_set"] forState:UIControlStateHighlighted];
        [manageGrouButton addTarget:self action:@selector(manageGroupClick:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:manageGrouButton];
        self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    } else {
        if (chatTitle) {
            title = chatTitle;
        } else {
            title = @"对话";
        }
    }
    
    //全屏大小
    mainRect = [Tool screenRect];
    
    //聊天窗口
    CGRect webRect;
    if (IS_GTE_IOS7) {
        webRect = CGRectMake(0, 0, mainRect.size.width, mainRect.size.height - (statusBarHeight + navigationBarHeight + toolBarHeight));
    } else {
        webRect = CGRectMake(0, navigationBarHeight, mainRect.size.width, mainRect.size.height - (statusBarHeight + navigationBarHeight + toolBarHeight));
    }
    messageWebView = [[UIWebView alloc] initWithFrame:webRect];
    messageWebView.delegate = self;
    [self.view addSubview:messageWebView];
    
    BGButton = [[UIButton alloc] initWithFrame:messageWebView.frame];
    [BGButton addTarget:self action:@selector(backgroundClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:BGButton];
    
    //底部边栏
    if (IS_GTE_IOS7) {
        toolbar = [[TranslucentToolbar alloc] initWithFrame:CGRectMake(0, messageWebView.frame.origin.y + messageWebView.frame.size.height, mainRect.size.width, toolBarHeight)];
    } else {
        toolbar = [[TranslucentToolbar alloc] initWithFrame:CGRectMake(0, messageWebView.frame.origin.y + messageWebView.frame.size.height, mainRect.size.width, toolBarHeight)];
    }
    //话筒按钮
    chatLogButton = [[UIButton alloc] initWithFrame:CGRectMake(0, toolBarS, toolBarSize, toolBarSize)];
    [chatLogButton setBackgroundImage:[UIImage imageNamed:@"macIcon"] forState:UIControlStateNormal];
    [chatLogButton setBackgroundImage:[UIImage imageNamed:@"macIcon"] forState:UIControlStateHighlighted];
    [chatLogButton addTarget:self action:@selector(showMenuView:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *chatLogBarButton = [[UIBarButtonItem alloc] initWithCustomView:chatLogButton];
    
    //输入框
    inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, toolBarS, mainRect.size.width - 2 * toolBarHeight - 4 * toolBarS, toolBarSize)];
    inputTextField.layer.cornerRadius = 4;
    inputTextField.layer.masksToBounds = YES;
    inputTextField.delegate = self;
    inputTextField.backgroundColor = [UIColor whiteColor];
    inputTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    inputTextField.returnKeyType = UIReturnKeySend;
    UIBarButtonItem *inputTextFieldBarButton = [[UIBarButtonItem alloc] initWithCustomView:inputTextField];
    
    //键盘按钮
    chooseFaceButton = [[UIButton alloc] initWithFrame:CGRectMake(0, toolBarS, toolBarSize, toolBarSize)];
    [chooseFaceButton setBackgroundImage:[UIImage imageNamed:@"keyIcon"] forState:UIControlStateNormal];
    [chooseFaceButton setBackgroundImage:[UIImage imageNamed:@"keyIcon"] forState:UIControlStateHighlighted];
    [chooseFaceButton addTarget:self action:@selector(showChooseFacePanel:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *chooseFaceBarButton = [[UIBarButtonItem alloc] initWithCustomView:chooseFaceButton];
    
    toolbar.items = [[NSArray alloc] initWithObjects:chatLogBarButton, inputTextFieldBarButton, chooseFaceBarButton, nil];
    [self.view addSubview:toolbar];
    
    [super viewDidLoad];
    
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ChatWindowBG.png"]];
    [self initLoad];
    
    /*if (closeButton == nil) {
        closeButton = [[UIBarButtonItem alloc]
                       initWithTitle: @"关闭"
                       style: UIBarButtonItemStyleBordered
                       target: self
                       action: @selector(closeChatWindow:)];
    }
    
    self.navigationItem.rightBarButtonItem = closeButton;*/
    
    /*if ([windowChatType isEqualToString:@"user"]) {
        self.title = [[UserDataManage getUser:chatUserId] getUserName];
    } else {
        self.title = [GroupDataManage getGroup:chatUserId].groupName;
    }*/
    
    
    [self.navigationController setNavigationBarHidden:NO];
    userChatLog = [[NSMutableArray alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [MyNotificationCenter recoveObserver: self
                                selector: @selector(updateChatMessage:)
                              obServerId: @"UserChatController_updateChatMessage"];
    
    
    [MyNotificationCenter addObserver: self
                             selector: @selector(inputFaceMessage:)
                                 name: SystemEventChooseFace
                           obServerId: @"UserChatController_inputFaceMessage"];
    
    
    [MyNotificationCenter addObserver: self
                             selector: @selector(updateImageMessage:)
                                 name: SocketRecvImageMessage
                           obServerId: @"UserChatController_updateImageMessage"];
    
    
    
    //表情
    //inputTextField.text = [NSString stringWithFormat:@"%C", 0xe001];
    //inputTextField.text = [NSString stringWithFormat:@"\ue057"];
    //表情滚动窗
    facePanelTableView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, mainRect.size.height, mainRect.size.width, 305)];
    //半透明背景
    faceBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainRect.size.width, 305)];
    faceBackView.backgroundColor = [UIColor whiteColor];
    faceBackView.layer.opacity = 0.3;
    [facePanelTableView addSubview:faceBackView];
    [self.view addSubview:facePanelTableView];
    
    cimSocketLogicExt = [CimGlobal getClass:@"CIMSocketLogicExt"];
    [self init:facePanelTableView];
    
    //菜单
    [self createMenuView];
    
    //读取web内容
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ChatDataPanel" ofType:@"html"];
    [messageWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
    messageWebView.backgroundColor = [Tool colorWithHexString:@"dbe2ed"];
    messageWebView.opaque = NO;
    messageWebViewWithUserId = @"";
}
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];
    isActive = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
    [super viewWillDisappear:animated];
    isActive = NO;
}
//菜单
- (void)createMenuView {
    //界面
    menuView = [[UIView alloc] initWithFrame:CGRectMake(0, mainRect.size.height, mainRect.size.width, 205)];
    menuView.backgroundColor = [UIColor clearColor];
    
    //半透明背景
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainRect.size.width, menuView.frame.size.height - 53)];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.opacity = 0.3;
    [menuView addSubview:backView];
    //间距
    CGFloat sWidth = (mainRect.size.width - 3 * menuButtonSize) / 4;
    //图片
    UIButton *picButton = [[UIButton alloc] initWithFrame:CGRectMake(sWidth, 10, menuButtonSize, menuButtonSize)];
    [picButton setBackgroundImage:[UIImage imageNamed:@"menuPicIcon"] forState:UIControlStateNormal];
    [picButton setBackgroundImage:[UIImage imageNamed:@"menuPicIcon"] forState:UIControlStateHighlighted];
    [picButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [menuView addSubview:picButton];
    //图片文字
    [menuView addSubview:[self createLabel:@"图片" rect:CGRectMake(sWidth - 10, 10 + menuButtonSize, menuButtonSize + 20, 20)]];
    
    //拍照
    UIButton *cameraButton = [[UIButton alloc] initWithFrame:CGRectMake(2 * sWidth + menuButtonSize, 10, menuButtonSize, menuButtonSize)];
    [cameraButton setBackgroundImage:[UIImage imageNamed:@"menuCameraIcon"] forState:UIControlStateNormal];
    [cameraButton setBackgroundImage:[UIImage imageNamed:@"menuCameraIcon"] forState:UIControlStateHighlighted];
    [cameraButton addTarget:self action:@selector(cameraButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [menuView addSubview:cameraButton];
    //拍照文字
    [menuView addSubview:[self createLabel:@"拍照" rect:CGRectMake(2 * sWidth + menuButtonSize - 10, 10 + menuButtonSize, menuButtonSize + 20, 20)]];
    
    //视频
    /*UIButton *videoButton = [[UIButton alloc] initWithFrame:CGRectMake(3 * sWidth + 2 * menuButtonSize, 10, menuButtonSize, menuButtonSize)];
    [videoButton setBackgroundImage:[UIImage imageNamed:@"menuVideoIcon"] forState:UIControlStateNormal];
    [videoButton setBackgroundImage:[UIImage imageNamed:@"menuVideoIcon"] forState:UIControlStateHighlighted];
    [menuView addSubview:videoButton];
    //视频文字
    [menuView addSubview:[self createLabel:@"视频" rect:CGRectMake(3 * sWidth + 2 * menuButtonSize - 10, 10 + menuButtonSize, menuButtonSize + 20, 20)]];
    
    //语音通话
    UIButton *macButton = [[UIButton alloc] initWithFrame:CGRectMake(sWidth, 10 + menuButtonSize + 25, menuButtonSize, menuButtonSize)];
    [macButton setBackgroundImage:[UIImage imageNamed:@"menuMacIcon"] forState:UIControlStateNormal];
    [macButton setBackgroundImage:[UIImage imageNamed:@"menuMacIcon"] forState:UIControlStateHighlighted];
    [menuView addSubview:macButton];
    //语音通话文字
    [menuView addSubview:[self createLabel:@"语音通话" rect:CGRectMake(sWidth - 10, 10 + 2 * menuButtonSize + 25, menuButtonSize + 20, 20)]];*/
    
    //聊天记录
    UIButton *logButton = [[UIButton alloc] initWithFrame:CGRectMake(3 * sWidth + 2 * menuButtonSize, 10, menuButtonSize, menuButtonSize)];
    [logButton setBackgroundImage:[UIImage imageNamed:@"menuLogIcon"] forState:UIControlStateNormal];
    [logButton setBackgroundImage:[UIImage imageNamed:@"menuLogIcon"] forState:UIControlStateHighlighted];
    [logButton addTarget:self action:@selector(viewChatLog:) forControlEvents:UIControlEventTouchUpInside];
    [menuView addSubview:logButton];
    //聊天记录文字
    [menuView addSubview:[self createLabel:@"聊天记录" rect:CGRectMake(3 * sWidth + 2 * menuButtonSize - 10, 10 + menuButtonSize, menuButtonSize + 20, 20)]];
    
    //发送按钮
    UIButton *sendButton = [[UIButton alloc] initWithFrame:CGRectMake(0, backView.frame.size.height, mainRect.size.width, 53)];
    [sendButton setBackgroundImage:[UIImage imageNamed:@"menuSendIconBG.png"] forState:UIControlStateNormal];
    [sendButton setBackgroundImage:[UIImage imageNamed:@"menuSendIconBG.png"] forState:UIControlStateHighlighted];
    [menuView addSubview:sendButton];
    UIImageView *sendImg = [[UIImageView alloc] initWithFrame:CGRectMake((mainRect.size.width - 30) / 2,backView.frame.size.height + (53 - 30) / 2, 30, 30)];
    sendImg.image = [UIImage imageNamed:@"menuSendIcon"];
    [menuView addSubview:sendImg];
    [self.view addSubview:menuView];
}
//创建label
- (UILabel *)createLabel:(NSString *)text rect:(CGRect)rect {
    UILabel *labelOne = [[UILabel alloc] initWithFrame:rect];
    labelOne.text = text;
    labelOne.textAlignment = NSTextAlignmentCenter;
    labelOne.textColor = [Tool colorWithHexString:@"386b88"];
    labelOne.font = [UIFont systemFontOfSize:12];
    labelOne.backgroundColor = [UIColor clearColor];
    return labelOne;
}
- (void)init:(UIScrollView*)view {
    view.scrollEnabled = YES;
    NSInteger faceCount = [Config getFaceCount];
    int cellIndex = 0;
    int rowIndex = 0;
    int buttonSize = 45;
    
    for (int i=0; i<faceCount; i++) {
        if (cellIndex == 7) {
            rowIndex++;
            cellIndex = 0;
        }
        UIButton *faceButton = [[UIButton alloc] initWithFrame:CGRectMake(cellIndex*buttonSize, rowIndex*buttonSize, buttonSize, buttonSize)];
        NSString *faceImageName = [NSString stringWithFormat:@"f%d.gif", i];
        [faceButton setTag:i];
        [faceButton setImage:[UIImage imageNamed:faceImageName] forState:UIControlStateNormal];
        [faceButton addTarget:self action:@selector(clickFaceButton:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:faceButton];
        cellIndex++;
    }
    view.contentSize = CGSizeMake(view.frame.size.width, (rowIndex + 3)*buttonSize);
    CGRect faceBackViewRect = faceBackView.frame;
    faceBackViewRect.size.height = view.contentSize.height;
    faceBackView.frame = faceBackViewRect;
}
//管理群按钮
- (void)manageGroupClick:(id)sender {
    GroupManageViewController *gvc = [[GroupManageViewController alloc] init];
    [self.navigationController pushViewController:gvc animated:YES];
}
- (void)clickFaceButton:(UIButton *)faceButt {
    NSString *faceIndex = [NSString stringWithFormat:@"%d", faceButt.tag];
    [self inputFaceMessage:faceIndex];
}

//设置当前用户
- (void)setConcantUser:(ChatUserStruct*)chatUser
{
    chatUserId = chatUser.dataId;
    [ChatListDataStruct setCurrentChatUserId:chatUser];
    windowChatType = chatUser.chatType;
    //清除未读记录
    [ChatListDataStruct clearTipsNumbers:chatUser];
    //[MyNotificationCenter postNotification:SystemEventUpdateChatListData setParam:chatUser];
}




//关闭聊天窗口
- (void)closeChatWindow:(id)sender
{
    ChatUserStruct *currentUser = [ChatListDataStruct getCurrentChatUserId];
    
    if ([windowChatType isEqualToString:@"user"])
    {
        [[UserDataManage getUser:currentUser.dataId] clearMessage];
    }
    else if ([windowChatType isEqualToString:@"group"])
    {
        [[GroupDataManage getGroup:currentUser.dataId] clearMessage];
    }
    
    [ChatListDataStruct removeChatUser:currentUser];
    [self.navigationController popViewControllerAnimated:YES];
}

//更新聊天信息
- (void)updateChatMessage:(ChatUserStruct*)chatUser
{
    ChatUserStruct *currentUser = [ChatListDataStruct getCurrentChatUserId];
    
    //来自当前窗口的消息 直接显示
    if (self.isViewLoaded && isActive && currentUser != nil)
    {
        //消息来自当前窗口
        if (chatUser == nil || [[currentUser getMark] isEqualToString:[chatUser getMark]])
        {
            //清除未读消息数量
            [ChatListDataStruct clearTipsNumbers:currentUser];
            [MyNotificationCenter postNotification:SystemEventUpdateChatListData setParam:chatUser];
            [self showChatMessage];
            return;
        }
    }
    
    //来自非当前窗口的消息 或聊天窗口非当前窗口 做消息提示
    if (chatUser != nil)
    {
        //添加会话联系人
        [ChatListDataStruct addChatUser:chatUser];
        //未读提醒
        [MyNotificationCenter postNotification:SystemEventUpdateChatListData setParam:chatUser];
    }
}


//////////////////////////键盘部分//////////////////////////


//输入表情
- (void)inputFaceMessage:(NSString*)faceIndex
{
    inputTextField.text = [inputTextField.text stringByAppendingFormat:@"(:%@:)", faceIndex];
    [self showChooseFacePanel:nil];
}




//显示表情面板
- (IBAction)showChooseFacePanel:(id)sender
{
    BGButton.hidden = NO;
    menuView.hidden = YES;
    
    if (!facePanelTableView.hidden)
    {
        facePanelTableView.hidden = YES;
        [inputTextField becomeFirstResponder];
        return;
    }
    
    [inputTextField resignFirstResponder];
    NSTimeInterval aniamtionDuration = 0.30;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:aniamtionDuration];
    float height = self.view.frame.size.height;
    float tableWidth = facePanelTableView.frame.size.width;
    float tableHeight = facePanelTableView.frame.size.height;
    float toolbarWidth = toolbar.frame.size.width;
    float toolbarHeight = toolbar.frame.size.height;
    float webViewHeight = messageWebView.frame.size.height;
    
    if (webViewHeight > 0.0f)
    {
        CGRect tableRect = CGRectMake(0.0f, messageWebView.frame.origin.y, messageWebView.frame.size.width, height - keyBoardHeight - toolbarHeight - messageWebView.frame.origin.y);
        messageWebView.frame = tableRect;
    }
    
    CGRect tableRect = CGRectMake(0.0f, height - keyBoardHeight, tableWidth, tableHeight);
    facePanelTableView.frame = tableRect;
    toolbar.frame = CGRectMake(0.0f, height - keyBoardHeight - toolbarHeight, toolbarWidth, toolbarHeight);
    facePanelTableView.hidden = NO;
    [UIView commitAnimations];
}
//显示菜单面板
- (void)showMenuView:(id)sender {
    BGButton.hidden = NO;
    facePanelTableView.hidden = YES;
    
    if (!menuView.hidden) {
        menuView.hidden = YES;
        [inputTextField becomeFirstResponder];
        return;
    }
    
    [inputTextField resignFirstResponder];
    NSTimeInterval aniamtionDuration = 0.30;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:aniamtionDuration];
    float height = self.view.frame.size.height;
    float tableWidth = menuView.frame.size.width;
    float tableHeight = menuView.frame.size.height;
    float toolbarWidth = toolbar.frame.size.width;
    float toolbarHeight = toolbar.frame.size.height;
    float webViewHeight = messageWebView.frame.size.height;
    
    if (webViewHeight > 0.0f)
    {
        CGRect tableRect = CGRectMake(0.0f, messageWebView.frame.origin.y, messageWebView.frame.size.width, height - tableHeight - toolbarHeight - messageWebView.frame.origin.y);
        messageWebView.frame = tableRect;
    }
    
    CGRect tableRect = CGRectMake(0.0f, height - tableHeight, tableWidth, tableHeight);
    menuView.frame = tableRect;
    toolbar.frame = CGRectMake(0.0f, height - tableHeight - toolbarHeight, toolbarWidth, toolbarHeight);
    menuView.hidden = NO;
    [UIView commitAnimations];
}



//获取键盘高度
- (void)keyboardWillShow:(NSNotification *)notif
{
    NSDictionary *info = [notif userInfo];
    NSValue *aValue = [info objectForKey:@"UIKeyboardBoundsUserInfoKey"];
    CGSize keyboardSize = [aValue CGRectValue].size;
    keyBoardHeight = keyboardSize.height;
    [self textFieldDidBeginEditing:nil];
}



//展开键盘时 收缩界面
- (IBAction)textFieldDidBeginEditing:(id)sender
{
    NSTimeInterval aniamtionDuration = 0.30;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:aniamtionDuration];
    float height = self.view.frame.size.height;
    float webViewHeight = messageWebView.frame.size.height;
    float toolbarWidth = toolbar.frame.size.width;
    float toolbarHeight = toolbar.frame.size.height;
    
    if (webViewHeight > 0.0f)
    {
        CGRect tableRect = CGRectMake(0.0f, messageWebView.frame.origin.y, messageWebView.frame.size.width, height - keyBoardHeight - toolbarHeight - messageWebView.frame.origin.y);
        messageWebView.frame = tableRect;
    }
    
    toolbar.frame = CGRectMake(0.0f, height - keyBoardHeight - toolbarHeight, toolbarWidth, toolbarHeight);
    [UIView commitAnimations];
    BGButton.hidden = NO;
    
    [messageWebView stringByEvaluatingJavaScriptFromString:@"scrollToButtom()"];
}



//关闭键盘时 还原界面
- (IBAction)backgroundClick:(id)sender
{
    NSTimeInterval aniamtionDuration = 0.30;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:aniamtionDuration];
    float height = self.view.frame.size.height;
    float webViewHeight = messageWebView.frame.size.height;
    float toolbarWidth = toolbar.frame.size.width;
    float toolbarHeight = toolbar.frame.size.height;
    
    //聊天窗口
    
    if (webViewHeight > 0.0f) {
        CGRect webRect;
        if (IS_GTE_IOS7) {
            webRect = CGRectMake(0, 0, mainRect.size.width, mainRect.size.height - (statusBarHeight + navigationBarHeight + toolBarHeight));
        } else {
            webRect = CGRectMake(0, navigationBarHeight, mainRect.size.width, mainRect.size.height - (statusBarHeight + navigationBarHeight + toolBarHeight));
        }
        messageWebView.frame = webRect;
    }
    
    toolbar.frame = CGRectMake(0.0f, height - toolbarHeight, toolbarWidth, toolbarHeight);
    [UIView commitAnimations];
    
    [inputTextField resignFirstResponder];
    facePanelTableView.hidden = YES;
    menuView.hidden = YES;
    BGButton.hidden = YES;
    
    [messageWebView stringByEvaluatingJavaScriptFromString:@"scrollToButtom()"];
}



///////////////////////////////////发送消息部分/////////////////////////////////



//测试发送消息
- (void)sendMessageTest:(id)sender
{
    testMessage++;
    
    if (testMessage > 20)
    {
        return;
    }
    
    [cimSocketLogicExt sendMessageToUser:[NSString stringWithFormat:@"%d",testMessage] userId:chatUserId messageType:1 groupId:@"10"];
}




//发送聊天消息
- (IBAction)textFieldDoneEditing:(id)sender
{
    NSString *messageContent = inputTextField.text;
    NSString *toOtherClientContent = [[NSString alloc] initWithString:[messageContent copy]];
    
    if (![messageContent isEqualToString:@""])
    {
        messageContent = [messageContent stringByReplacingOccurrencesOfString:@"(:" withString:@"<img src=f"];
        messageContent = [messageContent stringByReplacingOccurrencesOfString:@":)" withString:@".gif >"];
        toOtherClientContent = [toOtherClientContent stringByReplacingOccurrencesOfString:@"(:" withString:@"<img src=\"{$SYS_IMAGE_PATH$}"];
        toOtherClientContent = [toOtherClientContent stringByReplacingOccurrencesOfString:@":)" withString:@".gif\" >"];
        
        UserChatData *chatData = [UserChatData alloc];
        chatData.userId = [UserDataManage getSelfUser].userId;
        chatData.userName = [[UserDataManage getSelfUser] getUserName];
        chatData.sendTime = [UserChatData getNow];
        chatData.content = messageContent;
        chatData.isSelf = YES;
        NSString *userId = [[UserDataManage getSelfUser] userId];
        //NSLog(@"发送给客户端的消息为%@", toOtherClientContent);
        
        if ([windowChatType isEqualToString:@"user"])
        {
            [[UserDataManage getUser:chatUserId] addMessage:chatData];
            [cimSocketLogicExt sendMessageToUser:toOtherClientContent userId:chatUserId messageType:1 groupId:@"0"];
            
            OPChatLogData *opChatlogData = [CimGlobal getClass:@"OPChatLogData"];
            
            //保存聊天记录
            [opChatlogData addMessageLog:userId
                            chatWitherId:chatUserId
                            sendObjectId:userId
                          messageContent:[chatData getContent]
                                sendTime:chatData.sendTime
                             messageType:1];
            
            ChatUserStruct *currentUser = [ChatListDataStruct getCurrentChatUserId];
            [ChatListDataStruct addChatNormalUser:currentUser];
            [MyNotificationCenter postNotification:SystemEventUpdateChatListData setParam:currentUser];
        }
        else
        {
            [cimSocketLogicExt sendGroupMessage:toOtherClientContent groupId:chatUserId];
            
            ChatUserStruct *currentUser = [ChatListDataStruct getCurrentChatUserId];
            [ChatListDataStruct addChatNormalUser:currentUser];
            [MyNotificationCenter postNotification:SystemEventUpdateChatListData setParam:currentUser];
        }
        
        [self showChatMessage];
        inputTextField.text = @"";
    }
}
// //3通过socket发送第儿条消息 //告诉服务器图片已经上传了 , 可以推送给对方了
- (void)sendImage:(NSString *)imagePath imageName:(NSString *)imageName fileId:(NSString *)fileId {
    NSString *messageContent = imagePath;
    NSString *toOtherClientContent = [[NSString alloc] initWithString:[messageContent copy]];
    if (![messageContent isEqualToString:@""]) {
        messageContent = [NSString stringWithFormat:@"<img name=\"{%@}\" onmousedown=\"javascript:callShowImage(this.src);\" hspace=1 vspace=1 src=\"%@\"/>", [Tool getMD5:imageName], messageContent];
        toOtherClientContent = [NSString stringWithFormat:@"%@,%@.jpg,{%@}", fileId, imageName, [Tool getMD5:imageName]];
        UserChatData *chatData = [UserChatData alloc];
        chatData.userId = [UserDataManage getSelfUser].userId;
        chatData.userName = [[UserDataManage getSelfUser] getUserName];
        chatData.sendTime = [UserChatData getNow];
        chatData.content = messageContent;
        chatData.isSelf = YES;
        NSString *userId = [[UserDataManage getSelfUser] userId];
        
        if ([windowChatType isEqualToString:@"user"])
        {
            [[UserDataManage getUser:chatUserId] addMessage:chatData];
            [cimSocketLogicExt sendMessageToUser:toOtherClientContent userId:chatUserId messageType:SocketRecvImage groupId:@"0"];
            
            OPChatLogData *opChatlogData = [CimGlobal getClass:@"OPChatLogData"];
            
            //保存聊天记录
            [opChatlogData addMessageLog:userId
                            chatWitherId:chatUserId
                            sendObjectId:userId
                          messageContent:[chatData getContent]
                                sendTime:chatData.sendTime
                             messageType:1];
            
            ChatUserStruct *currentUser = [ChatListDataStruct getCurrentChatUserId];
            [ChatListDataStruct addChatNormalUser:currentUser];
            [MyNotificationCenter postNotification:SystemEventUpdateChatListData setParam:currentUser];
        }
        else
        {
            [cimSocketLogicExt sendSystemGroupMessage:toOtherClientContent groupId:chatUserId messageType:[NSString stringWithFormat:@"%d",SocketRecvGroupImage]];
        }
        [self showChatMessage];
        inputTextField.text = @"";
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self textFieldDoneEditing:nil];
    return YES;
}
//显示用户图片
- (void)imageButtonClick:(id)sender {
    [self openSheet:UIImagePickerControllerSourceTypePhotoLibrary];
}
//显示相机
- (void)cameraButtonClick:(id)sender {
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [SVProgressHUD showErrorWithStatus:@"您的设备没有可用的摄像头"];
        return;
    }
    [self openSheet:UIImagePickerControllerSourceTypeCamera];
}
- (void)openSheet:(UIImagePickerControllerSourceType)sourceType {
    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
    origiRect = self.view.frame;
    [self presentViewController:imagePickerController animated:YES completion:^{}];
}
//上传头像
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        self.view.frame = origiRect;
        [self.navigationController setNavigationBarHidden:NO];
    }];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970] * 1000;
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    timeString = [timeString stringByReplacingOccurrencesOfString:@"." withString:@""];
    NSString *imgageName = [NSString stringWithFormat:@"%@%@",timeString,@".png"];
    NSString *fullPath = [Tool getImagePath:imgageName];
    [self saveImage:image withName:fullPath];
    [self uploadImgFile:fullPath image:image imageName:timeString];
}
#pragma mark - 保存图片至沙盒
- (void)saveImage:(UIImage *)currentImage withName:(NSString *)fullPath {
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    //将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    self.navigationController.navigationBar.frame = CGRectMake(0, 100, 320, 44);
    [self dismissViewControllerAnimated:YES completion:^{
        self.view.frame = origiRect;
        [self.navigationController setNavigationBarHidden:NO];
    }];
}
//上传图片
- (void)uploadImgFile:(NSString*)imgFullPath image:(UIImage *)image imageName:(NSString *)timeString {
    HttpUpFile *http = [[HttpUpFile alloc] init];
    [SVProgressHUD showWithStatus:@"正在上传......"];
    //<img  name="{234CD8E0925C65BA4C3BC4DC3188B7}"  hspace=1 vspace=1 src="{$USER_IMAGE_PATH$}{234CD8E0925C65BA4C3BC4DC3188B7}.jpg,282888829593881,28150902736609885">
    NSString *sendImageMessageContent = [NSString stringWithFormat:@"<img  name=\"{%@}\"  hspace=1 vspace=1 src=\"{$USER_IMAGE_PATH$}{%@}.jpg,%@,%@\">", [Tool getMD5:timeString], [Tool getMD5:timeString], timeString, timeString];
    //1通过socket发送第一条消息 //告诉服务器要上传图片了
    if ([windowChatType isEqualToString:@"user"]) {
        [cimSocketLogicExt sendMessageToUser:sendImageMessageContent userId:chatUserId messageType:1 groupId:@"0"];
    } else {
        [cimSocketLogicExt sendGroupMessage:sendImageMessageContent groupId:chatUserId];
    }
    NSString *url = [NSString stringWithFormat:@"%@/service/UserFileUpload", [Config getProjectPath]];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"] forKey:@"sessionId"];
    [param setObject:[[UserDataManage getSelfUser] userId] forKey:@"toUserId"];
    //2通过http请求 上传图片到服务器
    [http request:url param:param filePath:imgFullPath delegate:self usingBlock:^(NSData *data) {
        [SVProgressHUD dismiss];
        if (data != nil) {
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
            //上传失败
            if (isFail) {
                [SVProgressHUD showAlert:nil msg:[NSString stringWithFormat:@"上传图片失败请重试"]];
                
                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"图片上传失败");
                return;
            }
            NSString *msg = nil;
            NSRegularExpression *xmlRegex2 = [NSRegularExpression regularExpressionWithPattern:@"msg=[\"|']([\\d]*)[\"|']" options:NSRegularExpressionCaseInsensitive error:nil];
            NSArray *arrayRange2 = [xmlRegex2 matchesInString:dataStr options:NSMatchingReportCompletion range:NSMakeRange(0, dataStr.length)];
            for (NSTextCheckingResult *match in arrayRange2) {
                msg = [dataStr substringWithRange:[match rangeAtIndex:1]];
            }
            if (msg) {
                NSString *url = [NSString stringWithFormat:@"%@/service/UserFileDownload?sessionId=%@&fileId=%@", [Config getProjectPath], [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"], msg];
                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"第一条图片消息文本描述描述发送成功");
                [self sendImage:url imageName:timeString fileId:msg];
            }

        } else {
            NSFileManager *fileManager = [[NSFileManager alloc] init];
            if([fileManager fileExistsAtPath:imgFullPath]){
                [fileManager removeItemAtPath:imgFullPath error:nil];
            }
            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"图片上传失败");

            [SVProgressHUD showAlert:nil msg:@"上传图片失败请重试"];
        }
    }];
}
//显示聊天记录
- (IBAction)viewChatLog:(id)sender {
    if (userChatController == nil) {
        userChatController = [[UserChatLogViewController alloc] init];
        userChatController.chatWitherId = chatUserId;
        if ([windowChatType isEqualToString:@"user"]) {
            userChatController.messageType = 1;
        } else {
            userChatController.messageType = 1004;
        }
    }
    [self.navigationController pushViewController:userChatController animated:YES];
}



- (void)showChatMessage {
    ChatUserStruct *currentUser = [ChatListDataStruct getCurrentChatUserId];
    NSString *userKeyString = [NSString stringWithFormat:@"%@_%@", currentUser.dataId, currentUser.chatType];
    
    NSMutableArray *chatArray = nil;
    
    if ([windowChatType isEqualToString:@"user"])
    {
        chatArray = [[UserDataManage getUser:currentUser.dataId] getMessage];
    }
    else if ([windowChatType isEqualToString:@"group"])
    {
        chatArray = [[GroupDataManage getGroup:currentUser.dataId] getMessage];
    }
    
    
    
    //切换了人员
    if (messageWebViewWithUserId == nil || ![messageWebViewWithUserId isEqualToString:userKeyString])
    {
        //清除旧的聊天记录
        [messageWebView stringByEvaluatingJavaScriptFromString:@"clearUserMessage();"];
        webViewMessageCount = 0;
    }
    
    for (int i = webViewMessageCount; i<[chatArray count]; i++) {
        UserChatData *data = [chatArray objectAtIndex:i];
        UserData *userData = [UserDataManage getUser:data.userId];
        NSString *headURL = [userData getHeadImage];
        if ([headURL isEqualToString:@"OfflineHead1.png"] || [headURL isEqualToString:@"DefaultHead.png"]) {
            headURL = @"DefaultHead.png";
            NSData *imageData = UIImagePNGRepresentation([UIImage imageNamed:headURL]);
            NSString *headDataImageStr = [NSString stringWithFormat:@"<img width=\"30\" height=\"30\" src=\"data:image/png;base64,%@\" />", [Base64 encode:imageData]];
            NSString *messageScript;
            NSString *messageTitle = [NSString stringWithFormat:@"%@ %@", data.userName, data.sendTime];
            if (data.isSelf) {
                messageScript = [NSString stringWithFormat:@"addMyMessage('%@','%@','%@');", messageTitle, data.content, headDataImageStr];
            } else {
                messageScript = [NSString stringWithFormat:@"addFriendMessage('%@','%@','%@');", messageTitle, data.content, headDataImageStr];
            }
            [messageWebView stringByEvaluatingJavaScriptFromString:messageScript];
        } else {
            AsynImageView *headImageView = [[AsynImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
            headImageView.loadedAfterFun = ^(id imageSelf) {
                AsynImageView *imageSelfView = (AsynImageView *)imageSelf;
                if (!imageSelfView.image) {
                    imageSelfView.image = [UIImage imageNamed:@"DefaultHead.png"];
                }
                NSData *imageData = UIImagePNGRepresentation(imageSelfView.image);
                NSString *headDataImageStr = [NSString stringWithFormat:@"<img width=\"30\" height=\"30\" src=\"data:image/png;base64,%@\" />", [Base64 encode:imageData]];
                NSString *messageScript;
                NSString *messageTitle = [NSString stringWithFormat:@"%@ %@", data.userName, data.sendTime];
                if (data.isSelf) {
                    messageScript = [NSString stringWithFormat:@"addMyMessage('%@','%@','%@');", messageTitle, data.content, headDataImageStr];
                } else {
                    messageScript = [NSString stringWithFormat:@"addFriendMessage('%@','%@','%@');", messageTitle, data.content, headDataImageStr];
                }
                [messageWebView stringByEvaluatingJavaScriptFromString:messageScript];
            };
            headImageView.imageURL = headURL;
        }
    }
    webViewMessageCount = [chatArray count];
    
    messageWebViewWithUserId = userKeyString;
}



//接收图片消息
- (void)updateImageMessage:(NSMutableDictionary*)param
{
    if (self.isViewLoaded)
    {
        NSString *imageId = [param objectForKey:@"imageId"];
        imageId = [NSString stringWithFormat:@"{%@}", imageId];
        NSString *imageSrc = [param objectForKey:@"downloadId"];
        [messageWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"showImage('%@','%@');", imageId, imageSrc]];
    }
}



//==============================================================


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    //javascript 回调 objective-c
    NSString *requestString = [[request URL] absoluteString];
    //  functionType:param
    NSArray *components = [requestString componentsSeparatedByString:@","];
    
    if ([components count] > 1)
    {
        NSString *functionType = (NSString *)[components objectAtIndex:1];
        NSString *param = [components objectAtIndex:2];
        
        if ([functionType isEqualToString:@"showImage"])
        {
            CIMShowImage *cimShowImage = [CIMShowImage alloc];
            cimShowImage.imageSrc = param;
            [self.navigationController pushViewController:cimShowImage animated:YES];
        }
        
        return NO;
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView  {
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self showChatMessage];
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
