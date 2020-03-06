//
//  ResetPsdVC.m
//  b2c
//
//  Created by wangyuanfei on 16/6/13.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
/***
 重置登录密码
 */

#import "ResetPsdVC.h"
#import "CustomInputView.h"
#import "FindPsdWithMblVC.h"
@interface ResetPsdVC ()<CustomInputViewDelegate>
@property(nonatomic,weak)CustomInputView * newpasswordInput ;
@property(nonatomic,weak)CustomInputView * confirmPasswordInput ;
@property(nonatomic,weak)UIButton * bottomButton ;
@property(nonatomic,copy)NSString * mobileOrEmail ;
@property(nonatomic,assign)FindPasswordType  currentFindType ;

@property(nonatomic,weak)UIButton * helpButton ;


@end

@implementation ResetPsdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mobileOrEmail = self.keyParamete[@"paramete"];
    self.currentFindType = [self.keyParamete[@"subparamete"] integerValue];
    // Do any additional setup after loading the view.
    CGFloat margin = 10 ;
    /** 验证方式输入框 */
    CustomInputView * newpasswordInput  = [[CustomInputView alloc]initWithFrame:CGRectMake(0, self.startY+margin, self.view.bounds.size.width, 44)];
    newpasswordInput.CustomInputDelegate = self;
    newpasswordInput.textFont = [UIFont systemFontOfSize:12];
    newpasswordInput.leftWidth = 88 ;
    newpasswordInput.tipsTitle = @"新密码";
    newpasswordInput.inputPlaceholder = @"由6-16个字符组合而成";
    newpasswordInput.secureTextEntry=YES;
    self.newpasswordInput = newpasswordInput;
    [self.view addSubview:newpasswordInput];
    
    /** 验证码输入框 */
    
    CustomInputView * confirmPasswordInput  = [[CustomInputView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.newpasswordInput.frame), self.view.bounds.size.width, 44)];
    confirmPasswordInput.CustomInputDelegate = self;
    confirmPasswordInput.textFont = [UIFont systemFontOfSize:12];
    confirmPasswordInput.leftWidth = 88 ;
    confirmPasswordInput.tipsTitle = @"确认密码";
    confirmPasswordInput.secureTextEntry = YES;
    confirmPasswordInput.inputPlaceholder = @"由6-16个字符组合而成";
    self.confirmPasswordInput = confirmPasswordInput;
    [self.view addSubview:confirmPasswordInput];
    
    
    CGFloat maigin = 20 ;
    CGFloat bottomButtonH = 40 ;
    CGFloat toBottomMargin = bottomButtonH;
    CGFloat bottomButtonX = maigin ;
    CGFloat bottomButtonY = self.view.bounds.size.height  - bottomButtonH  - toBottomMargin ;
    CGFloat bottomButtonW = self.view.bounds.size.width - maigin * 2 ;
    UIButton * bottomButton = [[UIButton alloc]initWithFrame:CGRectMake(bottomButtonX, bottomButtonY, bottomButtonW, bottomButtonH)];
    self.bottomButton = bottomButton;
    [bottomButton addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomButton setBackgroundColor:THEMECOLOR];
    [self.view addSubview:self.bottomButton];
    [bottomButton setTitle:@"确定" forState:UIControlStateNormal];
    
    
    
    CGFloat helpButtonX = CGRectGetMinX(bottomButton.frame);
    CGFloat helpButtonY = CGRectGetMaxY(self.bottomButton.frame);
    CGFloat helpButtonW = self.view.bounds.size.width - 2 * margin;
    CGFloat helpButtonH = 44;
    
    
    
    UIButton * helpButton = [[UIButton alloc]initWithFrame:CGRectMake(helpButtonX, helpButtonY, helpButtonW, helpButtonH)];
    helpButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [helpButton setTitleColor:MainTextColor forState:UIControlStateNormal];
    helpButton.contentHorizontalAlignment =  UIControlContentHorizontalAlignmentLeft ;
    self.helpButton = helpButton;
    [self.view addSubview:helpButton];
    [helpButton setTitle:@"遇到问题? 点击联系客服" forState:UIControlStateNormal];
    [helpButton addTarget:self action:@selector(needHelpClick:) forControlEvents:UIControlEventTouchUpInside];

}

-(void)needHelpClick:(UIButton*)sender
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"4009696123"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"点击联系客服");
}
-(void)customInputTextFieldShouldReturn:(CustomInputView *)customInputView{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"点击return按钮");

}
-(void)bottomButtonClick:(UIButton*)sender
{
    if (![self passwordLawful:self.newpasswordInput.currentText] || ![self passwordLawful:self.confirmPasswordInput.currentText]) {
        AlertInVC(@"请输入由6-16位的登录密码")
        return;
    }
    if ([self.newpasswordInput.currentText isEqualToString:self.confirmPasswordInput.currentText]&&self.newpasswordInput.currentText.length>0&&self.confirmPasswordInput.currentText.length>0) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"两次密码一致 , 执行修改");
        if (self.currentFindType == FindPasswordWithMobileType) {
            [[UserInfo shareUserInfo] resetPasswordWithAuthType:self.mobileOrEmail password:self.newpasswordInput.currentText success:^(ResponseObject *responseObject) {
                LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
                MBProgressHUD * hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hub.completionBlock  = ^(){
                    [self.navigationController popToRootViewControllerAnimated:YES];
                };
                hub.mode=MBProgressHUDModeText;
                hub.detailsLabelText=[NSString stringWithFormat:@"%@",@"密码重置成功\n即将跳转到登录页面"];
                [hub hide:YES afterDelay:1];
                
            } failure:^(NSError *error) {
                LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
            }];

        }else if (self.currentFindType == findPasswordWithEmailType){
            //通过邮箱接口 , 暂时写成跟手机找回一样
            [[UserInfo shareUserInfo] resetPasswordWithAuthType:self.mobileOrEmail password:self.newpasswordInput.currentText success:^(ResponseObject *responseObject) {
                LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
                MBProgressHUD * hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hub.completionBlock  = ^(){
                    [self.navigationController popToRootViewControllerAnimated:YES];
                };
                hub.mode=MBProgressHUDModeText;
                hub.detailsLabelText=[NSString stringWithFormat:@"%@",@"密码重置成功\n即将跳转到登录页面"];
                [hub hide:YES afterDelay:1];
                
            } failure:^(NSError *error) {
                LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
            }];
            
        }
        
        
        
        
        
        
    }else{
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"两次输入的密码不一致 , 请重新输入");
        AlertInVC(@"请输入两次相同的密码")
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
