//
//  LoginViewController.h
//  IOSCim
//
//  Created by Administrator on 9/25/14.
//  Copyright (c) 2014 CIMForIOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommViewController.h"

@interface LoginViewController : CommViewController <UITextFieldDelegate> {
    UIButton *statusButton;
    UIButton *autoLoginButton;
    UIButton *rememberButton;
    UITextField *userLoginId;
    UITextField *userPassword;
    NSMutableDictionary *loginUsersDict;
    UIScrollView *mainScrollView;
    BOOL isShowKeyboard;
    BOOL userLoginIsShow;
    BOOL passWordIsShow;
}

@end
