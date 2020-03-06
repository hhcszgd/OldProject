//
//  IOSCimAppDelegate.m
//  IOSCim
//
//  Created by fukq helpsoft on 11-3-18.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import "IOSCimAppDelegate.h"
#import "UserDataManage.h"
#import "LoginViewController.h"

@implementation IOSCimAppDelegate
@synthesize window, navCont, shopUsers, shopUsersId, shopDeptsId;


static CimExceptionLog *gLog;

static void uncaughtExceptionHandler(NSException *exception) 
{
    if (gLog != nil) {
        [gLog log:exception];
    }
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    gLog = [CimExceptionLog alloc];
    [gLog initLog];
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    navCont = [[UINavigationController alloc] init];
    [navCont setNavigationBarHidden:YES];
    loginViewController = [LoginViewController alloc];
    [navCont pushViewController:loginViewController animated:NO];
    CGRect mainRect = [[UIScreen mainScreen] bounds];
    self.window = [[UIWindow alloc] initWithFrame:mainRect];
    [window setRootViewController:navCont];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

//- (void)dealloc {
//	[loginViewController release];
//    [window release];
//	[navCont release];
//    [gLog release];
//    [super dealloc];
//}

@end
