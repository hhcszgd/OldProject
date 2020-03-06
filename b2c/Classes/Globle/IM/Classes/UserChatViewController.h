//
//  UserChatViewController.h
//  IOSCim
//
//  Created by fei lan on 14-9-26.
//  Copyright (c) 2014年 CIMForIOS. All rights reserved.
//

#import "CIMUIViewController.h"
#import "UserDataManage.h"
#import "ChatUserStruct.h"
#import "CIMSocketLogicExt.h"
#import "CIMUIViewController.h"
#import "UserChatLogViewController.h"
#import "TranslucentToolbar.h"

@interface UserChatViewController : CIMUIViewController<UIWebViewDelegate, UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
    UIView *inputView;
    UIScrollView *faceView;
    UITableView *chatTableView;
    NSMutableArray *userChatLog;
    
    NSString *chatUserId;
    NSString *messageWebViewWithUserId;
    int webViewMessageCount;
    int keyBoardHeight;
    TranslucentToolbar *toolbar;
    NSString *windowChatType;
    
    CGFloat totalHeight;
    int rowsCount;
    int testMessage;
    CIMSocketLogicExt *cimSocketLogicExt;
    UserDataManage *userDataManage;
    
    UITextField *inputTextField;
    UIButton *chatLogButton;
    UIButton *chooseFaceButton;
    UIScrollView *facePanelTableView;
    UIView *menuView;
    IBOutlet UIView *inputBar;
    UIButton *BGButton;
    UIWebView *messageWebView;
    UIBarButtonItem *closeButton;
    UserChatLogViewController *userChatController;
    CGRect mainRect;
    CGRect origiRect;
    CGFloat statusBarHeight;
    CGFloat navigationBarHeight;
    UIView *faceBackView;
    BOOL isActive;
}


@property (nonatomic, retain) NSString *chatUserId;
@property (nonatomic, retain) IBOutlet UIView *inputBar;
@property (nonatomic, retain) NSString *chatTitle;

- (IBAction) textFieldDoneEditing:(id)sender;
- (void) setConcantUser:(ChatUserStruct*)chatUser;
- (IBAction) textFieldDidBeginEditing:(id)sender;
- (IBAction) backgroundClick:(id)sender;
- (IBAction) viewChatLog:(id)sender;
- (void) keyboardWillShow:(NSNotification *)notif;

- (void) updateChatMessage:(id)userId;
//显示表情面板
- (IBAction)showChooseFacePanel:(id)sender;

@end
