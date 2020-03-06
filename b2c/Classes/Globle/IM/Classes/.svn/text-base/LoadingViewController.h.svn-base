//
//  LoadingViewController.h
//  IOSCim
//
//  Created by fei lan on 14-10-15.
//  Copyright (c) 2014年 CIMForIOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CIMShopUserTreeViewController.h"
#import "CIMFriendUserTreeViewController.h"
#import "ChatTreesViewController.h"
#import "NearTreeViewController.h"
#import "GroupTreeViewController.h"
#import "SettingController.h"

@interface LoadingViewController : UIViewController {
    UIButton *exitLoading;
    UITabBarController *tabBarCont;
    UINavigationController *navCont;
    
    NSString *userLoginId;
    NSString *userPassword;
    
    GroupTreeViewController *groupTreeViewCont;
    CIMShopUserTreeViewController *cimShopUserTreeViewController;
    CIMFriendUserTreeViewController *cimFriendUserTreeViewController;
    ChatTreesViewController *chatTreeViewCont;
    SettingController *setting;
}

@property(nonatomic, retain) NSString *userLoginId;
@property(nonatomic, retain) NSString *userPassword;

@end
