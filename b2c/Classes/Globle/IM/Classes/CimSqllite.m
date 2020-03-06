//
//  CimSqllite.m
//  IOSCim
//
//  Created by apple apple on 11-6-21.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "CimSqllite.h"

#import "SQLiteInstanceManager.h"
#import "SQLitePersistentObject.h"
#import "YYMSqlite.h"
#import <sqlite3.h>

@implementation CimSqllite
static sqlite3 *database;

//根据用户名创建表
+ (instancetype) initdata: (NSString *)loginId{
	if (sqlite3_open([[CimSqllite dataFilePath] UTF8String], &database)!=SQLITE_OK) {
		sqlite3_close(database);
		NSAssert(0,@"Failed to open database");			
	}
	char *errorMsg;
	//创建表
	NSString *createSQL = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' (SEND_ID VARCHAR(20),RECEIVE_ID VARCHAR(20),CONTENT TEXT,TIME VARCHAR(20),MESSAGETYPE INTEGER);",loginId];
	//如果相同名称的表存在 该命令平静退出 不执行任何操作
	if (sqlite3_exec(database, [createSQL UTF8String], NULL, NULL, &errorMsg)!=SQLITE_OK) {		
		sqlite3_close(database);
		NSAssert1(0,@"Error creating tables:%s",errorMsg);			
	}
	
	if(sqlite3_exec(database, [createSQL UTF8String], NULL, NULL, &errorMsg) ==SQLITE_OK){
		NSLog(@"创建表成功！");
	}
    return [NSObject class] ;
}
//添加记录
-(void) addMessage:(NSString *)sendId :
		 receiveId:(NSString *)receiveId:
		   content:(NSString *)content:
			  time:(NSString *)time:
			  type:(NSInteger *)type {	
	//把文本字段的值插入到数据库 或者更新行号匹配现有的行
	NSString *update = [NSString stringWithFormat:@"INSERT OR REPLACE INTO '%@' (SEND_ID,RECEIVE_ID,CONTENT,TIME,MESSAGETYPE) VALUES('%@','%@','%@','%@',%d);",sendId,sendId,receiveId,content,time,type];
	char *errorMsg;
	//使用断言
	if (sqlite3_exec(database, [update UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {		
		NSAssert1(0,@"Error updating tables:%s",errorMsg);
		sqlite3_free(errorMsg);		
	}else{
		NSLog(@"添加记录成功！");
	}	
}

-(NSMutableArray *)getmessage:(NSString *)sendId:
					receiveId:(NSString *)receiveId:
						 type:(NSInteger *) type{
	
	NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];	
	NSString *query = [NSString stringWithFormat:@"SELECT SEND_ID,RECEIVE_ID,CONTENT,TIME FROM '%@' WHERE MESSAGETYPE = %d;",sendId,type];	
	
	sqlite3_stmt *statement;//用于编译好sql语句
	
	if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
		
		while (sqlite3_step(statement) == SQLITE_ROW) {			
			char *rowData1 = (char *)sqlite3_column_text(statement, 0);			
			NSString *first = [[NSString alloc] initWithUTF8String:rowData1];			
			char *rowData2 = (char *)sqlite3_column_text(statement, 1);
			NSString *second = [[NSString alloc] initWithUTF8String:rowData2];						
			char *rowData3 = (char *)sqlite3_column_text(statement, 2);
			NSString *third = [[NSString alloc] initWithUTF8String:rowData3];			
			char *rowData4 = (char *)sqlite3_column_text(statement, 3);			
			NSString *four = [[NSString alloc] initWithUTF8String:rowData4];
			
			if([sendId isEqualToString:first]&&[receiveId isEqualToString:second]){		
				
				
				[array addObject:[NSDictionary dictionaryWithObjectsAndKeys:
								  first,@"sendId",
								  second,@"receiveId",
								  third,@"content",
								  four,@"time",nil]];
				NSLog(@"查询开始");
			}
			
		}
		
		sqlite3_finalize(statement);
	}
	
	return array;
}


-(void) closeDb {
	sqlite3_close(database);
}

//用于检索手机上的存储的数据库文件
+(NSString *)dataFilePath{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(//c函数来查找各种目录，它是foundation函数 因此可以共享
														 //NSDocumentDirectory表示正在查找Documents文件夹 NSUserDomainMask表明我们希望将搜索限制于我们的应用程序沙盒中
														 NSDocumentDirectory, NSUserDomainMask, YES);
	//每一个应用程序只有一个Documents目录 
	NSString *documentsDirectorty = [paths objectAtIndex:0];
	//通过检索的路径附加一个字符串来创建一个文件名 用于执行读取和写入操作	
	return [documentsDirectorty stringByAppendingPathComponent:[[NSDate date] description]];
	
}


@end
