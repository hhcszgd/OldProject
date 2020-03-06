//
//  FaceTableViewController.m
//  IOSCim
//
//  Created by apple apple on 11-7-13.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "FaceTableViewController.h"
#import "FaceTableViewCell.h"
#import "Config.h"


@implementation FaceTableViewController
@synthesize delegate;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
}



//獲取分區的數量
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView 
{
	return 1;
}


- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section 
{
	return 12;
}


//行的創建
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
		static NSString *SectionsTableIdentifier = @"SectionsTableIdentifier";
	
		FaceTableViewCell *cell = (FaceTableViewCell*)[tableView dequeueReusableCellWithIdentifier:SectionsTableIdentifier];
	
		if (cell == nil) {
			cell = [[FaceTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
											 reuseIdentifier:SectionsTableIdentifier ];
			cell.delegate = delegate;
		}
		
		//让行不能选中
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		[cell build:indexPath.row];
		return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	return 40;
}




@end
