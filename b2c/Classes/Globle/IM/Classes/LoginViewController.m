//
//  LoginViewController.m
//  IOSCim
//
//  Created by Administrator on 9/25/14.
//  Copyright (c) 2014 CIMForIOS. All rights reserved.
//

#import "LoginViewController.h"
#import "LoadingViewController.h"
#import "MyNotificationCenter.h"
#import "SystemConfig.h"
#import "SystemVariable.h"
#import "Tool.h"
#import "WebViewController.h"
#import "Config.h"

#define screenPaddingX 15

@implementation LoginViewController

#pragma mark - 生命周期

- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"isAutoLogined"];
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"dontCheckLogin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [SystemConfig init];
    
    [super viewDidLoad];
    
    // 屏幕尺寸
    CGRect screenRect = [Tool screenRect];
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    CGFloat navigationBarHeight = self.navigationController.navigationBar.bounds.size.height;
    
    // 背景图片
    CGRect backgroundViewRect = screenRect;
    if (IS_GTE_IOS7) {
        backgroundViewRect.origin.y -= (statusBarHeight + navigationBarHeight);
    }
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:backgroundViewRect];
    backgroundView.image = [UIImage imageNamed:@"appBG"];
    [self.view addSubview:backgroundView];
    
    if (IS_GTE_IOS7) {
        mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height - statusBarHeight - navigationBarHeight)];
        mainScrollView.contentSize = CGSizeMake(mainScrollView.frame.size.width, mainScrollView.frame.size.height);
    } else {
        mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
        mainScrollView.contentSize = CGSizeMake(mainScrollView.frame.size.width, screenRect.size.height - statusBarHeight);
    }
    mainScrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mainScrollView];
    
    // 用户头像
    static CGFloat avatarSize = 100.0f;
    UIImage *avatarImage = [UIImage imageNamed:@"avatar_default"];
    UIImageView *avatarView = [[UIImageView alloc] initWithFrame:CGRectZero];
    if (IS_GTE_IOS7) {
        avatarView.frame = CGRectMake((screenRect.size.width-avatarSize)/2, 20, avatarSize, avatarSize);
    } else {
        avatarView.frame = CGRectMake((screenRect.size.width-avatarSize)/2, navigationBarHeight+20, avatarSize, avatarSize);
    }
    avatarView.backgroundColor = [UIColor clearColor];
    avatarView.image = avatarImage;
    avatarView.layer.cornerRadius = avatarSize / 2;
    avatarView.layer.masksToBounds = YES;
    [mainScrollView addSubview:avatarView];
    
    // 登录表单
    static CGFloat textFieldHeight = 42;
    static CGFloat textFieldPadding = 20;
    UIView *formView = [[UIView alloc] initWithFrame:CGRectMake(screenPaddingX, avatarView.frame.origin.y+avatarView.frame.size.height+20, screenRect.size.width-screenPaddingX*2, textFieldHeight*2+1)];
    formView.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:formView];
    UIView *splitLine = [[UIView alloc] initWithFrame:CGRectMake(0, textFieldHeight, formView.bounds.size.width, 1)];
    splitLine.backgroundColor = [Tool colorWithHexString:@"d4d4d4"];
    [formView addSubview:splitLine];
    userLoginId = [[UITextField alloc] initWithFrame:CGRectMake(textFieldPadding, 0, formView.bounds.size.width-textFieldPadding*2, textFieldHeight)];
    userLoginId.autocorrectionType = UITextAutocorrectionTypeNo;
    userLoginId.backgroundColor = [UIColor clearColor];
    userLoginId.clearButtonMode = YES;
    userLoginId.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    userLoginId.placeholder = @"商盟通号码/手机/邮箱";
    userLoginId.delegate = self;
    userLoginId.returnKeyType = UIReturnKeyNext;
    [userLoginId addTarget:self action:@selector(nextTextFieldEvent:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [formView addSubview:userLoginId];
    userPassword = [[UITextField alloc] initWithFrame:CGRectMake(textFieldPadding, textFieldHeight+1, formView.bounds.size.width-textFieldPadding*2, textFieldHeight)];
    userPassword.backgroundColor = [UIColor clearColor];
    userPassword.clearButtonMode = YES;
    userPassword.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    userPassword.placeholder = @"点击输入商盟通密码";
    userPassword.secureTextEntry = YES;
    userPassword.returnKeyType = UIReturnKeyGo;
    userPassword.delegate = self;
    [formView addSubview:userPassword];
    
    // 查询历史所有登录账号
    loginUsersDict = [SystemConfig getMemberedLoginData];
    if ([[loginUsersDict allKeys] count] > 0) {
        // TODO: 仿照QQ登录界面，在userLoginId下添加历史登录账号选择的UIScrollView
    }
    
    // 在线状态
    UIView *optionView = [[UIView alloc] initWithFrame:CGRectMake(screenPaddingX, formView.frame.origin.y+formView.frame.size.height+20, screenRect.size.width-screenPaddingX*2, 33)];
    [mainScrollView addSubview:optionView];
    statusButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, optionView.frame.size.height)];
    [statusButton setBackgroundImage:[UIImage imageNamed:@"button_status"] forState:UIControlStateNormal];
    [statusButton setBackgroundImage:[UIImage imageNamed:@"button_status"] forState:UIControlStateNormal|UIControlStateHighlighted];
    [statusButton setBackgroundImage:[UIImage imageNamed:@"button_status"] forState:UIControlStateSelected|UIControlStateHighlighted];
    [statusButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon_online@2x" ofType:@"png"]] forState:UIControlStateNormal];
    [statusButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon_online@2x" ofType:@"png"]] forState:UIControlStateNormal|UIControlStateHighlighted];
    [statusButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon_offline@2x" ofType:@"png"]] forState:UIControlStateSelected];
    [statusButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon_offline@2x" ofType:@"png"]] forState:UIControlStateSelected|UIControlStateHighlighted];
    [statusButton setTitleColor:[Tool colorWithHexString:@"004f86"] forState:UIControlStateNormal];
    [statusButton setTitle:@" 在线" forState:UIControlStateNormal];
    [statusButton setTitle:@" 在线" forState:UIControlStateNormal|UIControlStateHighlighted];
    [statusButton setTitle:@" 隐身" forState:UIControlStateSelected];
    [statusButton setTitle:@" 隐身" forState:UIControlStateSelected|UIControlStateHighlighted];
    [statusButton addTarget:self action:@selector(statusButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
    [optionView addSubview:statusButton];
    [self updateStatusButton];
    
    // 自动登录
    autoLoginButton = [[UIButton alloc] initWithFrame:CGRectMake(optionView.frame.size.width-90, 0, 90, statusButton.frame.size.height)];
    [autoLoginButton setBackgroundColor:[UIColor clearColor]];
    [autoLoginButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"checkbox_empty@2x" ofType:@"png"]] forState:UIControlStateNormal];
    [autoLoginButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"checkbox_empty@2x" ofType:@"png"]] forState:UIControlStateNormal|UIControlStateHighlighted];
    [autoLoginButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"checkbox_checked@2x" ofType:@"png"]] forState:UIControlStateSelected];
    [autoLoginButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"checkbox_checked@2x" ofType:@"png"]] forState:UIControlStateSelected|UIControlStateHighlighted];
    [autoLoginButton setTitleColor:[Tool colorWithHexString:@"000000"] forState:UIControlStateNormal];
    [autoLoginButton setTitle:@"自动登录" forState:UIControlStateNormal];
    [autoLoginButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [autoLoginButton.titleLabel setTextAlignment:NSTextAlignmentRight];
    [autoLoginButton addTarget:self action:@selector(autoLoginButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
    [optionView addSubview:autoLoginButton];
    [self updateAutoLoginButton];
    
    // 记住密码
    rememberButton = [[UIButton alloc] initWithFrame:CGRectMake(autoLoginButton.frame.origin.x-95, 0, 90, statusButton.frame.size.height)];
    [rememberButton setBackgroundColor:[UIColor clearColor]];
    [rememberButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"checkbox_empty@2x" ofType:@"png"]] forState:UIControlStateNormal];
    [rememberButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"checkbox_empty@2x" ofType:@"png"]] forState:UIControlStateNormal|UIControlStateHighlighted];
    [rememberButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"checkbox_checked@2x" ofType:@"png"]] forState:UIControlStateSelected];
    [rememberButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"checkbox_checked@2x" ofType:@"png"]] forState:UIControlStateSelected|UIControlStateHighlighted];
    [rememberButton setTitleColor:[Tool colorWithHexString:@"000000"] forState:UIControlStateNormal];
    [rememberButton setTitle:@"记住密码" forState:UIControlStateNormal];
    [rememberButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [rememberButton.titleLabel setTextAlignment:NSTextAlignmentRight];
    [rememberButton addTarget:self action:@selector(rememberButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
    [optionView addSubview:rememberButton];
    [self updateRememberButton];
    
    // 登录按钮
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(screenPaddingX, optionView.frame.origin.y+optionView.frame.size.height+30, screenRect.size.width-screenPaddingX*2, 38)];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"button_login"] forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"button_login"] forState:UIControlStateHighlighted];
    [loginButton setTitleColor:[Tool colorWithHexString:@"004f86"] forState:UIControlStateNormal];
    [loginButton setTitle:@"登  录" forState:UIControlStateNormal];
    [loginButton.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [loginButton addTarget:self action:@selector(loginButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
    [mainScrollView addSubview:loginButton];
    /*
    // 忘记密码
    CGSize labelSize = [@"自动登录" sizeWithFont:[UIFont systemFontOfSize:16]];
    UIButton *forgetButton = [[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width/2-90, loginButton.frame.origin.y+loginButton.frame.size.height+20, labelSize.width, 40)];
    [forgetButton setTitleColor:[Tool colorWithHexString:@"004f86"] forState:UIControlStateNormal];
    [forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [forgetButton addTarget:self action:@selector(forgetButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
    [mainScrollView addSubview:forgetButton];
    
    // 注册商盟通
    labelSize = [@"注册商盟通" sizeWithFont:[UIFont systemFontOfSize:16]];
    UIButton *registerButton = [[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width/2+20, loginButton.frame.origin.y+loginButton.frame.size.height+20, labelSize.width, 40)];
    [registerButton setTitleColor:[Tool colorWithHexString:@"004f86"] forState:UIControlStateNormal];
    [registerButton setTitle:@"注册商盟通" forState:UIControlStateNormal];
    [registerButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [registerButton addTarget:self action:@selector(registerButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
    [mainScrollView addSubview:registerButton];
    */
    // 点击空白处隐藏键盘
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToHideKeyboard:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    mainScrollView.userInteractionEnabled = YES;
    [mainScrollView addGestureRecognizer:tapGestureRecognizer];
    
    // 查询最近一次登录帐号
    [self initLastLoginData];
}

- (void)viewWillAppear:(BOOL)animated {
    [self setTitle:@"欢迎登录"];
    [self.navigationController setNavigationBarHidden:NO];
    [MyNotificationCenter addObserver:self
                             selector:@selector(chooseMemberLoginIdClick:)
                                 name:SystemEventChooseMemberLoginId
                           obServerId:@"LoginUIController_chooseMemberLoginIdClick"];
    if (![SystemConfig isRememberParssword]) {
        userPassword.text = @"";
        rememberButton.selected = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [MyNotificationCenter removeObserver:self obServerId:@"LoginUIController_chooseMemberLoginIdClick"];
}


#pragma mark - 消息传递

// 选择历史登录账号
- (void)chooseMemberLoginIdClick:(NSMutableDictionary*)loginIdData {
    userLoginId.text = [loginIdData objectForKey:@"loginId"];
    userPassword.text = [loginIdData objectForKey:@"password"];
}


#pragma mark - UITextField
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == userLoginId) {
        userLoginIsShow = YES;
    }
    if (textField == userPassword) {
        passWordIsShow = YES;
    }
    if (!isShowKeyboard) {
        CGRect scrollViewRect = mainScrollView.frame;
        scrollViewRect.size.height -= 246;
        mainScrollView.frame = scrollViewRect;
        isShowKeyboard = YES;
    }
    
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (textField == userLoginId) {
        userLoginIsShow = NO;
    }
    if (textField == userPassword) {
        passWordIsShow = NO;
    }
    if (!userLoginIsShow && !passWordIsShow && isShowKeyboard) {
        CGRect scrollViewRect = mainScrollView.frame;
        scrollViewRect.size.height += 246;
        mainScrollView.frame = scrollViewRect;
        isShowKeyboard = NO;
    }
    return YES;
}
// 完成填写商盟通账号
- (void)nextTextFieldEvent:(id)sender {
    if (sender == userLoginId) {
        [userPassword becomeFirstResponder];
    }
}

// UITextFieldDelegate委托协议
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == userPassword) {
        [userPassword resignFirstResponder];
        LoadingViewController *loadingController = [[LoadingViewController alloc] init];
        loadingController.userLoginId = userLoginId.text;
        loadingController.userPassword = userPassword.text;
        if ([userLoginId.text length] == 0 || [userPassword.text length] == 0) {
            return YES;
        }
        if ([SystemConfig getAutoLogin]) {
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"isAutoLogined"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        [self.navigationController pushViewController:loadingController animated:YES];
        return YES;
    }
    return YES;
}


#pragma mark - UIButton

// 在线状态按键事件
- (void)statusButtonTouchDown:(UIButton *)sender {
    statusButton.selected = !statusButton.selected;
    [SystemConfig setLoginStatus];
}

// 自动登录按键事件
- (void)autoLoginButtonTouchDown:(UIButton *)sender {
    autoLoginButton.selected = !autoLoginButton.selected;
    [SystemConfig setAutoLogin];
}

// 记住密码按键事件
- (void)rememberButtonTouchDown:(UIButton *)sender {
    rememberButton.selected = !rememberButton.selected;
    [SystemConfig setRememberPassword];
}

// 登录按键事件
- (void)loginButtonTouchDown:(UIButton *)sender {
    LoadingViewController *loadingController = [[LoadingViewController alloc] init];
    loadingController.userLoginId = userLoginId.text;
    loadingController.userPassword = userPassword.text;
    if ([userLoginId.text length] == 0 || [userPassword.text length] == 0) {
        return;
    }
    if ([SystemConfig getAutoLogin]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"isAutoLogined"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    [self.navigationController pushViewController:loadingController animated:YES];
}

// 忘记密码按键事件
- (void)forgetButtonTouchDown:(UIButton *)sender {
    WebViewController *wvc = [[WebViewController alloc] init];
    [wvc initData:@"找回密码" url:[NSString stringWithFormat:@"%@/zrtRegister/find_pwd_phone.html?HttpPort=7001&WindHand=1444358&loginId=zs-1021", [Config getProjectPath]]];
    [self.navigationController pushViewController:wvc animated:YES];
}

// 注册商盟通按键事件
- (void)registerButtonTouchDown:(UIButton *)sender {
    WebViewController *wvc = [[WebViewController alloc] init];
    [wvc initData:@"商盟通注册" url:[NSString stringWithFormat:@"%@/zrtRegister/zrtPhoneReg.html", [Config getProjectPath]]];
    [self.navigationController pushViewController:wvc animated:YES];
}


#pragma mark - 自定义方法

// 点击空白处隐藏键盘
- (void)tapToHideKeyboard:(UITapGestureRecognizer *)tap {
    if ([userLoginId isFirstResponder]) {
        [userLoginId resignFirstResponder];
    } else if ([userPassword isFirstResponder]) {
        [userPassword resignFirstResponder];
    }
    if (isShowKeyboard) {
        CGRect scrollViewRect = mainScrollView.frame;
        scrollViewRect.size.height += 246;
        mainScrollView.frame = scrollViewRect;
        isShowKeyboard = NO;
    }
}

// 最近一次登录帐号
- (void)initLastLoginData {
    NSMutableDictionary *lastLoginData = [SystemConfig getLassLoginData];
    if (lastLoginData == nil) {
        return;
    }
    userLoginId.text = [lastLoginData objectForKey:@"loginId"];
    if ([SystemConfig isRememberParssword]) {
        userPassword.text = [lastLoginData objectForKey:@"password"];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *isAutoLogined = [userDefaults objectForKey:@"isAutoLogined"];
        if ([SystemConfig getAutoLogin] && [userLoginId.text length] > 0 && [userPassword.text length] > 0 && [isAutoLogined isEqualToString:@"0"]) {
            [NSTimer scheduledTimerWithTimeInterval:.6 target:self selector:@selector(loginButtonTouchDown:) userInfo:nil repeats:NO];
        }
    }
}

// 更新登录状态按键
- (void)updateStatusButton {
    if ([SystemConfig getLoginStatus]) {
        statusButton.selected = true;
    } else {
        statusButton.selected = false;
    }
}

// 更新自动登录按键
- (void)updateAutoLoginButton {
    if ([SystemConfig getAutoLogin]) {
        autoLoginButton.selected = true;
    } else {
        autoLoginButton.selected = false;
    }
}

// 更新记住密码按键
- (void)updateRememberButton {
    if ([SystemConfig isRememberParssword]) {
        rememberButton.selected = true;
    } else {
        rememberButton.selected = false;
    }
}
@end
