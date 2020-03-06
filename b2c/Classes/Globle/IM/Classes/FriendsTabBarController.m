//
//  FriendsTabBarController.m
//  IOSCim
//
//  Created by fukq helpsoft on 11-3-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FriendsTabBarController.h" 
#import "FriendListController.h"
#import "GroupListController.h"
#import "ChatListController.h"
#import "NearListController.h"
#import "Language.h"
@implementation FriendsTabBarController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	/*
	[Language init];
	tabBarCont = [[UITabBarController alloc] init];
	FriendListController *friendListCont = [FriendListController alloc];
	friendListCont.title = [Language getLanguage:@"tabBar_friendButton"];
	FriendTreeViewController *frendTreeViewCont = [FriendTreeViewController alloc];
	frendTreeViewCont.title = [Language getLanguage:@"tabBar_friendButton"];
	
	ChatListController *chatListCont = [ChatListController alloc];
	chatListCont.title = [Language getLanguage:@"tabBar_chatButton"];
	NearListController *nearListCont = [NearListController alloc];
	nearListCont.title = [Language getLanguage:@"tabBar_nearButton"];
	navCont = [[UINavigationController alloc] init];
	[navCont setNavigationBarHidden:YES]; 
	tabBarCont.viewControllers = [NSArray arrayWithObjects:frendTreeViewCont, nil];
	[friendListCont release];
	[chatListCont release];
	[nearListCont release];
	GroupListController *groupListCont = [GroupListController alloc];
	groupListCont.title = [Language getLanguage:@"tabBar_groupButton"];;
	[navCont pushViewController:frendTreeViewCont animated:NO];
	[groupListCont release];
	self.view = tabBarCont.view;
	[self.navigationController popViewControllerAnimated:YES];
    [super viewDidLoad];*/
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}




@end
