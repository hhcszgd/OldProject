//
//  EditUserInfoViewController.h
//  IOSCim
//
//  Created by fei lan on 14-10-15.
//  Copyright (c) 2014年 CIMForIOS. All rights reserved.
//

#import "CommViewController.h"
#import "InsetsTextField.h"

@interface EditUserInfoViewController : CommViewController<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate> {
    InsetsTextField *textField;
    UITableView *table;
    CGRect mainRect;
}
@property (nonatomic, assign) int infoType;
@end
