//
//  MyUserInfoViewController.h
//  IOSCim
//
//  Created by fei lan on 14-10-14.
//  Copyright (c) 2014年 CIMForIOS. All rights reserved.
//

#import "CommViewController.h"

@interface MyUserInfoViewController : CommViewController<UITableViewDataSource, UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate> {
    UITableView *table;
    CGRect mainRect;
    UIImageView *headView;
    UIActionSheet *sheet;
}

@end
