//
//  NearTreeViewController.h
//  IOSCim
//
//  Created by fukq helpsoft on 11-4-14.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "TreeNode.h"

@interface NearTreeViewController : UITableViewController {
	TreeNode* tree;
	NSMutableArray* nodes;
}

@end
