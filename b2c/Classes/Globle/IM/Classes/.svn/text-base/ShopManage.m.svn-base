//
//  ShopManage.m
//  IOSCim
//
//  Created by apple apple on 11-5-25.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "ShopManage.h"
#import "Config.h"
#import "Debuger.h"
#import "HttpGetData.h"

@implementation ShopManage

- (void)init {
	NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];
	
	HttpGetData *shopHttp = [HttpGetData alloc];
	//对密码加密
	NSString *urlParam = [NSString stringWithFormat:@"function=%@&sessionId=%@&shopId=0&assignShopId=0&offset=0&limit=999", 
						  @"getShop", sessionId];
	
	[shopHttp request:[Config getPath] 
					  param:urlParam 
				   delegate:self 
				   selector:@selector(recvShopData:)];
	
}

- (void)recvShopData:(NSData *)xmlData {
	[Debuger printNSData:xmlData];
}

@end
