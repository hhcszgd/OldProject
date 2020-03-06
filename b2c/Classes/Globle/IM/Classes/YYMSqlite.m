//
//  YYMSqlite.m
//  IOSCim
//
//  Created by apple apple on 11-8-30.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "YYMSqlite.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "YYMFilePath.h"


@implementation YYMSqlite


- (void)initParam
{
	createTableDictionary = [[NSMutableDictionary alloc] init];
	dbPath = @"";
	[self connectDB];
}



//连接数据库 创建表
- (BOOL)connectDB
{
    fullDBPath = [YYMFilePath getDocPath:dbPath];
    db = [[FMDatabase alloc] initWithPath:fullDBPath];
    
    if (![db open])
    {
        NSLog(@"SQLite数据库连接失败");
        return NO;
    }
    
    for (int i=0; i<[createTableDictionary allValues].count; i++)
    {
        if (![db executeUpdate:[[createTableDictionary allValues] objectAtIndex:i]])
        {
            NSLog(@"创建表%@", [[createTableDictionary allKeys] objectAtIndex:i]);
            return NO;
        }		
    }
    
    return YES;
}



//更新数据
- (BOOL)update:(NSString*)sql 
{

	if (![db executeUpdate:sql]) 
	{
		NSLog(@"更新表数据失败 sql: %@", sql);
		return NO;
	}
	
	return YES;
}


		
//查询数据
- (FMResultSet*)query:(NSString*)sql
{
	//NSMutableArray *chatLogArray = [[NSMutableArray alloc] init];
	FMResultSet *rs = [db executeQuery:sql];
	return rs;
}


- (void) close {
	[db close];
}

@end
