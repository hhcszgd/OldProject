//
//  ChooseLoginId.m
//  IOSCim
//
//  Created by apple apple on 11-5-11.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "ChooseLoginId.h"
#import "SystemConfig.h"

@implementation ChooseLoginId


#pragma mark -
#pragma mark View lifecycle

- (void) editLoginIdList:(id)sender 
{
	self.tableView.editing = YES;
	[self.tableView reloadData];
	self.navigationItem.rightBarButtonItem.title = @"完成";
	self.navigationItem.rightBarButtonItem.action = @selector(gotoLoginWindow:);
}



- (void)viewDidLoad 
{
	UIBarButtonItem *editButton = [[UIBarButtonItem alloc] 
								initWithTitle:@"编辑"
								style: UIBarButtonItemStyleBordered
								target: self
								action: @selector(editLoginIdList:)];
	self.navigationItem.rightBarButtonItem = editButton;
}



- (void)viewWillAppear:(BOOL)animated 
{
	[self.navigationController setNavigationBarHidden:NO];
}


#pragma mark -
#pragma mark Table view data source



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    // Return the number of sections.
	tableView.backgroundColor = [UIColor clearColor];
	//tableView.editing = YES;
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    // Return the number of rows in the section.
    return [[SystemConfig getLoginIds] count];
}



// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) 
	{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
									   reuseIdentifier:CellIdentifier];
    }
	
	NSString *loginId = [[SystemConfig getLoginIds] objectAtIndex:indexPath.row];
	
	if (indexPath.row == 0) 
	{
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	}
    
	cell.textLabel.text = loginId;
    return cell;
}



- (void)tableView:(UITableView *)tableView 
	commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
	forRowAtIndexPath:(NSIndexPath *)indexPath 
{
	NSString *loginId = [[SystemConfig getLoginIds] objectAtIndex:indexPath.row];
	NSString *password = nil ;
	[SystemConfig addLoginUser:loginId password:password];
}


#pragma mark -
#pragma mark Table view delegate



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	[self gotoLoginWindow:nil];
}




- (void)gotoLoginWindow:(id)sender 
{
	[self.navigationController popViewControllerAnimated:YES];
}




@end

