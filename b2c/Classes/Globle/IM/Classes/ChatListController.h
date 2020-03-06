//
//  ChatListController.h
//  IOSCim
//
//  Created by fukq helpsoft on 11-3-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ChatListController : UIViewController {
	IBOutlet UIButton *user;
}

@property(nonatomic, retain) IBOutlet UIButton *user;

- (IBAction)openChat:(id)sender; 
@end
