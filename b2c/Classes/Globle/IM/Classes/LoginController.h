//
//  LoginController.h
//  IOSCim
//
//  Created by fukq helpsoft on 11-3-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginController : UIViewController <UITableViewDelegate,UITableViewDataSource>{
	IBOutlet UILabel *loginIdLable;
	IBOutlet UILabel *passwordLable;
	IBOutlet UILabel *statusLable;
	IBOutlet UIButton *submitButt;
	IBOutlet UIButton *exitButt;
	IBOutlet UITextField *loginIdText;
	IBOutlet UITextField *passwordText;
	IBOutlet UIButton *listLoginId;
	
	IBOutlet UITableViewCell *loginCell;
	IBOutlet UITableViewCell *passwordCell;
	IBOutlet UITableViewCell *statusCell;
}

/*
@property (nonatomic, retain) IBOutlet UILabel *loginIdLable;
@property (nonatomic, retain) IBOutlet UILabel *passwordLable;
@property (nonatomic, retain) IBOutlet UILabel *statusLable;
@property (nonatomic, retain) IBOutlet UIButton *submitButt;
@property (nonatomic, retain) IBOutlet UIButton *exitButt;
@property (nonatomic, retain) IBOutlet UIButton *listLoginId;
@property (nonatomic, retain) IBOutlet UITextField *loginIdText;
@property (nonatomic, retain) IBOutlet UITextField *passwordText;

@property (nonatomic, retain) IBOutlet UITableViewCell *loginCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *passwordCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *statusCell;
 */

- (IBAction)login:(id)sender;
- (IBAction)listLoginId:(id)sender;
- (IBAction)textFieldDoneEditing:(id)sender;
@end
