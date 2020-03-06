//
//  CIMUserTreeViewController.m
//  IOSCim
//
//  Created by apple apple on 11-8-16.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "CIMUserTreeViewController.h"
#import "CimGlobal.h"
#import "MyNotificationCenter.h"
#import "UserChatViewController.h"
#import "ChatUserStruct.h"
#import "UserListKindDataStruct.h"
#import "TreeKindCell.h"
#import "ChatTreesViewCell.h"
#import "CIMSearchTableViewController.h"
#import "CimGlobal.h"
#import "CIMSocketLogicExt.h"
#import "SetGroupUserHttp.h"
#import "SetGroupHttp.h"
#import "GroupDataManage.h"
#import "SystemVariable.h"
#import "ErrorParam.h"
#import "Debuger.h"
#import "Tool.h"
#import "SystemConfig.h"
#import "WebViewController.h"
#import "AddFriendHttp.h"
#import "AddGroupViewController.h"
#import "Config.h"
#import "ChatListDataStruct.h"
#import "OPChatLogData.h"
#import "CIMFriendListDataStruct.h"

@implementation CIMUserTreeViewController {
    NSString *optGroupId;
    NSIndexPath *delIndexPath;
}

@synthesize searchTableView, mySearchBar, tableShowType;


//窗口刷新时调用
- (void)viewWillAppear:(BOOL)animated 
{
    [super viewWillAppear:animated];
	[self.navigationController setNavigationBarHidden:NO];
	//[self.parentViewController.navigationController setNavigationBarHidden:YES];
	self.title = windowTitle;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (searchDisplayController.isActive) {
        [searchDisplayController setActive:NO animated:NO];
    }
}

//构建企业树形节点
- (BOOL)buildKindShop:(UserListKindDataStruct*)shopKind  {
    
    //过滤空分组
    if ([shopKind getUsers] == nil && isFilterEmptyKind) {
        //return YES;
    }
    
    //树形节点
    TreeNode* treeKind = [[TreeNode alloc] init];
    treeKind.title = shopKind.kindName;
    treeKind.key = shopKind.dataId;
    treeKind.nodeType = @"kind";
    [shopNodesDictionary setObject:treeKind forKey:shopKind.dataId];
    [shopTree addChild:treeKind];
    
    //分组中的用户
    NSMutableArray *kindUsers = [[shopKind getUsers] mutableCopy];
    for (UserData *kindUser in kindUsers)
    {
        TreeNode *userNode = [[TreeNode alloc] init];
        userNode.title = [kindUser getUserName];
        userNode.key = [@"kinduser" stringByAppendingString:kindUser.userId];
        userNode.nodeType = @"node";
        userNode.info = kindUser.idiograph;
        userNode.param = kindUser.userId;
        [treeKind addChild:userNode];
    }
    
    return YES;
}

//构建好友树形节点
- (BOOL)buildKindUser:(UserListKindDataStruct*)userKind
{
	//过滤空分组
	if ([userKind getUsers] == nil && isFilterEmptyKind) 
	{
		return true;
	}
	
	//树形节点
	TreeNode* treeKind = [[TreeNode alloc] init];
	treeKind.title = [userKind getKindName];
	treeKind.key = userKind.dataId;
	treeKind.nodeType = @"kind";
	[userNodesDictionary setObject:treeKind forKey:userKind.dataId];
	[userTree addChild:treeKind];
	
	//分组中的用户
	NSMutableArray *kindUsers = [[userKind getUsers] mutableCopy];
	
	for (UserData *kindUser in kindUsers) 
	{
		TreeNode *userNode = [[TreeNode alloc] init];
		userNode.title = [kindUser getUserName];
		userNode.key = [@"kinduser" stringByAppendingString:kindUser.userId];
		userNode.nodeType = @"node";
		userNode.info = kindUser.idiograph;
		userNode.param = kindUser.userId;
		[treeKind addChild:userNode];
	}
	
	return YES;
}

//构建群树形节点
- (BOOL)buildKindGroup
{
    //过滤空分组
    if ([[GroupDataManage getMyGroups] count] <= 0) {
        //return YES;
    }
    
    //树形节点
    TreeNode* treeKind = [[TreeNode alloc] init];
    treeKind.title = @"群";
    treeKind.key = @"-999";
    treeKind.nodeType = @"kind";
    [groupNodesDictionary setObject:treeKind forKey:@"-999"];
    [groupTree addChild:treeKind];
    
    //分组中的用户
    NSMutableArray *myGroups = [GroupDataManage getMyGroups];
    
    for (GroupStruct *groupStruct in myGroups)
    {
        TreeNode *groupNode = [[TreeNode alloc] init];
        groupNode.title = groupStruct.groupName;
        groupNode.key = [@"group" stringByAppendingString:groupStruct.groupId];
        groupNode.nodeType = @"node";
        groupNode.param = groupStruct.groupId;
        [treeKind addChild:groupNode];
    }
    
    return YES;
}
//构建访客树形节点
- (BOOL)buildKindGuest:(UserListKindDataStruct*)guestKind  {
    
    //过滤空分组
    if ([guestKind getUsers] == nil && isFilterEmptyKind) {
        //return YES;
    }
    
    //树形节点
    TreeNode* treeKind = [[TreeNode alloc] init];
    treeKind.title = guestKind.kindName;
    treeKind.key = guestKind.dataId;
    treeKind.nodeType = @"kind";
    [guestNodesDictionary setObject:treeKind forKey:guestKind.dataId];
    [guestTree addChild:treeKind];
    
    //分组中的用户
    NSMutableArray *kindUsers = [[guestKind getUsers] mutableCopy];
    for (UserData *kindUser in kindUsers)
    {
        TreeNode *userNode = [[TreeNode alloc] init];
        userNode.title = [kindUser getUserName];
        userNode.key = [@"kinduser" stringByAppendingString:kindUser.userId];
        userNode.nodeType = @"node";
        userNode.info = kindUser.idiograph;
        userNode.param = kindUser.userId;
        [treeKind addChild:userNode];
    }
    
    return YES;
}

//更新用户状态
- (void)updateTreeUserStatus 
{
	//获取所有的分组树形节点
	NSMutableArray *treeNodesArray = [[userNodesDictionary allValues] mutableCopy];
    [treeNodesArray addObjectsFromArray:[[groupNodesDictionary allValues] mutableCopy]];
    [treeNodesArray addObjectsFromArray:[[guestNodesDictionary allValues] mutableCopy]];
    
	for (TreeNode *kindNode in treeNodesArray) 
	{
		//清除原有的用户节点 添加新顺序的节点
		[kindNode clearChilds];
        
        //获取分组数据
        if ([kindNode.key isEqualToString:@"-999"]) {
            //群列表
            NSMutableArray *myGroups = [GroupDataManage getMyGroups];
            for (GroupStruct *groupStruct in myGroups)
            {
                TreeNode *groupNode = [[TreeNode alloc] init];
                groupNode.title = groupStruct.groupName;
                groupNode.key = [@"group" stringByAppendingString:groupStruct.groupId];
                groupNode.nodeType = @"node";
                groupNode.param = groupStruct.groupId;
                [kindNode addChild:groupNode];
            }
        } else {
            //好友列表
            UserListKindDataStruct *kind = [cimUserListDataStruct getListKind:kindNode.key];
            NSMutableArray *kindUsers = [[kind getUsers] mutableCopy];
            for (UserData *kindUser in kindUsers)
            {
                TreeNode *userNode = [[TreeNode alloc] init];
                userNode.title = [kindUser getUserName];
                userNode.key = [@"kinduser" stringByAppendingString:kindUser.userId];
                userNode.nodeType = @"node";
                userNode.info = kindUser.idiograph;
                userNode.param = kindUser.userId;
                [kindNode addChild:userNode];
            }
            
            //访客列表
            UserListKindDataStruct *guestKind = [cimGuestListDataStruct getListKind:kindNode.key];
            NSMutableArray *guestKindUsers = [[guestKind getUsers] mutableCopy];
            for (UserData *kindUser in guestKindUsers) {
                TreeNode *userNode = [[TreeNode alloc] init];
                userNode.title = [kindUser getUserName];
                userNode.key = [@"kinduser" stringByAppendingString:kindUser.userId];
                userNode.nodeType = @"node";
                userNode.info = kindUser.idiograph;
                userNode.param = kindUser.userId;
                [kindNode addChild:userNode];
            }
        }
	}
}

//构建数据结构
- (void)buildData 
{
	if (userTree == nil) {
		userTree = [[TreeNode alloc] init];
		userTree.expanded = YES;
		userTree.isRoot = YES;
		userTree.title = windowTitle;
	}
    if (groupTree == nil) {
        groupTree = [[TreeNode alloc] init];
        groupTree.expanded = YES;
        groupTree.isRoot = YES;
        groupTree.title = windowTitle;
    }
    if (shopTree == nil) {
        shopTree = [[TreeNode alloc] init];
        shopTree.expanded = YES;
        shopTree.isRoot = YES;
        shopTree.title = windowTitle;
    }
    if (guestTree == nil) {
        guestTree = [[TreeNode alloc] init];
        guestTree.expanded = YES;
        guestTree.isRoot = YES;
        guestTree.title = windowTitle;
    }
	
	if (userNodes == nil) {
		userNodes = [[NSMutableArray alloc] init];
		userNodesDictionary = [[NSMutableDictionary alloc] init];
	}
    if (groupNodes == nil) {
        groupNodes = [[NSMutableArray alloc] init];
        groupNodesDictionary = [[NSMutableDictionary alloc] init];
        //树形节点
        TreeNode* treeKind = [[TreeNode alloc] init];
        treeKind.title = @"添加群";
        treeKind.key = @"-998";
        treeKind.nodeType = @"addGroup";
        [groupNodesDictionary setObject:treeKind forKey:@"-998"];
        [groupTree addChild:treeKind];
    }
    if (shopNodes == nil) {
        shopNodes = [[NSMutableArray alloc] init];
        shopNodesDictionary = [[NSMutableDictionary alloc] init];
    }
    if (guestNodes == nil) {
        guestNodes = [[NSMutableArray alloc] init];
        guestNodesDictionary = [[NSMutableDictionary alloc] init];
    }
	
	NSMutableArray *kinds = [cimUserListDataStruct getListKinds];
	for (UserListKindDataStruct *kind in kinds) {
		[self buildKindUser:kind];
	}
    
    NSMutableArray *shopKinds = [cimShopListDataStruct getListKinds];
    for (UserListKindDataStruct *kind in shopKinds) {
        [self buildKindShop:kind];
    }
    
    NSMutableArray *gusetKinds = [cimGuestListDataStruct getListKinds];
    for (UserListKindDataStruct *kind in gusetKinds) {
        [self buildKindGuest:kind];
    }
    
    [self buildKindGroup];
	
	//将要显示的节点装载到数组中
	[TreeNode getNodes:userTree :userNodes];
    [TreeNode getNodes:groupTree :groupNodes];
    [TreeNode getNodes:shopTree :shopNodes];
    [TreeNode getNodes:guestTree :guestNodes];
}

//加载后初始化参数
- (void)loadInit 
{
	[self initLoad];
	[self buildData];
	
	//1秒后刷新列表 更新状态
	[NSTimer scheduledTimerWithTimeInterval:1.0
									 target:self
								   selector:@selector(updateUserStatus:)
								   userInfo:nil
									repeats:NO];
	
	//在通知中心注册 状态变动时刷新用户列表
	[MyNotificationCenter addObserver:self selector:@selector(updateUserStatus:) 
								 name:SocketUpdateStatus
						   obServerId:[NSString stringWithFormat:@"%@_updateUserStatus", className]];
	
	CIMSocketLogicExt *cimSocketLogicExt = (CIMSocketLogicExt *)[CimGlobal getClass:@"CIMSocketLogicExt"];
	//请求状态
	[cimSocketLogicExt queryStatusForUsers:[cimUserListDataStruct getListUsersId]];
    
	/*CIMSearchTableViewController *cimSearchTableViewController = [CIMSearchTableViewController alloc];
	cimSearchTableViewController.listDataStruct = cimUserListDataStruct;
	cimSearchTableViewController.listObject = self;
	searchTableView.delegate = cimSearchTableViewController;
	searchTableView.dataSource = cimSearchTableViewController;
	mySearchBar.delegate = cimSearchTableViewController;*/
}

//加载完成回调
- (void)viewDidLoad 
{
    [super viewDidLoad];
	cimUserListDataStruct = (CIMUserListDataStruct *)[CimGlobal getClass:@"CIMShopListDataStruct"];
    cimShopListDataStruct = [CimGlobal getClass:@"CIMShopListDataStruct"];
    cimGuestListDataStruct = [CimGlobal getClass:@"CIMGuestListDataStruct"];
	windowTitle = @"列表";
	className = @"userlist";
	lookInfoSelector = @selector(lookShopUserInfo:);
	isFilterEmptyKind = YES;
	//[self loadInit];
}

//接收到状态消息后 更新用户树形列表
- (void)updateUserStatus:(id)sender 
{
	if (self.isViewLoaded) 
	{
		[self updateTreeUserStatus];
		[treeTableView reloadData];
	}
}


#pragma mark - UISearchBarDelegate委托协议

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
    if (IS_GTE_IOS7) {
        
    } else {
        //隐藏导航条
        CGRect screenRect = [Tool screenRect];
        CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        CGRect mySearchBarFrame = searchBar.frame;
        mySearchBarFrame.origin.y = 0;
        CGRect treeTableViewFrame = treeTableView.frame;
        treeTableViewFrame.origin.y = mySearchBarFrame.origin.y + mySearchBarFrame.size.height;
        treeTableViewFrame.size.height = screenRect.size.height - (statusBarHeight + mySearchBarFrame.size.height + self.tabBarController.tabBar.frame.size.height + 5);
        [UIView animateWithDuration:0.3 delay:0 options:0 animations:^{
            searchBar.frame = mySearchBarFrame;
            treeTableView.frame = treeTableViewFrame;
        } completion:^(BOOL finished) {
            [self.navigationController setNavigationBarHidden:YES animated:NO];
        }];
    }
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar setText:@""];
    if (IS_GTE_IOS7) {
        
    } else {
        //显示导航条
        CGRect screenRect = [Tool screenRect];
        CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        CGFloat navigationBarHeight = self.navigationController.navigationBar.bounds.size.height;
        CGRect mySearchBarFrame = searchBar.frame;
        mySearchBarFrame.origin.y = 44;
        CGRect treeTableViewFrame = treeTableView.frame;
        treeTableViewFrame.origin.y = mySearchBarFrame.origin.y + mySearchBarFrame.size.height;
        treeTableViewFrame.size.height = screenRect.size.height - (statusBarHeight + navigationBarHeight + mySearchBarFrame.size.height + self.tabBarController.tabBar.frame.size.height + 5);
        [UIView animateWithDuration:0.3 delay:0 options:0 animations:^{
            searchBar.frame = mySearchBarFrame;
            treeTableView.frame = treeTableViewFrame;
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:NO animated:YES];
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
}


#pragma mark - UISearchDisplayDelegate委托协议

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
   /* if (!searchNodesArray) {
        searchNodesArray = [[NSMutableArray alloc] init];
    } else {
        [searchNodesArray removeAllObjects];
    }
    if (!searchString) {
        return YES;
    }
    searchString = [[searchString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] lowercaseString];
    if ([searchString length] == 0) {
        return YES;
    }
    for (TreeNode *node in nodes) {
        if ([node.nodeType isEqualToString:@"kind"]) {
            for (TreeNode *childNode in node.children) {
                if ([childNode.title rangeOfString:searchString].length > 0 ) {
                    [searchNodesArray addObject:childNode];
                }
            }
        }
    }*/
    return YES;
}

- (void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView {
    treeTableView.hidden = YES;
    tableView.layer.opacity = 0.8;
}

- (void)searchDisplayController:(UISearchDisplayController *)controller willHideSearchResultsTableView:(UITableView *)tableView {
    treeTableView.hidden = NO;
}


#pragma mark - UITableViewDelegate委托协议

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
	return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    //搜索结果表格
    if (tableView == searchDisplayController.searchResultsTableView) {
        return [searchNodesArray count];
    }
    //常规表格
    if (tableShowType == Company) {
        return [shopNodes count];
    } else if (tableShowType == User) {
        return [userNodes count];
    } else if (tableShowType == Group) {
        return [groupNodes count];
    } else if (tableShowType ==Guest) {
        return [guestNodes count];
    }
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString* kindCellId = @"kindCell"; 
	static NSString* cellid = @"cell";
    static NSString *defaultCellId = @"defaultCell";
	
	TreeKindCell *kindCell = (TreeKindCell*)[tableView dequeueReusableCellWithIdentifier:kindCellId];
	ChatTreesViewCell *cell = (ChatTreesViewCell*)[tableView dequeueReusableCellWithIdentifier:cellid];
    UITableViewCell *defaultCell = [tableView dequeueReusableCellWithIdentifier:defaultCellId];
    
    //搜索结果表格
    if (tableView == searchDisplayController.searchResultsTableView) {
        if (cell == nil) {
            cell = [[ChatTreesViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                             reuseIdentifier:cellid] ;
        }
        TreeNode *node = [searchNodesArray objectAtIndex:indexPath.row];
        if ([node.key rangeOfString:@"group"].location != NSNotFound) {
            GroupStruct *group = [GroupDataManage getGroup:node.param];
            [cell initGroupStruct:group];
        } else if ([node.key rangeOfString:@"kinduser"].location != NSNotFound) {
            UserData *user = [UserDataManage getUser:node.param];
            [cell initUserData:user];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        return cell;
    }
	
    //常规表格
    TreeNode *node = nil;
    if (tableShowType == Company) {
        node = [shopNodes objectAtIndex:indexPath.row];
    } else if (tableShowType == User) {
        node = [userNodes objectAtIndex:indexPath.row];
    } else if (tableShowType == Group) {
        node = [groupNodes objectAtIndex:indexPath.row];
    } else if (tableShowType == Guest) {
        node = [guestNodes objectAtIndex:indexPath.row];
    }
	
    if ([node.nodeType isEqualToString:@"addGroup"]) {
        if (defaultCell == nil) {
            defaultCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:defaultCellId] ;
            defaultCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        defaultCell.textLabel.text = @"添加群";
        return defaultCell;
    } else if ([node.nodeType isEqualToString:@"kind"]) {
		if (kindCell == nil) {
			kindCell = [[TreeKindCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                            reuseIdentifier:kindCellId];
		}
		
		[kindCell setOwner:self];
		[kindCell setOnExpand:@selector(onExpand:)];
        if ([node.key isEqualToString:@"-999"]) {
            //群
            [kindCell setTreeNode:node onlineCount:[[GroupDataManage getMyGroups] count] totalCount:[[GroupDataManage getMyGroups] count]];
        } else if (tableShowType == Company) {
            //企业
            UserListKindDataStruct *kind = [cimShopListDataStruct getListKind:node.key];
            [kindCell setTreeNode:node onlineCount:[kind getOnlineUserCount] totalCount:[kind getTotalUserCount]];
        } else if (tableShowType == Guest) {
            UserListKindDataStruct *kind = [cimGuestListDataStruct getListKind:node.key];
            [kindCell setTreeNode:node onlineCount:[kind getOnlineUserCount] totalCount:[kind getTotalUserCount]];
        } else {
            //好友
            UserListKindDataStruct *kind = [cimUserListDataStruct getListKind:node.key];
            [kindCell setTreeNode:node onlineCount:[kind getOnlineUserCount] totalCount:[kind getTotalUserCount]];
        }
        kindCell.tag = indexPath.row;
		kindCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [kindCell addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openExpandByEditMode:)]];
		return kindCell;
		
	} 
	else 
	{
		if (cell == nil) 
		{
			cell = [[ChatTreesViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                             reuseIdentifier:cellid] ;
		}
        
        if (tableShowType == Company) {
            UserData *user = [UserDataManage getUser:node.param];
            [cell initUserData:user];
            for (UIView *subView in cell.contentView.subviews) {
                if (subView.tag == -1) {
                    subView.tag = indexPath.row;
                    [subView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headClick:)]];
                }
            }
        } else if (tableShowType == User) {
            UserData *user = [UserDataManage getUser:node.param];
            [cell initUserData:user];
            for (UIView *subView in cell.contentView.subviews) {
                if (subView.tag == -1) {
                    subView.tag = indexPath.row;
                    [subView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headClick:)]];
                }
            }
        } else if (tableShowType == Group) {
            GroupStruct *group = [GroupDataManage getGroup:node.param];
            [cell initGroupStruct:group];
        } else if (tableShowType == Guest) {
            UserData *user = [UserDataManage getUser:node.param];
            [cell initUserData:user];
            for (UIView *subView in cell.contentView.subviews) {
                if (subView.tag == -1) {
                    subView.tag = indexPath.row;
                    [subView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headClick:)]];
                }
            }
        }
        /*
        if (indexPath.row < [nodes count] - [[GroupDataManage getMyGroups] count] - 1) {
            //好友
            UserData *user = [UserDataManage getUser:node.param];
            [cell initUserData:user];
            for (UIView *subView in cell.contentView.subviews) {
                if (subView.tag == -1) {
                    subView.tag = indexPath.row;
                    [subView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headClick:)]];
                }
            }
        } else {
            //群
            GroupStruct *group = [GroupDataManage getGroup:node.param];
            [cell initGroupStruct:group];
        }*/
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        
		/*UIButton *assessoryButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
		[assessoryButton setTitle:user.userId forState:UIControlStateNormal];
		[assessoryButton addTarget:self
							action:lookInfoSelector
				  forControlEvents:UIControlEventTouchUpInside];
		cell.accessoryView = assessoryButton;
        */
		return cell;
	}
}
//头像点击事件
- (void)headClick:(UITapGestureRecognizer *)tap {
    int tag = tap.view.tag;
    TreeNode *node = nil;
    if (tableShowType == Company) {
        node = [shopNodes objectAtIndex:tag];
    } else if (tableShowType == User) {
        node = [userNodes objectAtIndex:tag];
    } else if (tableShowType == Group) {
        node = [groupNodes objectAtIndex:tag];
    } else if (tableShowType == Guest) {
        node = [guestNodes objectAtIndex:tag];
    }
    UserData *user = [UserDataManage getUser:node.param];
    NSMutableDictionary *loginData = [SystemConfig getLassLoginData];
    WebViewController *wvc = [[WebViewController alloc] init];
    wvc.hideNavWhenBack = YES;
    [wvc initData:user.nickname url:[NSString stringWithFormat:@"%@/ClientPage/userinfo_phone.html?sessionId=%@&userId=%@&loginId=%@", [Config getProjectPath], [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"], user.userId, [loginData objectForKey:@"loginId"]]];
    [self.parentViewController.navigationController pushViewController:wvc animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //搜索结果表格
    if (tableView == searchDisplayController.searchResultsTableView) {
        return 80;
    }
    
    //常规表格
    TreeNode *node = nil;
    if (tableShowType == Company) {
        node = [shopNodes objectAtIndex:indexPath.row];
    } else if (tableShowType == User) {
        node = [userNodes objectAtIndex:indexPath.row];
    } else if (tableShowType == Group) {
        node = [groupNodes objectAtIndex:indexPath.row];
    } else if (tableShowType == Guest) {
        node = [guestNodes objectAtIndex:indexPath.row];
    }
	if ([node.nodeType isEqualToString:@"kind"]) {
		return 40;
	} else {
		return 80;
	}
}

- (NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    TreeNode *node = nil;
    if (tableShowType == Company) {
        node = [shopNodes objectAtIndex:indexPath.row];
    } else if (tableShowType == User) {
        node = [userNodes objectAtIndex:indexPath.row];
    } else if (tableShowType == Group) {
        node = [groupNodes objectAtIndex:indexPath.row];
    } else if (tableShowType == Guest) {
        node = [guestNodes objectAtIndex:indexPath.row];
    }
	
    //搜索结果表格
    if (tableView == searchDisplayController.searchResultsTableView) {
        if ([node.key rangeOfString:@"group"].location != NSNotFound) {
            GroupStruct *group = [GroupDataManage getGroup:node.param];
            [self openGroupChatWindow:group];
        } else {
            UserData *user = [UserDataManage getUser:node.param];
            [self openChatWindow:user];
        }
    //常规表格
    } else {
        if ([node.nodeType isEqualToString:@"addGroup"]) {
            AddGroupViewController *avc = [[AddGroupViewController alloc] init];
            [self.parentViewController.navigationController pushViewController:avc animated:YES];
        } else if ([node.nodeType isEqualToString:@"kind"]) {
            node.expanded = !node.expanded; //切换“展开/收起”状态
            [self onExpand:node];
        } else {
            if (tableShowType == Company) {
                UserData *user = [UserDataManage getUser:node.param];
                [self openChatWindow:user];
            } else if (tableShowType == User) {
                UserData *user = [UserDataManage getUser:node.param];
                [self openChatWindow:user];
            } else if (tableShowType == Group) {
                GroupStruct *group = [GroupDataManage getGroup:node.param];
                [self openGroupChatWindow:group];
            } else if (tableShowType == Guest) {
                UserData *user = [UserDataManage getUser:node.param];
                [self openChatWindow:user];
            }
            /*
            if (indexPath.row < [nodes count] - [[GroupDataManage getMyGroups] count] - 1) {
                //好友
                UserData *user = [UserDataManage getUser:node.param];
                [self openChatWindow:user];
            } else {
                //群
                GroupStruct *group = [GroupDataManage getGroup:node.param];
                [self openGroupChatWindow:group];
            }*/
        }
    }
	
	return indexPath;
}

//允许编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    TreeNode *node = nil;
    if (tableShowType == Company) {
        node = [shopNodes objectAtIndex:indexPath.row];
    } else if (tableShowType == User) {
        node = [userNodes objectAtIndex:indexPath.row];
    } else if (tableShowType == Group) {
        node = [groupNodes objectAtIndex:indexPath.row];
    } else if (tableShowType == Guest) {
        node = [guestNodes objectAtIndex:indexPath.row];
    }
    if ([node.nodeType isEqualToString:@"kind"] || [node.nodeType isEqualToString:@"addGroup"] || tableShowType == Company) {
        return NO;
    }
    return YES;
}

//编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    TreeNode *node = nil;
    if (tableShowType == Company) {
        node = [shopNodes objectAtIndex:indexPath.row];
    } else if (tableShowType == User) {
        node = [userNodes objectAtIndex:indexPath.row];
    } else if (tableShowType == Group) {
        node = [groupNodes objectAtIndex:indexPath.row];
    } else if (tableShowType == Guest) {
        node = [guestNodes objectAtIndex:indexPath.row];
    }
    if ([node.nodeType isEqualToString:@"kind"] || [node.nodeType isEqualToString:@"addGroup"] || tableShowType == Company) {
        return UITableViewCellEditingStyleNone;
    }
    return UITableViewCellEditingStyleDelete;
}

//提交编辑
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        TreeNode *node = nil;
        delIndexPath = [indexPath copy];
        if (tableShowType == Company) {
            node = [shopNodes objectAtIndex:indexPath.row];
        } else if (tableShowType == User) {
            node = [userNodes objectAtIndex:indexPath.row];
        } else if (tableShowType == Group) {
            node = [groupNodes objectAtIndex:indexPath.row];
        } else if (tableShowType == Guest) {
            node = [guestNodes objectAtIndex:indexPath.row];
        }
        //删群
        if ([node.key rangeOfString:@"group"].location != NSNotFound) {
            CIMSocketLogicExt *cimSocketLogicExt = (CIMSocketLogicExt *)[CimGlobal getClass:@"CIMSocketLogicExt"];
            optGroupId = node.param;
            GroupStruct *group = [GroupDataManage getGroup:optGroupId];
            if ([group.myTypeInGroup isEqualToString:@"1"]) {
                [cimSocketLogicExt dissolveGroupMessage:optGroupId];
                SetGroupHttp *http = [SetGroupHttp alloc];
                http.delegate = self;
                [http removeGroup:optGroupId];
            } else {
                [cimSocketLogicExt leaveGroupMessage:optGroupId];
                SetGroupUserHttp *http = [SetGroupUserHttp alloc];
                http.delegate = self;
                [http removeUser:[UserDataManage getSelfUser].userId groupId:optGroupId];
            }
        } else if ([node.key rangeOfString:@"kinduser"].location != NSNotFound) {
            //删除访客
            if (tableShowType == Guest) {
                UserData *user = [UserDataManage getUser:node.param];
                [self successDeleteGuest:user];
            //删除好友
            } else {
                AddFriendHttp *http = [AddFriendHttp alloc];
                http.delegate = self;
                [http init:node.param kindName:@"" option:@"deleteFriend"];
            }
            
        }
    }
}

- (void)openExpandByEditMode:(UITapGestureRecognizer *)tap {
    //常规表格
    TreeNode *node = nil;
    if (tableShowType == Company) {
        node = [shopNodes objectAtIndex:tap.view.tag];
    } else if (tableShowType == User) {
        node = [userNodes objectAtIndex:tap.view.tag];
    } else if (tableShowType == Group) {
        node = [groupNodes objectAtIndex:tap.view.tag];
    } else if (tableShowType == Guest) {
        node = [guestNodes objectAtIndex:tap.view.tag];
    }
    if ([node.nodeType isEqualToString:@"kind"]) {
        node.expanded = !node.expanded;
        [self onExpand:node];
    }
}
//点击节点事件
- (void)onExpand:(TreeNode*)node
{
    if (tableShowType == Company) {
        shopNodes = [[NSMutableArray alloc] init];
        [TreeNode getNodes:shopTree :shopNodes];
    } else if (tableShowType == User) {
        userNodes = [[NSMutableArray alloc] init];
        [TreeNode getNodes:userTree :userNodes];
    } else if (tableShowType == Group) {
        groupNodes = [[NSMutableArray alloc] init];
        [TreeNode getNodes:groupTree :groupNodes];
    } else if (tableShowType == Guest) {
        guestNodes = [[NSMutableArray alloc] init];
        [TreeNode getNodes:guestTree :guestNodes];
    }
    [treeTableView reloadData];
}


- (void)openChatWindow:(UserData *)user
{
	UserChatViewController *userChat = [[UserChatViewController alloc] init];
	ChatUserStruct *chatUser = [ChatUserStruct alloc];
	chatUser.dataId = user.userId;
	chatUser.chatType = @"user";
	[userChat setConcantUser:chatUser];
    userChat.chatTitle = [user getUserName];
	[self.parentViewController.navigationController pushViewController:userChat animated:YES];
}

- (void)openGroupChatWindow:(GroupStruct *)group
{
    UserChatViewController *userChat = [[UserChatViewController alloc] init];
    ChatUserStruct *chatUser = [ChatUserStruct alloc];
    chatUser.dataId = group.groupId;
    chatUser.chatType = @"group";
    [userChat setConcantUser:chatUser];
    userChat.chatTitle = group.groupName;
    [self.parentViewController.navigationController pushViewController:userChat animated:YES];
}

//退群委托
- (void)recvSetGroupUserData:(id)sender {
    if (delIndexPath) {
        TreeNode *node = [groupNodes objectAtIndex:delIndexPath.row];
        if (node && node.param) {
            GroupStruct *group = [GroupDataManage getGroup:node.param];
            if (group) {
                ChatUserStruct *chatUser = [ChatUserStruct alloc];
                chatUser.dataId = group.groupId;
                chatUser.chatType = @"group";
                [ChatListDataStruct removeChatUser:chatUser];
                [GroupDataManage removeGroup:group.groupId];
            }
        }
        [treeTableView beginUpdates];
        [groupNodes removeObjectAtIndex:delIndexPath.row];
        [treeTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:delIndexPath] withRowAnimation:UITableViewRowAnimationFade];
        [treeTableView endUpdates];
        [self updateUserStatus:nil];
    }
    [Debuger systemAlert:@"退出成功"];
    [treeTableView reloadData];
}

- (void)errorSetGroupUser:(ErrorParam *)error {
    [Debuger systemAlert:error.errorInfo];
}

//解散群委托
- (void)recvSetGroupData:(id)sender {
    if (delIndexPath) {
        ChatUserStruct *chatUser = [ChatUserStruct alloc];
        chatUser.dataId = optGroupId;
        chatUser.chatType = @"group";
        [ChatListDataStruct removeChatUser:chatUser];
        
        [GroupDataManage removeGroup:optGroupId];
        [treeTableView beginUpdates];
        [groupNodes removeObjectAtIndex:delIndexPath.row];
        [treeTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:delIndexPath] withRowAnimation:UITableViewRowAnimationFade];
        [treeTableView endUpdates];
        [self updateUserStatus:nil];
    }
    [Debuger systemAlert:@"解散成功"];
    [treeTableView reloadData];
}

- (void)errorSetGroup:(ErrorParam*)error {
    [Debuger systemAlert:error.errorInfo];
}

//删除好友成功
- (void)successAddFriend:(UserData *)user {
    if (delIndexPath) {
        [treeTableView beginUpdates];
        UserListKindDataStruct *kind = [cimUserListDataStruct getListKind:user.kindId];
        ChatUserStruct *chatUser = [ChatUserStruct alloc];
        chatUser.dataId = user.userId;
        chatUser.chatType = @"user";
        CIMFriendListDataStruct *cimUserListDataStruct = [CimGlobal getClass:@"CIMFriendListDataStruct"];
        [cimUserListDataStruct removeUserByUserId:user.userId];
        OPChatLogData *opChatlogData = [CimGlobal getClass:@"OPChatLogData"];
        [opChatlogData removeStranger:user.userId];
        [ChatListDataStruct removeChatUser:chatUser];
        [kind removeUser:user.userId];
        [userNodes removeObjectAtIndex:delIndexPath.row];
        [treeTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:delIndexPath] withRowAnimation:UITableViewRowAnimationFade];
        [treeTableView endUpdates];
        [self updateUserStatus:nil];
    }
    [Debuger systemAlert:@"删除成功"];
    [treeTableView reloadData];
}

//删除好友失败
- (void)errorAddFriend:(ErrorParam*)error {
    [Debuger systemAlert:error.errorInfo];
}

//删除访客后更新刷新页面
- (void)successDeleteGuest:(UserData *)user {
    if (delIndexPath) {
        [treeTableView beginUpdates];
        UserListKindDataStruct *kind = [cimGuestListDataStruct getListKind:user.kindId];
        ChatUserStruct *chatUser = [ChatUserStruct alloc];
        chatUser.dataId = user.userId;
        chatUser.chatType = @"user";
        [cimGuestListDataStruct removeUserById:user.userId];
        OPChatLogData *opChatLogData = [CimGlobal getClass:@"OPChatLogData"];
        [opChatLogData deleteGeustById:user.userId];
        [kind removeUser:user.userId];
        [guestNodes removeObjectAtIndex:delIndexPath.row];
        [treeTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:delIndexPath] withRowAnimation:UITableViewRowAnimationFade];
        [treeTableView endUpdates];
        [self updateUserStatus:nil];
    }
    [Debuger systemAlert:@"删除成功"];
    [treeTableView reloadData];
}


@end
