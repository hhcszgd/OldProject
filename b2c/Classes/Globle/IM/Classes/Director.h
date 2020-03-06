//
//  Director.h
//  IOSCim
//
//  Created by apple apple on 11-6-1.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Director : NSObject {

}

+ (void)markCurrentViewController:(UIViewController *)viewController;
+ (NSString*)getCurrentViewController;
+ (BOOL)isCurrentViewController:(UIViewController*)viewController;
@end
