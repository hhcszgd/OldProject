//
//  AccountInfoVC.m
//  b2c
//
//  Created by wangyuanfei on 3/30/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "AccountInfoVC.h"
#import "PTableCellModel.h"
#import "XMPPvCardTemp.h"
#import "GDXmppStreamManager.h"

/**
 项目名-Swift.h
 */




//#import  "Test.swift"
//#import "b2c-Bridging-Header.h"

@interface AccountInfoVC ()<UIPickerViewDelegate,UIPickerViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIScrollViewDelegate,UITextFieldDelegate>


//@property(nonatomic,weak)UITableView * tableView ;
@property(nonatomic,strong)NSArray * arr ;
@property(nonatomic,weak)UIView * line  ;
@property(nonatomic,weak)  UIView * corver ;
@property(nonatomic,strong)NSArray * pickViewArr ;
@property(nonatomic,copy)  NSString * choose ;
//////////////////////////////////////////

@property(nonatomic,weak)UIScrollView *  scrollContainer;
@property(nonatomic,weak)ActionBaseView * iconImageView ;
@property(nonatomic,assign)CGFloat  maxY ;
@property(nonatomic,weak)UITextField * nickName ;
@property(nonatomic,weak)UILabel * accountName ;
@property(nonatomic,weak)UILabel * sex ;
@property(nonatomic,weak)UILabel * birthday ;
//@property(nonatomic,weak)UIButton * safeLevelLabel ; //安全等级不要了
@property(nonatomic,strong)NSDictionary * accountInfo ;
@property(nonatomic,weak)UIDatePicker * datePicker ;


@end

@implementation AccountInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=BackgroundGray;
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self addScrollContainer];
    [self accountInfo];
    // Do any additional setup after loading the view.
}

-(NSDictionary * )accountInfo{
    if(_accountInfo==nil){
//        _accountInfo = [[NSDictionary alloc]init];
        //在网络获取成功回调里设置名称
        _accountInfo= @{
//                        @"image":[UIImage imageNamed:[UserInfo shareUserInfo].head_images],

//                        @"sex":@"女",
//                        @"birthday":@"1999-04-06",
                        @"safeLevel":@"中"
                        };
    
        if ([UserInfo shareUserInfo].head_images.length>0 && [[UserInfo shareUserInfo].head_images containsString:@"head_images"]) {
            self.iconImageView.backImageURLStr = [UserInfo shareUserInfo].head_images;
        }else{
            self.iconImageView.img = [UIImage imageNamed:@"bg_nohead"];
        }
        self.accountName.text=[UserInfo shareUserInfo].name;
        self.nickName.text=[UserInfo shareUserInfo].nickname;
        NSString * sexStr = nil ;
        if ([UserInfo shareUserInfo].sex == 1) {
            sexStr = @"男";
        }else if ([UserInfo shareUserInfo].sex ==2){
            sexStr = @"女";
        }else{
            sexStr = @"保密";
        }
        self.sex.text= sexStr;
        
        if ([UserInfo shareUserInfo].birthday.length>0 && ![[UserInfo shareUserInfo].birthday containsString:@"null"]) {
            
            self.birthday.text=[UserInfo shareUserInfo].birthday;
        }else{
            self.birthday.text = @"未设置";
        }
        
//        NSString * hightOrLow = _accountInfo[@"safeLevel"];
//        NSString *contentStr = [NSString stringWithFormat:@"安全等级 : %@ ",hightOrLow];
//        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:contentStr];
//        NSString * ss = [contentStr substringFromIndex:7];
//        NSRange rr = [contentStr rangeOfString:ss];
//        [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:rr];
//        [self.safeLevelLabel setAttributedTitle:str forState:UIControlStateNormal];
        
        /** 安全等级的初始化也不要了 */
//        NSString * hightOrLow = @"高";
//        NSString *contentStr = [NSString stringWithFormat:@"安全等级 : %@ ",hightOrLow];
//        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:contentStr];
//        [str  addAttribute:NSForegroundColorAttributeName value:SubTextColor range:NSMakeRange(0, str.length)];
//        NSString * ss = [contentStr substringFromIndex:7];
//        NSRange rr = [contentStr rangeOfString:ss];
//        [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:rr];
//        [self.safeLevelLabel setAttributedTitle:str forState:UIControlStateNormal];
//        self.safeLevelLabel.titleLabel.font = [UIFont systemFontOfSize:14];
        self.sex.font  = [UIFont systemFontOfSize:14];

    }
    return _accountInfo;
}
-(void)addScrollContainer
{
    
    UIScrollView * scrollContainer = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.startY, self.view.bounds.size.width, self.view.bounds.size.height-self.startY)];
    scrollContainer.delegate=self;
    self.scrollContainer=scrollContainer;
//    self.scrollContainer.backgroundColor=randomColor;
    [self.view addSubview:self.scrollContainer];
    self.scrollContainer.alwaysBounceVertical = YES;

    [self addSubviewOfScrollContainer];
    
}

-(void)addSubviewOfScrollContainer
{
    CGFloat iconRowHeight = 60*SCALE ;
    CGFloat normalRowHeight = 44*SCALE;
    CGFloat topLineHeight = 3 ;
    CGFloat bottomLineHeight = 8 ;
//    CGFloat topMargin = 6 ;
//    CGFloat rightMargin = 10 ;
    CGFloat W = self.view.bounds.size.width;
    ActionBaseView * iconImageView = [[ActionBaseView alloc]init];
    [iconImageView addTarget:self action:@selector(changeIcon) forControlEvents:UIControlEventTouchUpInside];
    self.iconImageView = iconImageView;
//    self.iconImageView.img = [UIImage imageNamed:@"bg_nohead"];
    iconImageView.backgroundColor = BackgroundGray;
    [self setRowViewWithTitle:@"头像" frame:CGRectMake(0, self.maxY, W, iconRowHeight) lineHeight:topLineHeight detailView:iconImageView  andType:@"image"];
    iconImageView.layer.cornerRadius=iconImageView.bounds.size.width/2;
    iconImageView.layer.masksToBounds=YES;

    
    UILabel * accountName = [[UILabel alloc]init];
    self.accountName=accountName;
    accountName.textColor= [UIColor lightGrayColor];
    accountName.text = @"用户名";
    accountName.textAlignment=NSTextAlignmentRight;
    [self setRowViewWithTitle:@"用户名" frame:CGRectMake(0, self.maxY, W, normalRowHeight) lineHeight:topLineHeight detailView:accountName andType:@"string"];
#pragma mark    /** 取出昵称时点击事件错乱(已修复) */
//    UITextField * nickName = [[UITextField alloc]init];
//    nickName.returnKeyType = UIReturnKeyDone;
//    nickName.enablesReturnKeyAutomatically=YES;
//    nickName.delegate = self;
//    nickName.textAlignment = NSTextAlignmentRight;
//    self.nickName=nickName;
//    nickName.text = @"昵称";
//    [self setRowViewWithTitle:@"昵称" frame:CGRectMake(0, self.maxY, W, normalRowHeight) lineHeight:topLineHeight detailView:nickName andType:@"string"];
    
    
    ActionBaseView * sexContainer = [[ActionBaseView alloc]init];
    [sexContainer addTarget:self action:@selector(changeSex) forControlEvents:UIControlEventTouchUpInside];
    [self setRowViewWithTitle:@"性别" frame:CGRectMake(0, self.maxY, W, normalRowHeight) lineHeight:topLineHeight detailView:sexContainer andType:@"string"];
    UILabel * sex = [[UILabel alloc]init];
    sex.textColor = SubTextColor;
    [sexContainer addSubview:sex];
    sex.frame=sexContainer.bounds;
    self.sex=sex;
    sex.textAlignment = NSTextAlignmentRight;
//    sex.text=@"男";
    

    ActionBaseView * birthdayContainer= [[ActionBaseView alloc]init];
    [birthdayContainer addTarget:self action:@selector(changeBirthday) forControlEvents:UIControlEventTouchUpInside];
    [self setRowViewWithTitle:@"出生日期" frame:CGRectMake(0, self.maxY, W, normalRowHeight) lineHeight:topLineHeight detailView:birthdayContainer andType:@"string"];
    UILabel * birthday = [[UILabel alloc]init];
    birthday.textColor = SubTextColor;
    birthday.font = [UIFont systemFontOfSize:15*SCALE];
    [birthdayContainer addSubview:birthday];
    birthday.frame=birthdayContainer.bounds;
    birthday.textAlignment =NSTextAlignmentRight ;
    self.birthday = birthday ;
    birthday.text = @"生日";
    
    
    
    
    
    ActionBaseView * addressRowView = [[ActionBaseView alloc]init];
//    addressRowView.backgroundColor = randomColor;
    [addressRowView addTarget:self action:@selector(addressManager) forControlEvents:UIControlEventTouchUpInside];
   ActionBaseView * addressTotalClick = [self setRowViewWithTitle:@"收货地址管理" frame:CGRectMake(0, self.maxY, W, normalRowHeight) lineHeight:bottomLineHeight detailView:addressRowView andType:@"string"];
    [addressTotalClick addTarget:self action:@selector(addressManager) forControlEvents:UIControlEventTouchUpInside];
    UIImageView * addressArrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jiantou"]];
    addressArrow.contentMode = UIViewContentModeScaleAspectFit;
//    addressArrow.backgroundColor = randomColor;
    addressArrow.frame = CGRectMake(addressRowView.bounds.size.width -addressArrow.bounds.size.width, 0, addressArrow.bounds.size.width, addressRowView.bounds.size.height);
    [addressRowView addSubview:addressArrow];
    addressArrow.userInteractionEnabled=NO ;
    
    
    
    UIView * safeLevel = [[UIView alloc]init];
    safeLevel.userInteractionEnabled= NO ;
//     safeLevel.backgroundColor = randomColor;
   ActionBaseView * accountTotalClick = [self setRowViewWithTitle:@"账户安全" frame:CGRectMake(0, self.maxY, W, normalRowHeight) lineHeight:bottomLineHeight detailView:safeLevel andType:@"string"];
    
    UIImageView * safeLevelArrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jiantou"]];
    safeLevelArrow.contentMode = UIViewContentModeScaleAspectFit;
//    safeLevelArrow.backgroundColor = randomColor;
    safeLevelArrow.frame = CGRectMake(safeLevel.bounds.size.width -safeLevelArrow.bounds.size.width, 0, safeLevelArrow.bounds.size.width, safeLevel.bounds.size.height);
    LOG(@"_%@_%d_%@",[self class] , __LINE__,NSStringFromCGRect(safeLevelArrow.frame))
    [safeLevel addSubview:safeLevelArrow];
    
    /////////
//    UIButton * but = [[UIButton alloc]init];
//    [but setAttributedTitle:<#(nullable NSAttributedString *)#> forState:<#(UIControlState)#>]
    /////////\
    
    
    
    /** 安全等级去掉 */
//    UIButton * safeLevelLabel = [[UIButton alloc]init];
////    [safeLevelLabel setTitleColor:SubTextColor forState:UIControlStateNormal];
//     [safeLevelLabel addTarget:self action:@selector(setSafeLevel) forControlEvents:UIControlEventTouchUpInside];
        [accountTotalClick addTarget:self action:@selector(setSafeLevel) forControlEvents:UIControlEventTouchUpInside];
//
//    self.safeLevelLabel=safeLevelLabel;
//    [safeLevelLabel setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
//    [safeLevel addSubview:safeLevelLabel];
//    safeLevelLabel.frame=CGRectMake(0, 0, safeLevel.bounds.size.width-safeLevel.bounds.size.height, safeLevel.bounds.size.height);
//    NSString * hightOrLow = @"高";
//    NSString *contentStr = [NSString stringWithFormat:@"安全等级 : %@ ",hightOrLow];
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:contentStr];
//    [str  addAttribute:NSForegroundColorAttributeName value:SubTextColor range:NSMakeRange(0, str.length)];
//    NSString * ss = [contentStr substringFromIndex:7];
//    NSRange rr = [contentStr rangeOfString:ss];
//    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:rr];
//    [safeLevelLabel setAttributedTitle:str forState:UIControlStateNormal];
//       LOG(@"_%@_%d_%@",[self class] , __LINE__,NSStringFromCGRect(safeLevelArrow.frame))
}

#pragma 安全管理

-(void)setSafeLevel
{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"安全管理")
    PTableCellModel *model = [[PTableCellModel alloc]init];
    model.actionKey = ActionAccountSafe;
    model.title = @"账户安全";
    [[SkipManager shareSkipManager] skipByVC:self withActionModel:model];
}

#pragma 地址管理

-(void)addressManager
{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"地址管理")
    BaseModel * addressModel = [[BaseModel alloc]init];
    addressModel.actionKey = @"AddressManagerVC";
    
    [[SkipManager shareSkipManager] skipByVC:self withActionModel:addressModel];
}

#pragma 修改生日

-(void)changeBirthday
{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"修改生日")

    UIView * corver = [[UIView alloc]initWithFrame:self.view.bounds];
    self.corver = corver;
    [self.view addSubview:corver];
    corver.backgroundColor=[UIColor colorWithWhite:0.5 alpha:0.5];
    CGFloat containerW = screenW;
    CGFloat containerH = screenW/2;
    UIView * container = [[UIView alloc]initWithFrame:CGRectMake(0, screenH-containerH, containerW, containerH)];
    container.backgroundColor=[UIColor whiteColor];
    [corver addSubview:container];
    
    CGFloat sureW = 44;
    CGFloat sureH = 22;
    CGFloat topMargin = 10 ;
    CGFloat rightMargin = 2*topMargin;
    UIButton * sureButton = [[UIButton alloc]initWithFrame:CGRectMake( container.bounds.size.width-rightMargin-sureW,topMargin, sureW, sureH)];
    [sureButton setTitle:@"完成" forState:UIControlStateNormal];
    //    [sureButton.titleLabel setTextColor:[UIColor darkGrayColor]];
    [sureButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    sureButton.layer.borderWidth=1;
    [sureButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    sureButton.layer.borderColor=[UIColor darkGrayColor].CGColor;
    sureButton.layer.cornerRadius=3;
    sureButton.layer.masksToBounds=YES;
    [container addSubview:sureButton];
    [sureButton addTarget:self action:@selector(changeBirthdaySureClick:) forControlEvents:UIControlEventTouchUpInside];

   
    
    
    UIDatePicker * datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(sureButton.frame), container.bounds.size.width, container.bounds.size.height-CGRectGetMaxY(sureButton.frame))];
    self.datePicker = datePicker;
    datePicker.maximumDate=[NSDate date];
    datePicker.minimumDate=[NSDate dateWithTimeIntervalSince1970:-60*60*24*30*12*10*6];
    datePicker.datePickerMode=UIDatePickerModeDate;
    datePicker.timeZone=[NSTimeZone localTimeZone];
    [container addSubview:datePicker];
    //- (void)setDate:(NSDate *)date animated:(BOOL)animated
    
    if (![self.birthday.text containsString:@"-"]) {
        [datePicker  setDate:datePicker.maximumDate animated:NO];
        return;
    }
    
    NSDateFormatter *inputFormatter= [[NSDateFormatter alloc] init] ;
    
    [inputFormatter setLocale:[NSLocale currentLocale] ];
    
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate*inputDate = [inputFormatter dateFromString:self.birthday.text];
    
    //////
    LOG(@"_%@_%d_%@",[self class] , __LINE__,self.birthday.text);
    LOG(@"_%@_%d_%@",[self class] , __LINE__,inputDate);
    LOG(@"_%@_%d_%@",[self class] , __LINE__,datePicker.minimumDate);
   
    if ( [inputDate  isEqualToDate: [inputDate earlierDate:datePicker.minimumDate] ]) {
//        inputDate = datePicker.minimumDate;
        [datePicker setDate:datePicker.minimumDate animated:NO];
    }
    else if ( [inputDate  isEqualToDate: [inputDate laterDate:datePicker.maximumDate]]) {
//        inputDate = datePicker.maximumDate;
        [datePicker setDate:datePicker.maximumDate animated:NO];
    } else   {
        [datePicker setDate:inputDate animated:NO];
    }
//    }else{
////        [datePicker setDate:datePicker.maximumDate];
//    }
    
}
-(void)changeBirthdaySureClick:(UIButton*)sender
{
    NSDate * targetDate = self.datePicker.date;
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    formatter.formattingContext=NSFormattingContextStandalone;
    formatter.dateFormat=@"yyyy-MM-dd";
    NSString * dateStr = [formatter stringFromDate:targetDate];
    
    self.birthday.text=dateStr;
    LOG(@"_%@_%d_%@",[self class] , __LINE__,dateStr)
    [self.corver removeFromSuperview];
    self.corver = nil;
    //并同步到服务器
    UserInfo * newUserInfo = [[UserInfo alloc]init];
    newUserInfo.birthday = dateStr ;
    [[UserInfo shareUserInfo] editUserInfoWithNewUserInfo:newUserInfo success:^(ResponseObject *responseObject) {
        if (responseObject.status>0) {
            [UserInfo shareUserInfo].birthday = dateStr;
        }
        LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
    } failure:^(NSError *error) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
    }];
}
#pragma 修改性别

-(void)changeSex
{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"修改性别")
    UIView * corver = [[UIView alloc]initWithFrame:self.view.bounds];
    self.corver = corver;
    [self.view addSubview:corver];
    corver.backgroundColor=[UIColor colorWithWhite:0.5 alpha:0.5];
    CGFloat containerW = screenW;
    CGFloat containerH = screenW/2;
    UIView * container = [[UIView alloc]initWithFrame:CGRectMake(0, screenH-containerH, containerW, containerH)];
    container.backgroundColor=[UIColor whiteColor];
    [corver addSubview:container];
    
    CGFloat sureW = 44;
    CGFloat sureH = 22;
    CGFloat topMargin = 10 ;
    CGFloat rightMargin = 2*topMargin;
    UIButton * sureButton = [[UIButton alloc]initWithFrame:CGRectMake( container.bounds.size.width-rightMargin-sureW,topMargin, sureW, sureH)];
    [sureButton setTitle:@"完成" forState:UIControlStateNormal];
    //    [sureButton.titleLabel setTextColor:[UIColor darkGrayColor]];
    [sureButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    sureButton.layer.borderWidth=1;
    [sureButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    sureButton.layer.borderColor=[UIColor darkGrayColor].CGColor;
    sureButton.layer.cornerRadius=3;
    sureButton.layer.masksToBounds=YES;
    [container addSubview:sureButton];
    [sureButton addTarget:self action:@selector(changeSexSureClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIPickerView * picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, topMargin+sureH, container.bounds.size.width, container.bounds.size.height-topMargin-sureH)];
    [container addSubview:picker];
    picker.delegate=self;
    picker.dataSource=self;


}
#pragma 修改头像

-(void)changeIcon
{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"修改头像")
    
    UIAlertController * alertVC  =  [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * actionCamora = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //弹出系统相册
            UIImagePickerController *pickVC = [[UIImagePickerController alloc] init];
            //设置照片来源
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            
            pickVC.sourceType =  UIImagePickerControllerSourceTypeCamera;
            pickVC.delegate = self;
            [self presentViewController:pickVC animated:YES completion:nil];
        }else{
            AlertInVC(@"摄像头不可用");
        }
        pickVC.allowsEditing=YES;
    }];
    UIAlertAction * actionAlbum = [UIAlertAction actionWithTitle:@"我的相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //弹出系统相册
            UIImagePickerController *pickVC = [[UIImagePickerController alloc] init];
        
            //设置照片来源
        pickVC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            pickVC.delegate = self;
         pickVC.allowsEditing=YES;
            [self presentViewController:pickVC animated:YES completion:nil];
    }];
    UIAlertAction * actionCancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertVC addAction:actionCamora];
    [alertVC addAction:actionAlbum];
    [alertVC addAction:actionCancle];
    [self presentViewController:alertVC animated:YES completion:nil];


}

#pragma 修改昵称
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField.text.length>0) {
        //在此保存昵称,并上传到服务器TODO
        UserInfo * newUserInfo = [[UserInfo alloc]init];
        newUserInfo.nickname = textField.text;
        [[UserInfo shareUserInfo] editUserInfoWithNewUserInfo:newUserInfo success:^(ResponseObject *responseObject) {
            LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,<#@""#>);
        } failure:^(NSError *error) {
           LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
        }];
        [self.view endEditing:YES];
        return YES;
    }else{
        return NO;
    }
}
-(ActionBaseView *)setRowViewWithTitle:(NSString*)title frame:(CGRect)frame lineHeight:(CGFloat)lineHeight detailView:(UIView*)detailView andType:(NSString*)type
{
    CGFloat leftMargin  =  10 ;
    CGFloat rightMargin = 20 ;
    CGFloat topMargin = 5;
    ActionBaseView * tempView = [[ActionBaseView alloc]initWithFrame:frame];
    tempView.backgroundColor=[UIColor whiteColor];
    [self.scrollContainer addSubview:tempView];
    UIView * line = [[UIView alloc] init];
    line.backgroundColor = BackgroundGray;
    line.frame = CGRectMake(0, 0, tempView.bounds.size.width, lineHeight);
    [tempView addSubview:line];
    
    UILabel * titleLabel=[[UILabel alloc]init];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = MainTextColor;
    [tempView addSubview:titleLabel];
    titleLabel.frame=CGRectMake(leftMargin, lineHeight, frame.size.width/2-leftMargin, frame.size.height-lineHeight);
    titleLabel.text=title;
    
//    detailView.backgroundColor=randomColor;
    [tempView addSubview:detailView];
    if ([type isEqualToString:@"image"]) {
        CGFloat imgH = tempView.bounds.size.height-2*topMargin-lineHeight;
        CGFloat imgY = topMargin+lineHeight;
        CGFloat imgW = imgH;
        CGFloat imgX = tempView.bounds.size.width - imgW - rightMargin;
        detailView.frame = CGRectMake(imgX, imgY, imgW, imgH);
        
    }else if([type isEqualToString:@"string"]){
        detailView.frame = CGRectMake(frame.size.width/2, lineHeight + topMargin, frame.size.width/2-rightMargin, frame.size.height-lineHeight-2*topMargin);
    }
//    detailView.backgroundColor = randomColor;
    self.maxY+=frame.size.height;
    
    return tempView ;
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *photo = info[UIImagePickerControllerEditedImage];//UIImagePickerControllerEditedImage;//
    
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,photo)
    self.iconImageView.img=photo;
    [self uploadPicktreWithImage:photo];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)uploadPicktreWithImage:(UIImage *)image
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData * imgData = UIImageJPEGRepresentation(image, 0.1);
        [self setuserIconToIMSeverWithimgData:imgData];
        NSString * imgBase64 =  [imgData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        [[UserInfo shareUserInfo] uploadPictureWithPicBase64:imgBase64   targetType:1  success:^(ResponseObject*  response) {
            //头像上传成功 通知个人中心页面更新头像显示 , 偷了个懒 通过发送登录成功来重新获取个人信息数据LOGINSUCCESS
            [[NSNotificationCenter defaultCenter] postNotificationName:LOGINSUCCESS object:nil];
            LOG(@"_%@_%d_%@",[self class] , __LINE__,response.msg)
        } failure:^(NSError *error) {
            LOG(@"_%@_%d_%@",[self class] , __LINE__,error)
        }];
    });
    
}

-(void)setuserIconToIMSeverWithimgData:(NSData*)imgdata
{
    XMPPvCardTemp * myCard = [GDXmppStreamManager ShareXMPPManager].xmppvcardtempModule.myvCardTemp;
        [GDXmppStreamManager ShareXMPPManager].xmppvcardtempModule.myvCardTemp.photo = imgdata;
        [[GDXmppStreamManager ShareXMPPManager].xmppvcardtempModule updateMyvCardTemp:myCard];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString * choose =  self.pickViewArr[row];
    self.choose=choose;
    
}
/** 点击修改性别 */
-(void)changeSexSureClick:(UIButton*)sender//选择性别的确定按钮
{
//    if (self.choose.length>0) {
        self.sex.text=self.choose;
    UserInfo * newUserInfo = [[UserInfo alloc]init];
    if ([self.choose isEqualToString:@"男"])  newUserInfo.sex = 1 ;
    if ([self.choose isEqualToString:@"女"])  newUserInfo.sex = 2 ;
    if ([self.choose isEqualToString:@"保密"])  newUserInfo.sex = 3 ;

    [[UserInfo shareUserInfo] editUserInfoWithNewUserInfo:newUserInfo success:^(ResponseObject *responseObject) {
        if (responseObject.status>0) {
            [UserInfo shareUserInfo].sex = newUserInfo.sex;
        }
        LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
    } failure:^(NSError *error) {
       LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
    }];
//    }
    
    [self.corver removeFromSuperview];
    self.corver = nil;
    
}

#pragma pickerViewDataSource

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.pickViewArr.count;
    
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return self.pickViewArr[row];
    
}


-(NSArray * )pickViewArr{
    if(_pickViewArr==nil){
        _pickViewArr = [[NSArray alloc]initWithObjects:@"男",@"女",@"保密", nil];
        self.choose = _pickViewArr[0];
    }
    return _pickViewArr;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");

    // Dispose of any resources that can be recreated.
}
/////////////////////////////////////////////////////////////////////////////



@end
