#import "TreeViewCell.h"
@implementation TreeViewCell

@synthesize onExpand,imgIcon,owner;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        // Initialization code
    }
	
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

/**
 * 点击单节点的操作
 */

- (void)expandSingleNode:(id)node {
	
}

/**
 * 节点被点击
 */

- (void)onExpand:(id)sender {
	if ([treeNode hasChildren]) {//如果有子节点
		treeNode.expanded = !treeNode.expanded;//切换“展开/收起”状态
		
		if(treeNode.expanded){//若展开状态设置“+/-”号图标
			[btnExpand setImage:[UIImage imageNamed:@"down.png"] forState:UIControlStateNormal];
		}else {
			[btnExpand setImage:[UIImage imageNamed:@"dicator.png"] forState:UIControlStateNormal];
		}
		
		if(owner != nil && onExpand != nil)//若用户设置了onExpand属性则调用
			[owner performSelector:onExpand withObject:treeNode];
	} else {//点击单节点的操作
		[self expandSingleNode:treeNode];
	}
	
}

/**
 * 构建分组节点
 * @param node 节点的数据
 */

- (void)buildKindNode:(TreeNode *)node {	
	if (label == nil) {
		label = [[UILabel alloc]initWithFrame:CGRectMake(50+(5*node.deep), 0, 200,36)];
		btnExpand = [[UIButton alloc]initWithFrame:CGRectMake((5*node.deep), 5, 32, 32)];
		[btnExpand addTarget:self action:@selector(onExpand:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:label];
		[self addSubview:btnExpand];
	} else {
		[label setFrame:CGRectMake(50+(15*node.deep), 0, 200, 36)];
		[btnExpand setFrame:CGRectMake(5*node.deep, 5, 32, 32)];
	}
	
	//NSLog(@"node has children");
	if ([node expanded]) {
		[btnExpand setImage:[UIImage imageNamed:@"down.png"] forState:UIControlStateNormal];
	}else {
		[btnExpand setImage:[UIImage imageNamed:@"dicator.png"] forState:UIControlStateNormal];
	}
	
	[label setText:node.title];
}


/**
 * 构建单节点
 * @param node 节点的数据
 */

- (void)buildSingleNode:(TreeNode *)node {
	if (label == nil) {
		label = [[UILabel alloc]initWithFrame:CGRectMake(50+(5*node.deep), 0, 200,36)];
		[self addSubview:label];
	} else {
		[label setFrame:CGRectMake(50+(15*node.deep), 0, 200, 36)];
		[btnExpand setImage:nil forState:UIControlStateNormal];
	}
	
	[label setText:node.title];
}

/**
 * 构建节点界面
 */

- (void)setTreeNode:(TreeNode *)node {
	treeNode = node;
	
	if ([node hasChildren]) {
		[self buildKindNode:node];
	}else {
		[self buildSingleNode:node];
	}
}

@end