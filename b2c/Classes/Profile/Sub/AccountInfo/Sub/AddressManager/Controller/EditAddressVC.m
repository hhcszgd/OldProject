//
//  EditAddressVC.m
//  b2c
//
//  Created by wangyuanfei on 4/6/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "EditAddressVC.h"

#import "AMCell.h"

#import "AMCellModel.h"
#import "AddressManagerVC.h"
#import "ChooseAreaVC.h"

@interface EditAddressVC ()</*UIPickerViewDelegate,UIPickerViewDataSource,*/ChooseAreaVCDelegate>

@property(nonatomic,weak)UILabel * nameLabel ;
@property(nonatomic,strong)UITextField * nameInput ;
@property(nonatomic,weak)UILabel * idNumLabel ;
@property(nonatomic,strong)UITextField * idNumInput ;
@property(nonatomic,weak)UILabel * phoneNumberLabel ;
@property(nonatomic,weak)UITextField * phoneNumberInput ;
@property(nonatomic,weak)UILabel * areaLabel ;
@property(nonatomic,weak)UIButton * areaShow ;
//@property(nonatomic,weak)UILabel * streetLabel ;
//@property(nonatomic,weak)UIButton * streetShow ;
@property(nonatomic,weak)UILabel * detailAddressLabel;
@property(nonatomic,weak)UITextField * detailAddressInput ;
@property(nonatomic,weak)UILabel * postalCode ;
@property(nonatomic,weak)UITextField * postalCodeShow ;
@property(nonatomic,strong)NSMutableArray *left  ;
@property(nonatomic,strong)NSMutableArray * right ;
@property(nonatomic,weak)UIPickerView * pickerView ;
@property(nonatomic,strong)NSMutableArray * pickerData ;
@property(nonatomic,copy)NSString *  currentProvince ;
@property(nonatomic,copy)NSString *  currentCity;
@property(nonatomic,copy)NSString * currentArea ;
@property(nonatomic,weak)UIView * subContainer ;
@property(nonatomic,weak)UISwitch * isDefaule ;

@property(nonatomic,assign)EditAddressVCActionStyle  actionStyle ;
@end

@implementation EditAddressVC
-(instancetype)initWithActionStyle:(EditAddressVCActionStyle)actionStyle{
    if (self=[super init]) {

        self.actionStyle = actionStyle;
    }

    return self;
}
-(void)setActionStyle:(EditAddressVCActionStyle)actionStyle{
    _actionStyle = actionStyle;
    if (actionStyle == Editing) {
            self.naviTitle=@"修改地址";
    }else if (actionStyle == Adding){
            self.naviTitle=@"新增地址";
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor= BackgroundGray;
    [self setupRightBarbuttonItem];
    
    [self subContainer];
    if (self.editingCell) {
        self.model = self.editingCell.model;
    }else{
        self.model = [[AMCellModel alloc]init];
    }

//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textBegainEditing) name:UITextFieldTextDidBeginEditingNotification object:nil];
//
    // Do any additional setup after loading the view.
}
-(void)setupRightBarbuttonItem
{
    CGFloat margin = 20 ;
    CGFloat H = 44 ;
    UIButton * rightBarButton = [[UIButton alloc]initWithFrame:CGRectMake(margin, self.view.bounds.size.height - margin - H, self.view.bounds.size.width - margin*2, H)];
    rightBarButton.backgroundColor  = THEMECOLOR;
    [rightBarButton addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    [rightBarButton setTitle:@"保存" forState:UIControlStateNormal];
    [self.view addSubview:rightBarButton];
}

//-(void)textBegainEditing
//{
//    [self pickerViewDown];
//}

-(void)done:(UIBarButtonItem*)sender
{
    for (int i = 0;  i < self.right.count; i++) {
        if (i==0) {
            UITextField * field = self.right[i];
            if (field.text.length>15 || field.text.length<2) {
                AlertInVC(@"收货人为2~15个字符")
                return;
            }
        }if (i==1) {//身份证可以为空
            UITextField * field = self.right[i];
            if ( ![self idNumberLawful:field.text] && field.text.length != 0  ) {
                AlertInVC(@"请输入有效的身份证号码或者不写")
                return;
            }
        }else if (i==2) {
             UITextField * field = self.right[i];
            if (field.text.length==0) {
                UILabel * lbl = self.left[i];
                [self hubWithTitle:lbl.text];
                return;
            }
            if (![self mobileLawful:field.text]){
                 [self hubWithTitle:@"11位手机号码"];
                return;
            }

        } else  if (i==3) {
            UIButton * btn = self.right[i];
            if (btn.titleLabel.text.length<1) {
                
                UILabel * lbl = self.left[i];
                [self hubWithTitle:lbl.text];
                return;
            }
        }else if (i==4){
            UITextField * field = self.right[i];
            if (field.text.length<1) {
//                UILabel * lbl = self.left[i];
//                [self hubWithTitle:lbl.text];
                AlertInVC(@"具体地址为1~80个字符")
                return;
            }
            if (field.text.length>80) {
                AlertInVC(@"具体地址为1~80个字符")
                return;
            }
        }else{}
    }
    AMCellModel * model =[[AMCellModel alloc]init];
    model.id_number = self.idNumInput.text ? self.idNumInput.text : @"" ;
    model.username = self.nameInput.text;
    model.mobile=self.phoneNumberInput.text;
    model.postalCode=self.postalCodeShow.text;
    model.area = self.areaShow.currentTitle;
    model.province=self.currentProvince;//TODO
    model.city=self.currentCity;
    //////////////
    /** 改 */
    /////////////
    model.area_id = self.model.area_id;
    
//    model.area=self.currentArea;
    
    
    
    model.address=self.detailAddressInput.text;
    model.isDefaultAddress = self.isDefaule.isOn;

    if (self.actionStyle==Editing) {
        model.ID = self.model.ID;
//        model.methodType = @"put";
        LOG(@"_%@_%d_%@",[self class] , __LINE__,model);
        [[UserInfo shareUserInfo] editAddressWithAddressModel:model success:^(ResponseObject *responseObject) {
            LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
            LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.msg);
//            if ([self.delegate respondsToSelector:@selector(endEditingAddress)]) [self.delegate endEditingAddress];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSError *error) {
            LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
    }else{
//        model.methodType = @"post";
        [[UserInfo shareUserInfo] creatNewAddressWithModel:model success:^(ResponseObject *responseObject) {
            LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
            LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.msg);
//            if ([self.delegate respondsToSelector:@selector(endEditingAddress)])  [self.delegate endEditingAddress];
           
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSError *error) {
            LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,[NSString stringWithFormat:@"%@%@%@%@",model.country,model.province,model.city,model.area]);
    
    
}
-(void)hubWithTitle:(NSString * ) title
{
    MBProgressHUD * hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hub.mode=MBProgressHUDModeText;
    hub.labelText=[NSString stringWithFormat:@"请输入 %@",title];
    [hub hide:YES afterDelay:2];
    
}

-(UIView * )subContainer{
    if(_subContainer==nil){
        UIView * subContainer  = [[UIView alloc]init];
        self.subContainer=subContainer;
        [self.view addSubview:subContainer];
        [self addSubviewsAndLayout];
//        [self layoutMySubviews];
        _subContainer = subContainer;
    }
    return _subContainer;
}

-(void)addSubviewsAndLayout
{
    CGFloat margin = 10 ;
    CGFloat titleX = margin ;
    CGFloat titleW = 88;
    CGFloat subTitleX = titleW + titleX + margin;
    CGFloat subTitleW = self.view.bounds.size.width - margin - titleW - margin - margin;
    CGFloat Y = self.startY+5 ;
    CGFloat lineH  =3 ;
    CGFloat normalH = 44 ;
    //收货人
    UIView * nameView =[self creatBackgroundViewWithY:Y andH:normalH];
    UILabel * nameLabel  = [[UILabel alloc]initWithFrame:CGRectMake(titleX, 0, titleW, nameView.bounds.size.height)];
    nameLabel.textColor = MainTextColor;
    self.nameLabel=nameLabel;
    [nameView addSubview:self.nameLabel];
    [self.left addObject:self.nameLabel];
    nameLabel.text = @"收货人";
    UITextField * nameInput =[[UITextField alloc]initWithFrame:CGRectMake(subTitleX, 0, subTitleW, 44)];
    [nameInput addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    nameInput.placeholder = @"请输入2~15个字符的收件人姓名";
    nameInput.font = [UIFont systemFontOfSize:15*SCALE];
    self.nameInput=nameInput;
    [nameView addSubview:self.nameInput];
    [self.right addObject:self.nameInput];
    Y+=(normalH+lineH);
    
    //身份证
    UIView * idNumView =[self creatBackgroundViewWithY:Y andH:normalH];
    UILabel * idNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleX, 0, titleW, idNumView.bounds.size.height)];
    UITextField * idNumInput =[[UITextField alloc]initWithFrame:CGRectMake(subTitleX, 0, subTitleW, idNumView.bounds.size.height)];
    self.idNumLabel= idNumLabel;
    self.idNumInput = idNumInput;
    [idNumView addSubview:idNumLabel];
    [self.left addObject:self.idNumLabel];
    [idNumView addSubview:idNumInput];
    [self.right addObject:idNumInput];
    [idNumInput addTarget:self  action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    
    
    idNumLabel.textColor = MainTextColor;
    idNumLabel.text=@"身份证号码";
    
    idNumInput.placeholder = @"购买海外购商品需要身份证号码";
    idNumInput.font = [UIFont systemFontOfSize:15*SCALE];
    
    
    Y+=(normalH+lineH);
    
    
    //电话/手机
    UIView * phoneView = [self creatBackgroundViewWithY:Y andH:normalH];
    UILabel * phoneNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleX, 0, titleW, nameView.bounds.size.height)];
    phoneNumberLabel.textColor = MainTextColor;
    self.phoneNumberLabel = phoneNumberLabel;
    [phoneView addSubview:self.phoneNumberLabel];
    [self.left addObject:self.phoneNumberLabel];
    phoneNumberLabel.text=@"手机号码";
    
    UITextField * phoneNumberInput =[[UITextField alloc]initWithFrame:CGRectMake(subTitleX, 0, subTitleW, phoneView.bounds.size.height)];
    phoneNumberInput.placeholder = @"请输入11位数字的手机号码";
    phoneNumberInput.font = [UIFont systemFontOfSize:15*SCALE];
    phoneNumberInput.keyboardType = UIKeyboardTypePhonePad ;
    [phoneNumberInput addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    self.phoneNumberInput=phoneNumberInput;
    [phoneView addSubview:self.phoneNumberInput];
    [self.right addObject:self.phoneNumberInput];
//    [self.right addObject:self.phoneNumberInput];
//    [self setBorderWithView:phoneNumberInput andBackgroundcolor:[UIColor colorWithWhite:4.0 alpha:1]];
    self.phoneNumberInput.keyboardType = UIKeyboardTypeNumberPad;
    Y+=(normalH+lineH);
    //地区
    UIView * areaView = [self creatBackgroundViewWithY:Y andH:normalH];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseArea:)];
    [areaView addGestureRecognizer:tap];
    
    UILabel * areaLabel  = [[UILabel alloc]initWithFrame:CGRectMake(titleX, 0, titleW, areaView.bounds.size.height)];
    areaLabel.textColor = MainTextColor;
    self.areaLabel=areaLabel;
    [areaView addSubview:self.areaLabel];
    [self.left addObject:self.areaLabel];
    areaLabel.text=@"所在区域";
    UIImageView * arrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jiantou"]];
    [areaView addSubview:arrow];
    CGSize arrowSize =    arrow.bounds.size;
    arrow.frame = CGRectMake(areaView.bounds.size.width - margin - arrowSize.width, (areaView.bounds.size.height-arrowSize.height)/2, arrow.bounds.size.width, arrow.bounds.size.height);
    UIButton * areaShow =[[UIButton alloc]initWithFrame:CGRectMake(subTitleX, 0, subTitleW, areaView.bounds.size.height)] ;
    areaShow.titleLabel.font = [UIFont systemFontOfSize:15*SCALE];
    self.areaShow=areaShow;
    [areaView addSubview:self.areaShow];
    [self.right addObject:self.areaShow];
//    [self setBorderWithView:areaShow andBackgroundcolor:[UIColor whiteColor]];
    [self.areaShow setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.areaShow setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [areaShow addTarget:self action:@selector(chooseArea:) forControlEvents:UIControlEventTouchUpInside];
    Y+=(normalH+lineH);
    //详细地址
    
    UIView * detailAddressView = [self creatBackgroundViewWithY:Y andH:normalH];
    [self.view addSubview:detailAddressView];
    detailAddressView.backgroundColor = [UIColor whiteColor];
    UILabel * detailAddressLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleX, 0, titleW, detailAddressView.bounds.size.height)];
    detailAddressLabel.textColor = MainTextColor;
    self.detailAddressLabel=detailAddressLabel;
    [detailAddressView addSubview:self.detailAddressLabel];
    [self.left addObject:self.detailAddressLabel];
    detailAddressLabel.text=@"详细地址";
    
    
    UITextField * detailAddressInput =[[UITextField alloc]initWithFrame:CGRectMake(subTitleX, 0, subTitleW, detailAddressView.bounds.size.height)];
    detailAddressInput.placeholder = @"请输入1~80个字符的收货地址";
    detailAddressInput.font = [UIFont systemFontOfSize:15*SCALE];
    [detailAddressInput addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    self.detailAddressInput = detailAddressInput;
    [detailAddressView addSubview:self.detailAddressInput];
    [self.right addObject:self.detailAddressInput];
    Y+=(normalH + lineH);
//    [self setBorderWithView:detailAddressInput andBackgroundcolor:[UIColor colorWithWhite:4.0 alpha:1]];
    
    //是否设置默认
    
    
    UIView * defaultAddressView = [self creatBackgroundViewWithY:Y andH:normalH*1.5];
    [self.view addSubview:defaultAddressView];
    defaultAddressView.backgroundColor = [UIColor whiteColor];
    
    UISwitch * switchButton = [[UISwitch alloc]init];
    self.isDefaule = switchButton;
    switchButton.center  = CGPointMake(defaultAddressView.bounds.size.width  - margin - switchButton.bounds.size.width/2, defaultAddressView.bounds.size.height/2);
    [defaultAddressView addSubview:switchButton];
    
    UILabel * defaultLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleX, 0, defaultAddressView.bounds.size.width  - margin - switchButton.bounds.size.width, defaultAddressView.bounds.size.height)];
    defaultLabel.numberOfLines = 2 ;
    [defaultAddressView addSubview:defaultLabel];
    NSString * bigTit = @"设为默认地址";
    NSString * subTit = @"注:每次下单时会使用该地址";
    NSString * addressHoleTitle = [NSString stringWithFormat:@"%@\n%@",bigTit,subTit];
    NSRange  bigTitRange = [addressHoleTitle rangeOfString:bigTit];
    NSRange subTitRange = [addressHoleTitle rangeOfString:subTit];
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc]initWithString:addressHoleTitle];
    [attriStr addAttribute:NSForegroundColorAttributeName value:MainTextColor range:bigTitRange];
//    [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:bigTitRange];
    
    [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:subTitRange];
    [attriStr addAttribute:NSForegroundColorAttributeName value:SubTextColor range:subTitRange];
    //行间距
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing: 8];
    [attriStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle  range:NSMakeRange(0, addressHoleTitle.length)];
    
    
    
    defaultLabel.attributedText = attriStr;
//    UILabel * postalCode  = [[UILabel alloc]init];
//    self.postalCode=postalCode;
//    [self.view addSubview:self.postalCode];
//    [self.left addObject:self.postalCode];
//    postalCode.text=@"邮政编码";
//    
//    
//    UITextField * postalCodeShow =[[UITextField alloc]init];
//    self.postalCodeShow=postalCodeShow;
//    [self.view addSubview:self.postalCodeShow];
//    [self.right addObject:self.postalCodeShow];
//    [self setBorderWithView:postalCodeShow andBackgroundcolor:[UIColor whiteColor]];
//    [self setLeftTextAttribut];
//    self.postalCodeShow.keyboardType = UIKeyboardTypeNumberPad;
}

- (void)textFieldEditChanged:(UITextField *)textField
{
   
//    self.model.province = nil ;
//    self.model.city = self.;
//    self.model.country = self.country;
    self.model.mobile = self.phoneNumberInput.text;
    //增
    self.model.id_number = self.idNumInput.text ? self.idNumInput.text : @"";
//    self.model.ID = ;
    self.model.username = self.nameInput.text;
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,sel);
//    self.model.telephone = self.telephone;
    self.model.address = self.detailAddressInput.text;
    self.model.isDefaultAddress = self.isDefaule.isOn;
//    self.model.methodType = self.methodType;
}

-(UIView*)creatBackgroundViewWithY:(CGFloat)Y andH:(CGFloat)H
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, Y, self.view.bounds.size.width, H)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    return view ;
}
-(void)setLeftTextAttribut
{
    for (UILabel*label in self.left) {
        label.textColor=[UIColor grayColor];
        label.font=[UIFont systemFontOfSize:14];
    }
}
-(void)setBorderWithView:(UIView *)view andBackgroundcolor:(UIColor*)color
{
    view.layer.borderColor=[UIColor lightGrayColor].CGColor;
    view.layer.borderWidth=0.50;
    view.backgroundColor=color;
    view.layer.cornerRadius=2.50;
    view.layer.masksToBounds=YES;
}
//-(void)layoutMySubviews
//{
//    CGFloat margin = 10 ;
//    CGFloat h = 36 ;
//    CGFloat leftW = 90 ;
//    CGFloat rightW = screenW - margin*3 - leftW;
//    
//    for (int i = 0; i< self.left.count; i++) {
//        UIView * view = ( UIView *  )self.left[i];
//        view.frame=CGRectMake(margin, i*(margin+h)+margin+67, leftW, h);
//    }
//    for (int i = 0 ; i< self.right.count; i++) {
//        UIView * view = ( UIView *  )self.right[i];
//        view.frame=CGRectMake(margin+leftW+margin, i*(margin+h)+margin+67, rightW, h);
//    }
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}
#pragma lazylog
-(NSMutableArray * )left{
    if(_left==nil){
        _left = [[NSMutableArray alloc]init];
    }
    return _left;
}
-(NSMutableArray * )right{
    if(_right==nil){
        _right = [[NSMutableArray alloc]init];
    }
    return _right;
}

//-(void)setEditingCell:(AMCell *)editingCell{
//        [self subContainer];
//    _editingCell=editingCell;
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,editingCell.model.city)
//    _nameInput.text = editingCell.model.username;
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,    self.areaShow)
//    [self.areaShow setTitle:[NSString stringWithFormat:@"%@%@%@",editingCell.model.province,editingCell.model.city,editingCell.model.area] forState:UIControlStateNormal];
//    self.phoneNumberInput.text =editingCell.model.mobile;
//    self.detailAddressInput.text=editingCell.model.address;
//    self.postalCodeShow.text=editingCell.model.postalCode;
//    self.currentProvince=editingCell.model.province;
//    self.currentCity = editingCell.model.city;
//    self.currentArea = editingCell.model.area;
    
//}
-(void)setModel:(AMCellModel *)model{//如果是顺传,这里显示area里的字符串 , 如果是逆传 , area是没有值得 , 这里显示国省市拼接的字符串
//     [self subContainer];
    _model = model;
    _nameInput.text = model.username;
    _idNumInput.text = model.id_number;
    LOG(@"_%@_%d_%@",[self class] , __LINE__,    self.areaShow)

    NSString * allAreaStr =[[NSString alloc]initWithFormat:@""];
    if (model.country.length>0) {
        allAreaStr =[allAreaStr stringByAppendingString:model.country];
    }
    if (model.province.length>0) {
        allAreaStr = [allAreaStr stringByAppendingString:model.province];
    }
    if (model.city.length>0) {
        allAreaStr = [allAreaStr stringByAppendingString:model.city];
    }
    if (model.cantonal.length>0){
        allAreaStr = [allAreaStr stringByAppendingString:model.cantonal];
    }

    if (model.area.length==0) {
        [self.areaShow setTitle:allAreaStr forState:UIControlStateNormal];
    }else{
        [self.areaShow setTitle:model.area forState:UIControlStateNormal];
    }
//    allAreaStr=[NSString stringWithFormat:@"%@%@%@",model.country,model.province,model.city];
//    [self.areaShow setTitle:allAreaStr forState:UIControlStateNormal];
    self.phoneNumberInput.text =model.mobile;
    self.detailAddressInput.text=model.address;
    self.isDefaule.on = model.isDefaultAddress;
//    self.postalCodeShow.text=model.postalCode;
//    self.currentProvince=model.province;
//    self.currentCity = model.city;
//    self.currentArea = model.area;

}
-(void)chooseArea:(UIButton*)sender
{

//    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"=选择地区");;
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,self.editingCell.model.username);
//
//    [self.view endEditing:YES];
//    ChooseAreaVC * chooseAreaVC = [[ChooseAreaVC alloc]init];
//    chooseAreaVC.addressType=Country;
//    chooseAreaVC.areaID = @"0";
//    chooseAreaVC.delegate =self;
//    chooseAreaVC.addressModel = [self.model copy];
//    [self.navigationController pushViewController:chooseAreaVC animated:YES];
//    //选择省份, 跳出新的控制器TODO
    /*跳过国家直接选地区**/
    [self.view endEditing:YES];
    ChooseAreaVC * chooseAreaVC = [[ChooseAreaVC alloc]init];
    chooseAreaVC.addressType=Province;
    chooseAreaVC.areaID = @"110";
    chooseAreaVC.delegate =self;
    chooseAreaVC.addressModel = [self.model copy];
    [self.navigationController pushViewController:chooseAreaVC animated:YES];
    //选择省份, 跳出新的控制器TODO
    
}
//代理
-(void)choosedAddressWithModel:(AMCellModel *)addressModel{
    LOG(@"_%@_%d_%@_%@_%@_%@_%@_%@",[self class] , __LINE__,addressModel,addressModel.country,addressModel.province,addressModel.city,addressModel.area_id , addressModel.id_number);
    
//    if (![self.editingCell.model.city isEqualToString:addressModel.city] && addressModel.city.length>0) {
        LOG(@"_%@_%d_选择区域到最深层 , 返回地址模型 地址模型的国际是 %@ 省份是 %@ 城市是 %@   区是%@",[self class] , __LINE__,addressModel.country,addressModel.province,addressModel.city , addressModel.cantonal);
        if (self.editingCell) {
            self.editingCell.model=addressModel;
        }
    
        self.model =addressModel;
//    }

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
-(void)dealloc{
    LOG(@"_%@_%d_dealloc%@",[self class] , __LINE__,self)
    if ([self.delegate respondsToSelector:@selector(endEditingAddress)])  [self.delegate endEditingAddress];

}

/** 判断身份证号的合法性 */

- (BOOL) idNumberLawful:(NSString *)idNumbel{
    if (idNumbel.length==0) {//允许不填
//        AlertInVC(@"手机号为空");
//        return NO;
    }
    NSString * idNumRegx18 = @"^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$";
    NSPredicate *regextestmobile18 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", idNumRegx18];
//    NSString * idNumRegx15 = @"^[1-9]\\d{5}\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{2}$";
    NSString * idNumRegx15 =@"^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$";
    NSPredicate *regextestmobile15 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", idNumRegx15];
    if ([regextestmobile18 evaluateWithObject:idNumbel] | [regextestmobile15 evaluateWithObject:idNumbel]) {
        return YES;
    }
    return NO;
}
/** 判断手机号的合法性 */

- (BOOL) mobileLawful:(NSString *)mobileNumbel{
    if (mobileNumbel.length==0) {
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
    return NO;
}

/*
-(UIPickerView * )pickerView{
    if(_pickerView==nil){
        CGFloat pickerHeight = screenW/2;
        //        UIPickerView * pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, screenH-pickerHeight, screenW, pickerHeight)];
        UIPickerView * pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, screenH, screenW, pickerHeight)];
        pickerView.backgroundColor=randomColor;
        pickerView.dataSource = self;
        pickerView.delegate=self;
        [self.view addSubview:pickerView];
        _pickerView = pickerView;
    }
    return _pickerView;
}


-(void)pickerViewUp
{
    [UIView animateWithDuration:0.2 animations:^{
        self.pickerView.mj_y = screenH - self.pickerView.bounds.size.height;
    }];
}
-(void)pickerViewDown
{
    [UIView animateWithDuration:0.2 animations:^{
        self.pickerView.mj_y = screenH;
    }];
}
-(NSMutableArray * )pickerData{
    if(_pickerData==nil){
        NSMutableArray * arrM = [NSMutableArray array];
        if (YES) {
            for (int i = 0 ; i < 5; i++) {
                NSString * province  = [NSString stringWithFormat:@"省%d",i];
                NSMutableArray * cities = [NSMutableArray array];
                for (int j = 0; j < 10; j++) {
                    NSString * city = [NSString stringWithFormat:@"市%d" ,j];
                    NSMutableArray * areas = [NSMutableArray array];
                    for (int k = 0 ; k<15; k++) {
                        NSString * area = [NSString stringWithFormat:@"区%d",k];
                        NSDictionary * areaDic = @{
                                                   @"area":area
                                                   };
                        [areas addObject:areaDic];
                    }
                    NSDictionary * cityDic = @{
                                               @"city":city,
                                               @"areas":areas
                                               };
                    [cities addObject:cityDic];
                }
                NSDictionary * provinceDic = @{
                                               @"province" : province ,
                                               @"cities": cities
                                               };
                [arrM addObject:provinceDic];
            }
            
        }else{
            
        }
        _pickerData = arrM;
    }
    return _pickerData;
}
#pragma pickerViewDagasource

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3 ;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component==0) {
        return self.pickerData.count;
        
    }else if (component==1){
        NSInteger rowProvince = [pickerView selectedRowInComponent:0];
        NSDictionary * provinceDic =  self.pickerData[rowProvince];
        NSArray * provinceCities = provinceDic[@"cities"];
        
        return provinceCities.count;
    }else{
        NSInteger rowProvince=[pickerView selectedRowInComponent:0];
        NSInteger rowCity = [pickerView selectedRowInComponent:1];
        
        NSDictionary * provinceDic =  self.pickerData[rowProvince];
        NSArray * provinceCities = provinceDic[@"cities"];
        
        NSDictionary * cityDic = provinceCities[rowCity];
        NSArray * areas = cityDic[@"areas"];
        return areas.count;
        
    }
    
}
#pragma delegate

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    
    //    return streetDic[@"street"];
    
    
    if (component==0) {
        NSDictionary * provinceDic =  self.pickerData[row];
        NSString * province = provinceDic[@"province"];
        return province;
    }else if (component==1){
        NSInteger rowProvince = [pickerView selectedRowInComponent:0];
        NSDictionary * provinceDic =  self.pickerData[rowProvince];
        NSArray * provinceCities = provinceDic[@"cities"];
        NSDictionary * cityDic = provinceCities[row];
        NSString * city = cityDic[@"city"];
        return city;
    }else{
        NSInteger rowProvince=[pickerView selectedRowInComponent:0];
        NSInteger rowCity = [pickerView selectedRowInComponent:1];
        
        NSDictionary * provinceDic =  self.pickerData[rowProvince];
        NSArray * provinceCities = provinceDic[@"cities"];
        
        NSDictionary * cityDic = provinceCities[rowCity];
        NSArray * areas = cityDic[@"areas"];
        
        NSDictionary * areaDic = areas[row];
        NSString * area = areaDic[@"area"];
        return area;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component==0) {
        [pickerView selectRow:0 inComponent:1 animated:NO];
        [pickerView selectRow:0 inComponent:2 animated:NO];
        
    }else if (component==1){
        
        [pickerView selectRow:0 inComponent:2 animated:NO];
    }
    
    [pickerView reloadComponent:1];
    [pickerView reloadComponent:2];
    [self.areaShow setTitle:[NSString stringWithFormat:@"%@/%@/%@",self.currentProvince,self.currentCity,self.currentArea] forState:UIControlStateNormal];
}

-(NSString *)currentProvince{
    
    NSInteger rowProvince=[self.pickerView selectedRowInComponent:0];
    NSDictionary * provinceDic =  self.pickerData[rowProvince];
    NSString * province = provinceDic[@"province"];
    return province;
    
}

-(NSString *)currentCity{
    NSInteger rowProvince=[self.pickerView selectedRowInComponent:0];
    NSInteger rowCity = [self.pickerView selectedRowInComponent:1];
    NSDictionary * provinceDic =  self.pickerData[rowProvince];
    NSArray * provinceCities = provinceDic[@"cities"];
    NSDictionary * cityDic = provinceCities[rowCity];
    NSString * city = cityDic[@"city"];
    return city;
    
}
-(NSString *)currentArea{
    NSInteger rowProvince=[self.pickerView selectedRowInComponent:0];
    NSInteger rowCity = [self.pickerView selectedRowInComponent:1];
    NSInteger rowArea = [self.pickerView selectedRowInComponent:2];
    NSDictionary * provinceDic =  self.pickerData[rowProvince];
    NSArray * provinceCities = provinceDic[@"cities"];
    NSDictionary * cityDic = provinceCities[rowCity];
    NSArray * areas = cityDic[@"areas"];
    NSDictionary * areaDic = areas[rowArea];
    NSString * area = areaDic[@"area"];
    return area;
}
//
//-(void)initializationPickerView
//{
//    for (int i = 0 ; i<self.pickerData.count; i++) {
//        NSDictionary * provinceDic =  self.pickerData[i];
//        NSString * province = provinceDic[@"province"];
//        if ([self.editingCell.model.province isEqualToString:province]) {
//            LOG(@"_%@_%d_%d",[self class] , __LINE__,i)
//            [self.pickerView selectRow:i inComponent:0 animated:YES];
//            NSArray * provinceCities = provinceDic[@"cities"];
//            for (int j = 0 ; j<provinceCities.count; j++) {
//                NSDictionary * cityDic = provinceCities[j];
//                NSString * city = cityDic[@"city"];
//                if ([self.editingCell.model.city isEqualToString:city]) {
//                    LOG(@"_%@_%d_%d",[self class] , __LINE__,j)
//                    [self.pickerView selectRow:j inComponent:1 animated:YES];
//                    NSArray * areas = cityDic[@"areas"];
//                    for (int k = 0 ; k<areas.count; k++) {
//                        NSDictionary * areaDic  =  areas[k];
//                        NSString * area =areaDic[@"area"];
//                        if ([self.editingCell.model.area isEqualToString:area]) {
//                            LOG(@"_%@_%d_%d",[self class] , __LINE__,k)
//                            [self.pickerView selectRow:k inComponent:2 animated:YES];
//                        }
//                    }
//                }
//            }
//        }
//        
//    }
//}
 */


@end
