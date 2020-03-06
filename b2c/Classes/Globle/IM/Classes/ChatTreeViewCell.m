//
//  ChatTreeViewCell.m
//  IOSCim
//
//  Created by fukq helpsoft on 11-4-14.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ChatTreeViewCell.h"


@implementation ChatTreeViewCell

/**
 * 构建单节点
 * @param node 节点的数据
 */

- (void)buildSingleNode:(TreeNode *)node{
	if (label == nil) {
		label = [[UILabel alloc]initWithFrame:CGRectMake(50+(5*node.deep), 10, 200,28)];
		[self addSubview:label];
		
		imgIcon =  [[UIImageView alloc]initWithFrame:CGRectMake(5+(5*node.deep), 6, 40, 40)];
		[imgIcon setImage:[UIImage imageNamed:@"mr.png"]];
		[self addSubview:imgIcon];
	} else {
		[label setFrame:CGRectMake(50+(15*node.deep), 0, 200, 36)];
		[btnExpand setImage:nil forState:UIControlStateNormal];
	}
	
	[label setText:node.title];
}

@end
