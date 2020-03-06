//
//  SearchFriendViewController.m
//  IOSCim
//
//  Created by fei lan on 14-9-28.
//  Copyright (c) 2014年 CIMForIOS. All rights reserved.
//

#import "SearchFriendViewController.h"
#import "Config.h"
#import "MyNotificationCenter.h"
#import "Debuger.h"
#import "AddFriendRequest.h"
#import "CIMFriendListDataStruct.h"
#import "ExistFriendHttp.h"
#import "AddFriendHttp.h"
#import "ErrorParam.h"
#import "CimGlobal.h"
#import "CIMSocketLogicExt.h"
#import "SystemVariable.h"
#import "Tool.h"
#import "UserDataManage.h"
#import "SVProgressHUD.h"
#import "AsynImageView.h"

@interface SearchFriendViewController ()

@end

@implementation SearchFriendViewController

- (void)viewDidLoad
{
    isShowBackButton = YES;
    title = @"添加联系人";
    
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
    
    [MyNotificationCenter addObserver:self
                             selector:@selector(addFriendResult:)
                                 name:HttpAddFriendDataComplete
                           obServerId:@"SearchFriend_addFriendResult"];
    
    promptMessage = @"查到的用户";
    cimFriendListDataStruct = [CimGlobal getClass:@"CIMFriendListDataStruct"];
    
    
    //搜索条
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
    [searchDisplayController setActive:NO];
    
    userHttp = [GetUserWithLoginIdHttp alloc];
    userHttp.delegate = self;
    
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
    [super viewWillDisappear:animated];
}

- (void) searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller {
    [self resetBGRect];
    if (IS_GTE_IOS7) {
    } else {
        [self resetSearchBarRect];
    }
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    searchBar.text = @"";
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


- (void)recvGetUserData:(UserData*)user
{
    promptMessage = @"查到的用户";
    searchResult = user;
    [myTableView reloadData];
    myTableView.hidden = NO;
}




- (void)errorGetUserData:(ErrorParam*)error
{
    promptMessage = @"没有数据";
    [myTableView reloadData];
    myTableView.hidden = NO;
}



//獲取分區的數量
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    myTableView = tableView;
    return 1;
}



//行数
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if (searchResult == nil)
    {
        return 0;
    }
    
    return 1;
}



//行的創建
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    NSString *headImgStr = [searchResult getHeadImage];
    if ([headImgStr isEqualToString:@"OfflineHead1.png"] || [headImgStr isEqualToString:@"DefaultHead.png"]) {
        cell.imageView.image = [UIImage imageNamed:headImgStr];
    } else {
        AsynImageView *headImage = [[AsynImageView alloc] init];
        headImage.imageURL = headImgStr;
        cell.imageView.image = headImage.image;
    }
    if ([searchResult getStatus] == UserStatusLeave || [searchResult getStatus] == UserStatusBusy) {
        UIImageView *stateIcon = (UIImageView *)[cell.imageView viewWithTag:-11];
        if (!stateIcon) {
            stateIcon = [[UIImageView alloc] initWithFrame:CGRectMake(cell.imageView.frame.size.width - 20, cell.imageView.frame.size.height - 20, 20, 20)];
            stateIcon.tag = -11;
            [cell.imageView addSubview:stateIcon];
        }
        if ([searchResult getStatus] == UserStatusLeave) {
            stateIcon.image = [UIImage imageNamed:@"status_leave"];
        } else if ([searchResult getStatus] == UserStatusBusy) {
            stateIcon.image = [UIImage imageNamed:@"status_busy"];
        }
    } else {
        UIImageView *stateIcon = (UIImageView *)[cell.imageView viewWithTag:-11];
        if (stateIcon) {
            [stateIcon removeFromSuperview];
        }
    }
    
    cell.textLabel.text = searchResult.nickname;
    cell.detailTextLabel.text = searchResult.idiograph;
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}



//分区标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return promptMessage;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!isRequestData)
    {
        
        if ([cimFriendListDataStruct isMyUser:searchResult.userId])
        {
            [Debuger systemAlert:@"该用户已经是您的好友,不能再添加"];
            return;
        }
        
        
        //拒绝加任何人为好友
        if ([searchResult.friendVerifyType isEqualToString:@"2"]) {
            isRequestData = NO;
            [Debuger systemAlert:@"对方拒绝任何人加他为好友"];
            return;
        }
        
        isRequestData = YES;
        //判断是否存在单边好友或黑名单关系
        ExistFriendHttp *http = [ExistFriendHttp alloc];
        http.delegate = self;
        [http init:searchResult.loginId];
    }
}



//是单边好友
- (void)isUnilateralFriend:(id)sender
{
    //不通知对方
    isNoticeAddFriend = NO;
    AddFriendHttp *http = [AddFriendHttp alloc];
    http.delegate = self;
    [http init:searchResult.userId kindName:@"" option:@"add"];
}



//是黑名单用户
- (void)isBlackListUser:(id)sender
{
    isRequestData = NO;
    [Debuger systemAlert:@"对方已经将您加入黑名单，不能添加好友"];
}



//是普通用户无任何关系
- (void)isNormalUser:(id)sender
{
    //通知对方
    isNoticeAddFriend = YES;
    int friendVerifyType = searchResult.friendVerifyType.intValue;
    //允许任何人加为好友
    if (friendVerifyType == 0) {
        [UserDataManage addUser:searchResult];
        AddFriendHttp *http = [AddFriendHttp alloc];
        http.delegate = self;
        [http init:searchResult.userId kindName:@"" option:@"add"];
    //需要验证
    } else if (friendVerifyType == 1) {
        isRequestData = NO;
        AddFriendRequest *addFriendRequest = [AddFriendRequest alloc];
        addFriendRequest.tipsMessage = searchResult.nickname;
        addFriendRequest.friendId = searchResult.userId;
        [self.navigationController pushViewController:addFriendRequest animated:YES];
    } else if (friendVerifyType == 2) {
        [SVProgressHUD showAlert:nil msg:@"对方不允许任何人加好友"];
    }
}




//添加好友成功
- (void)successAddFriend:(UserData*)user
{
    isRequestData = NO;
    [Debuger systemAlert:@"添加成功，请在好友列表中查看"];
    //发送确认消息让对方的好友列表中消息自己
    
    if (isNoticeAddFriend)
    {
        CIMSocketLogicExt *cimSocketLogicExt = [CimGlobal getClass:@"CIMSocketLogicExt"];
        [cimSocketLogicExt sendAgreeAddFriendMessage:searchResult.userId];
    }
    
    //更新好友列表
    searchResult.kindId = @"1"; //默认添加到我的好友列表中
    CIMFriendListDataStruct *cimUserListDataStruct = [CimGlobal getClass:@"CIMFriendListDataStruct"];
    
    BOOL hasOne = NO;
    NSMutableArray *userList = [cimUserListDataStruct getListUsers];
    for (UserData *userOne in userList) {
        if ([userOne.userId isEqualToString:user.userId]) {
            if ([userOne.userType isEqualToString:@"stranger"]) {
                UserListKindDataStruct *strangerKind = [cimUserListDataStruct getListKind:@"stranger"];
                [strangerKind removeUser:userOne.userId];
                CIMUserListDataStruct *cimUserListDataStruct = (CIMUserListDataStruct *)[CimGlobal getClass:@"CIMShopListDataStruct"];
                UserListKindDataStruct *kind = [cimUserListDataStruct getListKind:userOne.kindId];
                [kind removeUser:userOne.userId];
                [MyNotificationCenter postNotification:SystemEventDynamicRemoveFriend setParam:userOne];
            } else {
                hasOne = YES;
                break;
            }
        }
    }
    if (!hasOne) {
        user.kindId = @"1";
        [cimUserListDataStruct addListUser:user];
    }
    //刷新好友列表
    [MyNotificationCenter postNotification:SystemEventDynamicAddFriend setParam:searchResult];
}




- (void)errorAddFriend:(ErrorParam*)error
{
    isRequestData = NO;
    [Debuger systemAlert:error.errorInfo];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar 
{
    [searchBar resignFirstResponder];
    //[self.navigationController setNavigationBarHidden:NO];
    
    if ([searchBar.text isEqualToString:@""]) 
    {
        return;
    }
    
    NSString *userLoginId = [searchBar.text stringByAppendingString:[Config getDomain]];
    //userLoginId = @"罗永强";
    [userHttp init:userLoginId];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
