//
//  RegisterVC.m
//  b2c
//
//  Created by wangyuanfei on 16/6/2.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "RegisterVC.h"

@interface RegisterVC ()
/** 上半部分子视图的容器视图 */
@property(nonatomic,weak)UIView * topContainerView ;


/** 下半部分子视图的容器视图 */
@property(nonatomic,weak)UIView * bottomContainerView ;

/** 用户名输入框 */
@property(nonatomic,weak)UITextField * userNameInput ;
/** 手机号码输入框 */
@property(nonatomic,weak)UITextField * mobileInput ;
/** 验证码输入框 */
@property(nonatomic,weak)UITextField * authcodeInput ;
/** 获取验证码按钮 */
@property(nonatomic,weak)UIButton * gotAuthcodeButton ;
/** 密码输入框 */
@property(nonatomic,weak)UITextField * passwordInput ;
/** 注册按钮 */
@property(nonatomic,weak)UIButton * registerButton ;
/** 协议选择按钮 */
@property(nonatomic,weak)UIButton * selectButton ;
/** 协议文字展示 */
@property(nonatomic,weak)UILabel * treatyLabel ;
/** 文本输入框容器数组 */
@property(nonatomic,strong)NSMutableArray * textFieldsArrM ;


/** 定时器 */
@property(nonatomic,strong)NSTimer * timer ;
/** 重新发送倒计时时间 */
@property(nonatomic,assign)NSInteger  time ;


/** 标识是否能执行注册的数组 , 元素达到4 */
@property(nonatomic,strong)NSMutableArray * markArrM ;
@end

@implementation RegisterVC

-(NSMutableArray * )textFieldsArrM{
    if(_textFieldsArrM==nil){
        _textFieldsArrM = [[NSMutableArray alloc]init];
    }
    return _textFieldsArrM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviTitle = @"注册";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupsubUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldEndEditing:) name:UITextFieldTextDidEndEditingNotification object:nil];
    // Do any additional setup after loading the view.
}

-(void)setupsubUI
{
    /** 上半部分子视图的容器视图 */
    UIView * topContainerView =[[UIView alloc]init];
    self.topContainerView = topContainerView;
    [self.view addSubview:topContainerView];
//    topContainerView.backgroundColor = randomColor;
    
    /** 下半部分子视图的容器视图 */
    UIView * bottomContainerView  =[[UIView alloc]init];
    self.bottomContainerView = bottomContainerView;
    [self.view addSubview:bottomContainerView];
//    bottomContainerView.backgroundColor = randomColor;
    
    
    /** 用户名输入框 */
    UITextField * userNameInput =[[UITextField alloc]init] ;
    [self.textFieldsArrM addObject:userNameInput];
    userNameInput.placeholder = @"请输入6~32位的用户名";
    self.userNameInput = userNameInput ;
    [self.topContainerView addSubview:userNameInput];
    userNameInput.font = [UIFont systemFontOfSize:14];
    
    
    
    /** 手机号码输入框 */
    UITextField * mobileInput =[[UITextField alloc]init];
    mobileInput.keyboardType =  UIKeyboardTypeNumberPad;
    [self.textFieldsArrM addObject:mobileInput];
//    mobileInput.backgroundColor = randomColor;
    mobileInput.placeholder = @"请输入手机号码";
    self.mobileInput = mobileInput;
    [self.topContainerView addSubview:mobileInput];
    mobileInput.font = [UIFont systemFontOfSize:14];
    
    
    /** 验证码输入框 */
    UITextField * authcodeInput =[[UITextField alloc]init];
    authcodeInput.keyboardType =  UIKeyboardTypeNumberPad;
    [self.textFieldsArrM addObject:authcodeInput];
//    authcodeInput.backgroundColor = randomColor;
    authcodeInput.placeholder = @"请输入验证码";
    self.authcodeInput = authcodeInput ;
    [self.topContainerView addSubview:authcodeInput];
    authcodeInput.font = [UIFont systemFontOfSize:14];
    
    /** 获取验证码按钮 */
    UIButton * gotAuthcodeButton =[[UIButton alloc]init];
    gotAuthcodeButton.titleLabel.font = [UIFont systemFontOfSize:14 ];
    [gotAuthcodeButton addTarget:self action:@selector(gotAuthcodeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [gotAuthcodeButton setTitleColor:SubTextColor forState:UIControlStateNormal];
//    gotAuthcodeButton.backgroundColor = randomColor;
    gotAuthcodeButton.layer.borderWidth = 1 ;
    gotAuthcodeButton.layer.borderColor = BackgroundGray.CGColor;
    gotAuthcodeButton.layer.masksToBounds = YES;
    [gotAuthcodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    gotAuthcodeButton.backgroundColor = THEMECOLOR;
//    [gotAuthcodeButton setcolor]
    self.gotAuthcodeButton = gotAuthcodeButton;
    self.gotAuthcodeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.topContainerView addSubview:gotAuthcodeButton];
    
    
    /** 密码输入框 */
    UITextField * passwordInput =[[UITextField alloc]init];
    passwordInput.secureTextEntry=YES;
    [self.textFieldsArrM addObject:passwordInput];
    passwordInput.placeholder  =  @"请输入密码";
    self.passwordInput = passwordInput ;
    [self.topContainerView addSubview:passwordInput];
    passwordInput.font = [UIFont systemFontOfSize:14];
    
    
    
    
    
    /** 注册按钮 */
    UIButton * registerButton =[[UIButton alloc]init];
    self.registerButton = registerButton ;
    [registerButton setBackgroundColor:THEMECOLOR];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.bottomContainerView addSubview:registerButton];
    [registerButton addTarget:self action:@selector(registerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    /** 协议选择按钮 */
//    UIButton * selectButton = [[UIButton alloc]init];
//    [selectButton setImage:[UIImage imageNamed:@"icon_selectionbox_sel"] forState:UIControlStateNormal];
//    [selectButton setImage:[UIImage imageNamed:@"icon_selectionbox_nor"] forState:UIControlStateSelected];
//    self.selectButton = selectButton ;
//    [self.bottomContainerView addSubview:selectButton];
//    selectButton.bounds = CGRectMake(0, 0, 14*SCALE, 14*SCALE);
//    [selectButton addTarget:self action:@selector(selectAgreeWithTreaty:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    /** 协议文字展示 */
    UILabel * treatyLabel =[[UILabel alloc]init];
    treatyLabel.font = [UIFont systemFontOfSize:12 ];
    self.treatyLabel = treatyLabel ;
    [self.bottomContainerView addSubview:treatyLabel];
//    NSString * leftText= @"我已阅读并同意";
    NSString * leftText= @"注册即视为同意";
    NSString * rightText = @"<直接捞注册协议>";
    NSString * fullText = [leftText stringByAppendingString:rightText];
//    NSRange leftRange = [fullText rangeOfString:leftText];
    NSRange rightRange = [fullText rangeOfString:rightText];
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc]initWithString:fullText];
    [attriStr addAttribute:NSForegroundColorAttributeName value:THEMECOLOR range:rightRange];
    treatyLabel.attributedText =attriStr;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoSeeTheTreaty:)];
    [treatyLabel addGestureRecognizer:tap];
    treatyLabel.userInteractionEnabled=YES;
    
    
    /** 开始布局 */
    CGFloat topComponentY = 0 ;
    
    CGFloat containerW = 275 * SCALE ;
    
    CGFloat leftImgW = 16 * SCALE ;
//    CGFloat leftImgH = 18 * SCALE ;
    CGFloat leftImgX = 4 ;

    CGFloat lineH = 1 ;
    CGFloat topComponentH = 44 ;
    CGFloat topComponentX = leftImgX + leftImgW + 10 ;
    CGFloat topComponentW = containerW - topComponentX;
    
    
    CGFloat topContainerH =  (topComponentH +lineH)* 4 ;
//    CGFloat topContainerY = 44 + 
    self.topContainerView.frame = CGRectMake((self.view.bounds.size.width - topComponentW)/2, 88 * SCALE, containerW, topContainerH);
    
    self.userNameInput.frame = CGRectMake(topComponentX, topComponentY, topComponentW, topComponentH);
    [self addIconToTopContainerViewWithCenterY:CGRectGetMidY(self.userNameInput.frame) imageName:@"tab_me_normal"];
    [self addLineToTopContainerWithY:CGRectGetMaxY(self.userNameInput.frame)];
    
    self.mobileInput.frame = CGRectMake(CGRectGetMinX(self.userNameInput.frame), CGRectGetMaxY(self.userNameInput.frame), topComponentW, topComponentH);
    [self addIconToTopContainerViewWithCenterY:CGRectGetMidY(self.mobileInput.frame) imageName:@"icon_phone"];
     [self addLineToTopContainerWithY:CGRectGetMaxY(self.mobileInput.frame)];

    CGFloat gotAuthCodeButtonW = 120 * SCALE ;
    self.gotAuthcodeButton.frame = CGRectMake(self.topContainerView.bounds.size.width - gotAuthCodeButtonW, CGRectGetMaxY(self.mobileInput.frame), gotAuthCodeButtonW, topComponentH+1);
    [gotAuthcodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [gotAuthcodeButton setTitleColor:SubTextColor forState:UIControlStateDisabled];
    
    self.authcodeInput.frame = CGRectMake(topComponentX, CGRectGetMaxY(self.mobileInput.frame), topComponentW - gotAuthCodeButtonW, topComponentH);
    [self addIconToTopContainerViewWithCenterY:CGRectGetMidY(self.authcodeInput.frame) imageName:@"icon_verificationcode"];
    [self addLineToTopContainerWithY:CGRectGetMaxY(self.authcodeInput.frame)];
    
    self.passwordInput.frame = CGRectMake(topComponentX, CGRectGetMaxY(self.authcodeInput.frame), topComponentW, topComponentH);
    [self addIconToTopContainerViewWithCenterY:CGRectGetMidY(self.passwordInput.frame) imageName:@"icon_password"];
    [self addLineToTopContainerWithY:CGRectGetMaxY(self.passwordInput.frame)];
    
    CGFloat topToBottomMargin = 72 * SCALE;
    
    CGFloat registerButtonH = 40 * SCALE;
    CGFloat registerButtonW = self.topContainerView.bounds.size.width;
    CGFloat registerButtonToTreaty = 12 * SCALE;
    CGFloat treatyLabelH  = 14 ;
    
    CGFloat bottomContainerViewH = registerButtonH + registerButtonToTreaty+treatyLabelH;
    
    self.bottomContainerView.frame = CGRectMake(self.topContainerView.frame.origin.x, CGRectGetMaxY(self.topContainerView.frame)+topToBottomMargin, self.topContainerView.bounds.size.width, bottomContainerViewH);
    

    self.registerButton.frame = CGRectMake(0, 0, registerButtonW, registerButtonH);
    registerButton.layer.cornerRadius = registerButton.bounds.size.height/2;
    registerButton.layer.masksToBounds = YES;
    
    CGSize textSize = [self.treatyLabel.text sizeWithFont:self.treatyLabel.font MaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,NSStringFromCGSize(textSize));
    CGFloat treatyCenterX = self.bottomContainerView.bounds.size.width/2 ;//+ self.selectButton.bounds.size.width;
    CGFloat treatyCenterY = CGRectGetMaxY(self.registerButton.frame) +registerButtonToTreaty + textSize.height/2 ;
    self.treatyLabel.bounds = CGRectMake(0, 0, textSize.width, treatyLabelH);
    self.treatyLabel.center = CGPointMake(treatyCenterX, treatyCenterY);
//    self.selectButton.center = CGPointMake(CGRectGetMinX(self.treatyLabel.frame)-self.selectButton.bounds.size.width, treatyCenterY);
    
    
}

-(UIImageView*)addIconToTopContainerViewWithCenterY:(CGFloat)Y imageName:(NSString*)imageName
{
    UIImageView * icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    icon.contentMode =  UIViewContentModeScaleAspectFit;
    CGFloat leftImgW = 16 * SCALE ;
    CGFloat leftImgH = 18 * SCALE ;
    CGFloat leftImgX = 4 ;
    icon.bounds = CGRectMake(0, 0, leftImgW, leftImgH);;
    icon.center = CGPointMake(leftImgX+icon.bounds.size.width/2, Y);
    [self.topContainerView addSubview:icon];
    return icon;
}

-(UIView*)addLineToTopContainerWithY:(CGFloat)Y
{
    UIView * line = [[UIView alloc]init];
    line.backgroundColor = BackgroundGray;
    line.frame = CGRectMake(0, Y, self.topContainerView.bounds.size.width, 1);
    [self.topContainerView addSubview:line];
    return line;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self deleteTimer];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)gotoSeeTheTreaty:(id )sender
{
    
//    LOG(@"_%@_%d_%@\n去查看直接捞注册协议",[self class] , __LINE__,sender);
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"http://m.zjlao.com/Index/zcxy.html");
    BaseModel * model = [[BaseModel alloc ]init];
    model.actionKey = @"BaseWebVC";
    //https://m.zjlao.cn/AppOrder/rule/id/136.html
    
//    model.keyParamete = @{@"paramete":[NSString stringWithFormat:@"%@/Index/zcxy1.html",WAPDOMAIN]};
    model.keyParamete = @{@"paramete":[NSString stringWithFormat:@"%@/AppOrder/rule/id/136.html",WAPDOMAIN]};
    [[SkipManager shareSkipManager] skipByVC:self withActionModel:model];
}
-(void)selectAgreeWithTreaty:(UIButton*)sender
{
    sender.selected = !sender.selected;
}
-(void)registerButtonClick:(UIButton*)sender
{
    //如果注册协议选择按钮状态为非选中状态 , 就可以注册 , 如果是选中状态就提示请同意协议
    
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"执行注册");
    [self.view endEditing:YES];
    [self judgeTextFieldContentLawful:^(BOOL result) {
        if (result==NO) {
            //禁止注册
        }else{
            //可以注册
        }
    }];
}
-(void)gotAuthcodeButtonClick:(UIButton*)sender
{
    sender.enabled = NO ;
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"点击获取验证码");
    [self resentAuthcode:self.gotAuthcodeButton];
    [self.view endEditing:YES];
}
/** 监听结束编辑 */
-(void)textFieldEndEditing:(NSNotification*)sender
{
    UITextField * currentTextField = sender.object;
//    LOG(@"_%@_%d_\n%@",[self class] , __LINE__,sender.object);
    LOG(@"_%@_%d_%@",[self class] , __LINE__,currentTextField.text);
    if (!(self.userNameInput.text.length>0)) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"请输入用户名");
    }else{
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"验证当前账户名是否已被占用");
        self.registerButton.enabled = YES;
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
    }

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)checkUserNameByInternet:(void(^)(BOOL lawful))result {//检查用户名的有效性
    if ([self userNameLawful:self.userNameInput.text]) {
        [[UserInfo shareUserInfo] checkUserNameOrMobileWithUserName:self.userNameInput.text mobile:nil email:nil mobilecode:nil success:^(ResponseObject *responseObject) {
            LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
            if ([responseObject.data isEqualToString:@"name_sucess"]) {
                //可以注册 , 进行下一条验证
                result(YES);
            }else if ([responseObject.data isEqualToString:@"name_have_exit"]){
                //已被占用 , 请更改
                self.registerButton.backgroundColor = THEMECOLOR;
                self.registerButton.enabled = YES;
                AlertInVC(@"该用户名已被占用 , 请更换用户名");
                result(NO);
            }
        } failure:^(NSError *error) {
            self.registerButton.backgroundColor = THEMECOLOR;
            self.registerButton.enabled = YES;
            LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
            AlertInVC(@"网络错误");
//            result(2);//网络错误
        }];
    }else{
        self.registerButton.backgroundColor = THEMECOLOR;
        self.registerButton.enabled = YES;
        AlertInVC(@"用户名由数字,字母, - , _ 组成,并以字母开头");
//        return;
    }

}

-(void)checkMobileByInternet:(void(^)(BOOL lawful))result {//检查手机的有效性
    if ([self mobileLawful:self.mobileInput.text]) {
        [[UserInfo shareUserInfo] checkUserNameOrMobileWithUserName:nil mobile:self.mobileInput.text email:nil mobilecode:nil success:^(ResponseObject *responseObject) {
            LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
            if ([responseObject.data isEqualToString:@"mobile_sucess"]) {//待整改
                //可以注册 , 进行下一条验证
                result(YES);
            }else if ([responseObject.data isEqualToString:@"mobile_have_used"]){
                //已被占用 , 请更改
                AlertInVC(@"该手机号已被注册 , 请更换手机并重新注册");
                self.registerButton.backgroundColor = THEMECOLOR;
                self.registerButton.enabled = YES;
                result(NO);
            }

        } failure:^(NSError *error) {
            self.registerButton.backgroundColor = THEMECOLOR;
            self.registerButton.enabled = YES;
            LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
            LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
            self.gotAuthcodeButton.enabled = YES;
            AlertInVC(@"网络错误");
//            result(2);//网络错误
        }];
    }/*else{
        AlertInVC(@"请输入合法手机号");
        //        return;
    }*/
    
}

-(void)checkAuthcodeByInternet:(void(^)(BOOL lawful))result {//检查验证码的有效性
    if ([self authcodeLawful:self.authcodeInput.text]) {

        [[UserInfo shareUserInfo] checkUserNameOrMobileWithUserName:nil mobile:self.mobileInput.text email:nil mobilecode:self.authcodeInput.text success:^(ResponseObject *responseObject) {
            LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
            if ([responseObject.data isEqualToString:@"verify_sucess"]) {//待整改
                //可以注册 , 进行下一条验证
                result(YES);
            }else if ([responseObject.data isEqualToString:@"verify_wrong"]){
                //已被占用 , 请更改
                self.registerButton.backgroundColor = THEMECOLOR;
                self.registerButton.enabled = YES;
                AlertInVC(@"验证码不正确");
                result(NO);
            }else if ([responseObject.data isEqualToString:@"verify_overtime"]){
                AlertInVC(@"验证码已过期");
                self.registerButton.backgroundColor = THEMECOLOR;
                self.registerButton.enabled = YES;
                result(NO);
            }else{
                self.registerButton.backgroundColor = THEMECOLOR;
                self.registerButton.enabled = YES;
                AlertInVC(@"验证码出现未知错误")
                result(NO);
            }
        } failure:^(NSError *error) {
            self.registerButton.backgroundColor = THEMECOLOR;
            self.registerButton.enabled = YES;
            LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
            AlertInVC(@"网络错误");
//            result(2);//网络错误
        }];
    }else{
        self.registerButton.backgroundColor = THEMECOLOR;
        self.registerButton.enabled = YES;
        AlertInVC(@"请输入手机短信中六位数字的验证码");
        //        return;
    }
    
}

-(void)judgeTextFieldContentLawful:(void(^)(BOOL result))result
{
    /** 本地判断格式 */
        for (int i = 0 ; i < self.textFieldsArrM.count; i ++ ) {
            LOG(@"_%@_%d_%d",[self class] , __LINE__,i);
            UITextField * input = self.textFieldsArrM[i];
            if (input.text.length==0) {
                NSString * tempPlaceHolder = input.placeholder.copy ;
                if ([input.placeholder containsString:@"6~32位的"]) {
                    tempPlaceHolder=[input.placeholder stringByReplacingOccurrencesOfString:@"6~32位的" withString:@""];
                }
                NSString * tipsStr = [tempPlaceHolder stringByReplacingOccurrencesOfString:@"请输入" withString:@""];

                tipsStr = [tipsStr stringByAppendingString:@"为空"];
                AlertInVC(tipsStr)
                return;
            }else if(input==self.userNameInput){
                if (![self userNameLawful:self.userNameInput.text]) {
                    AlertInVC(@"用户名由数字,字母, - , _ 组成,并以字母开头");
                    return;
                }
            }else if(input==self.mobileInput){
                if (![self mobileLawful:self.mobileInput.text]) {
//                    AlertInVC(@"请输入合法手机号")
                    return;
                }
            }else if(input==self.authcodeInput){
                if (![self authcodeLawful:self.authcodeInput.text]) {
                    if (self.authcodeInput.text.length==0) {
                        AlertInVC(@"请输入验证码");
                    }else{
                        AlertInVC(@"验证码不正确")
                    }
                    return;
                }
            }else if(input==self.passwordInput){
                if (![self passwordLawful:self.passwordInput.text ]) {
                    AlertInVC(@"请输入6~16位的登录密码")
                    return;
                }
            }
        }
//    if (self.selectButton.selected) {
//        AlertInVC(@"请勾选<直接捞注册协议>")
//        return;
//    }
    /** 网络判断有效性 */
    self.registerButton.enabled = NO ;
    self.registerButton.backgroundColor = SubTextColor;
    [self checkUserNameByInternet:^(BOOL lawful) {
        if (lawful) {
                [self checkMobileByInternet:^(BOOL lawful) {
                    if (lawful) {
                        [self checkAuthcodeByInternet:^(BOOL lawful) {
                            if (lawful) {


                                [UserInfo shareUserInfo].name = self.userNameInput.text;
                                    [UserInfo shareUserInfo].password = self.passwordInput.text;
                                    [UserInfo shareUserInfo].mobile = self.mobileInput.text;
                                    [UserInfo shareUserInfo].mobileCode = self.authcodeInput.text;
                                    [[UserInfo shareUserInfo] registerSuccess:^(ResponseObject *response) {
                                        LOG(@"_%@_%d_%@",[self class] , __LINE__,response.data);
                                        /** 注册成功之后跳转到哪个页面 */
                                        if (response.status == REGIST_SUCESS ) {
                                            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"注册成功");
                                            [[UserInfo shareUserInfo] loginSuccess:^(ResponseStatus response) {
                                                LOG(@"_%@_%d_%d",[self class] , __LINE__,response);
                                                 [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                                            } failure:^(NSError *error) {
                                                LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
                                                AlertInVC(@"注册成功 , 请返回登录")
//                                                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                                            }];
                                            
                                            
//                                            [self loginWithUser:user success:^(ResponseStatus response) {
//                                                
//                                                //            success(response);
//                                            } failure:^(NSError *error) {
//                                                failure(error);
//                                            }];
                                            
                                            
                                        }else if (response.status == REGIST_FAIL){
                                            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"注册失败");
                                            AlertInVC(@"注册失败 , 请重试")
                                            self.registerButton.backgroundColor = THEMECOLOR;
                                            self.registerButton.enabled  = YES;
                                        }else{
                                            AlertInVC(@"未知错误,请重试")
                                            self.registerButton.backgroundColor = THEMECOLOR ;
                                            self.registerButton.enabled = YES;
                                        }
                                        
                                    } failure:^(NSError *error) {
                                        AlertInVC(@"网络异常,请重试或者返回登录")
                                        self.registerButton.backgroundColor = THEMECOLOR;
                                        self.registerButton.enabled = YES;
                                        LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
                                    }];
                            }
                        }];
                    }
                }];
        }
    }];
    
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
/** 判断验证码的合法性 */

- (BOOL)authcodeLawful:(NSString *) textString
{
    NSString* number=@"^\\d{6}$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:textString];
}
///** 判断手机号的合法性 */
//-(BOOL)telNumberLawful:(NSString*)telNumber
//{
//    
//    NSString*pattern=@"^1[3|4|5|7|8][0-9]\\d{8}$";
//    
//    NSPredicate*pred=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
//    
//    BOOL isMatch= [pred evaluateWithObject:telNumber];
//    
//    return isMatch;
//    
//}
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
/** 判断手机号的合法性 */

- (BOOL) mobileLawful:(NSString *)mobileNumbel{
    if (mobileNumbel.length==0) {
        self.gotAuthcodeButton.enabled = YES;
        AlertInVC(@"手机号为空");
        return NO;
    }
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
    self.gotAuthcodeButton.enabled = YES;
    AlertInVC(@"请输入正确格式的手机号");
    return NO;
}








/////////验证码按钮相关////////////
-(void)navigationBack{
    [self deleteTimer];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)deleteTimer
{
    
    self.gotAuthcodeButton.enabled=YES;
    [self.gotAuthcodeButton setTitle:@"重新获取" forState:UIControlStateNormal];
//    [self.gotAuthcodeButton setTitleColor:@ forState:<#(UIControlState)#>]
    self.gotAuthcodeButton.backgroundColor = THEMECOLOR;
    [self.timer invalidate];
    self.timer=nil;
}
-(void)creatTimer
{
    self.gotAuthcodeButton.enabled=NO;
    self.gotAuthcodeButton.backgroundColor = [UIColor whiteColor];
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(daojishi) userInfo:nil repeats:YES];
    self.timer= timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    self.time=60;
}
-(void)daojishi
{
    
    self.time-=1;
    [self.gotAuthcodeButton setTitle:[NSString stringWithFormat:@"%lds后重新获取",self.time] forState:UIControlStateNormal];
    if (self.time==0) {
        [self.gotAuthcodeButton setTitle:@"重新获取" forState:UIControlStateNormal];
        [self deleteTimer];
    }
}
-(void)resentAuthcode:(UIButton*)sender
{
    [self checkMobileByInternet:^(BOOL lawful) {
        if (lawful) {
#pragma mark 手机号
            [UserInfo shareUserInfo].mobile = self.mobileInput.text;
            [self.gotAuthcodeButton setTitle:[NSString stringWithFormat:@"60s后重新获取"] forState:UIControlStateNormal];
            [self creatTimer];
            [[UserInfo shareUserInfo] gotMobileCodeWithType:Register Success:^(ResponseStatus response) {
                
//                MBProgressHUD * hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//                hub.mode=MBProgressHUDModeText;
//                [hub hide:YES afterDelay:1.5];
                if (response==SHORTMESSAGE_SUCESS) {
//                    hub.labelText=@"验证码发送成功";
//                    hub.completionBlock = ^{
//                        [self creatTimer];
//                    };
                }else if (response== SHORTMESSAGE_FAIL){
                    MBProgressHUD * hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    hub.mode=MBProgressHUDModeText;
                    [hub hide:YES afterDelay:1.5];
                    hub.labelText=@"验证码获取失败";
                    hub.detailsLabelText=@"请重试";
                    [self deleteTimer];
                    
                }
            } failure:^(NSError *error) {
                
            }];

            
        }else{
            self.gotAuthcodeButton.enabled = YES;
            return ;
        }
    }];
       LOG(@"_%@_%d_%@",[self class] , __LINE__,@"重新发送验证码操作")
}

@end
