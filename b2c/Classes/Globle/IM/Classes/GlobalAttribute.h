//
//  GlobalAttribute.h
//  IOSCim
//
//  Created by apple apple on 11-9-6.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GlobalAttribute : NSObject {

}
+ (void)setIsLogined:(BOOL)value;
+ (BOOL)getIsLogined;
+ (void)logout;
@end
