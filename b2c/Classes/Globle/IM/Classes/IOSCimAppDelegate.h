//
//  IOSCimAppDelegate.h
//  IOSCim
//
//  Created by fukq helpsoft on 11-3-18.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginController.h"
#import "CimExceptionLog.h"
#import "LoginViewController.h"


@interface IOSCimAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;	
	UINavigationController *navCont;
	NSMutableDictionary *shopUsers;
	NSMutableArray *shopUsersId;
	NSMutableArray *shopDeptsId;
    LoginViewController *loginViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UINavigationController *navCont;
@property (nonatomic, retain) NSMutableDictionary *shopUsers;
@property (nonatomic, retain) NSMutableArray *shopUsersId;
@property (nonatomic, retain) NSMutableArray *shopDeptsId;
@property (nonatomic, retain) NSMutableDictionary *shopDepts;

@end

