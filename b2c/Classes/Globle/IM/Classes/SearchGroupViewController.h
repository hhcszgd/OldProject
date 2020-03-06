//
//  SearchGroupViewController.h
//  IOSCim
//
//  Created by apple apple on 11-8-9.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupStruct.h"

@interface SearchGroupViewController : UIViewController {
	UITableView *myTableView;
	NSString *promptMessage;
	BOOL isRequestData;
	BOOL isNoticeAddGroup;
	GroupStruct *_group;
}

@end
