//
//  WSCallerBlock.m
//  jzg
//
//  Created by apple on 14-3-13.
//  Copyright (c) 2014年 bzwzdsoft. All rights reserved.
//

#import "WSCallerBlock.h"
#import "ASIFormDataRequest.h"
#import "SystemVariable.h"

#pragma clang diagnostic ignored "-Warc-retain-cycles"

@implementation WSCallerBlock


- (void)call:(NSString *)url delegate:(id)delegate usingBlock:(finishLoadBlock) finishBlock
{
    
    NSURL *dataUrl = [[NSURL alloc] initWithString:url];
    
    __block ASIFormDataRequest  *request = [ASIFormDataRequest  requestWithURL:dataUrl];
    
    [request setTimeOutSeconds:20];
    if (IS_GTE_IPHONE_4) {
        [request setShouldContinueWhenAppEntersBackground:YES];
    }
    [request setStringEncoding:NSUTF8StringEncoding];
	[request setDelegate:delegate];
    
    [request setCompletionBlock:^{
        NSData *data  = [request responseData];
        finishBlock(data);
    }];
    [request setFailedBlock:^{
        
        finishBlock(nil);
    }];
    
	[request startAsynchronous];
    
}

- (void)call:(NSString *)url timeOutSeconds:(int)seconds delegate:(id)delegate usingBlock:(finishLoadBlock) finishBlock
{
    NSURL *dataUrl = [[NSURL alloc] initWithString:url];
    __block ASIFormDataRequest  *request = [ASIFormDataRequest  requestWithURL:dataUrl];
    if (seconds == 0) {
        seconds = 20;
    }
    [request setTimeOutSeconds:seconds];
    //
    if (IS_GTE_IPHONE_4) {
        [request setShouldContinueWhenAppEntersBackground:YES];
    }
	[request setDelegate:delegate];
    [request setCompletionBlock:^{
        NSData *data  = [request responseData];
        finishBlock(data);
    }];
    [request setFailedBlock:^{
        
        finishBlock(nil);
    }];
    
	[request startAsynchronous];
    
}



- (void)callPost:(NSString *)apiUrl params:(NSMutableDictionary *)params delegate:(id)delegate usingBlock:(finishLoadBlock) finishBlock
{
    
    NSURL *dataUrl = [[NSURL alloc] initWithString:apiUrl];
    __block ASIFormDataRequest  *request = [ASIFormDataRequest requestWithURL:dataUrl];
    NSEnumerator * enumeratorKey =[params keyEnumerator];
    for (NSString *key in enumeratorKey) {
        [request setPostValue:[params objectForKey:key] forKey:key];
    }
	[request setTimeOutSeconds:20];
    //
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
    [request setShouldContinueWhenAppEntersBackground:YES];
#endif
	[request setDelegate:delegate];
    [request setCompletionBlock:^{
        NSData *data  = [request responseData];
        finishBlock(data);
    }];
    [request setFailedBlock:^{
        finishBlock(nil);
    }];
	[request startAsynchronous];
}

- (void)callPost:(NSString *)apiUrl params:(NSMutableDictionary *)params delegate:(id)delegate cookies:(NSArray *)cookies usingBlock:(finishLoadBlockAndCookies) finishBlock {
    NSURL *dataUrl = [[NSURL alloc] initWithString:apiUrl];
    __block ASIFormDataRequest  *request = [ASIFormDataRequest requestWithURL:dataUrl];
    NSEnumerator * enumeratorKey =[params keyEnumerator];
    for (NSString *key in enumeratorKey) {
        [request setPostValue:[params objectForKey:key] forKey:key];
    }
	[request setTimeOutSeconds:20];
    //
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
    [request setShouldContinueWhenAppEntersBackground:YES];
#endif
    if (cookies) {
        [request setRequestCookies:[[NSMutableArray alloc] initWithArray:cookies]];
    }
	[request setDelegate:delegate];
    [request setCompletionBlock:^{
        NSData *data  = [request responseData];
        finishBlock(data, [request responseCookies]);
    }];
    [request setFailedBlock:^{
        finishBlock(nil, nil);
    }];
	[request startAsynchronous];
}



@end
