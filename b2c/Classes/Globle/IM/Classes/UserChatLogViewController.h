//
//  UserChatLogViewController.h
//  IOSCim
//
//  Created by fei lan on 14-9-27.
//  Copyright (c) 2014年 CIMForIOS. All rights reserved.
//

#import "CommViewController.h"
#import "TranslucentToolbar.h"

@interface UserChatLogViewController : CommViewController <UIWebViewDelegate> {
    NSMutableArray *chatLogsArray;
    NSString *chatWitherId;
    NSInteger messageType;
    UIWebView *messageWebView;
    TranslucentToolbar *toolbar;
}

@property (nonatomic, retain) NSString *chatWitherId;
@property (assign) NSInteger messageType;

@end
