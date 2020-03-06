//
//  EditUserInfoViewController.m
//  IOSCim
//
//  Created by fei lan on 14-10-15.
//  Copyright (c) 2014年 CIMForIOS. All rights reserved.
//

#import "EditUserInfoViewController.h"
#import "Tool.h"
#import "UserData.h"
#import "UserDataManage.h"
#import "SystemVariable.h"
#import "SVProgressHUD.h"
#import "WSCallerBlock.h"
#import "Config.h"

@interface EditUserInfoViewController ()

@end

@implementation EditUserInfoViewController
@synthesize infoType;

- (void)viewDidLoad {
    if (infoType == 0) {
        title = @"修改昵称";
    } else {
        title = @"修改签名";
    }
    isShowBackButton = YES;
    //全屏大小
    mainRect = [Tool screenRect];
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
    [self initView];
    
    CGRect tableRect;
    if (IS_GTE_IOS7) {
        tableRect = CGRectMake(0, 0, mainRect.size.width, mainRect.size.height - (statusBarHeight + navigationBarHeight));
    } else {
        tableRect = CGRectMake(0, navigationBarHeight, mainRect.size.width, mainRect.size.height - (statusBarHeight + navigationBarHeight));
    }
    table = [[UITableView alloc] initWithFrame:tableRect style:UITableViewStyleGrouped];
    table.dataSource = self;
    table.delegate = self;
    table.layer.opacity = 0.8;
    table.scrollEnabled = NO;
    [self.view addSubview:table];
}
//创建导航条确认按钮, 文本输入框, (当前设置项为性别时 则不需要这两个)
- (void)initView {
    UIButton *completeButton = [self headeButton:@"确定" image:nil];
    [completeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [completeButton addTarget:self action:@selector(completeOnCheckButton:) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:completeButton];
    self.navigationItem.rightBarButtonItem = rightBtn;
    textField = [[InsetsTextField alloc] initWithFrame:CGRectMake(0, 0, mainRect.size.width - 20, 40)];
    UserData *userData = [UserDataManage getSelfUser];
    if (infoType == 0) {
        textField.text = userData.nickname;
    } else {
        textField.text = userData.idiograph;
    }
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.clearButtonMode = YES;
    textField.delegate = self;
    textField.returnKeyType = UIReturnKeyDone;
}
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
//生成行
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    }
    [cell.contentView addSubview:textField];
    return cell;
}
//点击键盘上的完成按钮事件
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self completeOnCheckButton:nil];
    return YES;
}
//确定按钮事件
- (void)completeOnCheckButton:(id)sender {
    [textField resignFirstResponder];
    NSString *text = textField.text;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"setUser" forKey:@"function"];
    [params setObject:@"edt" forKey:@"op"];
    [params setObject:[userDefault objectForKey:@"sessionId"] forKey:@"sessionId"];
    [params setObject:[userDefault objectForKey:@"userId"] forKey:@"userId"];
    if (infoType == 0) {
        if ([text length] == 0) {
            [SVProgressHUD showAlert:nil msg:@"昵称不能为空"];
            return;
        }
        [params setObject:text forKey:@"nickName"];
    } else {
        [params setObject:text forKey:@"idiograph"];
    }
    WSCallerBlock *http = [[WSCallerBlock alloc] init];
    
    [http callPost:[Config getPath] params:params delegate:self usingBlock:^(NSData *data) {
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
            [SVProgressHUD showAlert:nil msg:@"修改失败"];
            return;
        }
        UserData *userData = [UserDataManage getSelfUser];
        if (infoType == 0) {
            userData.nickname = text;
        } else {
            userData.idiograph = text;
        }
        [SVProgressHUD showAlert:nil msg:@"修改成功"];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
