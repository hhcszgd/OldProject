//
//  LoginIdDropListDelegate.m
//  IOSCim
//
//  Created by apple apple on 11-7-18.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "LoginIdDropListDelegate.h"
#import "SystemConfig.h"
#import "MyNotificationCenter.h"

@implementation LoginIdDropListDelegate

//獲取分區的數量
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView 
{
	//tableView.backgroundColor = [UIColor clearColor];
	tableView.editing = YES;
	return 1;
}


//行数
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section 
{
	loginUsersDict = [SystemConfig getMemberedLoginData];
	int rows = [[loginUsersDict allKeys] count];
	
	if (rows == 0) 
	{
		return 0;
	}
	
	return rows;
}



//行的創建
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	NSUInteger row = indexPath.row; //獲取行
	static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) 
	{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
									   reuseIdentifier:CellIdentifier] ;
    }
	
	NSArray *keys = [loginUsersDict allKeys];
	cell.textLabel.text = [keys objectAtIndex:row];
	//cell.selectionStyle = UITableViewCellSelectionStyleNone;
	cell.textLabel.backgroundColor = [UIColor clearColor];
	return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	NSUInteger row = indexPath.row; //獲取行
	return 40;
}



- (NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	NSUInteger row = indexPath.row; //獲取行
	NSArray *keys = [loginUsersDict allKeys];
	NSString *key = [keys objectAtIndex:row];
	NSString *password = [loginUsersDict objectForKey:key];
	NSMutableDictionary *loginIdData = [[NSMutableDictionary alloc] init];
	[loginIdData setObject:key forKey:@"loginId"];
	[loginIdData setObject:password forKey:@"password"];
	[MyNotificationCenter postNotification:SystemEventChooseMemberLoginId setParam:loginIdData];
	return indexPath;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{

}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
forRowAtIndexPath:(NSIndexPath *)indexPath 
{
	NSArray *keys = [loginUsersDict allKeys];
	[SystemConfig deleteLoginUser:[keys objectAtIndex:indexPath.row]];
	[tableView reloadData];
}

@end
