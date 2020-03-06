//
//  AddGroupViewController.h
//  IOSCim
//
//  Created by fei lan on 14-10-15.
//  Copyright (c) 2014年 CIMForIOS. All rights reserved.
//

#import "CommViewController.h"

@interface AddGroupViewController : CommViewController<UITextFieldDelegate, UITextViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate> {
    CGRect mainRect;
    UITextField *groupNameField;
    UILabel *groupTypeLabel;
    UIPickerView *groupTypePicker;
    NSMutableArray *groupTypes;
    UITextView *noteView;
}

@end
