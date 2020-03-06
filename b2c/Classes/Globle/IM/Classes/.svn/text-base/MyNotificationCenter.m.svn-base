//
//  MyNotificationCenter.m
//  IOSCim
//
//  Created by apple apple on 11-6-14.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "MyNotificationCenter.h"
#import "MyObserver.h"

@implementation MyNotificationCenter

static NSMutableDictionary *observersDict;

//添加观察者
+ (void)addObserver:(id)notificationObserver
		   selector:(SEL)notificationSelector
			   name:(MyNotificationObServerType)notificationName 
		 obServerId:(NSString*)obServerId 
{
	
	if (observersDict == nil) 
	{
		observersDict = [[NSMutableDictionary alloc] init];
	}
	
	NSString *key = [[NSString alloc] initWithFormat:@"%d", notificationName];
	
	if ([observersDict objectForKey:key] == nil) 
	{
		NSMutableDictionary *looks = [[NSMutableDictionary alloc] init];
		[observersDict setObject:looks forKey:key];
	}
	
	NSMutableDictionary *observerLooks = [observersDict objectForKey:key];
	MyObserver *myOb = [MyObserver alloc];
	myOb.myClass = notificationObserver;
	myOb.mySelector = notificationSelector;
	myOb.obServerId = obServerId;
	[observerLooks setObject:myOb forKey:obServerId];
}




//覆盖观察者
+ (void)recoveObserver:(id)notificationObserver
			  selector:(SEL)notificationSelector 
			obServerId:(NSString*)obServerId
{
	
	NSArray *observersArray = [observersDict allValues];
	
	for (NSMutableDictionary *obLookerDict in observersArray) 
	{
		MyObserver *obLooker = [obLookerDict objectForKey:obServerId];
		obLooker.myClass = notificationObserver;
		obLooker.mySelector = notificationSelector;
	}
}




//删除观察者
+ (void)removeObserver:(id)notificationObserver obServerId:(NSString*)obServerId
{
	NSArray *observersArray = [observersDict allValues];
	
	for (NSMutableDictionary *observersDict in observersArray) 
	{
		[observersDict removeObjectForKey:obServerId];
	}
}



//提交消息通知
+ (void)postNotification:(MyNotificationObServerType)notificationName setParam:(id)param 
{
	NSString *key = [[NSString alloc] initWithFormat:@"%d", notificationName];
	NSMutableDictionary *obLookerDict = [observersDict objectForKey:key];
	
	for (MyObserver *obLooker in [obLookerDict allValues]) 
	{
		[obLooker.myClass performSelector:obLooker.mySelector withObject:param];
	}
}



+ (void)clearAllObserver 
{
	[observersDict removeAllObjects];
}

@end

