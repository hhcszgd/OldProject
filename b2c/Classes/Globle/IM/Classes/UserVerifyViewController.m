//
//  UserVerifyViewController.m
//  IOSCim
//
//  Created by fei lan on 14-10-22.
//  Copyright (c) 2014年 CIMForIOS. All rights reserved.
//

#import "UserVerifyViewController.h"
#import "Tool.h"
#import "SystemVariable.h"
#import "WSCallerBlock.h"
#import "Config.h"
#import "SVProgressHUD.h"
#import "UserDataManage.h"
#import "UserData.h"

@interface UserVerifyViewController ()

@end

@implementation UserVerifyViewController


- (void)viewDidLoad {
    title = @"好友验证设置";
    //全屏大小
    mainRect = [Tool screenRect];
    isShowBackButton = YES;
    //状态栏高度
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    //导航栏高度
    CGFloat navigationBarHeight = self.navigationController.navigationBar.bounds.size.height;
    
    //背景图
    CGRect backgroundViewRect = mainRect;
    if (IS_GTE_IOS7) {
        backgroundViewRect.origin.y -= (statusBarHeight + navigationBarHeight);
    }
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:backgroundViewRect];
    backgroundView.image = [UIImage imageNamed:@"appBG"];
    [self.view addSubview:backgroundView];
    [super viewDidLoad];
    
    CGRect tableRect;
    if (IS_GTE_IOS7) {
        tableRect = CGRectMake(0, 0, mainRect.size.width, mainRect.size.height - (statusBarHeight + navigationBarHeight));
    } else {
        tableRect = CGRectMake(0, navigationBarHeight, mainRect.size.width, mainRect.size.height - (statusBarHeight + navigationBarHeight));
    }
    table = [[UITableView alloc] initWithFrame:tableRect style:UITableViewStyleGrouped];
    table.backgroundColor = [UIColor clearColor];
    table.dataSource = self;
    table.delegate = self;
    table.layer.opacity = 0.8;
    [self.view addSubview:table];
    
    UserData *userData = [UserDataManage getSelfUser];
    int myFriendVerifyType = userData.friendVerifyType.intValue;
    if (myFriendVerifyType == 0) {
        curSelected = 0;
    } else if (myFriendVerifyType == 1) {
        curSelected = 1;
    } else if (myFriendVerifyType == 2) {
        curSelected = 2;
    }
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated {
    [SVProgressHUD dismiss];
    [super viewWillAppear:animated];
}
//行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
//生成行
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"允许任何人加我为好友";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"需要通过我的验证";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"不允许任何人加我为好友";
    }
    if (indexPath.row == curSelected) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}
//行点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    int type = 0;
    if (indexPath.row == 1) {
        type = 1;
    } else if (indexPath.row == 2) {
        type = 2;
    }
    WSCallerBlock *http = [[WSCallerBlock alloc] init];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:@"friend.validate.set" forKey:@"function"];
    [param setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"] forKey:@"sessionId"];
    [param setObject:[NSNumber numberWithInt:type] forKey:@"type"];
    [SVProgressHUD show];
    [http callPost:[Config getPath] params:param delegate:self usingBlock:^(NSData *data) {
        [SVProgressHUD dismiss];
        NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSRegularExpression *xmlRegex = [NSRegularExpression regularExpressionWithPattern:@"<result code=[\"|']([\\d]*)[\"|']" options:NSRegularExpressionCaseInsensitive error:nil];
        NSArray *arrayRange = [xmlRegex matchesInString:dataStr options:NSMatchingReportCompletion range:NSMakeRange(0, dataStr.length)];
        BOOL isFail = YES;
        for (NSTextCheckingResult *match in arrayRange) {
            NSString *code = [dataStr substringWithRange:[match rangeAtIndex:1]];
            if (code.intValue == 0) {
                isFail = NO;
            }
        }
        if (isFail) {
            [SVProgressHUD showAlert:nil msg:@"设置失败"];
            return;
        }
        curSelected = indexPath.row;
        UserData *userData = [UserDataManage getSelfUser];
        [userData setFriendVerifyType:[NSString stringWithFormat:@"%d",type]];
        [table reloadData];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
