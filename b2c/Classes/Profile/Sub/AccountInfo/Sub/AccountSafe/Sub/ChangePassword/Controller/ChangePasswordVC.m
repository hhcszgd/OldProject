//
//  ChangePasswordVC.m
//  b2c
//
//  Created by wangyuanfei on 4/7/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
/**
 修改登录密码控制器 , 跟设置支付密码公用同一个控制器
 
 */

#import "ChangePasswordVC.h"

#import "MyInputAccessoryView.h"
#import "CustomInputView.h"


@interface ChangePasswordVC ()<CustomInputViewDelegate>
@property(nonatomic,weak)  CustomInputView * oldpasswordInput ;
@property(nonatomic,weak)  CustomInputView * newpasswordInput ;
@property(nonatomic,weak)UILabel * tipsLabel ;
@property(nonatomic,weak)UIButton * bottomButton ;

@property(nonatomic,assign) ChangePasswordType currentType ;
@end

@implementation ChangePasswordVC
-(instancetype)initWithType:(ChangePasswordType)changePsdPtye{
    if (self=[super init]) {
        self.currentType = changePsdPtye;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.keyParamete[@""];
    
//    self.view.backgroundColor=BackgroundGray;
    // Do any additional setup after loading the view.
    [self setupUI];
}
-(void)setupUI
{
    CGFloat margin = 10 ;
    CGFloat rowH = 44 ;
    NSString * oldStrTips = @"原始密码";
//    NSString * oldPlaceholderStr = @"请输入原始密码";
    NSString * newStrTips = @"新密码";
//    NSString * newPlaceholderStr =  @"请输入新密码";
    NSString * tipsStr = @"密码由6 ~ 16 个字符组成 ";
    if (self.currentType==ChangeLoginPassword) {
       self.naviTitle = @"修改登录密码";
    
    }else if (self.currentType == ChangePayPassword){
        tipsStr = @"支付密码由六位数字组成";
        self.naviTitle = @"修改支付密码";
    }else if (self.currentType == SetPayPassword){
        oldStrTips = @"支付密码";
        newStrTips = @"确认支付密码";
        tipsStr = @"支付密码由六位数字组成";
        self.naviTitle = @"设置支付密码";
    }
    
    
    
    
    CustomInputView * oldpasswordInput = [[CustomInputView alloc]initWithFrame:CGRectMake(0, self.startY+margin, self.view.bounds.size.width, rowH)];
    oldpasswordInput.secureTextEntry=YES;
    
    CustomInputView * newpasswordInput = [[CustomInputView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(oldpasswordInput.frame), self.view.bounds.size.width, rowH)];
    newpasswordInput.secureTextEntry = YES;
    self.oldpasswordInput = oldpasswordInput;
    [self.view addSubview:oldpasswordInput];
    CGSize newTipsStrSize = [newStrTips sizeWithFont:newpasswordInput.currentFont MaxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    CGSize oldTipsSize = [oldStrTips sizeWithFont:oldpasswordInput.currentFont MaxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    
    oldpasswordInput.tipsTitle = oldStrTips;
    oldpasswordInput.leftWidth = newTipsStrSize.width>oldTipsSize.width ? newTipsStrSize.width : oldTipsSize.width;
//    oldpasswordInput.inputPlaceholder = oldPlaceholderStr;
    
    self.newpasswordInput = newpasswordInput;
    [self.view addSubview:newpasswordInput];
    newpasswordInput.tipsTitle = newStrTips;
    newpasswordInput.leftWidth = newTipsStrSize.width>oldTipsSize.width ? newTipsStrSize.width : oldTipsSize.width;
    if (self.currentType == ChangePayPassword || self.currentType == SetPayPassword ) {
        oldpasswordInput.customKeyboardType = UIKeyboardTypeNumbersAndPunctuation;
        newpasswordInput.customKeyboardType = UIKeyboardTypeNumbersAndPunctuation;
    }
    oldpasswordInput.customReturenType = UIReturnKeyDone;
    newpasswordInput.customReturenType = UIReturnKeyDone;
    oldpasswordInput.CustomInputDelegate = self;
    newpasswordInput.CustomInputDelegate = self;
//    newpasswordInput.inputPlaceholder = newPlaceholderStr;
    
    
    UILabel * tipsLabel  =  [[UILabel alloc]initWithFrame:CGRectMake(margin, CGRectGetMaxY(newpasswordInput.frame), self.view.bounds.size.width-margin*2, 34)];
    tipsLabel.text = tipsStr;
    tipsLabel.textColor = SubTextColor;
    tipsLabel.font = [UIFont systemFontOfSize:12];
//    CGSize tipsLabelSize = 
    self.tipsLabel = tipsLabel;
    [self.view addSubview:tipsLabel];

    UIButton * bottomButton = [[UIButton alloc]initWithFrame:CGRectMake(margin*2, self.view.bounds.size.height  - rowH - margin*4, self.view.bounds.size.width - margin*2*2, rowH)];
    self.bottomButton = bottomButton;
    [self.view addSubview:bottomButton];
    bottomButton.backgroundColor = THEMECOLOR;
    [bottomButton setTitle:@"完成" forState:UIControlStateNormal];
    [bottomButton addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)customInputTextFieldShouldReturn:(CustomInputView*)customInputView{
    [self bottomButtonClick:self.bottomButton];
}

-(void)bottomButtonClick:(UIButton*)sender
{
    if (self.currentType==ChangeLoginPassword) {
        //修改登录密码
//        if (self.oldpasswordInput.currentText.length==0|| ![self.oldpasswordInput.currentText isEqualToString:self.newpasswordInput.currentText]){
//            AlertInVC(@"请输入两次一样的密码")
//            return;
//        }
        
        if (self.oldpasswordInput.currentText.length ==0) {
            AlertInVC(@"原登录密码为空")
            return;
        }
        
        if (![self loginPasswordLawful:self.oldpasswordInput.currentText]) {
            AlertInVC(@"请输入原始的6~16位的登录密码");
            return;
        }
        
        if (self.newpasswordInput.currentText.length==0) {
            AlertInVC(@"新登录密码为空")
            return;
        }
        if (![self loginPasswordLawful:self.newpasswordInput.currentText]) {
            AlertInVC(@"请输入新的6~16位的登录密码");
            return;
        }
        
        if ([self.oldpasswordInput.currentText isEqualToString:self.newpasswordInput.currentText]) {
            AlertInVC(@"新密码请勿与原始密码重复");
            return;
        }
//        if ([self loginPasswordLawful:self.oldpasswordInput.currentText]&&[self loginPasswordLawful:self.newpasswordInput.currentText]) {
//            AlertInVC(@"先验证老密码的正确性  , 再执行修改登录密码")
            [[UserInfo shareUserInfo ] checkOldLoginPasswordWithOldLoginPassword:self.oldpasswordInput.currentText success:^(ResponseObject *responseObject) {
                LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
                if (responseObject.status>0) {
                    [[UserInfo shareUserInfo] changeNewLoginPasswordWithNewLoginPassword:self.newpasswordInput.currentText success:^(ResponseObject *responseObject) {
                        if (responseObject.status>0) {
                            LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
                            [[NSNotificationCenter defaultCenter] postNotificationName:CHANGEPASSWORDSUCCESS object:nil];
                            MBProgressHUD * hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                            hub.mode=MBProgressHUDModeText;
                            hub.detailsLabelText=[NSString stringWithFormat:@"%@",responseObject.msg];
                            [hub hide:YES afterDelay:1];
                            hub.completionBlock = ^(){
//                                [self.navigationController popToRootViewControllerAnimated:YES];
                                [self.navigationController popViewControllerAnimated:YES];

                            };
//                            AlertInVC(responseObject.msg)
                        }else{
                            AlertInVC(responseObject.msg)
                        }
                    } failure:^(NSError *error) {
                        
                    }];
                }else{
//                    AlertInVC(responseObject.msg)
                    AlertInVC(@"原登录密码输入有误")
                }
            } failure:^(NSError *error) {
               LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
            }];
            
            //TODO
        
    
//    else{
//            AlertInVC(@"请输入6~16位的登录密码")
//        }
    }else if (self.currentType == ChangePayPassword){
        
        if ([self.oldpasswordInput.currentText isEqualToString:self.newpasswordInput.currentText]) {
            AlertInVC(@"新密码请勿与原始密码重复");
            return;
        }
        //修改支付密码
        if ([self payPasswordLawful:self.oldpasswordInput.currentText]&&[self payPasswordLawful:self.newpasswordInput.currentText]) {
            [[UserInfo shareUserInfo] checkOldPayPasswordWithOldPayPassword:self.oldpasswordInput.currentText success:^(ResponseObject *responseObject) {
                if (responseObject.status>0) {//验证成功 , 调用修改支付密码的接口
                    [[UserInfo shareUserInfo] changeNewPayPasswordWithNewPayPassword:self.newpasswordInput.currentText success:^(ResponseObject *responseObject) {
                        //
                        if (responseObject.status>0) {
                            [[NSNotificationCenter defaultCenter] postNotificationName:CHANGEPASSWORDSUCCESS object:nil];
                            
                            MBProgressHUD * hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                            hub.mode=MBProgressHUDModeText;
                            hub.detailsLabelText=[NSString stringWithFormat:@"%@",responseObject.msg];
                            [hub hide:YES afterDelay:1];
                            hub.completionBlock = ^(){
//                                [self.navigationController popToRootViewControllerAnimated:YES];
                                [self.navigationController popViewControllerAnimated:YES];

                            };
                        }else{
                            AlertInVC(responseObject.msg)
                        }
                    } failure:^(NSError *error) {
                       AlertInVC(@"网络错误")
                    }];
                }else{
                    AlertInVC(responseObject.msg)
                }
            } failure:^(NSError *error) {
                AlertInVC(@"网络错误");
            }];
            
            
           
        }else{
             AlertInVC(@"请输入6位数字的支付密码")
        }
        
        
        

    }else if (self.currentType == SetPayPassword){
        
        //初次设置支付密码
        if (self.oldpasswordInput.currentText.length==0 || self.newpasswordInput.currentText.length==0) {
            AlertInVC(@"支付密码为空");
            return;
        }
        
        if ( ![self.oldpasswordInput.currentText isEqualToString:self.newpasswordInput.currentText]){
            AlertInVC(@"请输入两次一样的密码")
            return;
        }
        if ([self payPasswordLawful:self.oldpasswordInput.currentText]) {
//            AlertInVC(@"执行设置支付密码")
            __weak typeof(self) weakSelf = self;
            [[UserInfo shareUserInfo] changeNewPayPasswordWithNewPayPassword:self.oldpasswordInput.currentText success:^(ResponseObject *responseObject) {
                if (responseObject.status>0) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:CHANGEPASSWORDSUCCESS object:nil];
                    MBProgressHUD * hub = [MBProgressHUD showHUDAddedTo:weakSelf.view.window animated:YES];
                    hub.mode=MBProgressHUDModeText;
                    hub.detailsLabelText=[NSString stringWithFormat:@"%@",responseObject.msg];
                    [hub hide:YES afterDelay:1];
                    hub.completionBlock = ^(){
//                        [self.navigationController popToRootViewControllerAnimated:YES];
                        [weakSelf.navigationController popViewControllerAnimated:YES];
//                        [self.navigationController po]
                    };
                }else{
                    AlertInVC(responseObject.msg);
                
                }
                LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
            } failure:^(NSError *error) {
               LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
            }];
            //TODO
        }else{
            AlertInVC(@"请输入6位数字的支付密码")
        }
    }
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"完成");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}
-(void)setComponentWithTitle:(NSString*)title subKeyComponent:(UIView*)subKeyComponent andFrame:(CGRect)frame{
    
}

/** 判断验证码的合法性 */

- (BOOL)payPasswordLawful:(NSString *) payPassword
{
    NSString* number=@"^\\d{6}$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:payPassword];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];

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
/**  则匹配用户密码6-18位数字和字母组合*/

-(BOOL)loginPasswordLawful:(NSString*)loginPassword

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
    return [passWordPredicate evaluateWithObject:loginPassword];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (self.canDestroy) {
        [self removeFromParentViewController];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
