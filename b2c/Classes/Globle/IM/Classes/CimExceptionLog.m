//
//  CimExceptionLog.m
//  IOSCim
//
//  Created by apple apple on 13-3-6.
//  Copyright (c) 2013年 CIMForIOS. All rights reserved.
//

#import "CimExceptionLog.h"

@implementation CimExceptionLog


- (void)initLog {
    // 获取当前应用的Documents下目录，
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];

    // 在Documents下面创建一个log目录，
    NSFileManager *fileManage = [NSFileManager defaultManager];
    NSString *logDirectory = [documentsDirectory stringByAppendingPathComponent:@"log"];
    if (![fileManage fileExistsAtPath:logDirectory]) {
        [fileManage createDirectoryAtPath:logDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    // 有旧日志文件就移动
    logFileName = [logDirectory stringByAppendingPathComponent:@"log.txt"];
    if ([fileManage fileExistsAtPath:logFileName]) {
        NSString *oldLogFile = [logDirectory stringByAppendingPathComponent:@"log1.txt"];
        
        [fileManage removeItemAtPath:oldLogFile error:nil];
        [fileManage moveItemAtPath:logFileName toPath:oldLogFile error:nil];
    }
}

- (void)log:(NSException *)exception {
    NSFileHandle *logFile = [NSFileHandle fileHandleForWritingAtPath:logFileName];
    if (logFile != nil) {
        NSString *s = [[NSString alloc] initWithFormat: @"CRASH: %@\nStack Trace: %@", exception, [exception callStackSymbols]];
        [logFile writeData:[s dataUsingEncoding: NSNEXTSTEPStringEncoding]];
        [logFile closeFile];
#ifdef DEBUG
        NSLog(@"%@", s);
#endif
    }
}

@end
