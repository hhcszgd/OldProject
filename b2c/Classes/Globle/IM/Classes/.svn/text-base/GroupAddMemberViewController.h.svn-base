//
//  GroupAddMemberViewController.h
//  IOSCim
//
//  Created by fei lan on 14-10-23.
//  Copyright (c) 2014年 CIMForIOS. All rights reserved.
//

#import "CommViewController.h"
#import "TreeNode.h"
#import "CIMUserListDataStruct.h"

@interface GroupAddMemberViewController : CommViewController<UITableViewDataSource, UITableViewDelegate, NSXMLParserDelegate> {
    CGRect mainRect;
    UITableView *table;
    NSString *curElementName;
    NSMutableArray *users;
    NSMutableArray *groupUsers;
    TreeNode *userTree;
    CIMUserListDataStruct *cimUserListDataStruct;
    NSMutableDictionary *selectedUsers;
}
- (void)setGroupUsers:(NSMutableArray *)groupUsersc;
@end
