//
//  ParseLogin.m
//  IOSCim
//
//  Created by apple apple on 11-5-23.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "ParseLogin.h"
#import "Debuger.h"
#import "ShopDeptStruct.h"
#import "IOSCimAppDelegate.h"
#import "UserData.h"
#import "UserDataManage.h"
#import "ChatListDataStruct.h"
#import "SocketManage.h"
#import "FriendKindStruct.h"
#import "SystemConfig.h"
#import "UserListKindDataStruct.h"

@implementation ParseLogin

- (void)setDelegate:(id)delegate selector:(SEL)selector {
	myDelegate = delegate;
	mySelector = selector;
}

//获得结点结尾的值
- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
	
	if ([elementName isEqualToString:@"cim"]) {
		[myDelegate performSelector:mySelector withObject:resultData];
	}
}

//获得结点头的值
- (void)parser:(NSXMLParser *)parser 
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName
	attributes:(NSDictionary *)attributeDict {
	
	if (resultData == nil) {
		resultData = [[NSMutableDictionary alloc] init];
		isShopMaster = NO;
	}
	
	if ([elementName isEqualToString:@"result"]) {
		
		if ([[attributeDict objectForKey:@"code"] isEqualToString: @"0" ]) {
			[resultData setObject:[attributeDict objectForKey:@"sessionid"] forKey:@"sessionId"];
			
			NSString *loginId = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginId"];
			NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
			
			if ([SystemConfig isRememberParssword]) {
				[SystemConfig addLoginUser:loginId password:password];
			}
			
		} else {
			[Debuger systemAlert:[attributeDict objectForKey:@"msg"]];
		}
	}
	
	if ([elementName isEqualToString:@"shopMaster"]) {
		isShopMaster = YES;
	}
	
	//自己的信息
	if ([elementName isEqualToString:@"user"] && deptId == nil && kindId == nil) {
		UserData *user = [UserData alloc];
		user.userId = [attributeDict objectForKey:@"id"];
		user.loginId = [attributeDict objectForKey:@"loginId"];
		user.nickname = [attributeDict objectForKey:@"nickname"];
		user.idiograph = [attributeDict objectForKey:@"idiograph"];
		[UserDataManage setSelfUserId:user.userId];
	}
	
	if ([elementName isEqualToString:@"shop"] && !isShopMaster) {
		shopId = [attributeDict objectForKey:@"id"];
	}
	
	if (([elementName isEqualToString:@"shop"] || [elementName isEqualToString:@"dept"]) && !isShopMaster) {
		
		UserListKindDataStruct *shopDept = [UserListKindDataStruct alloc];
		shopDept.dataId = [attributeDict objectForKey:@"id"];
		shopDept.kindName = [attributeDict objectForKey:@"name"];
		shopDept.parentId = [attributeDict objectForKey:@"parentId"];
		//[ChatListDataStruct addShopDept:shopDept];
		deptId = shopDept.dataId;
		
	} else if (([elementName isEqualToString:@"user"] && deptId != nil) && !isShopMaster) {
		
		UserData *user = [UserData alloc];
		user.userId = [attributeDict objectForKey:@"id"];
		user.loginId = [attributeDict objectForKey:@"loginId"];
		user.nickname = [attributeDict objectForKey:@"nickname"];
		user.idiograph = [attributeDict objectForKey:@"idiograph"];
		user.deptId = deptId;
		//[ChatListDataStruct addShopUser:user];
		
	}
	
	if ([elementName isEqualToString:@"friendKind"]) {
		
		UserListKindDataStruct *friendKind = [UserListKindDataStruct alloc];
		friendKind.dataId = [attributeDict objectForKey:@"id"];
		friendKind.kindName = [attributeDict objectForKey:@"name"];
		friendKind.parentId = [attributeDict objectForKey:@"parentId"];
		kindId = friendKind.dataId;
		
	} else if ([elementName isEqualToString:@"user"] && deptId == nil && kindId != nil) {
		
		UserData *user = [UserData alloc];
		user.userId = [attributeDict objectForKey:@"id"];
		user.loginId = [attributeDict objectForKey:@"loginId"];
		user.nickname = [attributeDict objectForKey:@"nickname"];
		user.idiograph = [attributeDict objectForKey:@"idiograph"];
		user.kindId = kindId;
	}
}


@end
