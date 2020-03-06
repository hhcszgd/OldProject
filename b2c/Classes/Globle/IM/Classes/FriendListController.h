//
//  FriendListController.h
//  IOSCim
//
//  Created by fukq helpsoft on 11-3-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "TreeNode.h"

@interface FriendListController : UIViewController <UITableViewDelegate,UITableViewDataSource> {
	TreeNode* tree;
	NSMutableArray* nodes;
}

@end
