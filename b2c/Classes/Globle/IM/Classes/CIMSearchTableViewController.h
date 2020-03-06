//
//  CIMSearchTableViewController.h
//  IOSCim
//
//  Created by apple apple on 11-8-16.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CIMUserListDataStruct.h"


@interface CIMSearchTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate> {
	CIMUserListDataStruct *listDataStruct;
	NSMutableArray *searchUsersArray;
	UITableView *searchTableView;
	id listObject; //用户列表的对象
}


@property (nonatomic, retain) CIMUserListDataStruct *listDataStruct;
@property (nonatomic, retain) id listObject;

@end
