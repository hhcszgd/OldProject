//
//  SearchFriendViewController.h
//  IOSCim
//
//  Created by fei lan on 14-9-28.
//  Copyright (c) 2014年 CIMForIOS. All rights reserved.
//

#import "CommViewController.h"
#import "UserData.h"
#import "CIMFriendListDataStruct.h"
#import "GetUserWithLoginIdHttp.h"

@interface SearchFriendViewController : CommViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate> {
    UITableView *myTableView;
    UserData *searchResult;
    NSString *promptMessage;
    BOOL isRequestData;
    BOOL isNoticeAddFriend;
    CIMFriendListDataStruct *cimFriendListDataStruct;
    
    CGRect screenRect;
    CGFloat statusBarHeight;
    CGFloat navigationBarHeight;
    UIImageView *backgroundView;
    UISearchBar *mySearchBar;
    UISearchDisplayController *searchDisplayController;
    GetUserWithLoginIdHttp *userHttp;
}

@end
