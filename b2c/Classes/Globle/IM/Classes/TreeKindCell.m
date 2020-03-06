//
//  TreeKindCell.m
//  IOSCim
//
//  Created by fukq helpsoft on 11-4-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TreeKindCell.h"

@implementation TreeKindCell
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
	treeNode.expanded = !treeNode.expanded;//切换“展开/收起”状态	
}



/**
 * 构建分组节点
 * @param node 节点的数据
 */

- (void)buildKindNode:(TreeNode *)node onlineCount:(int)onlineCount totalCount:(int)totalCount 
{
	/*
	if (label == nil) {
		label = [[UILabel alloc]initWithFrame:CGRectMake(30+(5*node.deep), 5, 200,26)];
		btnExpand = [[UIButton alloc]initWithFrame:CGRectMake((2*node.deep), 3, 30, 30)];
		//[btnExpand addTarget:self action:@selector(onExpand:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:label];
		[self addSubview:btnExpand];
	} else {
		[label setFrame:CGRectMake(30+(5*node.deep), 5, 200, 26)];
		[btnExpand setFrame:CGRectMake(2*node.deep, 3, 30, 30)];
	}
	
	if ([node expanded]) {
		[btnExpand setImage:[UIImage imageNamed:@"down.png"] forState:UIControlStateNormal];
	}else {
		[btnExpand setImage:[UIImage imageNamed:@"dicator.png"] forState:UIControlStateNormal];
	}
	
	[label setText:[node.title stringByAppendingFormat:@"(%d/%d)",[node getOnlineNumber],node.childrenCount]];
	label.backgroundColor = [UIColor clearColor];
	//self.contentView.backgroundColor = [UIColor clearColor];
	 */
	NSString *iconImg;
	
	if ([node expanded]) 
	{
		iconImg = @"down.png";
	}
	else 
	{
		iconImg = @"dicator.png";
	}
	
	self.imageView.image = [UIImage imageNamed:iconImg];
	self.textLabel.text = [node.title stringByAppendingFormat:@"(%d/%d)", onlineCount, totalCount];
	self.textLabel.backgroundColor = [UIColor clearColor];	
	UIView *backgrdView = [[UIView alloc] initWithFrame:self.frame];
    backgrdView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"TreeKindBg.png"]];
	self.backgroundView = backgrdView;
//	[backgrdView release];
}


/**
 * 构建节点界面
 */

- (void)setTreeNode:(TreeNode *)node onlineCount:(int)onlineCount totalCount:(int)totalCount
{
	treeNode = node;
	[self buildKindNode:node onlineCount:onlineCount totalCount:totalCount];
}



@end


