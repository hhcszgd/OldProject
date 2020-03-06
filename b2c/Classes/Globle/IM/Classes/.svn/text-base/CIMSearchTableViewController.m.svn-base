    //
//  CIMSearchTableViewController.m
//  IOSCim
//
//  Created by apple apple on 11-8-16.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "CIMSearchTableViewController.h"
#import "CIMUserListDataStruct.h"
#import "UserData.h"


@implementation CIMSearchTableViewController
@synthesize listDataStruct, listObject;



//匹配搜索数据
- (void)searchUserData:(NSString*)searchText 
{
	if (searchUsersArray == nil) 
	{
		searchUsersArray = [[NSMutableArray alloc] init];
	} 
	else 
	{
		[searchUsersArray removeAllObjects];
	}

	NSMutableArray *kindUsers = [listDataStruct getListUsers];
	
	for (UserData *user in kindUsers) 
	{
		if ([[user getUserName] rangeOfString:searchText].length > 0 ) 
		{
			//NSLog(@"搜索到的用户:%@", [user getUserName]);
			[searchUsersArray addObject:user];
		}
	}
	
	[searchTableView reloadData];
}




- (void)viewDidLoad 
{
    [super viewDidLoad];
}



//////////////////////////////////////////////////////////////////////



//獲取分區的數量
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView 
{
	searchTableView = tableView;
	//tableView.backgroundColor = [UIColor clearColor];
	return 1;
}



//行数
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section 
{
	if ([searchUsersArray count] > 0) 
	{
		tableView.hidden = NO;
	}
	
	return [searchUsersArray count];
}



//行的創建
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) 
	{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
									   reuseIdentifier:CellIdentifier];
    }
	
	UserData *user = [searchUsersArray objectAtIndex:indexPath.row];
	cell.imageView.image = [UIImage imageNamed:[user getHeadImage]];
	cell.textLabel.text = [user getUserName];
	cell.detailTextLabel.text = user.idiograph;
	UIView *backgrdView = [[UIView alloc] initWithFrame:cell.frame];
	backgrdView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"TreeEnd.png"]];
	cell.backgroundView = backgrdView;
	cell.textLabel.backgroundColor = [UIColor clearColor];
	return cell;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 59;
}



- (NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	
	UserData *user = [searchUsersArray objectAtIndex:indexPath.row];
	[listObject performSelector:@selector(openChatWindow:) withObject:user];
	return indexPath;
}



////////////////////////////////////////////////////////////////////////////



//鼠标进去搜索框
- (BOOL)searchBarShouldBeginEditing:(UISearchBar*)searchBar 
{
	searchBar.showsCancelButton = YES;
	[self searchUserData: @""];
	return YES;
}




//文字发生改变
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString*)searchText 
{
	if (![searchText isEqualToString:@""]) 
	{
		[self searchUserData: searchText];
	}
}




//点击取消按钮
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar 
{
	searchBar.text = @"";
	[searchBar resignFirstResponder];
	searchBar.showsCancelButton = NO;
	searchTableView.hidden = YES;
}




//点击搜索按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar 
{
	[searchBar resignFirstResponder];
}



- (void)dealloc {
//	[listDataStruct release];
//	[searchUsersArray release];
//	[searchTableView release];
//    [super dealloc];
}


@end
