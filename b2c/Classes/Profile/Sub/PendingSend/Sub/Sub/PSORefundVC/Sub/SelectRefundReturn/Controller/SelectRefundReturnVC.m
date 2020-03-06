//
//  SelectRefundReturnVC.m
//  b2c
//
//  Created by 0 on 16/4/15.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "SelectRefundReturnVC.h"

@interface SelectRefundReturnVC ()<UITextViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UILabel *idLabel;
@property (nonatomic, strong) UIScrollView *scrollView;
/**限制字数*/
@property (nonatomic, strong) UILabel *limitLabel;
/**父视图corver*/
@property (nonatomic, weak) UIView *corver;
/**退款原因和申请服务的数据源*/
@property (nonatomic, strong) NSArray *refundReasonArr;

/**被选择的退货原因*/
@property (nonatomic, copy) NSString *choese;
/**上传凭证*/
@property (nonatomic, strong) UIImageView *voucherImageOne;
@property (nonatomic, strong) UIImageView *voucherImageTwo;
@property (nonatomic, strong) UIImageView *voucherImageThree;
/**用来标记申请的服务和退货原因*/
@property (nonatomic, weak) ActionBaseView *actonView;



@end




@implementation SelectRefundReturnVC

- (UIImageView *)voucherImageOne{
    if (_voucherImageOne == nil) {
        _voucherImageOne = [[UIImageView alloc] init];
        [self.scrollView addSubview:_voucherImageOne];
        [_voucherImageOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.submitVoucher.mas_right).offset(10);
            make.top.equalTo(self.submitVoucher.mas_top).offset(0);
             make.width.equalTo(@(60));
            make.height.equalTo(@(60));
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageHindel:)];
        _voucherImageOne.userInteractionEnabled = YES;
        [_voucherImageOne addGestureRecognizer:tap];
    }
    return _voucherImageOne;
}
- (UIImageView *)voucherImageTwo{
    if (_voucherImageTwo == nil) {
        _voucherImageTwo = [[UIImageView alloc] init];
        [self.scrollView addSubview:_voucherImageTwo];
        [_voucherImageTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.voucherImageOne.mas_right).offset(5);
            make.top.equalTo(self.submitVoucher.mas_top).offset(0);
             make.width.equalTo(@(60));
            make.height.equalTo(@(60));
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageHindel:)];
        _voucherImageTwo.userInteractionEnabled = YES;
        [_voucherImageTwo addGestureRecognizer:tap];
        
    }
    return _voucherImageTwo;
}
- (UIImageView *)voucherImageThree{
    if (_voucherImageThree== nil) {
        _voucherImageThree = [[UIImageView alloc] init];
        [self.scrollView addSubview:_voucherImageThree];
        [_voucherImageThree mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.submitVoucher.mas_top).offset(0);
            make.left.equalTo(self.voucherImageTwo.mas_right).offset(5);
             make.width.equalTo(@(60));
            make.height.equalTo(@(60));
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageHindel:)];
        _voucherImageThree.userInteractionEnabled = YES;
        [_voucherImageThree addGestureRecognizer:tap];
        
    }
    return _voucherImageThree;
}


#pragma mark -- 上传的图片点击不上传
- (void)imageHindel:(UITapGestureRecognizer *)tap{
    UIImageView *imageView = (UIImageView *)tap.view;
    imageView.image = nil;
    
}
- (ActionBaseView *)submitVoucher{
    if (_submitVoucher == nil) {
        _submitVoucher = [[ActionBaseView alloc] init];
        [self.scrollView addSubview:_submitVoucher];
        [_submitVoucher addTarget:self action:@selector(submitVoucher:) forControlEvents:UIControlEventTouchUpInside];
        _submitVoucher.backgroundColor = [UIColor lightGrayColor];
        UIImageView *subImage = [[UIImageView alloc] init];
        [_submitVoucher addSubview:subImage];
        [subImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_submitVoucher);
            make.top.equalTo(_submitVoucher.mas_top).offset(10);
             make.width.equalTo(@(20));
            make.height.equalTo(@(20));
            
        }];
        subImage.image = [UIImage imageNamed:@"bg_coupon"];
        
        UILabel *subLabel = [[UILabel alloc] init];
        [_submitVoucher addSubview:subLabel];
        [subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(subImage.mas_bottom).offset(2);
            make.centerX.equalTo(_submitVoucher);
        }];
        [subLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor lightTextColor] backColor:[UIColor clearColor] textAligement:1 cornerRadius:0 text:@"上传凭证"];
        [subLabel sizeToFit];
        UILabel *sublabelTwo = [[UILabel alloc] init];
        [_submitVoucher addSubview:sublabelTwo];
        [sublabelTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(subLabel.mas_bottom).offset(2);
            make.centerX.equalTo(_submitVoucher);
        }];
        [sublabelTwo configmentfont:[UIFont systemFontOfSize:12] textColor:[UIColor lightTextColor] backColor:[UIColor clearColor] textAligement:1 cornerRadius:0 text:@"(最多三张)"];
        [sublabelTwo sizeToFit];
        
    }
    return _submitVoucher;
}




#pragma mark -- 上传凭证
- (void)submitVoucher:(ActionBaseView *)submitVoucher{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"上传凭证")

    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *actionCamoar = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ((self.voucherImageOne.image != nil)&&(self.voucherImageTwo.image != nil) && (self.voucherImageThree.image  != nil)) {
            LOG(@"%@,%d,%@",[self class], __LINE__,@"最多上传三张照片")
            return;
        }
        //弹出系统相册
        UIImagePickerController *imagepikerVC = [[UIImagePickerController alloc] init];
        //设置照片来源
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagepikerVC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            imagepikerVC.delegate = self;
            [self presentViewController:imagepikerVC animated:YES completion:nil];
        }else{
            LOG(@"%@,%d,%@",[self class], __LINE__,@"摄像头不可用")
        }
    }];
    UIAlertAction *actionAlum = [UIAlertAction actionWithTitle:@"我的相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ((self.voucherImageOne.image != nil)&&(self.voucherImageTwo.image != nil) && (self.voucherImageThree.image  != nil)) {
            LOG(@"%@,%d,%@",[self class], __LINE__,@"最多上传三张照片")
            return;
        }
        //弹出系统相册
        UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc] init];
        //设置照片来源
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        imagePickerVC.delegate = self;
        [self presentViewController:imagePickerVC animated:YES completion:nil];
    }];
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:actionCamoar];
    [alertVC addAction:actionAlum];
    [alertVC addAction:actionCancel];
    
    [self presentViewController:alertVC animated:YES completion:^{
        
    }];
    
    
}
#pragma mark - UIImagePickerControllerDelegate返回图片
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *photo = info[UIImagePickerControllerOriginalImage];
    
    if ((self.voucherImageOne.image != nil)&&(self.voucherImageTwo.image != nil) && (self.voucherImageThree.image  == nil)) {
        self.voucherImageThree.image = photo;
    }
    if ((self.voucherImageOne.image != nil)&& (self.voucherImageTwo.image == nil )){
        self.voucherImageTwo.image = photo;
    }
    if (self.voucherImageOne.image == nil) {
        self.voucherImageOne.image = photo;
    }
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



#pragma mark -- 提交申请UI
- (UILabel *)submitApplicationLabel{
    if (_submitApplicationLabel == nil) {
        _submitApplicationLabel = [[UILabel alloc] init];
        [self.scrollView addSubview:_submitApplicationLabel];
        [_submitApplicationLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor whiteColor] backColor:[UIColor redColor] textAligement:1 cornerRadius:0 text:@"提交申请"];
        UITapGestureRecognizer *submitTap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(submitapplicationAction:)];
        _submitApplicationLabel.userInteractionEnabled = YES;
        [_submitApplicationLabel addGestureRecognizer:submitTap];
    }
    return _submitApplicationLabel;
}
#pragma mark -- 提交申请
- (void)submitapplicationAction:(UITapGestureRecognizer *)submit{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"提交申请")
    //跳转到订单详情页面
    [self.navigationController popToRootViewControllerAnimated:NO];
}


- (UILabel *)limitLabel{
    if (_limitLabel == nil) {
        _limitLabel = [[UILabel alloc] init];
        [self.refundInstructions addSubview:_limitLabel];
        [_limitLabel configmentfont:[UIFont systemFontOfSize:13] textColor:[UIColor blackColor] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@"200"];
        [_limitLabel sizeToFit];
    }
    return _limitLabel;
}

- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.startY, screenW, screenH - self.startY)];
        _scrollView.scrollEnabled = YES;
        _scrollView.backgroundColor = [UIColor greenColor];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(screenW, screenH - self.startY + 0.5);
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}




- (ActionBaseView *)applicateView{
    if (_applicateView == nil) {
        _applicateView = [[ActionBaseView alloc] init];
        _applicateView.backgroundColor = BackgroundGray;
        [self.scrollView addSubview:_applicateView];
        UILabel *applicateKey = [[UILabel alloc] init];
        [_applicateView addSubview:applicateKey];
        [applicateKey mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.applicateView.mas_left).offset(0);
            make.top.bottom.equalTo(_applicateView);
            make.width.equalTo(@(80));
        }];
        [applicateKey configmentfont:[UIFont systemFontOfSize:13] textColor:[UIColor lightGrayColor] backColor:[UIColor clearColor] textAligement:2 cornerRadius:0 text:@"申请服务:"];
        
        UIImageView *arrowImage = [[UIImageView alloc] init];
        [_applicateView addSubview:arrowImage];
        [arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_applicateView);
            make.right.equalTo(_applicateView.mas_right).offset(-10);
             make.width.equalTo(@(20));
            make.height.equalTo(@(20));
        }];
        arrowImage.image = [UIImage imageNamed:@"bg_collocation"];
        
        
        [self.refundStyleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.applicateView);
            make.left.equalTo(applicateKey.mas_right).offset(10);
            make.right.equalTo(arrowImage.mas_left).offset(0);
        }];
        [self.refundStyleLable configmentfont:[UIFont systemFontOfSize:13] textColor:[UIColor blackColor] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@"退货退款"];
        
        [_applicateView addTarget:self action:@selector(selectAppliance:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _applicateView;
}
- (void)selectAppliance:(ActionBaseView *)actionView{
    self.actonView = actionView;
    self.refundReasonArr = @[@"退货",@"退款"];
    [self addPickerView];
}



- (ActionBaseView *)refundReason{
    if (_refundReason == nil) {
        _refundReason = [[ActionBaseView alloc] init];
        _refundReason.backgroundColor = BackgroundGray;
        [self.scrollView addSubview:_refundReason];
        UILabel *reasonKey = [[UILabel alloc] init];
        [_refundReason addSubview:reasonKey];
        [reasonKey mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.applicateView.mas_left).offset(0);
            make.top.bottom.equalTo(_refundReason);
            make.width.equalTo(@(80));
        }];
        [reasonKey configmentfont:[UIFont systemFontOfSize:13] textColor:[UIColor lightGrayColor] backColor:[UIColor clearColor] textAligement:2 cornerRadius:0 text:@"退货原因:"];
        UIImageView *arrowImage = [[UIImageView alloc] init];
        [_refundReason addSubview:arrowImage];
        [arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_refundReason);
            make.right.equalTo(_refundReason.mas_right).offset(-10);
            make.width.equalTo(@(20));
            make.height.equalTo(@(20));
        }];
        arrowImage.image = [UIImage imageNamed:@"bg_collocation"];
        
        
        [self.refundReasonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(_refundReason);
            make.left.equalTo(reasonKey.mas_right).offset(10);
            make.right.equalTo(arrowImage.mas_left).offset(0);
        }];
        [self.refundReasonLabel configmentfont:[UIFont systemFontOfSize:13] textColor:[UIColor blackColor] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@"请选择退货原因"];
        
        [_refundReason addTarget:self action:@selector(selectRefundReason:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _refundReason;
}
//- (NSArray *)refundReasonArr{
//    if (_refundReasonArr == nil) {
//        _refundReasonArr = @[@"请选择退款原因",@"拍错了",@"不想要了",@"描述与真实情况不相符"];
//        
//    }
//    return _refundReasonArr;
//}
#pragma mark -- 选择退款原因
- (void)selectRefundReason:(ActionBaseView *)actionView{
    self.actonView = actionView;
    self.refundReasonArr =  @[@"请选择退货原因",@"不想要了",@"卖家发货太慢",@"不好看"];
    [self addPickerView];
}
- (void)addPickerView{
    UIView *corver = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenH - self.startY)];
    [self.view addSubview:corver];
    self.corver = corver;
    corver.backgroundColor=[UIColor colorWithWhite:0.5 alpha:0.5];
    CGFloat containerW = screenW;
    CGFloat containerH = screenH/2;
    UIView * container = [[UIView alloc]initWithFrame:CGRectMake(0, containerH, containerW, containerH)];
    container.backgroundColor=[UIColor whiteColor];
    [corver addSubview:container];
    
    CGFloat sureW = 44;
    CGFloat sureH = 22;
    CGFloat topMargin = 10 ;
    CGFloat rightMargin = 2*topMargin;
    UIButton * sureButton = [[UIButton alloc]initWithFrame:CGRectMake( container.bounds.size.width-rightMargin-sureW,topMargin, sureW, sureH)];
    [sureButton setTitle:@"完成" forState:UIControlStateNormal];
    [sureButton.titleLabel setTextColor:[UIColor darkGrayColor]];
    [sureButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    sureButton.layer.borderWidth=1;
    [sureButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    sureButton.layer.borderColor=[UIColor darkGrayColor].CGColor;
    sureButton.layer.cornerRadius=3;
    sureButton.layer.masksToBounds=YES;
    [container addSubview:sureButton];
    [sureButton addTarget:self action:@selector(selectRufundReasonEnd:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIPickerView * picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, topMargin+sureH, container.bounds.size.width, container.bounds.size.height-topMargin-sureH)];
    picker.backgroundColor = BackgroundGray;
    [container addSubview:picker];
    picker.delegate=self;
    picker.dataSource=self;
}
#pragma mark UIPickerView的代理方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.refundReasonArr.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.refundReasonArr[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.choese = self.refundReasonArr[row];
}
/**选择退货退款原因完成*/
- (void)selectRufundReasonEnd:(UIButton *)btn{
    if (self.choese.length == 0) {
        if (self.actonView == self.applicateView) {
            self.refundStyleLable.text = self.refundReasonArr[0];
        }else{
            self.refundReasonLabel.text = self.refundReasonArr[0];
        }
        
    }else{
        if (self.actonView == self.applicateView) {
            self.refundStyleLable.text = self.choese;
        }else{
            self.refundReasonLabel.text = self.choese;
        }
        
    }
    
    [self.corver removeFromSuperview];
    self.corver = nil;
    self.actonView = nil;
}

- (ActionBaseView *)refundPrice{
    if (_refundPrice == nil) {
        _refundPrice = [[ActionBaseView alloc] init];
        _refundPrice.backgroundColor = BackgroundGray;
        [self.scrollView addSubview:_refundPrice];
        UILabel *priceKey = [[UILabel alloc] init];
        [_refundPrice addSubview:priceKey];
        [priceKey mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.applicateView.mas_left).offset(0);
            make.top.bottom.equalTo(_refundPrice);
            make.width.equalTo(@(80));
        }];
        [priceKey configmentfont:[UIFont systemFontOfSize:13] textColor:[UIColor lightGrayColor] backColor:[UIColor clearColor] textAligement:2 cornerRadius:0 text:@"退货金额:"];
        [self.refundPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(_refundPrice);
            make.left.equalTo(priceKey.mas_right).offset(10);
        }];
        [self.refundPriceLabel configmentfont:[UIFont systemFontOfSize:13] textColor:[UIColor blackColor] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@"$99.00"];
    }
    return _refundPrice;
}

- (UIView *)refundInstructions{
    if (_refundInstructions == nil) {
        _refundInstructions = [[UIView alloc] init];
        _refundInstructions.backgroundColor = BackgroundGray;
        [self.scrollView addSubview:_refundInstructions];
        UILabel *instructionKey = [[UILabel alloc] init];
        [_refundInstructions addSubview:instructionKey];
        [instructionKey mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_refundInstructions.mas_left).offset(0);
            make.top.equalTo(_refundInstructions.mas_top).offset(0);
            make.height.equalTo(@(40));
            make.width.equalTo(@(80));
        }];
        _idLabel = instructionKey;
        [instructionKey configmentfont:[UIFont systemFontOfSize:13] textColor:[UIColor lightGrayColor] backColor:[UIColor clearColor] textAligement:2 cornerRadius:0 text:@"退款说明:"];
        [self.refundInstructView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(_refundInstructions);
            make.left.equalTo(instructionKey.mas_right).offset(10);
            make.right.equalTo(_refundInstructions.mas_right).offset(0);
        }];
        self.refundInstructView.font = [UIFont systemFontOfSize:13];
        
        self.refundInstructView.textAlignment = NSTextAlignmentNatural;
      
        self.refundInstructView.delegate = self;
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, 40)];
        topView.backgroundColor =BackgroundGray;
        self.refundInstructView.inputAccessoryView = topView;
        //完成按钮
        UIButton *endBtn = [[UIButton alloc] init];
        endBtn.backgroundColor = [UIColor redColor];
        [endBtn setTitle:@"完成" forState:UIControlStateNormal];
        endBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [endBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [endBtn addTarget:self action:@selector(endBtn:) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:endBtn];
        [endBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(topView);
            make.right.equalTo(topView).offset(-20);
             make.width.equalTo(@(60));
            make.height.equalTo(@(30));
        }];
        endBtn.layer.masksToBounds = YES;
        endBtn.layer.cornerRadius = 6;
        [self addalabel];
        //文字居中显示
        
        
        
        
        
        
        
    }
    return _refundInstructions;
}

#pragma mark -- 添加palceholder
- (void)addalabel{
    [_refundInstructions addSubview:self.refundLimit];
    [self.refundLimit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(_refundInstructions);
        make.left.equalTo(_idLabel.mas_right).offset(10);
    }];
}
#pragma mark -- 隐藏palceholedr
- (void)hindleLabel{
    [self.refundLimit removeFromSuperview];
}
#pragma mark -- 完成按钮，点击键盘消失
- (void)endBtn:(UIButton *)btn{
    [self.refundInstructView resignFirstResponder];
}


- (UILabel *)refundStyleLable{
    if (_refundStyleLable == nil) {
        _refundStyleLable = [[UILabel alloc] init];
        [self.applicateView addSubview:_refundStyleLable];
    }
    return _refundStyleLable;
}
- (UILabel *)refundReasonLabel{
    if (_refundReasonLabel == nil) {
        _refundReasonLabel = [[UILabel alloc] init];
        [self.refundReason addSubview:_refundReasonLabel];
    }
    return _refundReasonLabel;
}
- (UILabel *)refundPriceLabel{
    if (_refundPriceLabel == nil) {
        _refundPriceLabel = [[UILabel alloc] init];
        [self.refundPrice addSubview:_refundPriceLabel];
    }
    return _refundPriceLabel;
}
- (UITextView *)refundInstructView{
    if (_refundInstructView == nil) {
        _refundInstructView = [[UITextView alloc] init];
        [self.refundInstructions addSubview:_refundInstructView];
    }
    return _refundInstructView;
}

- (ActionBaseView *)uploadDocumentView{
    if (_uploadDocumentView == nil) {
        _uploadDocumentView = [[ActionBaseView alloc] init];
        [self.view addSubview:_uploadDocumentView];
    }
    return _uploadDocumentView;
}

- (UILabel *)refundLimit{
    if (_refundLimit== nil) {
        _refundLimit = [[UILabel alloc] init];
        [_refundLimit configmentfont:[UIFont systemFontOfSize:13] textColor:[UIColor blackColor] backColor:[UIColor lightGrayColor] textAligement:0 cornerRadius:0 text:@"请输入退款说明"];
        _refundLimit.backgroundColor = BackgroundGray;
        
    }
    return _refundLimit;
}




#pragma mark -- 初始话
- (instancetype)initWithModel:(OrderDetailModel *)orderDetailModel{
    self = [super init];
    if (self) {
        _orderDetailModel = orderDetailModel;
        
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    switch (_orderDetailModel.refundState) {
        case refundStateRefundReturn:
        {
            self.naviTitle = @"选择退货退款";
            [self configmentRefundReturnUI];
            
        }
            break;
        case refundStateOnlyRefund:
        {
            self.naviTitle = @"选择退款";
            [self configmentRefundReturnUI];
        }
            break;
        default:
            break;
    }
    // Do any additional setup after loading the view.
}

#pragma mark -- 搭建界面UI
- (void)configmentRefundReturnUI{
    self.applicateView.frame =  CGRectMake(0, 10, screenW, 40);
    self.refundReason.frame = CGRectMake(0, self.applicateView.frame.origin.y + self.applicateView.frame.size.height +10, screenW, 40);
    self.refundPrice.frame = CGRectMake(0, self.refundReason.frame.origin.y + self.refundReason.frame.size.height + 10, screenW, 40);
    self.refundInstructions.frame = CGRectMake(0, self.refundPrice.frame.origin.y + self.refundPrice.frame.size.height + 10, screenW, 40);
    
    [self.submitVoucher mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView.mas_left).offset(20);
        make.top.equalTo(self.refundInstructions.mas_bottom).offset(20);
         make.width.equalTo(@(80));
        make.height.equalTo(@(80));
    }];
    self.submitApplicationLabel.frame = CGRectMake(0, self.scrollView.frame.size.height - 40, screenW, 40);
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboadWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboadWillHind:) name:UIKeyboardWillHideNotification object:nil];
    
}
#pragma mark -- 键盘将要弹出
- (void)keyboadWillShow:(NSNotification *)notification{
    NSDictionary *dic = [notification userInfo];
    CGSize keyboardSize = [[dic objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    LOG(@"%@,%d,%@",[self class], __LINE__,@"1")
    self.scrollView.frame = CGRectMake(0, self.startY, screenW, screenH - self.startY - keyboardSize.height);
    //scrollview需要滑动的距离
    CGFloat scrollHeight = self.refundInstructions.frame.origin.y - 10;
    self.scrollView.contentOffset = CGPointMake(0, scrollHeight);
    
    
    
}
#pragma mark -- 键盘将要隐藏
- (void)keyboadWillHind:(NSNotification *)notifictaion{

    self.scrollView.frame = CGRectMake(0, self.startY, screenW, screenH - self.startY);
    self.scrollView.contentOffset = CGPointMake(0, 0);
}
#pragma mark -- uitextfield的代理方法


-(void)textViewDidBeginEditing:(UITextView *)textView{
    [textView becomeFirstResponder];
    LOG(@"%@,%d,%@",[self class], __LINE__,@"2")
    [self hindleLabel];
    self.refundInstructions.frame = CGRectMake(0, self.refundPrice.frame.origin.y + self.refundPrice.frame.size.height + 10, screenW, 80);
    //添加限制文字
    [self.limitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.refundInstructions.mas_bottom).offset(-10);
        make.right.equalTo(self.refundInstructions.mas_right).offset(-10);
    }];
    self.limitLabel.hidden = NO;
    
    
}



- (void)textViewDidChange:(UITextView *)textView{
    
   self.limitLabel.text = [NSString stringWithFormat:@"%ld",200 - textView.text.length ];
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    
    if (textView.text.length == 0) {
        [self addalabel];
        self.refundInstructions.frame = CGRectMake(0, self.refundPrice.frame.origin.y + self.refundPrice.frame.size.height + 10, screenW, 40);
        [self addalabel];
        [self.limitLabel setHidden:YES];
    }
 
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if (textView.text.length > 200) {
        
        [textView resignFirstResponder];
        
    }
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        
        return NO;
    }
    
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
