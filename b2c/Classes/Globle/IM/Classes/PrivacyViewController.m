//
//  PrivacyViewController.m
//  IOSCim
//
//  Created by fei lan on 14-10-22.
//  Copyright (c) 2014年 CIMForIOS. All rights reserved.
//

#import "PrivacyViewController.h"
#import "Tool.h"
#import "SystemVariable.h"
#import "UserVerifyViewController.h"

@interface PrivacyViewController ()

@end

@implementation PrivacyViewController

- (void)viewDidLoad {
    title = @"隐私与权限";
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
    [self.view addSubview:table];
    [super viewDidLoad];
}
//行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
//生成行
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = @"添加好友验证";
    return cell;
}
//行点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UserVerifyViewController *uvc = [[UserVerifyViewController alloc] init];
    [self.navigationController pushViewController:uvc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
