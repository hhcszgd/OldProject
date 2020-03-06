//
//  HttpUpFile.h
//  jzg
//
//  Created by apple on 14-1-15.
//  Copyright (c) 2014年 bzwzdsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"

typedef void (^UpFileFinishLoadBlock)(NSData *);

@interface HttpUpFile : NSObject {
	id myDelegate;
    NSMutableData *receivedData;

}


- (void)request:(NSString *)url param:(NSMutableDictionary *)param filePath:(NSString *)filePath delegate:(id)delegate usingBlock:(UpFileFinishLoadBlock) finishBlock;


@end
