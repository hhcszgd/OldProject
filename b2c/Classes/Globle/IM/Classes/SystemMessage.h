//
//  SystemMessage.h
//  IOSCim
//
//  Created by apple apple on 11-8-5.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommViewController.h"

@interface SystemMessage : CommViewController {
	IBOutlet UILabel *messageContent;
	NSString *content;
}

@property (retain, nonatomic) IBOutlet UIImageView *msgImg;
@property (nonatomic, retain) IBOutlet UILabel *messageContent;
@property (nonatomic, retain) NSString *content;

@end
