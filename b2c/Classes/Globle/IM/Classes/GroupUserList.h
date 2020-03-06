//
//  GroupUserList.h
//  IOSCim
//
//  Created by apple apple on 11-7-21.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GroupUserList : UIViewController {
	NSString *groupId;
	IBOutlet UITableView *myTableView;
	NSMutableArray *groupUsers;
}

@property (nonatomic, retain) NSString *groupId;
@property (nonatomic, retain) IBOutlet UITableView *myTableView;

@end
