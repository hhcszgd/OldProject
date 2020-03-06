//
//  LoginController.m
//  IOSCim
//
//  Created by fukq helpsoft on 11-3-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginController.h"
#import "Language.h"
#import "HttpWebService.h"
#import "AsyncSocket.h"
#import "IOSCimAppDelegate.h"
#import "ParseXMLString.h"

@implementation LoginController

/*
@synthesize loginIdLable, passwordLable, submitButt, exitButt, loginIdText, 
passwordText, listLoginId, statusLable, loginCell, passwordCell, statusCell;*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[Language init];
	loginIdLable.text = [Language getLanguage:@"login_loginId"];
	passwordLable.text = [Language getLanguage:@"login_password"];
	[submitButt setTitle:[Language getLanguage:@"login_submit"] forState:UIControlStateNormal];
	[exitButt setTitle:[Language getLanguage:@"login_exit"] forState:UIControlStateNormal] ;
    [super viewDidLoad];
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

- (IBAction)login:(id)sender {
	//FriendsTabBarController *friendsTabBar = [[FriendsTabBarController alloc] init];
}

- (IBAction)listLoginId:(id)sender {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"选择账号" message:nil delegate:self cancelButtonTitle:@"完成"  otherButtonTitles:nil];
	
	[alert addButtonWithTitle:@"1001"];
	[alert addButtonWithTitle:@"1002"];
	[alert addButtonWithTitle:@"888888888"];
	[alert addButtonWithTitle:@"666666"];
	[alert show];
	//[alert release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	NSLog(@"click loginId index is: %d", buttonIndex);
}

//按完Done键以后关闭键盘
- (IBAction) textFieldDoneEditing:(id)sender {
	[sender resignFirstResponder];
}

//獲取分區的數量
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
	return 1;
}

//行数
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
	return 3;
}

//行的創建
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	//NSUInteger section = indexPath.section; //獲取第幾分區
	NSUInteger row = indexPath.row; //獲取行
	
	NSLog(@"%d", row);
	
	if (row == 0) {
		return loginCell;
	} else if (row == 1) {
		return passwordCell;
	}
	
	return statusCell;
}

@end
