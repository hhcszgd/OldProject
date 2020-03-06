#import "FriendListController.h"
#import "TreeViewCell.h"

@implementation FriendListController

-(void)viewDidLoad{
	[super viewDidLoad];
	tree = [[TreeNode alloc]init];
	tree.hidden = YES;
	tree.expanded = YES;
	tree.title = @"中商科技";
	TreeNode* node[10];
	
	for (int i=0; i<10; i++) {
		node[i]=[[TreeNode alloc]init];
		node[i].title=[NSString stringWithFormat:@"分组%d",i];
		node[i].key=[NSString stringWithFormat:@"%d",i];
	}
	
    [node[0] addChild:node[1]];
	[node[0] addChild:node[2]];
	[node[0] addChild:node[3]];
	
	[node[2] addChild:node[4]];
	[node[2] addChild:node[5]];
	[node[2] addChild:node[6]];
	
	[node[6] addChild:node[7]];
	[node[6] addChild:node[8]];
	
	[node[3] addChild:node[9]];
	
	[tree addChild:node[0]];
	
	nodes = [[NSMutableArray alloc]init];
	[TreeNode getNodes:tree :nodes];
}

#pragma mark ===table view datasource methods====

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

-(NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
	return nodes.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString* cellid = @"cell";
	
	TreeViewCell* cell = (TreeViewCell*)[tableView dequeueReusableCellWithIdentifier:cellid];
	
	if (cell == nil) {
		cell = [[TreeViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] ;
	}
	
	TreeNode* node=[nodes objectAtIndex:indexPath.row];
	
	[cell setOwner:self];
	[cell setOnExpand:@selector(onExpand:)];
	[cell setTreeNode:node];
	
	return cell;
}

-(void)onExpand:(TreeNode*)node{
	nodes = [[NSMutableArray alloc]init];
	[TreeNode getNodes:tree :nodes];
	//[self.tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	TreeNode* node = [nodes objectAtIndex:indexPath.row];
	
	
	if ([node hasChildren]) {
		return 40;
	} else {
		return 60;
	}
}

@end