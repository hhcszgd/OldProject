//
//  MainViewController.m
//  IOSCim
//
//  Created by fei lan on 14-9-24.
//  Copyright (c) 2014年 CIMForIOS. All rights reserved.
//

#import "MainViewController.h"
#import "LoginViewController.h"
#import "WebViewController.h"
#import "SystemVariable.h"
#import "SystemConfig.h"
#import "Tool.h"
#import "MyNotificationCenter.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backHP:) name:@"backHP" object:nil];
    //[MyNotificationCenter addObserver:self selector:@selector(gotoLoginPage:) name:SystenEventGoToLoginPage obServerId:@"MainViewController_gotoLoginPage"];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"isAutoLogined"];
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"dontCheckLogin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    title = @"首页";
    //全屏大小
    CGRect mainRect = [Tool screenRect];
    //状态栏高度
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    //导航栏高度
    CGFloat navigationBarHeight = self.navigationController.navigationBar.bounds.size.height;
    
    // 导航委托
    navDelegate = [UINavigationDelegate alloc];
    self.navigationController.delegate = navDelegate;
    [SystemConfig init];
    
    //背景图
    CGRect backgroundViewRect = mainRect;
    if (IS_GTE_IOS7) {
        backgroundViewRect.origin.y -= (statusBarHeight + navigationBarHeight);
    }
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:backgroundViewRect];
    backgroundView.image = [UIImage imageNamed:@"appBG"];
    [self.view addSubview:backgroundView];
    
    //按钮
    CGFloat buttonSize = mainRect.size.width / 3;
    CGFloat sLine = buttonSize / 3;
    //按钮布局
    CGRect leftButtonRect = CGRectMake(sLine, mainRect.size.height / 4 - buttonSize, buttonSize, buttonSize);
    CGRect rightButtonRect = CGRectMake(2 * sLine + buttonSize, mainRect.size.height / 4 - buttonSize, buttonSize, buttonSize);
    if (IS_GTE_IOS7) {
    } else {
        leftButtonRect.origin.y += navigationBarHeight;
        rightButtonRect.origin.y += navigationBarHeight;
    }
    //第一行
    {
        //即时通讯按钮
        [self createButton:leftButtonRect tag:1];
        //有机标志查询
        [self createButton:rightButtonRect tag:2];
    }
    leftButtonRect.origin.y += sLine + buttonSize;
    rightButtonRect.origin.y += sLine + buttonSize;
    //第二行
    {
        //强制性标志查询
        [self createButton:leftButtonRect tag:3];
        //有机证书查询
        [self createButton:rightButtonRect tag:4];
    }
    leftButtonRect.origin.y += sLine + buttonSize;
    rightButtonRect.origin.y += sLine + buttonSize;
    //第三行
    {
        //我有疑问
        [self createButton:leftButtonRect tag:5];
        //关于商盟通
        [self createButton:rightButtonRect tag:6];
    }
    
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)createButton:(CGRect)rect tag:(int)tag {
    UIButton *buttonOne = [[UIButton alloc] initWithFrame:rect];
    buttonOne.tag = tag;
    [buttonOne setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"mainImg%d", tag]] forState:UIControlStateNormal];
    [buttonOne setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"mainImg%d", tag]] forState:UIControlStateHighlighted];
    [buttonOne addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonOne];
}
//按钮点击事件
- (void)buttonClick:(UIButton *)button {
    if (button.tag == 1) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if ([[userDefaults objectForKey:@"dontCheckLogin"] isEqualToString:@"1"] && tempViewController) {
            [userDefaults setObject:@"0" forKey:@"dontCheckLogin"];
            [userDefaults synchronize];
            [self.navigationController pushViewController:tempViewController animated:YES];
        } else {
            LoginViewController *lvc = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:lvc animated:YES];
        }
    } else if (button.tag == 2) {
        /*WebViewController *wvc = [[WebViewController alloc] init];
        [wvc initData:@"综合服务" url:@"http://im1.ggwork.net:8878/ggmail/mail/login_jump.html"];
        [self.navigationController pushViewController:wvc animated:YES];*/
    }
}
- (void)backHP:(NSNotification *)notification {
    tempViewController = [notification object];
    [self.navigationController popToViewController:self animated:YES];
}
- (void)gotoLoginPage:(id)sender {
    [self.navigationController popToViewController:self animated:NO];
    LoginViewController *lvc = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:lvc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
