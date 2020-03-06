//
//  ChangePhoneNumVC.m
//  b2c
//
//  Created by wangyuanfei on 4/7/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "ChangePhoneNumVC.h"

#import "CountryNumModel.h"
#import "CustomInputView.h"

@interface ChangePhoneNumVC ()<UIPickerViewDelegate,UIPickerViewDataSource,UINavigationControllerDelegate,CustomInputViewDelegate>

/** 显示当前国家的字控件的容器控件 */
@property(nonatomic,weak)ActionBaseView * countryContainer ;
/** 国家标题提示 */
@property(nonatomic,weak)UILabel * leftCountryTitleLabel ;
/** 当前国家 */
@property(nonatomic,weak)UILabel * rightContryTitleLabel ;
/** 选择国家按钮 */
@property(nonatomic,weak)UIButton * chooseCountryButton ;
/** 手机号容器视图 */
@property(nonatomic,weak)UIView * mobileContainer ;
/** 手机号输入视图 */
@property(nonatomic,weak)CustomInputView * mobileInputView ;
/** 获取验证码点击按钮 */
@property(nonatomic,weak)UIButton * gotAuthButton ;
/** 验证码输入框 */
@property(nonatomic,weak)CustomInputView * authcodeInput ;
/** 绑定按钮 */
@property(nonatomic,weak)UIButton * bindingButton ;
/** 底部子视图容器 */
@property(nonatomic,weak)UIView * pickerContainer ;
/** 选择完成点击按钮 */
@property(nonatomic,weak)UIButton * doneButton ;
/** 弹出视图pickerView */
@property(nonatomic,weak)UIPickerView * pickerView ;
@property(nonatomic,weak)UIView * corver ;

@property(nonatomic,strong)NSMutableArray * countries ;
@property(nonatomic,strong)CountryNumModel * currentCountry ;


/** 定时器 */
@property(nonatomic,strong)NSTimer * timer ;
/** 重新发送倒计时时间 */
@property(nonatomic,assign)NSInteger  time ;
@end

@implementation ChangePhoneNumVC

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     regular = ^(86){0,1}1\d{10}$;
     number = 86;
     name = 中国大陆;
     */
    self.currentCountry= [[CountryNumModel alloc]initWithDict:@{@"regular":@"^(86){0,1}1\\d{10}$",@"number":@"86",@"name":@"中国大陆"}];
    self.view.backgroundColor = BackgroundGray;
    [self setupsubviews];
    // Do any additional setup after loading the view.
    /** 13671115793 */
}
-(void)setupsubviews
{
    CGFloat rowH = 44 ;
    CGFloat margin = 10 ;
    /** 显示当前国家的字控件的容器控件 */
    ActionBaseView * countryContainer = [[ActionBaseView alloc]initWithFrame:CGRectMake(0, self.startY+40, self.view.bounds.size.width, rowH)];
    countryContainer.backgroundColor = [UIColor whiteColor];
    self.countryContainer = countryContainer;
    [self.view addSubview:countryContainer];
    [countryContainer addTarget:self action:@selector(chooseCountry) forControlEvents:UIControlEventTouchUpInside];
    /** 国家标题提示 */
    NSString * leftCountryTitleStr = @"国家/地区";
    UILabel * leftCountryTitleLabel = [[UILabel alloc]init] ;
    CGSize leftCountryTitleStrSize = [leftCountryTitleStr sizeWithFont:leftCountryTitleLabel.font MaxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    leftCountryTitleLabel.frame = CGRectMake(margin, 0, leftCountryTitleStrSize.width, rowH);
    leftCountryTitleLabel.text = leftCountryTitleStr;
    leftCountryTitleLabel.textColor = MainTextColor;
    self.leftCountryTitleLabel = leftCountryTitleLabel;
    [self.countryContainer addSubview:leftCountryTitleLabel];
    
    
    /** 选择国家按钮 */
    CGFloat chooseW = 28;
    CGFloat chooseH = 18 ;
    UIButton * chooseCountryButton = [[UIButton alloc]initWithFrame:CGRectMake(self.countryContainer.bounds.size.width - margin - chooseW, (self.countryContainer.bounds.size.height-chooseH)/2, chooseW, chooseH)];
    [chooseCountryButton setImage:[UIImage imageNamed:@"icon_dropdown"] forState:UIControlStateNormal];
    self.chooseCountryButton = chooseCountryButton;
    [self.countryContainer addSubview:chooseCountryButton];
    
    
    /** 当前国家 */
    CGFloat rightCountryLabelW = CGRectGetMinX(chooseCountryButton.frame) - margin*2 - CGRectGetMaxX(leftCountryTitleLabel.frame);
    CGFloat rightCountryLabelX = CGRectGetMaxX(leftCountryTitleLabel.frame)+margin;
    UILabel * rightContryTitleLabel  = [[UILabel alloc]initWithFrame:CGRectMake(rightCountryLabelX, 0, rightCountryLabelW, self.countryContainer.bounds.size.height)] ;
    rightContryTitleLabel.font = [UIFont systemFontOfSize:14];
    rightContryTitleLabel.textAlignment = NSTextAlignmentRight;
    rightContryTitleLabel.text = @"中国大陆(86)";
    self.rightContryTitleLabel = rightContryTitleLabel;
    [self.countryContainer addSubview:rightContryTitleLabel];
    
    
    
    UIView * mobileContainer = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(countryContainer.frame)+margin, self.view.bounds.size.width, rowH)];
    mobileContainer.backgroundColor = [UIColor whiteColor];
    self.mobileContainer = mobileContainer;
    [self.view addSubview:mobileContainer];
    
    /** 获取验证码点击按钮 */
    NSString * gotCodeStr = @"重新获取验证码";
    CGSize gotCodeStrSize = [gotCodeStr sizeWithFont:[UIFont systemFontOfSize:17] MaxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    UIButton * gotAuthButton  = [[UIButton alloc]initWithFrame:CGRectMake(self.mobileContainer.bounds.size.width - gotCodeStrSize.width, 0, 111, self.mobileContainer.bounds.size.height)];
    self.gotAuthButton = gotAuthButton;
    gotAuthButton.titleLabel.font = [UIFont systemFontOfSize:14*SCALE];
    [gotAuthButton addTarget:self action:@selector(resentAuthcode:) forControlEvents:UIControlEventTouchUpInside];
    [gotAuthButton setTitle:@"获取验证码" forState:UIControlStateNormal];
//    [gotAuthButton setTitleColor:[UIColor shi] forState:UIControlStateNormal];
    gotAuthButton.backgroundColor = [UIColor colorWithHexString:@"e95513"];
    [self.mobileContainer addSubview:gotAuthButton];
    
    
    /** 手机号输入视图 */
    CustomInputView * mobileInputView = [[CustomInputView alloc]initWithFrame:CGRectMake(0, 0,CGRectGetMinX(gotAuthButton.frame), self.mobileContainer.bounds.size.height)];
//    mobileInputView.li
    self.mobileInputView = mobileInputView;
    mobileInputView.customKeyboardType = UIKeyboardTypeNumberPad;
    mobileInputView.leftWidth = 66 ;
    mobileInputView.tipsTitle = @"手机号";
    mobileInputView.inputPlaceholder = @"新手机号";
    [self.mobileContainer addSubview:mobileInputView];
    
    CustomInputView * authcodeInput =[[CustomInputView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(mobileContainer.frame)+margin, self.view.bounds.size.width, rowH)];
    authcodeInput.backgroundColor = [UIColor whiteColor];
    self.authcodeInput = authcodeInput;
    authcodeInput.customKeyboardType  =  UIKeyboardTypeNumbersAndPunctuation;
    authcodeInput.customReturenType =  UIReturnKeyDone;
    authcodeInput.CustomInputDelegate = self;
    [self.view addSubview:authcodeInput];
    authcodeInput.leftWidth = 0.1 ;
    authcodeInput.inputPlaceholder = @"请输入手机短信中的验证码";
    
    /** 绑定按钮 */
    UIButton * bindingButton  = [[UIButton alloc]initWithFrame:CGRectMake(margin, CGRectGetMaxY(authcodeInput.frame)+margin*5, self.view.bounds.size.width-margin*2, rowH-10)];
    bindingButton.backgroundColor = [UIColor redColor];
    [bindingButton setTitle:@"绑定" forState:UIControlStateNormal];
    [bindingButton addTarget:self action:@selector(bindingAction:) forControlEvents:UIControlEventTouchUpInside];
    self.bindingButton = bindingButton;
    [self.view addSubview:bindingButton];
    
    

    
}

-(void)customInputTextFieldShouldReturn:(CustomInputView*)customInputView{
    [self bindingAction:self.bindingButton];
}
-(void)bindingAction:(UIButton*)sender
{
       BOOL mobileLawful =  [self mobileLawful:self.mobileInputView.currentText andRegularStr:self.currentCountry.regular];
    if (mobileLawful) {
         //1 判断验证码的正确性
        if (![self authcodeLawful:self.authcodeInput.currentText]) {
            
            AlertInVC(@"请输入手机短信中六位数字的验证码")
            return;
        }
        
        [[UserInfo shareUserInfo] checkUserNameOrMobileWithUserName:nil mobile:self.mobileInputView.currentText email:nil mobilecode:self.authcodeInput.currentText success:^(ResponseObject *responseObject) {
            if (responseObject.status>0) {
              LOG(@"_%@_%d_%d",[self class] , __LINE__,responseObject.status);
                LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
                
                
                
                
                
                
                
                
                
                
                //2 执行绑定
                [[UserInfo shareUserInfo] changeBoundMobileWithBoundMobile:self.mobileInputView.currentText success:^(ResponseObject *responseObject) {
                    if (responseObject.status>0) {
                        MBProgressHUD * hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                        hub.mode=MBProgressHUDModeText;
                        [hub hide:YES afterDelay:1.5];
                        hub.labelText=responseObject.msg;
                        hub.completionBlock = ^{
                            [self deleteTimer];
                            [self.navigationController popViewControllerAnimated:YES];
                        };
                        
                    }else{
                        AlertInVC(responseObject.msg)
                    }
                } failure:^(NSError *error) {
                    AlertInVC(@"网络错误");
                }];
                
                
                
                
                
            }else{
                AlertInVC(responseObject.msg);
            }
        } failure:^(NSError *error) {
           AlertInVC(@"网络错误")
        }];
        
       
    }else{
        AlertInVC(@"请输入正确格式的手机号")
    }
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"执行绑定");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}
-(void)chooseCountry
{
    self.chooseCountryButton.selected = !self.chooseCountryButton.selected;
    if (self.chooseCountryButton.selected) {
        [self startChooseCountry];
    }else{
        [self endChooseCountry];
    }
}
-(void)startChooseCountry
{
    [[UserInfo shareUserInfo] gotCountryNumberWithSuccess:^(ResponseObject *responseObject) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
        LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.msg);
        if (responseObject.status>0) {
            [self.countries removeAllObjects];
            if ([responseObject.data isKindOfClass:[NSArray class]]) {
                for (id sub in responseObject.data) {
                    if ([sub isKindOfClass:[NSDictionary class]]) {
                        CountryNumModel * country = [[CountryNumModel alloc]initWithDict:sub];
                        [self.countries addObject:country];
                    }
                }
            }
            [self showPickerView];
        }
    } failure:^(NSError *error) {
       LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
    }];
    
}

-(void)showPickerView
{
    UIView * corver = [[UIView alloc]initWithFrame:self.view.bounds];
    self.corver = corver;
    [self.view addSubview:corver];
    corver.backgroundColor=[UIColor colorWithWhite:0.5 alpha:0.5];
    CGFloat containerW = screenW;
    CGFloat containerH = screenW/2;
    UIView * pickerContainer = [[UIView alloc]initWithFrame:CGRectMake(0, screenH-containerH, containerW, containerH)];
    pickerContainer.backgroundColor=[UIColor whiteColor];
    [corver addSubview:pickerContainer];
    
    CGFloat sureW = 44;
    CGFloat sureH = 22;
    CGFloat topMargin = 10 ;
    CGFloat rightMargin = 2*topMargin;
    UIButton * doneButton = [[UIButton alloc]initWithFrame:CGRectMake( pickerContainer.bounds.size.width-rightMargin-sureW,topMargin, sureW, sureH)];
    [doneButton setTitle:@"完成" forState:UIControlStateNormal];
    //    [sureButton.titleLabel setTextColor:[UIColor darkGrayColor]];
    [doneButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    doneButton.layer.borderWidth=1;
    [doneButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    doneButton.layer.borderColor=[UIColor darkGrayColor].CGColor;
    doneButton.layer.cornerRadius=3;
    doneButton.layer.masksToBounds=YES;
    [pickerContainer addSubview:doneButton];
    [doneButton addTarget:self action:@selector(sureClick:) forControlEvents:UIControlEventTouchUpInside];
    self.doneButton = doneButton;
    
    UIPickerView * pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, topMargin+sureH, pickerContainer.bounds.size.width, pickerContainer.bounds.size.height-topMargin-sureH)];
    [pickerContainer addSubview:pickerView];
    self.pickerView = pickerView;

    pickerView.delegate=self;
    pickerView.dataSource=self;

}
-(void)sureClick:(UIButton*)sender
{
    [self endChooseCountry];
}
-(void)endChooseCountry
{
    //动画消失以后销毁
    [self.doneButton removeFromSuperview];
    self.doneButton = nil ;
    [self.pickerView removeFromSuperview];
    self.pickerView = nil ;
    [self.corver removeFromSuperview];
    self.corver = nil;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
//    NSString * choose =  self.pickViewArr[row];
    CountryNumModel * model = self.countries[row];
    self.currentCountry = model;
    self.rightContryTitleLabel.text = [NSString stringWithFormat:@"%@(%@)",model.name,model.number];
    
}
#pragma pickerViewDataSource

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.countries.count;
    
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    CountryNumModel * model = self.countries[row];
    return [NSString stringWithFormat:@"%@(%@)",model.name,model.number];
    
}

-(NSMutableArray * )countries{
    if(_countries==nil){
        _countries = [[NSMutableArray alloc]init];
    }
    return _countries;
}

/** 判断当前国家手机号码的合法性 */

- (BOOL)mobileLawful:(NSString *) mobileString andRegularStr:(NSString*)regularStr
{
//    NSString* number=@"^\\d{6}$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regularStr];
    return [numberPre evaluateWithObject:mobileString];
}

/////////验证码按钮相关////////////
-(void)deleteTimer
{
    
    self.gotAuthButton.enabled=YES;
    self.gotAuthButton.backgroundColor = [UIColor colorWithHexString:@"e95513"];
    [self.gotAuthButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.timer invalidate];
    self.timer=nil;
}
-(void)creatTimer
{
    self.gotAuthButton.enabled=NO;
    self.gotAuthButton.backgroundColor = [UIColor whiteColor] ;
    [self.gotAuthButton setTitleColor:SubTextColor forState:UIControlStateNormal];
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
    BOOL mobileLawful = [self mobileLawful:self.mobileInputView.currentText andRegularStr:self.currentCountry.regular];
    if (mobileLawful) {
        [UserInfo shareUserInfo].mobile = self.mobileInputView.currentText;
        
        [[UserInfo shareUserInfo] checkUserNameOrMobileWithUserName:nil mobile:self.mobileInputView.currentText email:nil mobilecode:nil success:^(ResponseObject *responseObject) {//验证手机有效性
//            AlertInVC(<#alertMessage#>)
            if (responseObject.status>0) {
                [self creatTimer];
                [self.gotAuthButton setTitle:[NSString stringWithFormat:@"60s后重新获取"] forState:UIControlStateNormal];
                [[UserInfo shareUserInfo] gotMobileCodeWithType:Ohter Success:^(ResponseStatus response) {//执行发送
                    
//                    MBProgressHUD * hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//                    hub.mode=MBProgressHUDModeText;
//                    [hub hide:YES afterDelay:1.5];
                    if (response==SHORTMESSAGE_SUCESS) {
//                        hub.labelText=@"验证码获取成功";
//                        hub.completionBlock = ^{
//                            [self creatTimer];
//                        };
                    }else if (response== SHORTMESSAGE_FAIL){
//                        hub.labelText=@"验证码获取失败";
//                        self.gotAuthButton.enabled = YES;
//                        [self.gotAuthButton setTitle:@"重新获取" forState:UIControlStateNormal];
//                        hub.detailsLabelText=@"请重试";
                        
                    }
                } failure:^(NSError *error) {
                    
                }];
            }else{
                    AlertInVC(responseObject.msg)
            }
        } failure:^(NSError *error) {
           LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
            AlertInVC(@"网络错误")
        }];
        
        
        
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"重新发送验证码操作")
    }else{
        AlertInVC(@"请输入正确的手机号")
    }
    
   
    
}
/** 判断验证码的合法性 */

- (BOOL)authcodeLawful:(NSString *) textString
{
    NSString* number=@"^\\d{6}$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:textString];
}

-(void)dealloc{
    [self deleteTimer];
}
@end
