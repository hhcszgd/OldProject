//
//  TreeEndCell.h
//  IOSCim
//
//  Created by fukq helpsoft on 11-4-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TreeNode.h"

@interface TreeEndCell : UITableViewCell {
	SEL onExpand;//selector:点击“+”展开按钮时触发
	TreeNode* treeNode;//每个单元格表示一个节点
	UILabel* label;//标签：显示节点title
	id owner;//表示 onExpand方法委托给哪个对象
	UIImageView* imgIcon;//图标	
}

@property (assign) SEL onExpand;
@property (retain) id owner;
@property (retain) UIImageView* imgIcon;

- (void)setTreeNode:(TreeNode *)node;

@end
