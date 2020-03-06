//
//  SearchFriend.h
//  IOSCim
//
//  Created by apple apple on 11-7-11.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserData.h"
#import "CIMFriendListDataStruct.h"

@interface SearchFriend : UIViewController {
	IBOutlet UITextField *searchUserLoginIdFiled;
	UITableView *myTableView;
	UserData *searchResult;
	NSString *promptMessage;
	BOOL isRequestData;
	BOOL isNoticeAddFriend;
	CIMFriendListDataStruct *cimFriendListDataStruct;
}

@property (nonatomic, retain) IBOutlet UITextField *searchUserLoginIdFiled;

- (IBAction)searchUser:(id)sender;

@end
