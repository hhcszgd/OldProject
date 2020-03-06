//
//  YYMSqlite.h
//  IOSCim
//
//  Created by apple apple on 11-8-30.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"


@interface YYMSqlite : NSObject 
{
	FMDatabase *db;
	NSMutableDictionary *createTableDictionary;
	NSString *dbPath;
	NSString *fullDBPath;
}
- (FMResultSet*)query:(NSString*)sql;
- (BOOL)update:(NSString*)sql;
- (BOOL)connectDB;
@end
