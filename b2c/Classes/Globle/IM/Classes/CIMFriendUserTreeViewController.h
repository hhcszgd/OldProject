//
//  CIMFriendUserTreeViewController.h
//  IOSCim
//
//  Created by apple apple on 11-8-16.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CIMUserTreeViewController.h"


@interface CIMFriendUserTreeViewController : CIMUserTreeViewController {
    CGRect screenRect;
    CGFloat statusBarHeight;
    CGFloat navigationBarHeight;
    UIImageView *backgroundView;
}

@end
