//
//  HttpUpFile.m
//  jzg
//
//  Created by apple on 14-1-15.
//  Copyright (c) 2014年 bzwzdsoft. All rights reserved.
//

#import "HttpUpFile.h"
#import "SystemVariable.h"
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
@implementation HttpUpFile

//使用这种方式时 url中不能带有?a=b等参数, 这样写参数a是会被忽略的, 一定要使用param传参
- (void)request:(NSString *)url param:(NSMutableDictionary *)param filePath:(NSString *)filePath delegate:(id)delegate usingBlock:(UpFileFinishLoadBlock) finishBlock
{
    myDelegate = delegate;
    NSURL *dataUrl = [[NSURL alloc] initWithString:url];
   __block ASIFormDataRequest  *request = [ASIFormDataRequest  requestWithURL:dataUrl];
    NSEnumerator * enumeratorKey =[param keyEnumerator];
    for (NSString *key in enumeratorKey) {
        [request setPostValue:[param objectForKey:key] forKey:key];
    }
    if (filePath !=nil) {
         [request setFile:filePath forKey:@"sendFile"];
    }
	[request setTimeOutSeconds:20];
    if (IS_GTE_IPHONE_4) {
        [request setShouldContinueWhenAppEntersBackground:YES];
    }
	[request setDelegate:delegate];
    __weak ASIFormDataRequest *blockRequest = request;
    [request setCompletionBlock:^{
        NSData *data  = [blockRequest responseData];
        finishBlock(data);
    }];
    [request setFailedBlock:^{
        finishBlock(nil);
    }];
    
	[request startAsynchronous];
}






@end
