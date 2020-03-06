//
//  SearchGroupViewController.m
//  IOSCim
//
//  Created by apple apple on 11-8-9.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "SearchGroupViewController.h"
#import "GetGroupHttp.h"
#import "ErrorParam.h"
#import "GroupStruct.h"
#import "Debuger.h"
#import "GroupDataManage.h"
#import "CIMSocketLogicExt.h"
#import "CimGlobal.h"


@implementation SearchGroupViewController


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
}



//獲取分區的數量
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView 
{
	myTableView = tableView;
	return 1;
}



//行数
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section 
{
	if (_group == nil) 
	{
		return 0;
	}
	
	return 1;
}



//行的創建
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) 
	{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:CellIdentifier] ;
    }
	
	cell.imageView.image = [UIImage imageNamed:@"grouphead.png"];
	cell.textLabel.text = _group.groupName;
	cell.detailTextLabel.text = _group.notes;
	return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	return 50;
}



//分区标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return promptMessage;
}



//发送申请加入群消息
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	if ([GroupDataManage isMyGroup:_group.groupId]) 
	{
		[Debuger systemAlert:@"您已经加入了该群，不能再添加"];
		return;
	}
	
	CIMSocketLogicExt *cimSocketLogicExt = [CimGlobal getClass:@"CIMSocketLogicExt"];
	[cimSocketLogicExt sendAddGroupRequest:_group.groupId groupMasterId:_group.groupMaster.userId];
	[Debuger systemAlert:@"已经发出申请"];
}



- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar 
{
	searchBar.text = @"";
	[self.navigationController setNavigationBarHidden:YES];
	return YES;
}



- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar 
{
	[searchBar resignFirstResponder];
	[self.navigationController setNavigationBarHidden:NO];
	GetGroupHttp *http = [GetGroupHttp alloc];
	http.delegate = self;
	[http init:searchBar.text];
}



- (void)recvGetGroupData:(GroupStruct*)group 
{
	promptMessage = @"搜索到群";
	_group = group;
	[myTableView reloadData];
}



- (void)errorGetGroup:(ErrorParam*)error 
{
	promptMessage = error.errorInfo;
	_group = nil;
	[myTableView reloadData];
}




@end
