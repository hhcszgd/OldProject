//
//  Debuger.h
//  IOSCim
//
//  Created by apple apple on 11-5-23.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Debuger : NSObject {

}

+ (void)printNSData:(NSData*)data;
+ (void)systemAlert:(NSString *)content;
@end
