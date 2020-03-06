//
//  NearTreeViewController.m
//  IOSCim
//
//  Created by fukq helpsoft on 11-4-14.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NearTreeViewController.h"
#import "TreeKindCell.h"
#import "TreeEndCell.h"
#import "UserChatViewController.h"

@implementation NearTreeViewController

- (void)viewWillAppear:(BOOL)animated {
	[self.navigationController setNavigationBarHidden:NO];
	self.title = @"最近联系人";
}

- (void)viewDidLoad{
	[super viewDidLoad];
	tree = [[TreeNode alloc]init];
	tree.isRoot = YES;
	tree.title = @"最近联系人";
	tree.expanded = YES;
	
	TreeNode* nodeUser1 = [[TreeNode alloc]init];
	nodeUser1.title=[NSString stringWithFormat:@"联系人张"];
	nodeUser1.key=[NSString stringWithFormat:@"%d", 1];
	
	TreeNode* nodeUser2 = [[TreeNode alloc]init];
	nodeUser2.title=[NSString stringWithFormat:@"联系人王"];
	nodeUser2.key=[NSString stringWithFormat:@"%d", 2];
		
	[tree addChild:nodeUser1];
	[tree addChild:nodeUser2];
	
	nodes = [[NSMutableArray alloc]init];
	[TreeNode getNodes:tree :nodes];
}

#pragma mark ===table view datasource methods====

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
	return nodes.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString* kindCellId = @"kindCell"; 
	static NSString* cellid = @"cell";
	
	TreeKindCell* kindCell = (TreeKindCell*)[tableView dequeueReusableCellWithIdentifier:kindCellId];
	TreeEndCell* cell = (TreeEndCell*)[tableView dequeueReusableCellWithIdentifier:cellid];
	
	TreeNode* node = [nodes objectAtIndex:indexPath.row];
	
	if ([node hasChildren]) {
		if (kindCell == nil) {
			kindCell = [[TreeKindCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kindCellId] ;
		}
		
		[kindCell setOwner:self];
		[kindCell setOnExpand:@selector(onExpand:)];
		[kindCell setTreeNode:node];
		return kindCell;
	} else {
		if (cell == nil) {
			cell = [[TreeEndCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] ;
		}
		
		[cell setOwner:self];
		[cell setOnExpand:@selector(onExpand:)];
		[cell setTreeNode:node];
		return cell;
	}
}
- (void)onExpand:(TreeNode*)node{
	nodes = [[NSMutableArray alloc] init];
	[TreeNode getNodes:tree :nodes];
	[self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	TreeNode* node = [nodes objectAtIndex:indexPath.row];
	
	
	if ([node hasChildren]) {
		return 30;
	} else {
		return 40;
	}
}

- (NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	TreeNode* node = [nodes objectAtIndex:indexPath.row];
	
	if ([node hasChildren]) {
		node.expanded = !node.expanded;//切换“展开/收起”状态
	} else {
		UserChatViewController *userChat = [[UserChatViewController alloc] init];
		[self.parentViewController.navigationController pushViewController:userChat animated:YES];
	}
	
	[self onExpand:node];
	return indexPath;
}



@end

