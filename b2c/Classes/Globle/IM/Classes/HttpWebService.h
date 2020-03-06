//
//  HttpWebService.h
//  IOSCim
//
//  Created by fukq helpsoft on 11-4-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HttpWebService : NSObject {

}

+ (NSData *)get:(NSString *)url param:(NSString *)param ;  

@end
