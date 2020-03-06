//
//  ShopTreeCell.m
//  IOSCim
//
//  Created by apple apple on 11-5-24.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "ShopTreeCell.h"
#import "UserData.h"

@implementation ShopTreeCell

/**
 * 构建最终节点
 * @param node 节点的数据
 */

- (void)buildEndNode:(TreeNode *)node user:(UserData*)user 
{	
	self.imageView.image = [user getHeadImage];
	self.textLabel.text = node.title;
	self.detailTextLabel.text = node.info;
	self.detailTextLabel.backgroundColor = [UIColor clearColor];
	UIFont *font = [UIFont systemFontOfSize:16];
	self.textLabel.font = font;
	self.textLabel.backgroundColor = [UIColor clearColor];
	UIView *backgrdView = [[UIView alloc] initWithFrame:self.frame];
    backgrdView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"TreeEnd.png"]];
	self.backgroundView = backgrdView;
}



/**
 * 构建节点界面
 */

- (void)setTreeNode:(TreeNode *)node user:(UserData*)user
{
	treeNode = node;
	[self buildEndNode:node user:user];
}

@end
