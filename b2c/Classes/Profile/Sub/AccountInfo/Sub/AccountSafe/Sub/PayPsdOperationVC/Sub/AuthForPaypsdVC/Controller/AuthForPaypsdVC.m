//
//  AuthForPaypsdVC.m
//  b2c
//
//  Created by wangyuanfei on 6/14/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "AuthForPaypsdVC.h"
#import "CustomInputView.h"
#import "ChangePasswordVC.h"
@interface AuthForPaypsdVC ()<CustomInputViewDelegate>
@property(nonatomic,weak)CustomInputView * mobileInput ;
@property(nonatomic,weak)CustomInputView * authcodeInput ;
@property(nonatomic,weak)UIButton * gotAuthButton ;
@property(nonatomic,weak)UIButton * bindingButton ;

/** 网络获取的手机号 */
@property(nonatomic,copy)NSString * currentMobile ;
/** 定时器 */
@property(nonatomic,strong)NSTimer * timer ;
/** 重新发送倒计时时间 */
@property(nonatomic,assign)NSInteger  time ;

@end

@implementation AuthForPaypsdVC
/** 
  获取验证码按钮
UIButton * gotAuthcodeButton =[[UIButton alloc]init];
gotAuthcodeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
gotAuthcodeButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
gotAuthcodeButton.titleLabel.font = [UIFont systemFontOfSize:14 ];
[gotAuthcodeButton addTarget:self action:@selector(gotAuthcodeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
[gotAuthcodeButton setTitleColor:SubTextColor forState:UIControlStateNormal];
//    gotAuthcodeButton.backgroundColor = randomColor;
gotAuthcodeButton.layer.borderWidth = 1 ;
gotAuthcodeButton.layer.borderColor = BackgroundGray.CGColor;
gotAuthcodeButton.layer.masksToBounds = YES;
[gotAuthcodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
self.gotAuthcodeButton = gotAuthcodeButton;
gotAuthcodeButton.frame = CGRectMake(margin, CGRectGetMaxY(authcodeInput.frame)+margin, (self.view.bounds.size.width-margin*2)/2, 18);
[self.view addSubview:gotAuthcodeButton];

}
-(void)gotAuthcodeButtonClick:(UIButton*)sender
{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"点击获取验证码");
    [self resentAuthcode:self.gotAuthcodeButton];
    [self.view endEditing:YES];
}

 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changePasswordSuccessCallback) name:CHANGEPASSWORDSUCCESS object:nil];
    
    
    CGFloat margin = 10 ;
    CGFloat gotAuthButtonW = 100 ;
    /** 手机号输入框 */
    CustomInputView * mobileInput  = [[CustomInputView alloc]initWithFrame:CGRectMake(0, self.startY+margin, self.view.bounds.size.width-gotAuthButtonW, 44)];
//    userInfoInputView.CustomInputDelegate = self;
    mobileInput.customKeyboardType = UIKeyboardTypeNumbersAndPunctuation;
    mobileInput.textFont = [UIFont systemFontOfSize:14];
    mobileInput.leftWidth = 88 ;
    mobileInput.tipsTitle = @"手机号";
    mobileInput.inputPlaceholder = @"请输入手机号";
    self.mobileInput = mobileInput;
    [self.view addSubview:mobileInput];
    mobileInput.userInteractionEnabled=NO ;
    //获取验证码按钮
    UIButton * gotAuthButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-gotAuthButtonW, CGRectGetMinY(self.mobileInput.frame), gotAuthButtonW, 44)];
    [self.view addSubview:gotAuthButton];
    [gotAuthButton addTarget:self action:@selector(gotAuthcodeButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    gotAuthButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.gotAuthButton = gotAuthButton;
    gotAuthButton.backgroundColor = THEMECOLOR;
    [gotAuthButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    
    
    /** 验证码输入框 */
    
    
    CustomInputView * authcodeInput  = [[CustomInputView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.mobileInput.frame), self.view.bounds.size.width, 44)];
    authcodeInput.CustomInputDelegate = self;
    authcodeInput.customKeyboardType =   UIKeyboardTypeNumbersAndPunctuation;
    authcodeInput.customReturenType =  UIReturnKeyDone;
    authcodeInput.textFont = [UIFont systemFontOfSize:14];
    authcodeInput.leftWidth = 0 ;
//    authcodeInput.tipsTitle = @"验证码";
    authcodeInput.inputPlaceholder = @"请输入验证码";
    self.authcodeInput = authcodeInput;
    [self.view addSubview:authcodeInput];

    
    
    
    CGFloat bindingButtonMargin = 22 ;
    UIButton*bindingButton = [[UIButton alloc]initWithFrame:CGRectMake(bindingButtonMargin, self.view.bounds.size.height - 44 - bindingButtonMargin, self.view.bounds.size.width - 2 * bindingButtonMargin, 44)];
    self.bindingButton = bindingButton;
    [bindingButton addTarget:self action:@selector(performbindingClick:) forControlEvents:UIControlEventTouchUpInside];
    bindingButton.backgroundColor = THEMECOLOR;
    [bindingButton setTitle:@"下一步" forState:UIControlStateNormal];
    [self.view addSubview:self.bindingButton];
    [self setMobileNumber];
    
}

-(void)gotAuthcodeButtonClick:(UIButton*)sender
{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"重新获取验证码");
    if ([self mobileLawful:self.currentMobile]) {
        [self resentAuthcode:self.gotAuthButton];
        [self.view endEditing:YES];
        
    }else{
        AlertInVC(@"请输入正确手机号")
        return;
    }
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)customInputTextFieldShouldReturn:(CustomInputView*)customInputView{
    [self performbindingClick:self.bindingButton];
}
-(void)performbindingClick:(UIButton*)sender
{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"下一步");
    [self checkAuthcodeByInternet:^(BOOL lawful) {
        if (lawful) {
            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"good_xiu gai cheng gong le ");
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
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
    NSString * CM = @"^13[0-9]{9}$|14[0-9]{9}|15[0-9]{9}$|18[0-9]{9}|17[0-9]{9}$";
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
/** 判断验证码的合法性 */

- (BOOL)authcodeLawful:(NSString *) textString
{
    NSString* number=@"^\\d{6}$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:textString];
}


/////////验证码按钮相关////////////
-(void)deleteTimer
{
    
    self.gotAuthButton.enabled=YES;
    [self.timer invalidate];
    self.timer=nil;
}
-(void)creatTimer
{
    self.gotAuthButton.enabled=NO;
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(daojishi) userInfo:nil repeats:YES];
    self.timer= timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    self.time=60;
}
-(void)daojishi
{
    
    self.time-=1;
    [self.gotAuthButton setTitle:[NSString stringWithFormat:@"%lds后重新获取",self.time] forState:UIControlStateNormal];
    if (self.time==0||self.time<0) {
        [self.gotAuthButton setTitle:@"重新获取" forState:UIControlStateNormal];
        [self deleteTimer];
    }
}
-(void)resentAuthcode:(UIButton*)sender
{
    

    [UserInfo shareUserInfo].mobile = self.currentMobile;
    [self.gotAuthButton setTitle:[NSString stringWithFormat:@"60s后重新获取"] forState:UIControlStateNormal];
     [self creatTimer];
    [[UserInfo shareUserInfo] gotMobileCodeWithType:FindPassword Success:^(ResponseStatus response) {
        
//        MBProgressHUD * hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        hub.mode=MBProgressHUDModeText;
//        [hub hide:YES afterDelay:1.5];
        if (response==SHORTMESSAGE_SUCESS) {
//            hub.labelText=@"验证码发送成功";
//            hub.completionBlock = ^{
//                [self creatTimer];
//            };
        }else if (response== SHORTMESSAGE_FAIL){
//            hub.labelText=@"验证码发送失败";
//            self.gotAuthButton.enabled = YES;
//             [self.gotAuthButton setTitle:@"重新发送" forState:UIControlStateNormal];
//            hub.detailsLabelText=@"请重试";
            
        }
    } failure:^(NSError *error) {
        
    }];
    
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"重新发送验证码操作")
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)setMobileNumber
{
    [[UserInfo shareUserInfo] gotAccountSafeSuccess:^(ResponseObject *responseObject) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
        if (responseObject.status>0) {
            
            
            //设置支付密码显示状态
            if ([responseObject.data isKindOfClass:[NSDictionary class]]) {
                if ([responseObject.data[@"items"] isKindOfClass:[NSArray class]]) {
                    for (id sub in responseObject.data[@"items"]) {
                        if ([sub isKindOfClass:[NSDictionary class]]) {
                            
                            if ([sub[@"actionkey"] isEqualToString:@"mobile"]) {
                                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"注册时的手机号码");
                                NSString * mobile =  sub[@"sub_title"];
                                if ([ sub[@"sub_title"] isKindOfClass:[NSString class]]&& mobile.length==11) {
                                    self.currentMobile = mobile;
                                    self.currentMobile=mobile;
                                    [self resentAuthcode:self.gotAuthButton];
                                    mobile = [mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
                                     self.mobileInput.inputPlaceholder = mobile;
                                }else{
//                                    AlertInVC(@"请绑定手机号码")
                                    MBProgressHUD * hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                                    hub.mode=MBProgressHUDModeText;
                                    hub.detailsLabelText=[NSString stringWithFormat:@"%@",(@"请前往账户安全中绑定手机号码")];
                                    [hub hide:YES afterDelay:2];
                                    hub.completionBlock = ^(){
                                        [self.navigationController popViewControllerAnimated:YES];
                                    };
                                    return ;
                                }
                                
                            }
                            
                            
                            
                            
//                            if ([sub[@"actionkey"] isEqualToString:@"mobile"]) {
//                                LOG(@"_%@_%d_注册时的手机号码%@",[self class] , __LINE__,sub[@"sub_title"]);
//                                self.mobileInput.inputPlaceholder = sub[@"sub_title"];
//                                [self resentAuthcode:self.gotAuthButton];
//                            }
                        }
                    }
                }
            }
        }
    } failure:^(NSError *error) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
    }];
}


-(void)checkAuthcodeByInternet:(void(^)(BOOL lawful))result {//检查验证码的有效性
    if ([self authcodeLawful:self.authcodeInput.currentText]) {
        [[UserInfo shareUserInfo] checkUserNameOrMobileWithUserName:nil mobile:self.currentMobile email:nil mobilecode:self.authcodeInput.currentText success:^(ResponseObject *responseObject) {
            LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
            if ([responseObject.data isEqualToString:@"verify_sucess"]) {//待整改
                //可以注册 , 进行下一条验证
                ChangePasswordVC * changepadVC = [[ChangePasswordVC alloc]initWithType:SetPayPassword];
                [self.navigationController pushViewController:changepadVC animated:YES];
                result(YES);
            }else if ([responseObject.data isEqualToString:@"verify_wrong"]){
                //已被占用 , 请更改
                AlertInVC(@"验证码不正确");
                result(NO);
            }else if ([responseObject.data isEqualToString:@"verify_overtime"]){
                AlertInVC(@"验证码已过期");
                result(NO);
            }else{
                AlertInVC(@"验证码出现未知错误")
                result(NO);
            }
        } failure:^(NSError *error) {
            LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
            AlertInVC(@"网络错误");
            //            result(2);//网络错误
        }];
    }else{
        AlertInVC(@"请输入手机短信中六位数字的验证码");
        //        return;
    }
    
}
-(void)changePasswordSuccessCallback
{
    [self removeFromParentViewController];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
