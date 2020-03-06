//
//  ForgetPasswordVC.m
//  b2c
//
//  Created by wangyuanfei on 16/6/2.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "ForgetPasswordVC.h"
#import "AuthcodeView.h"
#import "CustomInputView.h"
#import "FindPsdWithMblVC.h"
@interface ForgetPasswordVC ()<UITextFieldDelegate,CustomInputViewDelegate>
//@property(nonatomic,strong)GDXmppStreamManager * xmp ;
@property(nonatomic,weak)AuthcodeView * authCodeView ;
@property(nonatomic,weak)CustomInputView * userInfoInputView ;//
@property(nonatomic,weak)CustomInputView * authCodeInputView ;//
@property(nonatomic,weak)UIButton * nextStepbutton ;
@end

@implementation ForgetPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviTitle = @"找回密码";

    
    CGFloat margin = 10 ;
    /** 验证方式输入框 */
    CustomInputView * userInfoInputView  = [[CustomInputView alloc]initWithFrame:CGRectMake(0, self.startY+margin, self.view.bounds.size.width, 44)];
    userInfoInputView.CustomInputDelegate = self;
    userInfoInputView.textFont = [UIFont systemFontOfSize:12];
    userInfoInputView.leftWidth = 88 ;
    userInfoInputView.tipsTitle = @"请输入验证方式";
    userInfoInputView.inputPlaceholder = @"手机号/邮箱/用户名";
    self.userInfoInputView = userInfoInputView;
    [self.view addSubview:userInfoInputView];
    
    /** 验证码输入框 */
    CGFloat authCodeViewW = 88 ;
    
    CustomInputView * authCodeInputView  = [[CustomInputView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.userInfoInputView.frame), self.view.bounds.size.width-authCodeViewW, 44)];
    authCodeInputView.CustomInputDelegate = self;
    authCodeInputView.customKeyboardType = UIKeyboardTypeNumbersAndPunctuation;
    authCodeInputView.customReturenType = UIReturnKeyNext;
    authCodeInputView.textFont = [UIFont systemFontOfSize:12];
    authCodeInputView.leftWidth = 100 ;
    authCodeInputView.tipsTitle = @"验证码";
    authCodeInputView.inputPlaceholder = @"请输入验证码";
    self.authCodeInputView = authCodeInputView;
    [self.view addSubview:authCodeInputView];
    
    //显示验证码界面
    AuthcodeView * authCodeView = [[AuthcodeView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-authCodeViewW, CGRectGetMaxY(self.userInfoInputView.frame), authCodeViewW, 44)];
    [self.view addSubview:authCodeView];
    self.authCodeView = authCodeView;
    
    CGFloat nextStepButtonMargin = 22 ;
    UIButton*nextStepButton = [[UIButton alloc]initWithFrame:CGRectMake(nextStepButtonMargin, self.view.bounds.size.height - 44 - nextStepButtonMargin, self.view.bounds.size.width - 2 * nextStepButtonMargin, 44)];
    self.nextStepbutton = nextStepButton;
    [nextStepButton addTarget:self action:@selector(performNextStep:) forControlEvents:UIControlEventTouchUpInside];
    nextStepButton.backgroundColor = THEMECOLOR;
    [nextStepButton setTitle:@"下一步" forState:UIControlStateNormal];
    [self.view addSubview:self.nextStepbutton];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.authCodeView  resetAuthcode];

}

-(void)performNextStep:(UIButton*)sender
{
    //点击了下一步按钮
    [self customInputTextFieldShouldReturn:nil];
}


-(void)customInputTextFieldShouldReturn:(CustomInputView *)customInputView{//要从服务器请求数据,判断手机号 , 用户名 , 或者邮箱是否存在
    if (self.userInfoInputView.currentText.length==0) {
        AlertInVC(@"请输入验证方式")
        return;
    }
    
    if (self.authCodeInputView.currentText.length==0) {
        AlertInVC(@"请输入验证码")
        return;
    }
    
    if (!([self mobileLawful:self.userInfoInputView.currentText]||[self emailLawful:self.userInfoInputView.currentText]||[self userNameLawful:self.userInfoInputView.currentText]))  {
        AlertInVC(@"请输入注册时用得手机号码 , 邮箱 或者用户名")
        return;
    }
    
    //判断输入的是否为验证图片中显示的验证码
    LOG(@"_%@_%d_%@",[self class] , __LINE__,self.userInfoInputView);
    LOG(@"_%@_%d_%@",[self class] , __LINE__,self.authCodeInputView);
    LOG(@"_%@_%d_%@",[self class] , __LINE__,self.authCodeInputView.currentText);
    LOG(@"_%@_%d_%@",[self class] , __LINE__,self.authCodeView.authCodeStr);

    if ([self.authCodeInputView.currentText isEqualToString:self.authCodeView.authCodeStr]) {
        //正确弹出警告款提示正确
//        AlertInVC(@"验证成功,执行下一步")
    }  else{
        AlertInVC(@"验证码不正确")
        return  ;
        //验证不匹配，验证码和输入框抖动
        //        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        //        anim.repeatCount = 3;
        //        anim.repeatDuration=0.330;
        //        anim.values = @[@-20,@20,@-20];
        //        //        [authCodeView.layer addAnimation:anim forKey:nil];
        //        [customInputView.layer addAnimation:anim forKey:nil];
    }

    
    if ([self mobileLawful:self.userInfoInputView.currentText]) {//如果是手机 , 再进行网络判断
        [self checkMobileByInternet:^(BOOL lawful) {
            if (lawful) {
//                AlertInVC(@"验证码已发送到手机")
                [self sendAuthcodeToMobileWithMobile:self.userInfoInputView.currentText InputMobileType :@"directMobile"];
            }else{
//                AlertInVC(@"该手机号未被注册")
            }
        }];
    }else if ([self userNameLawful:self.userInfoInputView.currentText]){//如果是用户名
        [self checkUserNameByInternet:^(BOOL lawful) {
            if (lawful) {//不在这儿处理了 , 在方法内部处理
//                AlertInVC(@"验证码已发送到手机还是邮箱呢?")
//                [self sendAuthcodeToMobile];?
//                [self sendAuthcodeToEmail];?
            }else{
                AlertInVC(@"该用户名不存在,")
            }
        }];
    }else if ([self emailLawful:self.userInfoInputView.currentText]){//如果是邮箱
//        [self checkEmailLawful:........]需要接口支持
        [[UserInfo shareUserInfo] checkUserNameOrMobileWithFindbackname:nil findbackmobile:nil findbackemail:self.userInfoInputView.currentText success:^(ResponseObject *responseObject) {
            if (responseObject.status>0) {
                [self sendAuthcodeToEmailWithEmail:self.userInfoInputView.currentText];
            }else{
                AlertInVC(responseObject.msg)
            }
        } failure:^(NSError *error) {
            AlertInVC(@"网络错误")
        }];
//        AlertInVC(@"网络检查邮箱是否注册过 , 需要接口支持,如果存在就发送验证到邮箱")
        
    }
    


}

-(void)sendAuthcodeToMobileWithMobile:(NSString*)mobile InputMobileType:(NSString*)inputMobileType//通过直接输入的手机号还是通过用户名间接获取的手机号directMobile/indirectMobile
{
    BaseModel * model = [[BaseModel alloc]init];
    model.actionKey = @"FindPsdWithMblVC";
    model.keyParamete = @{
                          @"paramete":mobile,
                          @"inputMobileType":inputMobileType
                          };
    [[SkipManager shareSkipManager] skipByVC:self withActionModel:model];
}
-(void)sendAuthcodeToEmailWithEmail:(NSString*)email
{
    BaseModel * model = [[BaseModel alloc]init];
    model.actionKey = @"FindPsdWithMblVC";
    model.keyParamete = @{
                          @"paramete":email
                          };
    [[SkipManager shareSkipManager] skipByVC:self withActionModel:model];
}
-(void)checkUserNameByInternet:(void(^)(BOOL lawful))result {//检查用户名的有效性
    
    
//        [[UserInfo shareUserInfo] checkUserNameOrMobileWithUserName:self.userInfoInputView.currentText mobile:nil email:nil mobilecode:nil success:^(ResponseObject *responseObject) {
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
//            if ([responseObject.data isEqualToString:@"name_sucess"]) {
//                //
//                AlertInVC(@"改用户名暂未在本网站注册,请核实后重新输入")
//                result(NO);
//            }else if ([responseObject.data isEqualToString:@"name_have_exit"]){
//                //已被占用 , 请更改
////                AlertInVC(@"验证成功 , 执行发送短信验证码或者邮件");
//                result(YES);
//            }
//        } failure:^(NSError *error) {
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
//            AlertInVC(@"网络错误");
//            //            result(2);//网络错误
//        }];
//    
    
    /** 测试另一个接口 */
    [[UserInfo shareUserInfo] checkUserNameOrMobileWithFindbackname:self.userInfoInputView.currentText findbackmobile:nil findbackemail:nil success:^(ResponseObject *responseObject) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
        if ([responseObject.data isKindOfClass:[NSDictionary class]]) {
            if (responseObject.data[@"mobile"] && [self mobileLawful:responseObject.data[@"mobile"]]) {//改
                //手机
//                if ([self mobileLawful:responseObject.data[@"mobile"] ]){
//                    BaseModel * model = [[BaseModel alloc]init];
//                    model.actionKey = @"FindPsdWithMblVC";
//                    model.keyParamete = @{
//                                          @"paramete":responseObject.data[@"mobile"]
//                                          };
//                    [[SkipManager shareSkipManager] skipByVC:self withActionModel:model];
//                    AlertInVC(@"验证码已发送至手机");
                [self sendAuthcodeToMobileWithMobile:responseObject.data[@"mobile"] InputMobileType:@"indirectMobile"];
                    result(YES);
//                }

            }else if (responseObject.data[@"email"] && [self emailLawful:responseObject.data[@"email"]]){
                //邮箱
//                if ([self emailLawful:responseObject.data[@"email"]]){
//                    BaseModel * model = [[BaseModel alloc]init];
//                    model.actionKey = @"FindPsdWithMblVC";
//                    model.keyParamete = @{
//                                          @"paramete":responseObject.data[@"email"]
//                                          };
//                    [[SkipManager shareSkipManager] skipByVC:self withActionModel:model];
//                    AlertInVC(@"验证信息已发送至邮箱");
                [self sendAuthcodeToEmailWithEmail:responseObject.data[@"email"]];
                    result(YES);
//                }
            }else{
                AlertInVC(@"未知错误")
            }
        }else{
            AlertInVC(responseObject.msg)
        }
    } failure:^(NSError *error) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
        AlertInVC(@"网络错误");
        //            result(2);//网络错误
    }];
    
}

-(void)checkMobileByInternet:(void(^)(BOOL lawful))result {//检查手机的有效性
    
//    [[UserInfo shareUserInfo] checkUserNameOrMobileWithFindbackname:nil findbackmobile:self.userInfoInputView.currentText findbackemail:nil success:^(ResponseObject *responseObject) {
//       LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
//        if ([responseObject.data isEqualToString:@"mobile_cannot_find"]) {
    /** 	status = -400;
     msg = 该手机没有注册，不能用此邮箱找回密码;
     data = mobile_cannot_find;
     */

//
//            result(NO);
//        }else if ([responseObject.data isEqualToString:@"mobile_can_find"]){
//
    /** 	status = 200;
     msg = 可以使用该手机找回密码;
     data = mobile_can_find;
     */
//            //                AlertInVC(@"验证码已发送至手机");
//            result(YES);
//        }
//    } failure:^(NSError *error) {
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
//        AlertInVC(@"网络错误");
//    }];
    /** 上面注释的部分跟下面的部分作用相同 */
    [[UserInfo shareUserInfo] checkUserNameOrMobileWithUserName:nil mobile:self.userInfoInputView.currentText email:nil mobilecode:nil success:^(ResponseObject *responseObject) {
            LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
            if ([responseObject.data isEqualToString:@"mobile_sucess"]) {//待整改
                //可以注册 , 进行下一条验证
                AlertInVC(@"该手机暂未注册")
                result(NO);
            }else if ([responseObject.data isEqualToString:@"mobile_have_used"]){
                //已被占用 , 请更改
//                AlertInVC(@"验证码已发送至手机");
                result(YES);
            }
        } failure:^(NSError *error) {
            LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
            AlertInVC(@"网络错误");
            //            result(2);//网络错误
        }];
    
}
-(void)checkEmailByInternet:(void(^)(BOOL lawful))result {//检查邮箱的有效性
    [[UserInfo shareUserInfo] checkUserNameOrMobileWithUserName:nil mobile:nil email:self.userInfoInputView.currentText mobilecode:nil success:^(ResponseObject *responseObject) {
        if ([responseObject.data isEqualToString:@"email_sucess"]) {//邮箱不存在 , 可以注册 , 因此就不能用来找回密码了
            AlertInVC(@"邮箱未找到")
            result(NO);
        }else if ([responseObject.data isEqualToString:@""]){
            result(YES);
        }
    } failure:^(NSError *error) {
        
    }];

}
/** 判断用户名的合法性 */
-(BOOL)userNameLawful:(NSString*)input
{
//    NSString * regex = @"^[a-zA-Z0-9_]{6,16}$";
//    NSString * regex = @"^[a-zA-Z][a-zA-Z0-9_]{5,31}$";
     NSString * regex =  @"^[a-zA-Z][a-zA-Z0-9-_]{5,31}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:input];
    return isMatch;
}

- (BOOL) emailLawful:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
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


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
