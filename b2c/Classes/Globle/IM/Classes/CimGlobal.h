//
//  CimGlobal.h
//  IOSCim
//
//  Created by apple apple on 11-8-15.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CimGlobal : NSObject {

}

+ (void)addClass:(NSObject*)class name:(NSString*)name;
+ (id)getClass:(NSString*)name;

@end
