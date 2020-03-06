//
//  CIMUserTreeViewController.h
//  IOSCim
//
//  Created by apple apple on 11-8-16.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TreeNode.h"
#import "CIMUserListDataStruct.h"
#import "CIMShopListDataStruct.h"
#import "CIMGuestListDataStruct.h"
#import "CIMUIViewController.h"

typedef NS_ENUM(NSInteger, TableShowType) {
    Company = 0,    //企业
    User = 1,       //好友
    Group = 2,      //群
    Guest = 3       //访客
} NS_ENUM_AVAILABLE_IOS(5_0);

@interface CIMUserTreeViewController : CIMUIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate> {
	TreeNode *userTree; //树形节点的数据结构
    TreeNode *groupTree;
    TreeNode *shopTree;
    TreeNode *guestTree;
	NSMutableArray *userNodes; //存放每次需要显示的节点
    NSMutableArray *groupNodes;
    NSMutableArray *shopNodes;
    NSMutableArray *guestNodes;
	NSMutableArray *searchNodesArray;
	NSMutableDictionary *userNodesDictionary;  //树形节点的集合
    NSMutableDictionary *groupNodesDictionary; //群树形节点的的集合
    NSMutableDictionary *shopNodesDictionary;  //企业树形节点的的集合
    NSMutableDictionary *guestNodesDictionary; //访客树形节点的的集合
	CIMUserListDataStruct *cimUserListDataStruct; //人员的数据结构
	NSString *windowTitle; //窗口标题
	NSString *className;
	
	UITableView *treeTableView; //显示树形的tableview
	UITableView *searchTableView; //显示搜索结果的tableview
	UISearchBar *mySearchBar;
    UISearchDisplayController *searchDisplayController;
	
	BOOL isFilterEmptyKind; //是否过滤空分组
	SEL lookInfoSelector; //转到详细窗口的函数
	
    CIMShopListDataStruct *cimShopListDataStruct;
    CIMGuestListDataStruct *cimGuestListDataStruct;
}

@property (nonatomic, retain) UITableView *searchTableView;
@property (nonatomic, retain) UISearchBar *mySearchBar;
@property (nonatomic, assign) TableShowType tableShowType;

- (void)loadInit;
- (void)updateUserStatus:(id)sender;

@end
