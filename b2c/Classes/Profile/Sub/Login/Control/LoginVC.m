//
//  LoginVC.m
//  TTmall
//
//  Created by wangyuanfei on 2/18/16.
//  Copyright © 2016 Footway tech. All rights reserved.
//

#import "LoginVC.h"

//#import "UM"
#import "GDXmppStreamManager.h"

#import "UMSocial.h"

//#import "RegisterVC.h"
@interface LoginVC ()<UITableViewDelegate , UITableViewDataSource , UITextFieldDelegate>
/** 企业logo */
@property(nonatomic,weak)UIImageView * logoImg ;//
/** 用户名,密码容器视图 */
@property(nonatomic,weak)UIView * userInfoContainer ;//
/** 登录相关控件容器 */
//@property(nonatomic,weak)UIView * loginContainer ;
/** 第三方登录 */
@property(nonatomic,weak)UIView * otherAccountContainer ;//
//@property(nonatomic,<#copy?assign?weak?strong#>)<#class#> <#*#> <#name#> ;
/** 用户名输入提示 */
@property(nonatomic,weak)UILabel * accountName ;
/** 用户名输入框 */
@property(nonatomic,weak)UITextField * accountInput ;//
/** 选择用户名下拉箭头 */
@property(nonatomic,weak)UIButton * chooseAccount ;
/** 待选用户名视图 */
@property(nonatomic,weak)UITableView * accountsView ;
/** 盛放所有用户名的数组 这个需要本地存储在这台设备上登录过的用户名*/
@property(nonatomic,strong)NSMutableArray * accounts ;
/** 密码输入提示 */
@property(nonatomic,weak)UILabel * password ;
/** 密码输入框 */
@property(nonatomic,weak)UITextField * passwordInput ;//
/** 密码可见性按钮 */
@property(nonatomic,weak)UIButton * eyeable ;
/** 登录按钮 */
@property(nonatomic,weak)UIButton * login ;//
/** 其他账户登录 */
@property(nonatomic,weak)UIButton * otherAccountLogin ;//
/** 找回密码 */
@property(nonatomic,weak)UIButton * forgetPassword ;//
/** 注册 */
@property(nonatomic,weak)UIButton * registerButton ;//
/** 下半部分控件的容器控件, 方便整体下移 */
@property(nonatomic,weak)UIView * bottomContainer ;
/**
 UIView * accountContainer = [[UIView alloc]init];
 UIView * passwordContainer = [[UIView alloc]init];
 */
@property(nonatomic,strong)  MASConstraint * accountsViewHeight ;
@property(nonatomic,weak) UIView * accountContainer  ;
@property(nonatomic,weak) UIView * passwordContainer  ;
@property(nonatomic,strong)  MASConstraint * changeConstraint  ;
@end

@implementation LoginVC


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self loginClick:self.login];
    return YES;
}


-(void)loginByOtherPlayformAccount:(UIButton*)sender
{
    if (sender.tag==1828380) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"微信登录");//////////////////////////////////////////////////////
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
        
        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
            LOG(@"_%@_%d_%@",[self class] , __LINE__,response);
            if (response.responseCode == UMSResponseCodeSuccess) {
                
//                NSDictionary *dict = [UMSocialAccountManager socialAccountDictionary];
                UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
//                [self operatetAfterAuthorWith:snsAccount andPlatformName:@"weixin"];
                snsAccount.platformName = @"wechat";
                [self operatetAfterAuthorWith:snsAccount origenRespons:response];
                NSString * platformInfo = [NSString stringWithFormat:@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n thirdPlatformUserProfile = %@,\n thirdPlatformResponse = %@ \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message];
                LOG(@"_%@_%d_%@",[self class] , __LINE__,platformInfo);
                
//                NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n thirdPlatformUserProfile = %@,\n thirdPlatformResponse = %@ \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message);\
                
                
                
                
                
            }else{
                LOG(@"_%@_%d_%@",[self class] , __LINE__,response.message);
                AlertInVC(response.message);
            }
            
        });
    }else if (sender.tag == 1828381){
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"微博登录");/////////////////////////////////////////////////////
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
        
        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
            LOG(@"_%@_%d_%@",[self class] , __LINE__,response);
            //          获取微博用户名、uid、token等
            
            if (response.responseCode == UMSResponseCodeSuccess) {
                
//                NSDictionary *dict = [UMSocialAccountManager socialAccountDictionary];
                UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
//                [self operatetAfterAuthorWith:snsAccount andPlatformName:@"sina"];
                snsAccount.platformName = @"sina";
                [self operatetAfterAuthorWith:snsAccount origenRespons:response];
                NSString * platformInfo = [NSString stringWithFormat:@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n thirdPlatformUserProfile = %@,\n thirdPlatformResponse = %@ \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message];
                LOG(@"_%@_%d_%@",[self class] , __LINE__,platformInfo);
                
//                NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n thirdPlatformUserProfile = %@,\n thirdPlatformResponse = %@ \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message);
                
            }else{
                LOG(@"_%@_%d_%@",[self class] , __LINE__,@(response.responseCode));
                LOG(@"_%@_%d_%@",[self class] , __LINE__,response.message);
                AlertInVC(response.message);
            
            }
        
        
        
        
        });
    }else if (sender.tag == 1828382){
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"qq登录");/////////////////////////////////////////////////////
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
        
        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
            LOG(@"_%@_%d_%@",[self class] , __LINE__,response);
            //          获取微博用户名、uid、token等
            
            if (response.responseCode == UMSResponseCodeSuccess) {
                
//                NSDictionary *dict = [UMSocialAccountManager socialAccountDictionary];
                UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
                snsAccount.platformName = @"qq";
                [self operatetAfterAuthorWith:snsAccount origenRespons:response];
                
//                [self operatetAfterAuthorWith:snsAccount andPlatformName:@"QQ"];
                NSString * platformInfo = [NSString stringWithFormat:@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n thirdPlatformUserProfile = %@,\n thirdPlatformResponse = %@ \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message];
                LOG(@"_%@_%d_%@",[self class] , __LINE__,platformInfo);
                
//                NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n thirdPlatformUserProfile = %@,\n thirdPlatformResponse = %@ \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message);
                /** 登录成功信息 */
                
//                username = 下一站,
//                usid = 757DC92B936D2D64B6021F5C193487DD,
//                token = 4D916656F43807F524BD844ECD7A567D iconUrl = http://q.qlogo.cn/qqapp/1105439736/757DC92B936D2D64B6021F5C193487DD/100,
//                unionId = (null),
//                thirdPlatformUserProfile = {
//                    is_lost = 0;
//                    figureurl = http://qzapp.qlogo.cn/qzapp/1105439736/757DC92B936D2D64B6021F5C193487DD/30;
//                    vip = 0;
//                    is_yellow_year_vip = 0;
//                    province = 河南;
//                    ret = 0;
//                    is_yellow_vip = 0;
//                    figureurl_qq_1 = http://q.qlogo.cn/qqapp/1105439736/757DC92B936D2D64B6021F5C193487DD/40;
//                    yellow_vip_level = 0;
//                    level = 0;
//                    figureurl_1 = http://qzapp.qlogo.cn/qzapp/1105439736/757DC92B936D2D64B6021F5C193487DD/50;
//                    city = 周口;
//                    figureurl_2 = http://qzapp.qlogo.cn/qzapp/1105439736/757DC92B936D2D64B6021F5C193487DD/100;
//                    nickname = 下一站;
//                    msg = ;
//                    gender = 男;
//                    figureurl_qq_2 = http://q.qlogo.cn/qqapp/1105439736/757DC92B936D2D64B6021F5C193487DD/100;
//                }
//                ,
//                thirdPlatformResponse = <TencentOAuth: 0x7fb594b066d0> 
//                , message = no error

            }else{
                LOG(@"_%@_%d_%@",[self class] , __LINE__,response.message);
                AlertInVC(response.message);
            }
        
        });
    }
}
-(void)operatetAfterAuthorWith:(UMSocialAccountEntity*)snsAccount origenRespons:(UMSocialResponseEntity*)origenRespons{
    [[UserInfo shareUserInfo] saveThirdPlayromAccountInfomationWithSnsAccount:snsAccount origenRespons:origenRespons  success:^(ResponseObject *responseObject) {
        if (responseObject.status==202) {
            BaseModel * model = [[BaseModel alloc]init];
            model.actionKey  =  @"BindingMobileAfterAuthorVC";
            model.keyParamete = @{
                                  @"paramete":snsAccount
                                  };
            [[SkipManager shareSkipManager] skipByVC:self withActionModel:model];
        }else if (responseObject.status==200){
            //保存账户信息 , 直接处于登录状态 , 调到个人中心
            
            [UserInfo shareUserInfo].member_id = responseObject.data;
            [[UserInfo shareUserInfo] save];
            

            
            [[UserInfo shareUserInfo] gotPersonalInfoSuccess:^(ResponseStatus response) {
                if (response>0) {
                    if ((![GDXmppStreamManager ShareXMPPManager].XmppStream.isConnected && ![GDXmppStreamManager ShareXMPPManager].XmppStream.isConnecting) ) {
                       // LOG(@"_%@_%d_登录IM时用得token%@",[self class] , __LINE__,[UserInfo shareUserInfo].token);

                        [[GDXmppStreamManager ShareXMPPManager]loginWithJID:[XMPPJID jidWithUser:[UserInfo shareUserInfo].imName domain:JabberDomain resource:@"iOS"] passWord:[UserInfo shareUserInfo].token];
//                        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"执行登录");
                    }
                    [[NSNotificationCenter defaultCenter] postNotificationName:LOGINSUCCESS object:nil];
                    if ([self.mydelegate  respondsToSelector:@selector(sbloginsuccessed:)]) {
                        [self.mydelegate  sbloginsuccessed:self ];
                    }
                    [self.navigationController dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                }else{
                    GDlog(@"查询不到用户信息")
                }
            } failure:^(NSError *error) {
                //                AlertInVC(@"登录失败,请重试")
                GDlog(@"第三方登录时 , 获取个人信息失败")
            }];
            GDlog(@"之前已经授权过了 , 直接保存用户信息处于登录状态")
        }else if(responseObject.status<0){
            AlertInVC(@"登录失败,请重试")
        }
        
        
        GDlog(responseObject.data)
    } failure:^(NSError *error) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
    }];


}



//-(void)operatetAfterAuthorWith:(UMSocialAccountEntity*)snsAccount andPlatformName:(NSString*)platformName{
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,snsAccount.platformName);
//
////    
//    [[UserInfo shareUserInfo] saveThirdPlayromAccountInfomationWithOpenID:snsAccount.usid accessToken:snsAccount.accessToken source:snsAccount.platformName success:^(ResponseObject *responseObject) {
//        if (responseObject.status==202) {
//            snsAccount.platformName = platformName;
//            BaseModel * model = [[BaseModel alloc]init];
//            model.actionKey  =  @"BindingMobileAfterAuthorVC";
//            model.keyParamete = @{
//                                  @"paramete":snsAccount
//                                  };
//            [[SkipManager shareSkipManager] skipByVC:self withActionModel:model];
//        }else if (responseObject.status==200){
//            //保存账户信息 , 直接处于登录状态 , 调到个人中心
//            [UserInfo shareUserInfo].member_id = responseObject.data;
//            [[UserInfo shareUserInfo] save];
//            [[UserInfo shareUserInfo] gotPersonalInfoSuccess:^(ResponseStatus response) {
//                if (response>0) {
//                    [[NSNotificationCenter defaultCenter] postNotificationName:LOGINSUCCESS object:nil];
//                    [self.navigationController dismissViewControllerAnimated:YES completion:^{
//                        
//                    }];
//                }else{
//                    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"查询不到用户信息");
//                }
//            } failure:^(NSError *error) {
////                AlertInVC(@"登录失败,请重试")
//                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"第三方登录时 , 获取个人信息失败");
//            }];
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"之前已经授权过了 , 直接保存用户信息处于登录状态");
//        }else if(responseObject.status<0){
//            AlertInVC(@"登录失败,请重试")
//        }
//        
//        
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
//    } failure:^(NSError *error) {
//      LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
//    }];
//
//}
-(void)otherAccountLoginClick:(UIButton *)sender
{
    
    
#pragma mark 弹出新的 第三方登录控制器 TODO
    [self.view endEditing:YES];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"执行第三方登录 , 待完成")
}
-(void)forgetPasswordClick:(UIButton *)sender
{
#pragma mark 弹出新的 找回密码控制器 TODO
    [self.view endEditing:YES];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"执行找回密码 , 待完成")
    BaseModel * model = [[BaseModel alloc]init];
    model.actionKey = @"ForgetPasswordVC";
    [[SkipManager shareSkipManager] skipByVC:self withActionModel:model];
    
}
-(void)registerButtonClick:(UIButton *)sender
{
#pragma mark 弹出新的 注册控制器 TODO
    [self.view endEditing:YES];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"执行新用户注册 , 待完成")
    BaseModel * model = [[BaseModel alloc]init];
    model.actionKey = @"RegisterVC";
    [[SkipManager shareSkipManager] skipByVC:self withActionModel:model];
    //    [[SkipManager shareSkipManager] skipByVC:self urlStr:nil title:@"注册" action:@"RegisterVC"];
}


- (void)viewDidLoad {

    [super viewDidLoad];
    self.naviTitle = @"登录";
    UIButton * backBtn = [[UIButton alloc]init];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
    [backBtn  setImage:[UIImage imageNamed:@"header_leftbtn_nor"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(dismissLogin) forControlEvents:UIControlEventTouchUpInside];
    self.navigationBarLeftActionViews = @[backBtn];
    self.view.backgroundColor= BackgroundGray;
    [self setupSubviews];
    
    
//    [super viewDidLoad];
//    self.naviTitle = @"登录";
//    UIView * backBtnContainer = [[UIView alloc]init];
//    ActionBaseView * btn = [[ActionBaseView alloc]init];
//    
//    btn.bounds=CGRectMake(0, 0, 26, 26);
//    [btn addTarget:self action:@selector(dismissLogin) forControlEvents:UIControlEventTouchUpInside];
//    [backBtnContainer addSubview:btn];
//    btn.img=[UIImage imageNamed:@"ar_back"];
//    self.navigationBarLeftActionViews = @[backBtnContainer];
//    btn.center=backBtnContainer.center;
//    self.view.backgroundColor= BackgroundGray;
//    [self setupSubviews];

}
-(void)dismissLogin
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}
/** 导航栏下的细横线 */
-(void)testNaviBar
{
    
    UIView * test =[[UIView alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.bounds.size.height, screenW, 3) ];
    test.backgroundColor=[UIColor greenColor];
    [self.navigationController.navigationBar addSubview:test];
}
//添加子控价
-(void)setupSubviews{
    UIImageView * logoImg = [[UIImageView alloc]init];
    logoImg.contentMode = UIViewContentModeScaleAspectFill ;
    logoImg.image = [UIImage imageNamed:@"icon_logo"];
    self.logoImg = logoImg;
    [self.view addSubview:logoImg];
//    logoImg.backgroundColor = [UIColor whiteColor];
    /** 登录相关容器视图 */
    UIView * userInfoContainer = [[UIView alloc]init];
    self.userInfoContainer = userInfoContainer;
    [self.view addSubview:userInfoContainer];
//    userInfoContainer.backgroundColor = randomColor;

//    UIView * loginContainer = [[UIView alloc]init];
//    [self.view addSubview:loginContainer];
//    self.loginContainer = loginContainer;
//    loginContainer.backgroundColor = randomColor;
    
    /** 三方登录容器视图 */
    UIView * otherAccountContainer = [[UIView alloc]init];
    self.otherAccountContainer = otherAccountContainer;
    [self.view addSubview:otherAccountContainer];
//    otherAccountContainer.backgroundColor = randomColor;
//    [self laysubview];
    
    /** 布局容器视图开始 */
    /** 设置间距 */
    CGFloat passwordToLoginBtn = 52 * SCALE*SCALE;
    CGFloat accountNameToPassword = 22*SCALE ;
    CGFloat loginBtnToForget = 18*SCALE;
    CGFloat logoImgToTop = 88 *SCALE;
    /** 企业logo */
    CGFloat logoImgW = 176*SCALE ;
    CGFloat logoImgH = 54*SCALE  ;
    CGFloat LogoImgX = (screenW - logoImgW)/2 ;
    CGFloat logoImgY = logoImgToTop;
    self.logoImg.frame = CGRectMake(LogoImgX, logoImgY, logoImgW, logoImgH);
    
    
    /** 登录布局 */
    CGFloat componentH = 40*SCALE;//登录按钮 , 密码框 , 用户名框的高度
    CGFloat forgetPasswordH = 30*SCALE ;
    CGFloat userInfoContainerW = 262*SCALE;
    CGFloat userInfoContainerH = componentH+accountNameToPassword+componentH+passwordToLoginBtn+componentH +loginBtnToForget+forgetPasswordH;//两个输入框一个按钮 + 三个间距+忘记密码的高度
    CGFloat userInfoContainerX = (screenW - userInfoContainerW)/2 ;
    CGFloat userInfoContainerY = CGRectGetMaxY(self.logoImg.frame)+26*SCALE*SCALE;
    
    self.userInfoContainer.frame = CGRectMake(userInfoContainerX, userInfoContainerY, userInfoContainerW, userInfoContainerH);
    
    //布局二级子控件
    
    /** 三方登录布局 */
    CGFloat otherLoginTipsW = 262*SCALE;
    CGFloat otherLoginTipsH = 14*SCALE ;
    CGFloat tipsToIcon = 27 *SCALE;
    CGFloat iconH = 50*SCALE ;
    CGFloat iconToIcon = 20*SCALE ;
    CGFloat otherW = otherLoginTipsW;
    CGFloat otherH = otherLoginTipsH + tipsToIcon + iconH;
    //    CGFloat otherY = CGRectGetMaxY(self.userInfoContainer.frame)+ userInfoContainerToOtherActountContainer;
    CGFloat otherToBottom = 30*SCALE*SCALE ;
    CGFloat otherY = screenH - otherH - otherToBottom;
    CGFloat otherX = (screenW - otherW)/2 ;
    self.otherAccountContainer.frame = CGRectMake(otherX, otherY, otherW , otherH);
    //布局二级子控件
    /** 布局容器视图结束 */
    //登录信息二级子控件
    //账户名
    UIView * accountNameContainer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.userInfoContainer.bounds.size.width,componentH)];
    [self setcornerWithView:accountNameContainer];
//    accountNameContainer.backgroundColor  = randomColor;
    [self.userInfoContainer addSubview:accountNameContainer];
    //图标
    UIImageView * accountIcon = [[UIImageView alloc]initWithFrame:CGRectMake(accountNameContainer.bounds.size.height/4, accountNameContainer.bounds.size.height/4, accountNameContainer.bounds.size.height/2, accountNameContainer.bounds.size.height/2)];
    accountIcon.contentMode = UIViewContentModeScaleAspectFit;
    accountIcon.image = [UIImage imageNamed:@"icon_phone"];
    [accountNameContainer addSubview:accountIcon];
    
    //输入框
    UITextField * accountInput =[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(accountIcon.frame)+CGRectGetMinX(accountIcon.frame), 0, accountNameContainer.bounds.size.width - CGRectGetMaxX(accountIcon.frame)- CGRectGetMinX(accountIcon.frame), accountNameContainer.bounds.size.height)];
//    accountInput.backgroundColor = randomColor;
    accountInput.font = [UIFont systemFontOfSize:14*SCALE];
    accountInput.placeholder = @"请输入手机,邮箱或用户名";
    [accountNameContainer addSubview:accountInput];
    self.accountInput =accountInput ;
#pragma mark 临时赋值
    self.accountInput.text = [[NSUserDefaults standardUserDefaults] objectForKey:RECENTACCOUNTNAME];
    

    //密码
    UIView * passwordContainer = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(accountNameContainer.frame)+accountNameToPassword, self.userInfoContainer.bounds.size.width,componentH)];
    [self setcornerWithView:passwordContainer];
    [self.userInfoContainer addSubview:passwordContainer];
    
    UIImageView * passwordIcon = [[UIImageView alloc]initWithFrame:CGRectMake(passwordContainer.bounds.size.height/4, passwordContainer.bounds.size.height/4, passwordContainer.bounds.size.height/2, passwordContainer.bounds.size.height/2)];
    passwordIcon.contentMode = UIViewContentModeScaleAspectFit;
    passwordIcon.image = [UIImage imageNamed:@"icon_password"];
    [passwordContainer addSubview:passwordIcon];
    
    UITextField * passwordInput =[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(passwordIcon.frame)+CGRectGetMinX(accountIcon.frame), 0, accountNameContainer.bounds.size.width - CGRectGetMaxX(passwordIcon.frame)- CGRectGetMinX(passwordIcon.frame), passwordContainer.bounds.size.height)];
    passwordInput.font = [UIFont systemFontOfSize:14*SCALE];
    passwordInput.placeholder = @"密码为6~16个字符 区分大小写";
    passwordInput.secureTextEntry=YES;
    [passwordContainer addSubview:passwordInput];
    self.passwordInput =passwordInput ;
    
    
    self.passwordInput.delegate = self ;
    self.accountInput.delegate = self ;
    //登录按钮
    UIButton * loginBtn = [[UIButton  alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(passwordContainer.frame)+passwordToLoginBtn, self.userInfoContainer.bounds.size.width, componentH)];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitle:@"取消" forState:UIControlStateSelected];
    loginBtn.backgroundColor = [UIColor redColor];
    [loginBtn addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
//    loginBtn.enabled = NO;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
//    [self setcornerWithView:loginBtn];
    loginBtn.layer.cornerRadius = loginBtn.bounds.size.height/2;
    loginBtn.layer.masksToBounds = YES;
    loginBtn.backgroundColor = THEMECOLOR;
    self.login = loginBtn;
    [self.userInfoContainer addSubview:loginBtn];
    
    
    //注册 / 忘记密码按钮
    UIButton * registerButton = [[UIButton alloc]init];
    [registerButton setTitle:@"快速注册" forState:UIControlStateNormal];
    [registerButton setTitleColor:MainTextColor forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    CGSize btnTxtSize =    [registerButton.currentTitle sizeWithFont:registerButton.titleLabel.font MaxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    registerButton.frame = CGRectMake(0, CGRectGetMaxY(loginBtn.frame)+ loginBtnToForget, btnTxtSize.width, forgetPasswordH);
    self.registerButton = registerButton ;
    [self.userInfoContainer addSubview:registerButton];
    
    
    
    UIButton * forgetPassword = [[UIButton alloc]init];
    [forgetPassword setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetPassword addTarget:self action:@selector(forgetPasswordClick:) forControlEvents:UIControlEventTouchUpInside];
    [forgetPassword setTitleColor:THEMECOLOR forState:UIControlStateNormal];
//    CGSize btnTxtSize =    [forgetPassword.currentTitle sizeWithFont:registerButton.titleLabel.font MaxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    forgetPassword.frame = CGRectMake(self.userInfoContainer.bounds.size.width - btnTxtSize.width, CGRectGetMaxY(loginBtn.frame)+ loginBtnToForget, btnTxtSize.width, forgetPasswordH);
    self.forgetPassword = forgetPassword ;
    [self.userInfoContainer addSubview:forgetPassword];
    //第三方登录二级子控件
    
    //其他登录方式文字提示
    UIImageView * otherAccountLoginImageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.otherAccountContainer.bounds.size.width, otherLoginTipsH)];
    otherAccountLoginImageview.image  = [UIImage imageNamed:@"word_othersignin"];
    [self.otherAccountContainer addSubview:otherAccountLoginImageview];
    
        //微信 , 微博 , qq按钮
    CGFloat btnWH = 50*SCALE;
    UIButton * weiBoLoginButton = [[UIButton alloc]init];
    weiBoLoginButton.tag = 1828381;
    [weiBoLoginButton addTarget:self action:@selector(loginByOtherPlayformAccount:) forControlEvents:UIControlEventTouchUpInside];
    [weiBoLoginButton setImage:[UIImage imageNamed:@"icon_othermicroblog"] forState:UIControlStateNormal];
    [self.otherAccountContainer addSubview:weiBoLoginButton];
    weiBoLoginButton.bounds = CGRectMake(0, 0, btnWH, btnWH);
    weiBoLoginButton.center = CGPointMake(self.otherAccountContainer.bounds.size.width/2, CGRectGetMaxY(otherAccountLoginImageview.frame)+tipsToIcon+btnWH/2);
    
    UIButton * weiChatLoginButton = [[UIButton alloc]init];
    weiChatLoginButton.tag = 1828380;
    [weiChatLoginButton addTarget:self action:@selector(loginByOtherPlayformAccount:) forControlEvents:UIControlEventTouchUpInside];
    [self.otherAccountContainer addSubview:weiChatLoginButton];
    weiChatLoginButton.bounds = CGRectMake(0, 0, btnWH, btnWH);
    weiChatLoginButton.center = CGPointMake(self.otherAccountContainer.bounds.size.width/2 - btnWH - iconToIcon, CGRectGetMaxY(otherAccountLoginImageview.frame)+tipsToIcon+btnWH/2);
    [weiChatLoginButton setImage:[UIImage imageNamed:@"icon_otherwechat"] forState:UIControlStateNormal];
    
    UIButton * qqLoginButton = [[UIButton alloc]init];
    qqLoginButton.tag = 1828382;
    [qqLoginButton addTarget:self action:@selector(loginByOtherPlayformAccount:) forControlEvents:UIControlEventTouchUpInside];
    [self.otherAccountContainer addSubview:qqLoginButton];
    qqLoginButton.bounds = CGRectMake(0, 0, btnWH, btnWH);
    qqLoginButton.center = CGPointMake(self.otherAccountContainer.bounds.size.width/2+btnWH + iconToIcon, CGRectGetMaxY(otherAccountLoginImageview.frame)+tipsToIcon+btnWH/2);
    [qqLoginButton setImage:[UIImage imageNamed:@"icon_otherqq"] forState:UIControlStateNormal];
    //二级子控件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

-(void)setcornerWithView:(UIView*)view
{
    view.layer.cornerRadius = view.bounds.size.height/2;
    view.layer.masksToBounds = YES;
    view.layer.borderColor = SubTextColor.CGColor;
    view.layer.borderWidth  =1 ;
}


-(void)loginClick:(UIButton *)sender
{
    [self saveAccountName];

    sender.selected=!sender.selected;
    if (sender.selected) {
        //
        [self performLogin];
        //        [self testInit];
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"点击了登录, 现在显示 取消  ")
        [self.view endEditing:YES];
    }else{
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"点击了取消, 现在显示 登录")
    }
}

/**  则匹配用户密码6-16位数字和字母组合*/

-(BOOL)passwordLawful:(NSString*)password

{
    //    NSString*pattern=@"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}$";
    //
    //    NSPredicate*pred=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    //
    //    BOOL isMatch=[pred evaluateWithObject:password];
    //
    //    return isMatch;
    //    NSString *Regex = @"//w{6,16}";
    //    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    //    return [emailTest evaluateWithObject:password];
//    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,16}+$";
//    NSString * passWordRegex = @"^.{6,16}$";
    NSString * passWordRegex = @"^\\S{6,16}$";

    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:password];
    
}

-(void)performLogin
{
//    [[UserInfo shareUserInfo] initialization];
    if (!([self userNameLawful:self.accountInput.text] || [self emailLawful:self.accountInput.text]  || [self mobileLawful:self.accountInput.text ])) {
        [self.login setTitle:@"登录" forState:UIControlStateNormal];
        self.login.selected = NO;
        if (self.accountInput.text.length==0) {
            AlertInVC(@"账号为空")
        }else{
            AlertInVC(@"请输入正确的手机,邮箱或者用户名")
        }
        return;
    }
    if (![self passwordLawful:self.passwordInput.text]) {
        self.login.selected = NO;
        [self.login setTitle:@"登录" forState:UIControlStateNormal];
        if (self.passwordInput.text.length==0) {
            AlertInVC(@"密码为空")
        }else{
            AlertInVC(@"请输入6~16位的登录密码")
        }
        return;
    }
    [[NSUserDefaults standardUserDefaults]  setObject:self.accountInput.text forKey:RECENTACCOUNTNAME];
    [UserInfo shareUserInfo].name = self.accountInput.text;
    [UserInfo shareUserInfo].password=self.passwordInput.text;
    [[UserInfo shareUserInfo] loginSuccess:^(ResponseStatus response) {
        
        if (response==LOGIN_SUCCESS) {  
           if ([self.mydelegate  respondsToSelector:@selector(sbloginsuccessed:)]) {
               [self.mydelegate  sbloginsuccessed:self ];
           }
            [[NSNotificationCenter defaultCenter] postNotificationName:GOSHOPCARLOGINSUCCESS object:nil];
            
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }else if (response <0){
            AlertInVC(@"用户名不存在或密码不正确")
            //用户名或密码不正确
//            MBProgressHUD * hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//            hub.mode=MBProgressHUDModeText;
//            hub.labelText=@"用户名或密码不正确";
            self.login.selected = NO;
            [self.login setTitle:@"登录" forState:UIControlStateNormal];
//
//            [hub hide:YES afterDelay:1.5];

        }

    } failure:^(NSError *error) {

        LOG(@"_%@_%d_%@",[self class] , __LINE__,error)
        AlertInVC(@"登录失败,请检查网络")
        self.login.selected=NO;
    }];
}























#pragma about TableView method
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger  i = self.accounts.count;
    return i;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * identy = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
    }
    cell.backgroundColor = BackgroundGray ;
    NSString * accountName = self.accounts[indexPath.row];//[@"userName"] ;
    cell.textLabel.text = accountName;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if (![cell.textLabel.text isEqualToString:self.accountInput.text]) {
        self.passwordInput.text = nil;
    }
    self.accountInput.text = cell.textLabel.text;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self textChange:nil];
    
    [self.passwordInput becomeFirstResponder];
    
    self.accountsViewHeight.mas_equalTo(0);
    [UIView animateWithDuration:0.2 animations:^{
        self.chooseAccount.selected = NO;
        [self.accountsView layoutIfNeeded];
        [self.bottomContainer layoutIfNeeded];
    }];
}

#pragma lazyLoad
-(NSMutableArray * )accounts{
    if(_accounts==nil){
        //从沙盒里去取

            _accounts = [[NSMutableArray alloc]init];

    }
    NSString * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString * filePath = [path stringByAppendingPathComponent:@"accounts.plist"];
    NSMutableArray * tempArrM = [[NSMutableArray alloc]initWithContentsOfFile:filePath];
    if (tempArrM) {
        _accounts = [[NSMutableArray alloc]initWithContentsOfFile:filePath];
    }
    return _accounts;
}

-(void)saveAccountName
{
    NSString * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString * filePath = [path stringByAppendingPathComponent:@"accounts.plist"];
    NSMutableArray * arrM = [NSMutableArray arrayWithArray:self.accounts];
    for (NSString*target in arrM) {
        if ([target isEqualToString:self.accountInput.text])  return;
    }

    [arrM insertObject:self.accountInput.text atIndex:0] ;
    [arrM writeToFile:filePath atomically:YES];
    [self.accountsView reloadData];
}
-(void)textChange:(NSNotification*)noti
{
    
    if (self.accountInput.text.length>0&&self.passwordInput.text.length>0) {
//        self.login.enabled=YES;
    }else{
//        self.login.enabled=NO;
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}
#pragma ButtonClick
-(void)chooseAccountClick:(UIButton*)sender
{
    
    CGFloat accountsViewHeight   = self.accounts.count>1 ? 88 : 44;
    sender.selected=!sender.selected;
    if (sender.selected) {
        self.accountsViewHeight.mas_equalTo(accountsViewHeight);
        [UIView animateWithDuration:0.2 animations:^{
            //            [self.accountsView layoutIfNeeded];
            [self.bottomContainer layoutIfNeeded];
        }];
    }else{
        self.accountsViewHeight.mas_equalTo(0);
        [UIView animateWithDuration:0.2 animations:^{
            [self.accountsView layoutIfNeeded];
            [self.bottomContainer layoutIfNeeded];
        }];
    }
    LOG_METHOD
}
-(void)eyeableClick:(UIButton *)sender
{
    sender.selected=!sender.selected;
    if (sender.selected) {
        self.passwordInput.secureTextEntry=NO;
        //点击之后图片显示眼睛睁开
    }else{
        
        self.passwordInput.secureTextEntry=YES;
        //点击之后图片显示眼睛闭合
    }
    LOG_METHOD
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];

}






//正则
- (BOOL) emailLawful:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


/** 判断用户名的合法性 */
-(BOOL)userNameLawful:(NSString*)input
{
    //    NSString * regex = @"^[a-zA-Z0-9_]{6,16}$";
    
//    NSString * regex = @"^[a-zA-Z][a-zA-Z0-9_]{5,31}$";
    NSString * regex = @"^[a-zA-Z][a-zA-Z0-9-_]{5,31}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:input];
    return isMatch;
}

/** 判断手机号的合法性 */

- (BOOL) mobileLawful:(NSString *)mobileNumbel{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189,181(增加)
     */
    NSString * MOBIL = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     */
    //    NSString * CM = @"^1(70|34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    NSString * CM=@"^13[0-9]{9}$|14[0-9]{9}|15[0-9]{9}$|18[0-9]{9}|17[0-9]{9}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,152,155,156,185,186
     */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,1349,153,180,189,181(增加)
     */
    NSString * CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNumbel]
         || [regextestcm evaluateWithObject:mobileNumbel]
         || [regextestct evaluateWithObject:mobileNumbel]
         || [regextestcu evaluateWithObject:mobileNumbel])) {
        return YES;
    }
    
    return NO;
}

















#pragma 布局子控件
//-(void)laysubview
//{
//    /** 设置间距 */
//    CGFloat passwordToLoginBtn = 52 * SCALE*SCALE;
//    CGFloat accountNameToPassword = 22*SCALE ;
//    CGFloat loginBtnToForget = 18*SCALE;
//    CGFloat logoImgToTop = 88 *SCALE;
//    /** 企业logo */
//    CGFloat logoImgW = 176*SCALE ;
//    CGFloat logoImgH = 54*SCALE  ;
//    CGFloat LogoImgX = (screenW - logoImgW)/2 ;
//    CGFloat logoImgY = logoImgToTop;
//    self.logoImg.frame = CGRectMake(LogoImgX, logoImgY, logoImgW, logoImgH);
//
//
//    /** 登录布局 */
//    CGFloat componentH = 40*SCALE;//登录按钮 , 密码框 , 用户名框的高度
//    CGFloat gorgetPasswordH = 30*SCALE ;
//    CGFloat userInfoContainerW = 262*SCALE;
//    CGFloat userInfoContainerH = componentH+accountNameToPassword+componentH+passwordToLoginBtn+componentH +loginBtnToForget+gorgetPasswordH;//两个输入框一个按钮 + 三个间距+忘记密码的高度
//    CGFloat userInfoContainerX = (screenW - userInfoContainerW)/2 ;
//    CGFloat userInfoContainerY = CGRectGetMaxY(self.logoImg.frame)+26*SCALE*SCALE;
//
//    self.userInfoContainer.frame = CGRectMake(userInfoContainerX, userInfoContainerY, userInfoContainerW, userInfoContainerH);
//
//    //布局二级子控件
//
//    /** 三方登录布局 */
//    CGFloat otherLoginTipsW = 262*SCALE;
//    CGFloat otherLoginTipsH = 40*SCALE ;
//    CGFloat tipsToIcon = 27 *SCALE;
//    CGFloat iconH = 50*SCALE ;
//    CGFloat iconToIcon = 20*SCALE ;
//    CGFloat otherW = otherLoginTipsW;
//    CGFloat otherH = otherLoginTipsH + tipsToIcon + iconH;
////    CGFloat otherY = CGRectGetMaxY(self.userInfoContainer.frame)+ userInfoContainerToOtherActountContainer;
//    CGFloat otherToBottom = 30*SCALE*SCALE ;
//    CGFloat otherY = screenH - otherH - otherToBottom;
//    CGFloat otherX = (screenW - otherW)/2 ;
//    self.otherAccountContainer.frame = CGRectMake(otherX, otherY, otherW , otherH);
//    //布局二级子控件
//}
/*
 #pragma 添加子控件
 -(void)setupSubviews
 {
 UITableView * accountsView = [[UITableView alloc]init];
 self.accountsView=accountsView;
 accountsView.backgroundColor = BackgroundGray;
 [self.view addSubview:accountsView];
 accountsView.dataSource=self;
 accountsView.delegate=self;
 
 UIView * bottomContainer = [[UIView alloc]init];
 [self.view addSubview:bottomContainer];
 bottomContainer.backgroundColor=BackgroundGray;
 self.bottomContainer=bottomContainer;
 
 UIView * accountContainer = [[UIView alloc]init];
 accountContainer.backgroundColor = [UIColor whiteColor];
 self.accountContainer=accountContainer;
 [self.view addSubview:accountContainer];
 
 UIView * passwordContainer = [[UIView alloc]init];
 passwordContainer.backgroundColor=[UIColor whiteColor];
 self.passwordContainer=passwordContainer;
 [self.bottomContainer addSubview:passwordContainer];
 
 UILabel * accountName = [[UILabel alloc]init];
 accountName.text=@"账户";
 //    accountName.backgroundColor = randomColor;
 [self.accountContainer addSubview:accountName];
 self.accountName=accountName;
 
 UITextField * accountInput = [[UITextField alloc]init];
 
 accountInput.placeholder=@"请输入用户名";
 accountInput.text=@"chuck1";
 //    accountInput.backgroundColor = randomColor;
 [self.accountContainer addSubview:accountInput];
 self.accountInput=accountInput;
 
 UIButton * chooseAccount = [[UIButton alloc]init];
 //    chooseAccount.backgroundColor = randomColor;
 [chooseAccount addTarget:self action:@selector(chooseAccountClick:) forControlEvents:UIControlEventTouchUpInside];
 [self.accountContainer addSubview:chooseAccount];
 self.chooseAccount= chooseAccount;
 
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:nil];
 
 
 
 UILabel * password = [[UILabel alloc]init];
 password.text=@"登录密码";
 
 //    password.backgroundColor = randomColor;
 [self.passwordContainer addSubview:password];
 self.password=password;
 
 UITextField * passwordInput = [[UITextField alloc]init];
 passwordInput.secureTextEntry=YES;
 passwordInput.placeholder = @"请输入密码";
 passwordInput.text=@"123123";
 //    passwordInput.backgroundColor = randomColor;
 [self.passwordContainer addSubview:passwordInput];
 self.passwordInput = passwordInput;
 
 UIButton * eyeable = [[UIButton alloc]init];
 //    [eyeable setImage:[UIImage imageNamed:@"yan bi he "] forState:UIControlStateNormal];
 //    [eyeable setImage:[UIImage imageNamed:@"yan zheng kai "] forState:UIControlStateSelected];
 //    eyeable.backgroundColor = randomColor;
 [eyeable addTarget:self action:@selector(eyeableClick:) forControlEvents:UIControlEventTouchUpInside];
 [self.passwordContainer addSubview:eyeable];
 self.eyeable=eyeable;
 
 UIButton*login = [[UIButton alloc]init];
 login.layer.cornerRadius = 5 ;
 login.layer.masksToBounds= YES;
 //    [login setBackgroundImage:[UIImage imageNamed:@"zheng chang zhuang tai bei jing tu "] forState:UIControlStateNormal];
 //    [login setBackgroundImage:[UIImage imageNamed:@"bu ke dian ji bei jing tu "] forState:UIControlStateDisabled];
 login.enabled = NO;
 [login setTitle:@"登录" forState:UIControlStateNormal];
 [login setTitle:@"取消" forState:UIControlStateSelected];
 login.backgroundColor = [UIColor redColor];
 [login addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
 [self.bottomContainer addSubview:login];
 self.login=login;
 
 UIButton * otherAccountLogin = [[UIButton alloc]init];
 [otherAccountLogin.titleLabel setFont:[UIFont systemFontOfSize:14]];
 [otherAccountLogin setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
 [otherAccountLogin setTitle:@"第三方登录" forState: UIControlStateNormal];
 //    otherAccountLogin.backgroundColor = randomColor;
 [otherAccountLogin addTarget:self action:@selector(otherAccountLoginClick:) forControlEvents:UIControlEventTouchUpInside];
 [self.bottomContainer addSubview:otherAccountLogin];
 self.otherAccountLogin=otherAccountLogin;
 
 UIButton * forgetPassword = [[UIButton alloc]init];
 [forgetPassword setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
 [forgetPassword.titleLabel setFont:[UIFont systemFontOfSize:14]];
 [forgetPassword setTitle:@"找回密码" forState:UIControlStateNormal];
 //    forgetPassword.backgroundColor = randomColor;
 [forgetPassword addTarget:self action:@selector(forgetPasswordClick:) forControlEvents:UIControlEventTouchUpInside];
 [self.bottomContainer addSubview:forgetPassword];
 self.forgetPassword=forgetPassword;
 
 UIButton * registerButton = [[UIButton alloc]init];
 [registerButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
 [registerButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
 registerButton.layer.borderColor = [UIColor redColor].CGColor;
 registerButton.layer.borderWidth = 1.0;
 registerButton.layer.cornerRadius= 5 ;
 registerButton.layer.masksToBounds=YES;
 [registerButton setTitle:@"免费注册" forState:UIControlStateNormal];
 //    registerButton.backgroundColor = randomColor;
 [registerButton addTarget:self action:@selector(registerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
 [self.bottomContainer addSubview:registerButton];
 self.registerButton = registerButton;
 
 
 }
 -(void)changeButtonStateWithButton:(UIButton *)button Title:(NSString*)title titleColor:(UIColor *)titleColor titleFontSize:(CGFloat)fontSize
 {
 
 }
 #pragma 布局子控件
 -(void)laysubview
 {
 CGFloat compnentH=44;
 //    CGFloat accountAndPasswordW=64.0;
 CGFloat topMargin = 16;
 [self.accountContainer mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.right.equalTo(self.view);
 make.top.equalTo(self.view).offset(topMargin+64);
 //        make.width.equalTo(@(screenW));
 make.height.equalTo(@(compnentH));
 }];
 
 [self.accountName mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.equalTo(self.accountContainer).offset(28);
 make.top.bottom.equalTo(self.accountContainer);
 make.width.equalTo(@80);
 }];
 
 [self.chooseAccount mas_makeConstraints:^(MASConstraintMaker *make) {
 make.top.right.equalTo(_accountContainer);
 make.width.height.equalTo(@(compnentH));
 }];
 
 [self.accountsView mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.equalTo(self.accountName.mas_right);
 make.right.equalTo(self.accountContainer);
 make.top.equalTo(self.accountContainer.mas_bottom);
 MASConstraint * accountsViewHeight = make.height.equalTo(@0);
 self.accountsViewHeight = accountsViewHeight;
 }];
 
 [self.bottomContainer mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.right.equalTo(self.accountContainer);
 MASConstraint * changeConstraint =  make.top.equalTo(self.accountsView.mas_bottom);
 self.changeConstraint = changeConstraint;
 //        make.width.equalTo(@(screenW));
 make.height.equalTo(@(screenW));
 }];
 
 [self.accountInput mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.equalTo(self.accountName.mas_right);
 make.top.bottom.equalTo(self.accountContainer);
 make.right.equalTo(self.chooseAccount.mas_left);
 }];
 
 [self.passwordContainer mas_makeConstraints:^(MASConstraintMaker *make) {
 make.top.left.right.equalTo(self.bottomContainer);
 make.height.equalTo(self.accountContainer);
 }];
 
 [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.equalTo(self.passwordContainer).offset(28);
 make.top.bottom.equalTo(self.passwordContainer);
 make.width.equalTo(self.accountName.mas_width);
 }];
 
 [self.eyeable mas_makeConstraints:^(MASConstraintMaker *make) {
 make.top.bottom.right.equalTo(self.passwordContainer);
 make.width.equalTo(self.passwordContainer.mas_height);
 }];
 
 [self.passwordInput mas_makeConstraints:^(MASConstraintMaker *make) {
 make.top.bottom.equalTo(self.passwordContainer);
 make.left.equalTo(self.password.mas_right);
 make.right.equalTo(self.eyeable.mas_left);
 }];
 
 [self.login mas_makeConstraints:^(MASConstraintMaker *make) {
 make.top.equalTo(self.passwordContainer.mas_bottom).offset(30);
 make.left.equalTo(self.bottomContainer).offset(20);
 make.right.equalTo(self.bottomContainer).offset(-20);
 make.height.equalTo(self.accountContainer.mas_height);
 }];
 
 [self.otherAccountLogin mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.equalTo(self.login);
 make.top.equalTo(self.login.mas_bottom).offset(10);
 }];
 
 [self.forgetPassword mas_makeConstraints:^(MASConstraintMaker *make) {
 make.right.equalTo(self.login).offset(10);
 make.top.equalTo(self.otherAccountLogin);
 
 }];
 
 [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
 make.centerX.equalTo(self.login.mas_centerX);
 make.top.equalTo(self.otherAccountLogin.mas_bottom).offset(44);
 make.width.equalTo(@100);
 make.height.equalTo(@36);
 }];
 }
 
 
 */
@end
