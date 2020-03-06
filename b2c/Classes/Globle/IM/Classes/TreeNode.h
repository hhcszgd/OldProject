//
//  TreeNode.h
//  IOSCim
//
//  Created by fukq helpsoft on 11-4-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TreeNode : NSObject {
	TreeNode* p_node;//父节点
	NSMutableArray *children;//子节点
	NSInteger fatherItemIndex;
	id data;//节点可以包含任意数据
	NSString* title;//节点要显示的文字
	NSString* key;//主键，在树中唯一
	BOOL expanded;//标志：节点是否已展开，保留给TreeViewCell使用的
	BOOL hidden;//标志，节点是否隐藏
	BOOL isRoot;//是否是跟节点
	NSString* nodeType;
	NSString *info;
	NSString *param;
	NSInteger onlineCount;
}

@property (retain) TreeNode* p_node;
@property (retain) id data;
@property (retain) NSString *title,*key;
@property (assign) BOOL expanded, hidden, isRoot;
@property (retain) NSMutableArray* children;
@property (nonatomic, retain) NSString *nodeType;
@property (nonatomic, retain) NSString *info;
@property (nonatomic, retain) NSString *param;
@property (assign) NSInteger fatherItemIndex;
@property (assign) NSInteger onlineCount;

- (int)deep;
- (BOOL)hasChildren;
//子节点的添加方法
- (void)addChild:(TreeNode*) child;
- (void)removeChild:(NSString*)key;
- (int)childrenCount;
- (void)addOnlineNumber;
- (int)getOnlineNumber;
- (void)resetOnlineNumber;
- (void)updateStatus;
- (void)clearChilds;

+ (TreeNode*)findNodeByKey:(NSString*)_key :(TreeNode*) node;
+ (void)getNodes:(TreeNode*)root :(NSMutableArray*) array;

@end
