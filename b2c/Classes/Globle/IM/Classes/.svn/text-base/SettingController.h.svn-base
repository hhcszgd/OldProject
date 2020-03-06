//
//  SettingController.h
//  IOSCim
//
//  Created by apple apple on 11-6-7.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CIMUIViewController.h"


@interface SettingController : CIMUIViewController<UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate> {
	IBOutlet UIButton *exitSystem;
	NSMutableDictionary *userStatusDict;
	UITableView *myTableView;
	IBOutlet UISwitch *soundSwitch;
    UISwitch *shockSwitch;
    UISwitch *groupSwitch;
    UISwitch *guestSwitch;
	IBOutlet UITableViewCell *setSoundCell;
	UIActionSheet *actionSheet;
}

@property (nonatomic, retain) UIButton *exitSystem;
@property (nonatomic, retain) UISwitch *soundSwitch;
@property (nonatomic, retain) UITableViewCell *setSoundCell;

- (IBAction)exit:(id)sender;
- (void)chooseOnlineStatus;
- (IBAction)setSoundRemind:(id)sender;
-(void)updateData ;

@end
