//
//  WSCallerBlock.h
//  jzg
//
//  Created by apple on 14-3-13.
//  Copyright (c) 2014年 bzwzdsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^finishLoadBlock)(NSData *);

typedef void (^finishLoadBlockAndCookies)(NSData *, NSArray*);

@interface WSCallerBlock : NSObject

- (void)call:(NSString *)url delegate:(id)delegate usingBlock:(finishLoadBlock) finishBlock;

- (void)call:(NSString *)url timeOutSeconds:(int)seconds delegate:(id)delegate usingBlock:(finishLoadBlock) finishBlock;

- (void)callPost:(NSString *)apiUrl params:(NSMutableDictionary *)params delegate:(id)delegate usingBlock:(finishLoadBlock) finishBlock;

- (void)callPost:(NSString *)apiUrl params:(NSMutableDictionary *)params delegate:(id)delegate cookies:(NSArray *)cookies usingBlock:(finishLoadBlockAndCookies) finishBlock;

@end
