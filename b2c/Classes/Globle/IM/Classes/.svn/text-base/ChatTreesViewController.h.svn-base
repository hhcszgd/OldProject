//
//  ChatTreesViewController.h
//  IOSCim
//
//  Created by fei lan on 14-9-25.
//  Copyright (c) 2014年 CIMForIOS. All rights reserved.
//

#import "CommViewController.h"
#import "TreeNode.h"
#import "ChatUserStruct.h"

@interface ChatTreesViewController : CommViewController<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate> {
    TreeNode* tree;
    NSMutableArray* nodes;
    NSMutableArray *usersId;
    int totalHoldReadMessageNumber;
    int rowsNumber;
    NSMutableArray *usersIdArray; //会话列表用户数组
    UITableView *myTableView;
    UITableView *table;
    UIAlertView *clearAlertView;
}

//未读消息提醒
- (void)addMessageTips:(ChatUserStruct*)chatUser;

//更新会话列表
- (void)updateChatListUser:(ChatUserStruct*)chatUser;

- (void)clearMessageTips:(id)sender;


@end
