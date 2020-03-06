//
//  TreeNode.m
//  TreeView
//
//  Created by fukq helpsoft on 11-4-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TreeNode.h"
#import "UserDataManage.h"




@implementation TreeNode
@synthesize p_node, children, data, title, key, expanded, 
hidden, isRoot, nodeType, info, param, fatherItemIndex, onlineCount;

NSComparisonResult compare(TreeNode *first, TreeNode *second, void *context) 
{
	int firstStatus = [[UserDataManage getUser:first.param] getStatus];
	int secondStatus = [[UserDataManage getUser:second.param] getStatus];
	
	if (firstStatus < secondStatus)
		return NSOrderedAscending;
	else if (firstStatus > secondStatus)
		return NSOrderedDescending;
	else
		return NSOrderedSame;
}



- (id)init
{
	if (self = [super init]) 
	{
		p_node = nil;
		children = nil;
		key = nil;
		hidden = NO;
		isRoot = NO;
		expanded = NO;
		onlineCount = 0;
	}
	
	return self;
}



- (void)addOnlineNumber 
{
	onlineCount++;
}



- (int)getOnlineNumber 
{
	return onlineCount;
}



- (void)resetOnlineNumber 
{
	onlineCount = 0;
}



- (void)clearChilds 
{
	[children removeAllObjects];
	self.fatherItemIndex = 0;
}


- (void)addChild:(TreeNode *)child 
{
	if (children == nil) 
	{
		children = [[NSMutableArray alloc]init];
	}
	
	child.p_node = self;
	[children addObject:child];
	
	if ([children count] > 0) 
	{
		child.fatherItemIndex = [children count] - 1;
	} 
	else 
	{
		child.fatherItemIndex = 0;
	}
}



- (void)removeChild:(NSString*)aKey
{
	for (int i=0; i<[children count]; i++) 
	{
		TreeNode *node = [children objectAtIndex:i];
		
		if ([node.key isEqualToString:aKey])
		{
			[children removeObjectAtIndex:i];
			break;
		}
	}
}



- (int)childrenCount
{
	return children == nil ? 0 : children.count;
}



- (int)deep
{
	if (p_node == nil) 
	{
		return 0;
	} 
	else 
	{
		return [p_node deep] + 1;
	}
}



- (BOOL)hasChildren
{
	if(children == nil || children.count == 0)
		return NO;
	else return YES;
}



//更新状态 改变自己在父级节点中的位置
//先从父节点中 删除自己 再找个新的位置放好
- (void)updateStatus 
{
	NSMutableArray *fatherChilds = p_node.children;
	
	if ([fatherChilds count] == 0) 
	{
		return;
	}
	
	//状态没更变就忽略掉
	if (![[UserDataManage getUser:param] isChangeStatus]) 
	{
		return;
	}
	
	int onlineUserCount = 0;
	
	//统计上线人数
	for (int i=0; i<[fatherChilds count]; i++) 
	{
		TreeNode *node = [fatherChilds objectAtIndex:i];
		int otherStatus = [[UserDataManage getUser:node.param] getStatus];
		
		if (otherStatus != UserStatusOffline) 
		{
			onlineUserCount++;
		}
	}
	
	p_node.onlineCount = onlineUserCount;
	[fatherChilds sortUsingFunction:compare context:NULL];
}






+ (TreeNode*)findNodeByKey:(NSString*)_key :(TreeNode*)node
{
	//如果node就匹配，返回node
	if ([_key isEqualToString:[node key]]) 
	{
		return node;
	} 
	else if ([node hasChildren])
	{//如果node有子节点，查找node 的子节点
		for(TreeNode* each in [node children])
		{
			TreeNode* childNode = [TreeNode findNodeByKey:_key :each];
			
			if (childNode != nil) 
			{
				return childNode;
			}
		}
	}
	
	//如果node没有子节点,则查找终止,返回ni
	return nil;
}




+ (void)getNodes:(TreeNode*)node :(NSMutableArray*) array
{
	if (!node.isRoot) 
	{
		[array addObject:node];
	}
	
	if ([node hasChildren] && node.expanded) 
	{
		for(TreeNode* each in [node children])
		{
			[TreeNode getNodes:each :array];
		}
	}
}

@end
