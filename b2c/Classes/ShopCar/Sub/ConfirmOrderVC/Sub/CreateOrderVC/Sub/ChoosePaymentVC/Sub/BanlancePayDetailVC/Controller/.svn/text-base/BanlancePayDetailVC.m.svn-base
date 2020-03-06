//
//  BanlancePayDetailVC.m
//  b2c
//
//  Created by wangyuanfei on 6/16/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
/**余额支付详情页面*/

#import "BanlancePayDetailVC.h"
#import "PayResultVC.h"
#import "COrderGooditemModel.h"
#import "MyInputAccessoryView.h"
#import "AuthForPaypsdVC.h"
#import "ChangePasswordVC.h"
@interface BanlancePayDetailVC ()<MyInputAccessoryViewDelegate>
{
    /** 接收用户密码的隐形输入框 */
@private
    UITextField * _acceptPassword;
}


@property(nonatomic,weak)UIView  * topContainer ;

 ;
@property(nonatomic,weak)UILabel * priceLabel ;
@property(nonatomic,weak)UILabel * banlanceLabel ;

@property(nonatomic,weak )UIButton * bottomButton ;

@property(nonatomic,copy)NSString * orderID ;
/** 所买商品的数组 */
@property(nonatomic,strong)NSArray <COrderGooditemModel*>* goodses;
/** 所买商品的价格 */
@property(nonatomic,copy)NSString * price ;
/** 余额 */
@property(nonatomic,copy)NSString * balance ;

/** 辅助键盘 */
@property(nonatomic,strong)MyInputAccessoryView * myAccessoryView ;

@property(nonatomic,weak)UIButton * corverView ;

@end

@implementation BanlancePayDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.naviTitle = @"余额支付";
    
    
    
    NSDictionary * parametes = self.keyParamete[@"paramete"];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,parametes);
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,parametes);
    self.orderID = parametes[@"orderID"];
    self.price = parametes[@"price"] ;
    self.goodses = parametes[@"goodses"];
    
    // Do any additional setup after loading the view.
    
//    self.orderID = self.keyParamete[@"paramete"];
//    self.orderID = @"923764019837241218934";
    UIView * topContainer = [[UIView alloc]initWithFrame:CGRectMake(0, self.startY, self.view.bounds.size.width, 222)];
    topContainer.backgroundColor = THEMECOLOR;
    self.topContainer = topContainer;
    [self.view addSubview:topContainer];
    
    UILabel * tipsLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, self.view.bounds.size.width, 22)];
    tipsLabel.text = @"您目前的账户余额为:";
    tipsLabel.textColor =[UIColor whiteColor];
    [self.topContainer addSubview:tipsLabel];
    
    
    UILabel * banlanceLabel =[[UILabel alloc]init];
    banlanceLabel.textAlignment = NSTextAlignmentCenter;
    banlanceLabel.textColor = [UIColor whiteColor];
    banlanceLabel.bounds = CGRectMake(0, 0, self.topContainer.bounds.size.width, self.topContainer.bounds.size.height);
    banlanceLabel.center = CGPointMake(self.topContainer.bounds.size.width/2, self.topContainer.bounds.size.height/2);
    self.banlanceLabel  =  banlanceLabel;
    [self.topContainer addSubview:banlanceLabel];
    
//    banlanceLabel.text = [NSString stringWithFormat:@"%@元",self.price];
    [self gotBanlanceWithInterfaceSuccess:^(NSString *banlance) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,banlance);
    } failure:^{
        
    }];
    
    
    UILabel * priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.topContainer.frame)+10, self.view.bounds.size.width - 20, 22)];
    priceLabel.textColor = MainTextColor;
    NSString * priceStr= [self.price convertToYuan];
    NSString * priceTotalDescrip = [NSString stringWithFormat:@"此订单将花费为%@元",priceStr ];
    
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc]initWithString:priceTotalDescrip];
    NSRange priceRange = [priceTotalDescrip rangeOfString:priceStr];
    [attriStr addAttribute:NSForegroundColorAttributeName value:THEMECOLOR range:priceRange];
    priceLabel.attributedText = attriStr;
    self.priceLabel = priceLabel;
    [self.view addSubview:priceLabel];
    
    
    CGFloat bottomButtonW = 120 ;
    UIButton * bottomButton = [[UIButton alloc]initWithFrame:CGRectMake((self.view.bounds.size.width - bottomButtonW)/2, self.view.bounds.size.height -100, bottomButtonW, 44)];
    self.bottomButton= bottomButton;
    bottomButton.backgroundColor = THEMECOLOR;
    [self.view addSubview:bottomButton];
    [bottomButton setTitle:@"使用余额支付" forState:UIControlStateNormal];
    [bottomButton addTarget:self action:@selector(performpay:) forControlEvents:UIControlEventTouchUpInside];
    bottomButton.layer.cornerRadius = 6 ;
    bottomButton.layer.masksToBounds = YES;
    LOG(@"_%@_%d_%@",[self class] , __LINE__,parametes);

    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
    
    MyInputAccessoryView * myAccessoryView   = [[MyInputAccessoryView alloc]initWithFrame:CGRectMake(0, 0, 300, 128*SCALE)];
    self.myAccessoryView = myAccessoryView;
    myAccessoryView.InputAccessoryViewDelegate = self;
    UITextField * acceptPassword = [[UITextField alloc]init];
    acceptPassword.inputAccessoryView = myAccessoryView;
    acceptPassword.keyboardType=UIKeyboardTypeNumberPad;
    _acceptPassword=acceptPassword;
    [self.view addSubview:acceptPassword];
    
    
    
}

-(void)gotBanlanceWithInterfaceSuccess:(void(^)(NSString * banlance))success failure:(void(^)())failure
{
    [[UserInfo shareUserInfo] gotBanlanceWithUserInfoSuccess:^(ResponseObject *responseObject) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
//    banlanceLabel.text = [NSString stringWithFormat:@"%@元",self.price];
        if (responseObject.status>0) {
            self.balance = responseObject.data[@"balance"];
            NSString * showBalancePrice = [NSString stringWithFormat:@"%.02f",[self.balance  integerValue]/100.0];
            NSString * tempStr = @"  元";
            NSString * totalStr = [NSString stringWithFormat:@"%@%@",showBalancePrice,tempStr];
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:totalStr];
            NSRange  priceRange = [totalStr rangeOfString:showBalancePrice];
//            NSRange tempStrRange = [totalStr rangeOfString:tempStr];
//            [str addAttribute:NSKernAttributeName   value:@(-(5*SCALE)) range:NSMakeRange(0, 1)];
            [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"ArialRoundedMTBold" size:30*SCALE] range:priceRange];
//            [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:30*SCALE] range:priceRange];
            
            
            self.banlanceLabel.attributedText=str;
            
            if ([self.price floatValue ]> [self.balance floatValue]) {
                self.bottomButton.enabled = NO ;
                self.bottomButton.backgroundColor = [UIColor lightGrayColor];
            }else{
                self.bottomButton.enabled = YES;
                 self.bottomButton.backgroundColor = THEMECOLOR;
            }
            success(@"价格");
            
        }else{
            AlertInVC(responseObject.msg)
        }
    } failure:^(NSError *error) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
        AlertInVC(@"网络请求失败,请重试")
        failure();
        
        
    }];
}
/** 辅助键盘代理 */

-(void)forgetPasswordActionWithAccessoryView:(MyInputAccessoryView *)accessoryView{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"代理执行成功");
//    BaseModel * model = [[BaseModel alloc]init];
//    model.actionKey = @"AuthForPaypsdVC";
//    [[SkipManager shareSkipManager] skipByVC:self withActionModel:model];
    [self.corverView removeFromSuperview];
    self.corverView = nil ;     
    
    [self.view endEditing:YES];
    _acceptPassword.text = nil ;
    AuthForPaypsdVC * authForPayPsdVC = [[AuthForPaypsdVC alloc]init];
    [self.navigationController pushViewController:authForPayPsdVC animated:YES];
}

#pragma mark 传真正的订单id

-(void)performpay:(UIButton*)sender
{
    ////////////////////////
    if (!self.orderID) {
        AlertInVC(@"订单id为空")
        return;
    }
    #pragma mark 要先判断用户有没有设置支付密码 ,
    [self checkPayPasswordSuccess:^(BOOL payPasswordLawful) {
        if (payPasswordLawful) {//正常结算(弹出输入支付密码)
            UIButton * corverView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, screenW, screenH)];
            self.corverView = corverView;
            
            [self.corverView addTarget:self action:@selector(removeCorver) forControlEvents:UIControlEventTouchUpInside];
            corverView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.33];
            [self.view.window addSubview:corverView];
            [_acceptPassword becomeFirstResponder];
            
//            [self enterPayPasswordAndPayWithBanlance];

#pragma mark 如果没设置,调到设置支付密码
        }else{//
            UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请设置支付密码" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                BaseModel * model = [[BaseModel alloc]init];
//                model.actionKey = @"";
                [self chenkMobileInfo:^(BOOL has) {
                    if (has) {
                        //跳转到验证手机的控制器
                        AuthForPaypsdVC * authForPayPsdVC = [[AuthForPaypsdVC alloc]init];
                        [self.navigationController pushViewController:authForPayPsdVC animated:YES];
                    }else{
                        MBProgressHUD * hub = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
                        hub.mode=MBProgressHUDModeText;
                        hub.detailsLabelText=[NSString stringWithFormat:@"%@",(@"您还没用绑定手机 \n即将跳转到绑定手机界面")];
                        [hub hide:YES afterDelay:2];
                        hub.completionBlock = ^(){
                            
                            BaseModel *model = [[BaseModel alloc]init];
                            model.actionKey = ActionChangePhoneNum;
                            model.title = @"修改手机号";
                            [[SkipManager shareSkipManager] skipByVC:self withActionModel:model];
                        
                        };
//                        AlertInVC(@"你还没用绑定手机 \n请先前往账户安全 绑定手机号码");
                    }
                }];

            }];
            UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alertVC addAction:confirmAction];
            [alertVC addAction:cancleAction];
            [self presentViewController:alertVC animated:YES completion:^{
                
            }];
            
            
        }
        
    } failure:^{
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"");
        AlertInVC(@"网络错误")
    }];
    
    
    
    
    
    
    
    
}



//        ChangePasswordVC * setPayPassword = [[ChangePasswordVC alloc]initWithType:SetPayPassword];
//        [self.navigationController pushViewController:setPayPassword animated:YES];




-(void)chenkMobileInfo:(void(^)(BOOL has))callBack
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
                                    callBack(YES);
                                }else{
                                    //                                    AlertInVC(@"请绑定手机号码")
//                                    MBProgressHUD * hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//                                    hub.mode=MBProgressHUDModeText;
//                                    hub.detailsLabelText=[NSString stringWithFormat:@"%@",(@"请绑定手机号码")];
//                                    [hub hide:YES afterDelay:2];
                                    //                                    hub.completionBlock = ^(){
                                    //                                        [self.navigationController popViewControllerAnimated:YES];
                                    //                                    };
                                    callBack(NO);
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
-(void)removeCorver
{
    [self.view endEditing:YES];
    [self.corverView removeFromSuperview];
    self.corverView=nil;
    _acceptPassword.text = nil ;
    [self.myAccessoryView  trendsChangeInputViewWithLength:0];
}
-(void)enterPayPasswordAndPayWithBanlance
{
    [[UserInfo shareUserInfo] payByBalanceWithOrderID:self.orderID success:^(ResponseObject *responseObject) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
        if (responseObject.status>0) {
            
            [self theViewWithPayResult:PaySuccess];
        }else{
            NSString  * result =responseObject.msg;
            AlertInVC(result);
        }
    } failure:^(NSError *error) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
        [self theViewWithPayResult:PayFailure];
    }];
}

-(void)checkPayPasswordSuccess:(void(^)(BOOL payPasswordLawful))success failure:(void(^)())failure//判断支付密码的有无
{
        [[UserInfo shareUserInfo] gotAccountSafeSuccess:^(ResponseObject *responseObject) {
            LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
            if (responseObject.status>0) {
                //设置支付密码显示状态
                if ([responseObject.data isKindOfClass:[NSDictionary class]]) {
                    if ([responseObject.data[@"items"] isKindOfClass:[NSArray class]]) {
                        for (id sub in responseObject.data[@"items"]) {
                            if ([sub[@"title"] isKindOfClass:[NSString class]] && [sub[@"title"] isEqualToString:@"支付密码"]) {
                                if ([sub[@"sub_title"] isKindOfClass:[NSString class]]&&[sub[@"sub_title"] isEqualToString:@"已开启"]) {//什么奇葩服务器数据  -_-! 还中美混合
                                    
                                    success(YES);
                                }else{
                                    success(NO);
                                }
                                
                            }

                            }
                        }
                    }
                    
                }
                
            
        } failure:^(NSError *error) {
            LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
            AlertInVC(@"网络错误,请重试")
            failure();
        }];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}
-(void)theViewWithPayResult:(PayResult)payResult
{
    BaseModel * payResultModel = [[BaseModel alloc]init];
    payResultModel.actionKey = @"PayResultVC";
    payResultModel.keyParamete = @{@"paramete":@(payResult)};
    [[SkipManager shareSkipManager] skipByVC:self withActionModel:payResultModel];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)textChange:(NSNotification*)noti
{
    
//    NSInteger  count = _acceptPassword.text.length;
    
    LOG(@"_%@_%d_%@",[self class] , __LINE__,_acceptPassword.text)

    if (_acceptPassword.text.length>6) {
        _acceptPassword.text = [_acceptPassword.text substringToIndex:6];
        LOG(@"_%@_%d_%@",[self class] , __LINE__,_acceptPassword.text)
        return;
    }
    [self.myAccessoryView trendsChangeInputViewWithLength:_acceptPassword.text.length];
    if (_acceptPassword.text.length>6||_acceptPassword.text.length==6) {
        [self verifyPayPasswordByInternetSuccess:^(BOOL result) {
            if (result) {
                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"支付密码验证成功")
//                NSString * realPassword = _acceptPassword.text;
                //把密码传给服务器
//                self.canDestroy=YES;
//                MBProgressHUD * hub = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
//                hub.mode=MBProgressHUDModeText;
//                
//                hub.labelText=@"支付密码验证成功";
//                hub.detailsLabelText=@"即将前往首页";
//                [hub hide:YES afterDelay:3];
                
//                hub.completionBlock=^{
                    [self enterPayPasswordAndPayWithBanlance];
//                };
                [self.corverView removeFromSuperview];
                self.corverView=nil;
                [self.view endEditing:YES];
            }
        } failure:^{
            
        }];

    }
}

-(void)verifyPayPasswordByInternetSuccess:(void(^)(BOOL result))success failure:(void(^)())failure
{
    [[UserInfo shareUserInfo] checkOldPayPasswordWithOldPayPassword:_acceptPassword.text success:^(ResponseObject *responseObject) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
        if (responseObject.status>0) {
            success(YES);
        }else{
            MBProgressHUD * hub = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
            hub.mode=MBProgressHUDModeText;
            hub.yOffset = -88 ;
            hub.labelText=[NSString stringWithFormat:@"%@",responseObject.msg];
            [hub hide:YES afterDelay:1];
        }
    } failure:^(NSError *error) {
       LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
    }];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (self.canDestroy) {
        [self removeFromParentViewController];
    }
}
@end
