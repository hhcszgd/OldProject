//
//  CIMFriendUserTreeViewController.m
//  IOSCim
//
//  Created by apple apple on 11-8-16.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "CIMFriendUserTreeViewController.h"
#import "FriendNavigation.h"
#import "UserData.h"
#import "MyNotificationCenter.h"
#import "CimGlobal.h"
#import "SearchFriendViewController.h"
#import "GroupTreeViewController.h"
#import "SystemVariable.h"
#import "Tool.h"
#import "GroupStruct.h"
#import "GroupDataManage.h"

@implementation CIMFriendUserTreeViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];
    [self.parentViewController.navigationController setNavigationBarHidden:YES];
}
//加载完成回调
- (void)viewDidLoad 
{
    title = @"联系人";
    [super viewDidLoad];
    
    // 屏幕尺寸
    screenRect = [Tool screenRect];
    statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    navigationBarHeight = self.navigationController.navigationBar.bounds.size.height;
    
    // 背景图片
    CGRect backgroundViewRect = screenRect;
    if (IS_GTE_IOS7) {
        backgroundViewRect.origin.y -= (statusBarHeight + navigationBarHeight);
    }
    backgroundView = [[UIImageView alloc] initWithFrame:backgroundViewRect];
    backgroundView.image = [UIImage imageNamed:@"appBG"];
    backgroundView.tag = 100;
    [self.view addSubview:backgroundView];
    
    cimUserListDataStruct = (CIMUserListDataStruct *)[CimGlobal getClass:@"CIMFriendListDataStruct"];
	
	windowTitle = @"联系人";
	className = @"CIMFriendUserTreeViewController";
	isFilterEmptyKind = NO;
	lookInfoSelector = @selector(lookFriendInfo:);
	
	[MyNotificationCenter addObserver:self 
							 selector:@selector(dynamicAddUser:) 
								 name:SystemEventDynamicAddFriend 
						   obServerId:@"CIMFriendUserTreeViewController_dynamicAddUser"];
	
	[MyNotificationCenter addObserver:self 
							 selector:@selector(dynamicRemoveUser:)
								 name:SystemEventDynamicRemoveFriend 
						   obServerId:@"CIMFriendUserTreeViewController_dynamicRemoveUser"];
    
    [MyNotificationCenter addObserver:self
                             selector:@selector(dynamicAddGroup:)
                                 name:SystemEventDynamicAddGroup
                           obServerId:@"CIMFriendUserTreeViewController_dynamicAddGroup"];
    
    [MyNotificationCenter addObserver:self
                             selector:@selector(dynamicUpdate:)
                                 name:SystemEventDynamicUpdate
                           obServerId:@"CIMFriendUserTreeViewController_dynamicUpdate"];
    
	
    //导航栏添加好友按钮
    UIButton * addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [addButton setBackgroundImage:[UIImage imageNamed:@"icon_add"] forState:UIControlStateNormal];
    [addButton setBackgroundImage:[UIImage imageNamed:@"icon_add"] forState:UIControlStateHighlighted];
    [addButton addTarget:self action:@selector(addFriend:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    self.navigationItem.rightBarButtonItem = addButtonItem;
	
	//导航栏编辑好友按钮
    /*UIButton * editButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [editButton setBackgroundImage:[UIImage imageNamed:@"icon_edit"] forState:UIControlStateNormal];
    [editButton setBackgroundImage:[UIImage imageNamed:@"icon_edit"] forState:UIControlStateHighlighted];
    [editButton addTarget:self action:@selector(changeToEditMode:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:editButton];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;*/
    
    self.tableShowType = User;
    //搜索条
    /*
    CGRect searchbarRect;
    if (IS_GTE_IOS7) {
        searchbarRect = CGRectMake(0, 0, screenRect.size.width, 42);
    } else {
        searchbarRect = CGRectMake(0, navigationBarHeight, screenRect.size.width, 42);
    }
    mySearchBar = [[UISearchBar alloc] initWithFrame:searchbarRect];
    [mySearchBar setAutocorrectionType:UITextAutocorrectionTypeNo];
    [mySearchBar setBackgroundColor:[UIColor clearColor]];
    [mySearchBar setBarStyle:UIBarStyleDefault];
    [mySearchBar setClipsToBounds:NO];
    [mySearchBar setDelegate:self];
    [mySearchBar setKeyboardType:UIKeyboardTypeDefault];
    [mySearchBar setPlaceholder:@"搜索联系人..."];
    [mySearchBar setShowsCancelButton:NO];
    [mySearchBar setShowsSearchResultsButton:NO];
    [mySearchBar setSpellCheckingType:UITextSpellCheckingTypeNo];
    [mySearchBar setTranslucent:YES];
    [mySearchBar.layer setBorderWidth:0];
    [mySearchBar.layer setBorderColor:[[UIColor clearColor] CGColor]];
    if (IS_GTE_IOS7) {
        [mySearchBar setBackgroundImage:[UIImage imageNamed:@"searchbar_background.png"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    } else {
        [mySearchBar setBackgroundImage:[UIImage imageNamed:@"searchbar_background.png"]];
    }
    [self.view addSubview:mySearchBar];
    
    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:mySearchBar contentsController:self];
    searchDisplayController.delegate = self;
    searchDisplayController.searchResultsDataSource = self;
    searchDisplayController.searchResultsDelegate = self;
    [searchDisplayController setActive:NO];*/
    
    //按钮条
    CGRect buttonViewRect;
    if (IS_GTE_IOS7) {
        buttonViewRect = CGRectMake(0, 0, screenRect.size.width, 44);
    } else {
        buttonViewRect = CGRectMake(0, 44, screenRect.size.width, 44);
    }
    UIView *buttonsView = [[UIView alloc] initWithFrame:buttonViewRect];
    buttonsView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:buttonsView];
    //按钮
    [buttonsView addSubview:[self createButton:@"企业" number:0]];
    [buttonsView addSubview:[self createButton:@"好友" number:1]];
    [buttonsView addSubview:[self createButton:@"群" number:2]];
    [buttonsView addSubview:[self createButton:@"访客" number:3]];
    
    //好友列表
    CGRect tableRect;
    if (IS_GTE_IOS7) {
        tableRect = CGRectMake(0, buttonsView.frame.size.height, screenRect.size.width, screenRect.size.height - (statusBarHeight + navigationBarHeight + buttonsView.frame.size.height + self.tabBarController.tabBar.frame.size.height + 5));
    } else {
        tableRect = CGRectMake(0, navigationBarHeight + buttonsView.frame.size.height, screenRect.size.width, screenRect.size.height - (statusBarHeight + navigationBarHeight + buttonsView.frame.size.height + self.tabBarController.tabBar.frame.size.height + 5));
    }
    treeTableView = [[UITableView alloc] initWithFrame:tableRect];
    treeTableView.dataSource = self;
    treeTableView.delegate = self;
    treeTableView.layer.opacity = 0.8;
    UIView *tableBackView = [[UIView alloc] initWithFrame:CGRectZero];
    tableBackView.backgroundColor = [UIColor clearColor];
    treeTableView.backgroundView = tableBackView;
    [self.view addSubview:treeTableView];
    
    //搜索结果列表
    /*searchTableView = [[UITableView alloc] initWithFrame:tableRect];
    searchTableView.hidden = YES;
    searchTableView.layer.opacity = 0.8;
    searchTableView.backgroundView = tableBackView;
    [self.view addSubview:searchTableView];*/
    
	[self loadInit];
}
//创建按钮
- (UIButton *)createButton:(NSString *)buttonTitle number:(int)number {
    UIButton *buttonOne = [[UIButton alloc] initWithFrame:CGRectMake(number * screenRect.size.width / 4, 0, screenRect.size.width / 4, 44)];
    buttonOne.tag = number;
    [buttonOne setBackgroundImage:[UIImage imageNamed:@"button_unselected"] forState:UIControlStateNormal];
    [buttonOne setBackgroundImage:[UIImage imageNamed:@"button_selected"] forState:UIControlStateSelected];
    [buttonOne setTitle:buttonTitle forState:UIControlStateNormal];
    [buttonOne setTintColor:[Tool colorWithHexString:@"557f98"]];
    [buttonOne addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    if (number == 1) {
        buttonOne.selected = YES;
    }
    return buttonOne;
}
- (void)buttonClick:(UIButton *)button {
    for (UIButton *buttonOne in [[button superview] subviews]) {
        buttonOne.selected = [buttonOne isEqual:button];
    }
    self.tableShowType = button.tag;
    [treeTableView reloadData];
}
- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller {
    [self resetBGRect];
    if (IS_GTE_IOS7) {
    } else {
        [self resetSearchBarRect];
    }
    treeTableView.hidden = NO;
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    CGRect backgroundViewRect = screenRect;
    if (IS_GTE_IOS7) {
        backgroundViewRect.origin.y -= (statusBarHeight + navigationBarHeight);
    }
    backgroundViewRect.origin.y += searchBar.frame.size.height;
    backgroundView.frame = backgroundViewRect;
    
    //搜索条
    CGRect searchbarRect;
    if (IS_GTE_IOS7) {
    } else {
        searchbarRect = CGRectMake(0, 0, screenRect.size.width, 42);
        mySearchBar.frame = searchbarRect;
        mySearchBar.backgroundColor = [Tool colorWithHexString:@"bccce3"];
        [mySearchBar setBackgroundImage:[UIImage imageNamed:@"searchbar_background.png"]];
    }
    
    return YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self resetBGRect];
    if (IS_GTE_IOS7) {
    } else {
        [self resetSearchBarRect];
    }
}
- (void)resetSearchBarRect {
    //搜索条
    CGRect searchbarRect;
    if (IS_GTE_IOS7) {
        searchbarRect = CGRectMake(0, 0, screenRect.size.width, 42);
    } else {
        searchbarRect = CGRectMake(0, navigationBarHeight, screenRect.size.width, 42);
    }
    mySearchBar.frame = searchbarRect;
}
- (void)resetBGRect {
    CGRect backgroundViewRect = screenRect;
    if (IS_GTE_IOS7) {
        backgroundViewRect.origin.y -= (statusBarHeight + navigationBarHeight);
    }
    backgroundView.frame = backgroundViewRect;
}
//转到查看好友资料的窗口
- (void)lookFriendInfo:(UIButton*)sender 
{
	FriendNavigation *friendNavigation = [FriendNavigation alloc];
	friendNavigation.optUserId = [sender titleForState:UIControlStateNormal];
	[self.navigationController pushViewController:friendNavigation animated:YES];
}



//转到群窗口
- (void)toGroupView:(id)sender 
{
	GroupTreeViewController *groupTreeViewController = [GroupTreeViewController alloc];
	[self.navigationController pushViewController:groupTreeViewController animated:YES];
}



//转到添加好友窗口
- (void)addFriend:(id)sender 
{
	SearchFriendViewController *searchFriend = [SearchFriendViewController alloc];
	[self.parentViewController.navigationController pushViewController:searchFriend animated:YES];
}



//动态添加人员
- (void)dynamicAddUser:(UserData*)user 
{
	if (self.isViewLoaded) 
	{
        TreeNode *kind = [userNodesDictionary objectForKey:user.kindId];
        NSMutableArray *childrenArray = [kind children];
        BOOL hasOne = NO;
        for (TreeNode *userOne in childrenArray) {
            if ([userOne.param isEqualToString:user.userId]) {
                hasOne = YES;
                break;
            }
        }
        if (hasOne) {
            return;
        }
        
		TreeNode *userNode = [[TreeNode alloc] init];
		userNode.title = [user getUserName];
		userNode.key = [@"kinduser" stringByAppendingString:user.userId];
		userNode.nodeType = @"node";
		userNode.info = user.idiograph;
		userNode.param = user.userId;
		
		[kind addChild:userNode];
		[userNodes removeAllObjects];
		[TreeNode getNodes:userTree :userNodes];
		[self updateUserStatus:nil];
	}
}


//动态添加群
- (void)dynamicAddGroup:(GroupStruct *)groupOne {
    if (self.isViewLoaded)
    {
        TreeNode *groupNode = [[TreeNode alloc] init];
        groupNode.title = groupOne.groupName;
        groupNode.key = [@"group" stringByAppendingString:groupOne.groupId];
        groupNode.nodeType = @"group";
        groupNode.param = groupOne.groupId;
        [GroupDataManage addGroup:groupOne];
        
        TreeNode *kind = [groupNodesDictionary objectForKey:@"-999"];
        [kind addChild:groupNode];
        [groupNodes removeAllObjects];
        [TreeNode getNodes:groupTree :groupNodes];
        [self updateUserStatus:nil];
    }
}

//动态添加群
- (void)dynamicUpdate:(id)param {
    if (self.isViewLoaded) {
        [self updateUserStatus:nil];
    }
}


//动态删除用户
- (void)dynamicRemoveUser:(UserData*)user
{
	if (self.isViewLoaded) 
	{
		NSString *key = [@"kinduser" stringByAppendingString:user.userId];
		TreeNode *kind = [userNodesDictionary objectForKey:user.kindId];
		[kind removeChild:key];
		[userNodes removeAllObjects];
		[TreeNode getNodes:userTree :userNodes];
		[self updateUserStatus:nil];
	}
}

//好友列表编辑模式
- (void)changeToEditMode:(UIBarButtonItem*)sender  {
    if ([treeTableView isEditing]) {
        [treeTableView setEditing:NO animated:YES];
        [self updateUserStatus:nil];
    } else {
        [treeTableView setEditing:YES animated:YES];
    }
}


@end
