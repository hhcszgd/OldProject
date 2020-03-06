//
//  SocketObserver.m
//  IOSCim
//
//  Created by apple apple on 11-5-23.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "SocketObserver.h"
#import "SocketOb.h"

@implementation SocketObserver

static NSMutableDictionary *obs;
static NSMutableArray *didLoginLookers;
static NSMutableArray *updateStatusLookers;
static NSMutableArray *recvMessageLookers;
static NSMutableArray *tipsMessageLookers;

//注册观察者
+ (void) addObserver:(id)class selector:(SEL)method obType:(SocketObServerType)obType {
	
	if (obs == nil) {
		obs = [[NSMutableDictionary alloc] init];
		didLoginLookers = [[NSMutableArray alloc] init];
		updateStatusLookers = [[NSMutableArray alloc] init];
		recvMessageLookers = [[NSMutableArray alloc] init];
		tipsMessageLookers = [[NSMutableArray alloc] init];
	}
	
	SocketOb *observer = [SocketOb alloc];
	observer.myClass = class;
	observer.method = method;
	
	switch (obType) {
		case SocketObServerTypeDidLogin:
			[didLoginLookers addObject:observer];
			break;
		case SocketObServerTypeUpdateStatus:
			[updateStatusLookers addObject:observer];
			break;
		case SocketObServerTypeRecvMessage:
			[recvMessageLookers addObject:observer];
			break;
		case SocketObServerTypeTipsMessage:
			[tipsMessageLookers addObject:observer];
			break;

		default:
			break;
	}
}

//注销观察者
+ (void) removeObserver:(id)class selector:(SEL)selector obType:(SocketObServerType)obType {
	
}

//被观察者改变 通知观察者
+ (void) update:(SocketObServerType)obType setObject:(id)object {
	NSMutableArray *obArray;
	
	switch (obType) {
		case SocketObServerTypeDidLogin:
			obArray = didLoginLookers;
			break;
		case SocketObServerTypeUpdateStatus:
			obArray = updateStatusLookers;
			break;
		case SocketObServerTypeRecvMessage:
			obArray = recvMessageLookers;
			break;
		case SocketObServerTypeTipsMessage:
			obArray = tipsMessageLookers;
			break;

		default:
			break;
	}
	
	for (SocketOb *ob in obArray) {
		[ob.myClass performSelector:ob.method withObject:object];
	}
	
}

@end
