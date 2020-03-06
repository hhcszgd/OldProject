//
//  UserChatLogViewController.m
//  IOSCim
//
//  Created by fei lan on 14-9-27.
//  Copyright (c) 2014年 CIMForIOS. All rights reserved.
//

#import "UserChatLogViewController.h"
#import "UserChatLog.h"
#import "OPChatLogData.h"
#import "UserDataManage.h"
#import "ChatWebLog.h"
#import "ChatLogCell.h"
#import "Config.h"
#import "CimGlobal.h"
#import "SystemVariable.h"
#import "Tool.h"
#import "AsynImageView.h"
#import "Base64.h"

#define toolBarS 5
#define toolBarHeight 50
#define toolBarSize (toolBarHeight - 2 * toolBarS)

@interface UserChatLogViewController ()

@end

@implementation UserChatLogViewController
@synthesize chatWitherId, messageType;

- (void)viewDidLoad {
    isShowBackButton = YES;
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
    //新建网页
    if (IS_GTE_IOS7) {
        messageWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, mainRect.size.width, mainRect.size.height - (statusBarHeight + navigationBarHeight + toolBarHeight))];
    } else {
        messageWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, navigationBarHeight, mainRect.size.width, mainRect.size.height - (statusBarHeight + navigationBarHeight + toolBarHeight))];
    }
    messageWebView.delegate = self;
    [self.view addSubview:messageWebView];
    
    
    //底部边栏
    if (IS_GTE_IOS7) {
        toolbar = [[TranslucentToolbar alloc] initWithFrame:CGRectMake(0, messageWebView.frame.origin.y + messageWebView.frame.size.height, mainRect.size.width, toolBarHeight)];
    } else {
        toolbar = [[TranslucentToolbar alloc] initWithFrame:CGRectMake(0, messageWebView.frame.origin.y + messageWebView.frame.size.height, mainRect.size.width, toolBarHeight)];
    }
    //清除按钮
    UIButton *clearButton = [[UIButton alloc] initWithFrame:CGRectMake(0, toolBarS, toolBarSize, toolBarSize)];
    [clearButton setBackgroundImage:[UIImage imageNamed:@"trashIcon"] forState:UIControlStateNormal];
    [clearButton setBackgroundImage:[UIImage imageNamed:@"trashIcon"] forState:UIControlStateHighlighted];
    [clearButton addTarget:self action:@selector(deleteChatLog:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *chatLogBarButton = [[UIBarButtonItem alloc] initWithCustomView:clearButton];
    
    toolbar.items = [[NSArray alloc] initWithObjects:chatLogBarButton, nil];
    [self.view addSubview:toolbar];
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ChatWindowBG.png"]];
    self.title = @"聊天记录";
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ChatDataPanel" ofType:@"html"];
    [messageWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
    messageWebView.backgroundColor = [Tool colorWithHexString:@"dbe2ed"];
    messageWebView.opaque = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];
}


//====================================================================================


- (void)showChatMessage {
    NSString *selfId = [[UserDataManage getSelfUser] userId];
    OPChatLogData *opChatlogData = [CimGlobal getClass:@"OPChatLogData"];
    chatLogsArray = [opChatlogData getMessageLog:selfId chatWitherId:chatWitherId messageType:messageType];
    
    //清除旧的聊天记录
    [messageWebView stringByEvaluatingJavaScriptFromString:@"clearUserMessage();"];
    
    for (int i=0; i<[chatLogsArray count]; i++) {
        UserChatData *data = [chatLogsArray objectAtIndex:i];
        UserData *userData = [UserDataManage getUser:data.userId];
        NSString *headURL = [userData getHeadImage];
        if ([headURL isEqualToString:@"OfflineHead1.png"] || [headURL isEqualToString:@"DefaultHead.png"]) {
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
            headImageView.isGrayImage = ([userData getStatus] == UserStatusOffline);
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
}

//==========================================================================


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return true;
}


- (void)webViewDidStartLoad:(UIWebView *)webView {
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self showChatMessage];
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
}

//删除聊天记录
- (IBAction)deleteChatLog:(id)sender {
    NSString *selfId = [[UserDataManage getSelfUser] userId];
    OPChatLogData *opChatlogData = [CimGlobal getClass:@"OPChatLogData"];
    [opChatlogData deleteMessageLog:selfId chatWitherId:chatWitherId];
    [chatLogsArray removeAllObjects];
    [self showChatMessage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
