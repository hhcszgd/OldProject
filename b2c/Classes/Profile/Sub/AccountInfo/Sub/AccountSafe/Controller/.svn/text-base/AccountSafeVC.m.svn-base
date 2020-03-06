//
//  AccountSafeVC.m
//  b2c
//
//  Created by wangyuanfei on 4/7/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "AccountSafeVC.h"
#import "PTableCellModel.h"

#import "CustomDetailCell.h"
#import "ChangePasswordVC.h"
#import "AuthForPaypsdVC.h"
@interface AccountSafeVC ()
@property(nonatomic,weak)UIScrollView *  scrollContainer;
/** reset */
@property(nonatomic,weak)   CustomDetailCell * changeLoginPassword ;
@property(nonatomic,weak)   CustomDetailCell * changeMobile;
@property(nonatomic,weak)   CustomDetailCell * payPassword;
@property(nonatomic,weak)   UILabel * tipsLabel ;

@property(nonatomic,assign)BOOL  hasSetPayPassword ;
@end

@implementation AccountSafeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addScrollContainer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}
-(void)addScrollContainer
{
    
    UIScrollView * scrollContainer = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.startY, self.view.bounds.size.width, self.view.bounds.size.height-self.startY)];
    scrollContainer.delegate=self;
    scrollContainer.backgroundColor=BackgroundGray;
    self.scrollContainer=scrollContainer;
    //    self.scrollContainer.backgroundColor=randomColor;
    [self.view addSubview:self.scrollContainer];
    self.scrollContainer.alwaysBounceVertical = YES;
    
    [self addSubviewOfScrollContainer];
//    [self setPayPasswordTitle];
}

-(void)addSubviewOfScrollContainer
{

    CGFloat margin = 10 ;
    CGFloat rowHeight = 44 ;
    CustomDetailCell * changeLoginPassword = [[CustomDetailCell alloc]initWithFrame:CGRectMake(0, margin, self.view.bounds.size.width, rowHeight)];
    [changeLoginPassword addTarget:self action:@selector(changeLoginPasswordClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollContainer addSubview:changeLoginPassword];
    self.changeLoginPassword = changeLoginPassword;
    [self setAttributeWithCustomDetailCellView:changeLoginPassword WithLeftTitle:@"修改登陆密码" rightTitle:nil];
    
    
    CustomDetailCell * changeMobile = [[CustomDetailCell alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.changeLoginPassword.frame), self.view.bounds.size.width, rowHeight)];
    [self.scrollContainer addSubview:changeMobile];
    [self setAttributeWithCustomDetailCellView:changeMobile WithLeftTitle:@"修改绑定手机" rightTitle:@"加载中..."];
    [changeMobile addTarget:self action:@selector(changeMobileClick:) forControlEvents:UIControlEventTouchUpInside];
    self.changeMobile = changeMobile;
    
    
    CustomDetailCell * payPassword = [[CustomDetailCell alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.changeMobile.frame)+margin, self.view.bounds.size.width, rowHeight)];
    [self.scrollContainer addSubview:payPassword];
    [self setAttributeWithCustomDetailCellView:payPassword WithLeftTitle:@"支付密码" rightTitle:@"未开启"];
    [payPassword addTarget:self action:@selector(payPasswordClick:) forControlEvents:UIControlEventTouchUpInside];
    self.payPassword = payPassword;
    
    UILabel * tipsLabel = [[UILabel alloc]initWithFrame:CGRectMake(margin, CGRectGetMaxY(self.payPassword.frame), self.scrollContainer.bounds.size.width - margin*2, 40)];
    tipsLabel.text = @"使用虚拟资产需验证支付密码,保障资产安全";
    tipsLabel.textColor = SubTextColor;
    tipsLabel.font = [UIFont systemFontOfSize:12];
    self.tipsLabel = tipsLabel ;
    [self.scrollContainer addSubview:tipsLabel];
    
}
-(void)setAttributeWithCustomDetailCellView:(CustomDetailCell*)customDetailCell WithLeftTitle:(NSString * )leftTitle rightTitle:(NSString*)rightTitle{
    customDetailCell.backgroundColor = [UIColor whiteColor];
    customDetailCell.leftTitleFont = [UIFont systemFontOfSize:14];
    customDetailCell.leftTitleColor = MainTextColor;
    customDetailCell.showBottomLine = YES;
    customDetailCell.leftTitle = leftTitle;
    customDetailCell.rightDetailTitle=rightTitle;
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
-(void)changeLoginPasswordClick:(id)sender
{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"修改密码")
    PTableCellModel *model = [[PTableCellModel alloc]init];
    model.actionKey = ActionChangePassword;
    model.title = @"修改密码";
    [[SkipManager shareSkipManager] skipByVC:self withActionModel:model];
}
-(void)changeMobileClick:(id)sender
{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"修改电话")
    PTableCellModel *model = [[PTableCellModel alloc]init];
    model.actionKey = ActionChangePhoneNum;
    model.title = @"修改手机号";
    [[SkipManager shareSkipManager] skipByVC:self withActionModel:model];
}
-(void)payPasswordClick:(id)sender
{
    
    if (self.hasSetPayPassword/** 有支付密码 */) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"更改支付密码或者忘记支付密码");
        BaseModel * model = [[BaseModel alloc]init];
        model.actionKey = @"PayPsdOperationVC";
        [[SkipManager shareSkipManager] skipByVC:self withActionModel:model];
    }else{/** 无支付密码 */
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"设置支付密码");
        [self chenkMobileInfo:^(BOOL has) {
            if (has) {
                //跳转到验证手机的控制器
                AuthForPaypsdVC * authForPayPsdVC = [[AuthForPaypsdVC alloc]init];
                [self.navigationController pushViewController:authForPayPsdVC animated:YES];
 
            }
        }];
        

        
//        ChangePasswordVC * setPayPassword = [[ChangePasswordVC alloc]initWithType:SetPayPassword];
//        [self.navigationController pushViewController:setPayPassword animated:YES]; 
    }
}


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
                                    MBProgressHUD * hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                                    hub.mode=MBProgressHUDModeText;
                                    hub.detailsLabelText=[NSString stringWithFormat:@"%@",(@"请绑定手机号码")];
                                    [hub hide:YES afterDelay:2];
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
-(void)setPayPasswordTitle
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
                                if ([sub[@"sub_title"] isKindOfClass:[NSString  class]]&&mobile.length==11) {
                                   mobile = [mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
                                    self.changeMobile.rightDetailTitle = mobile;
                                }else{
                                    self.changeMobile.rightDetailTitle = @"暂未绑定手机号码";
                                }
                                
                            }
                            if ([sub[@"sub_title"] isKindOfClass:[NSString class]]&&[sub[@"sub_title"] isEqualToString:@"已开启"]) {//什么奇葩服务器数据  -_-! 还中美混合
                                self.payPassword.rightDetailTitle = @"已开启";
                                self.hasSetPayPassword = YES;
                                
                            }else{
                                self.payPassword.rightDetailTitle = @"未开启";
                                self.hasSetPayPassword=NO ;
                            }
                        }
                    }
                }
                
            }
            
        }
    } failure:^(NSError *error) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setPayPasswordTitle];
}
@end
