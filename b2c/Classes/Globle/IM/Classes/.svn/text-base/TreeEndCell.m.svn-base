//
//  TreeEndCell.m
//  IOSCim
//
//  Created by fukq helpsoft on 11-4-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TreeEndCell.h"

@implementation TreeEndCell
@synthesize onExpand,imgIcon,owner;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier 
{
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) 
	{
        // Initialization code
    }
	
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated 
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


/**
 * 节点被点击
 */

- (void)onExpand:(id)sender 
{
	//treeNode.expanded = !treeNode.expanded;
}



/**
 * 构建最终节点
 * @param node 节点的数据
 */

- (void)buildEndNode:(TreeNode *)node 
{
	if (label == nil) 
	{
		label = [[UILabel alloc]initWithFrame:CGRectMake(50+(2*node.deep), 5, 260,30)];
		imgIcon =  [[UIImageView alloc]initWithFrame:CGRectMake((2*node.deep), 1, 40, 40)];
		[imgIcon setImage:[UIImage imageNamed:@"mr.png"]];
		[self addSubview:label];
		[self addSubview:imgIcon];
	} 
	else 
	{
		[label setFrame:CGRectMake(50+(2*node.deep), 5, 260, 30)];
		[imgIcon setFrame:CGRectMake((2*node.deep), 1, 40, 40)];
	}
	
	[label setText:node.title];
	label.backgroundColor = [UIColor clearColor];
	self.backgroundColor = [UIColor clearColor];
}



/**
 * 构建节点界面
 */

- (void)setTreeNode:(TreeNode *)node 
{
	treeNode = node;
	[self buildEndNode:node];
}





@end