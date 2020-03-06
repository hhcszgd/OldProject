//
//  SetGroupHttp.m
//  IOSCim
//
//  Created by apple apple on 11-8-12.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "SetGroupHttp.h"
#import "XMLElementParam.h"
#import "ErrorParam.h"

@implementation SetGroupHttp
@synthesize delegate;


- (void)createGroup:(NSString*)groupName groupType:(NSString*)groupType groupNotes:(NSString*)groupNotes 
{
	additionalParam = [[NSString alloc] 
					   initWithFormat:@"&function=%@&name=%@&type=%@&notes=%@&&op=%@", 
					   @"setGroup", groupName, groupType, groupNotes, @"add"];
	httpType = @"setGroup";
	isPrintXML = YES;
	[self call];
}



- (void)removeGroup:(NSString*)groupId 
{
	additionalParam = [[NSString alloc] 
					   initWithFormat:@"&function=%@&id=%@&op=%@", 
					   @"setGroup", groupId, @"del"];
	httpType = @"setGroup";
	isPrintXML = YES;
	[self call];
}



- (void)parseXMLFunction:(XMLElementParam*)xmlParam 
{
	[delegate performSelector:@selector(recvSetGroupData:) withObject:nil];
}



//解析完成后通知
- (void)postEndFunction:(id)sender 
{
	
}



- (void)errorFunction:(ErrorParam*)error 
{
	[delegate performSelector:@selector(errorSetGroup:) withObject:error];
}


@end
