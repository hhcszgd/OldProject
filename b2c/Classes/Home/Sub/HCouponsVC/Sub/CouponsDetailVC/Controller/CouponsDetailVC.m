//
//  CouponsDetailVC.m
//  b2c
//
//  Created by wangyuanfei on 16/5/6.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "CouponsDetailVC.h"
#import "CouponsDetailModel.h"

#import <QuartzCore/QuartzCore.h>

@interface CouponsDetailVC ()
/** 背景 */
@property(nonatomic,weak)UIView * backView ;
/** 优惠券图片 */
@property(nonatomic,weak)UIImageView * ticketImageView ;
/** 优惠券面额 */
@property(nonatomic,weak)UILabel * ticketPriceLabel ;
/** 优惠券使用条件 */
@property(nonatomic,weak)UILabel * ticketLimtLabel ;
/** 优惠券所属店铺 */
@property(nonatomic,weak)UILabel * shopNameLabel ;
/** 优惠券使用使用时间提示 */
@property(nonatomic,weak)UILabel * useTimeKeyLabel ;
/** 优惠券使用时间 */
@property(nonatomic,weak)UILabel * useTimeValueLabel ;
/** 间隔线 */
@property(nonatomic,weak)UIImageView * composeLine ;

/** 立即领取按钮 , 如果已被领取就显示立即使用 , 并跳转到所属店铺 */
@property(nonatomic,weak)UIButton * gotSoonButton ;
/** 当前优惠券使用情况 , 已有多少人领取 ,  还剩余多少张 */
@property(nonatomic,weak)UILabel * usedStateLabel ;

@property(nonatomic,weak)  UILabel * descrip  ;

@property(nonatomic,weak)UIScrollView * descripsContainer ;

/** 中间虚线 */
@property(nonatomic,weak)CAShapeLayer * midLine ;
@end

@implementation CouponsDetailVC

-(instancetype)initWithCouponsID:(NSString*)couponsID{
    if (self=[super init]) {
        self.couponsID = couponsID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
#pragma mark 控制器初始化时所需参数
    if (!self.couponsID) {
        self.couponsID = self.keyParamete[@"paramete"];
    }
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BackgroundGray;
//    NSUInteger chuanGuoLaiDeID = 3 ;
    [self addCouPonsVCSubviews];
    [self gotCouponsDetailDataWithCouponsID:[self.couponsID integerValue] actionType:0 Success:^(ResponseObject *responseObject) {
        
        CouponsDetailModel * model = [[CouponsDetailModel alloc]initWithDict:responseObject.data];
        self.couponsDetailModel = model;
        
        [self setgotButtonEnable];
        [self dontTaiSheZhiShuoMingWithArr:model.discription];
        [self setsubviewsFrame];
        
    } failure:^(NSError *error) {
        [self showTheViewWhenDisconnectWithFrame:CGRectMake(0, self.startY, self.view.bounds.size.width, self.view.bounds.size.height-self.startY)];
    }];
}
-(void)setgotButtonEnable
{
    if (self.couponsDetailModel.take) {
            self.gotSoonButton.enabled = YES;
            [self.gotSoonButton  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.gotSoonButton setTitle:@"立即使用" forState:UIControlStateNormal];
        
    }else{
        if ([self.couponsDetailModel.leftCount  isEqualToString:@"0"]) {
            self.gotSoonButton.enabled = NO;
            [self.gotSoonButton  setTitleColor:SubTextColor forState:UIControlStateNormal];
            [self.gotSoonButton setTitle:@"立即领取" forState:UIControlStateNormal];
        }else{
            
            self.gotSoonButton.enabled = YES;
            [self.gotSoonButton  setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [self.gotSoonButton setTitle:@"立即领取" forState:UIControlStateNormal];
        }
    }
}
/** 1添加控件(跟布局分离) */
-(void)addCouPonsVCSubviews
{
    CGRect  backViewFrame   =   CGRectMake(0, self.startY, self.view.bounds.size.width, self.view.bounds.size.width/2);
    UIView * backView = [[UIView alloc]initWithFrame:backViewFrame];
    self.backView = backView;
    self.backView.backgroundColor = [UIColor colorWithHexString:@"56c2fe"];
    [self.view addSubview:backView];
//    ///////////////画虚线////////////
//    CALayer * layer = [self gotlayerWithSize:CGSizeMake(backView.bounds.size.width, 5) ] ;
//    layer.position = CGPointMake(backView.bounds.size.width/2  , CGRectGetMaxY(self.backView.frame) );//backView.bounds.size.height);//相当于center
//    [self.view.layer addSublayer:layer];//在立即领取后天添加 , 好放在立即领取上面
    
     UIImageView * ticketImageView = [[UIImageView alloc]init];
    self.ticketImageView = ticketImageView;
    ticketImageView.backgroundColor = [UIColor whiteColor];
    [self.backView addSubview:ticketImageView];
    /** 优惠券面额 */
     UILabel * ticketPriceLabel = [[UILabel alloc]init] ;
    self.ticketPriceLabel = ticketPriceLabel ;
    self.ticketPriceLabel.font = [UIFont boldSystemFontOfSize:30*SCALE];
    [self.backView addSubview:self.ticketPriceLabel];
    self.ticketPriceLabel.textColor = [UIColor whiteColor];
    
    /** 优惠券使用条件 */
     UILabel * ticketLimtLabel = [[UILabel alloc]init];
    self.ticketLimtLabel = ticketLimtLabel;
    [self.backView addSubview:self.ticketLimtLabel];
    
    
    /** 优惠券所属店铺 */
     UILabel * shopNameLabel = [[UILabel alloc]init];
    self.shopNameLabel = shopNameLabel;
    [self.backView addSubview:shopNameLabel];
    self.shopNameLabel.font = [UIFont boldSystemFontOfSize:14];
    self.shopNameLabel.textColor = [UIColor whiteColor];

    /** 优惠券使用使用时间提示 */
     UILabel * useTimeKeyLabel = [[UILabel alloc]init];
    self.useTimeKeyLabel = useTimeKeyLabel;
    useTimeKeyLabel.text = @"使用时间";
    useTimeKeyLabel.textColor = [UIColor whiteColor];
    useTimeKeyLabel.font = [UIFont systemFontOfSize:11*SCALE];
    [backView addSubview:useTimeKeyLabel];
    /** 优惠券使用时间 */
     UILabel * useTimeValueLabel = [[UILabel alloc]init];
    useTimeKeyLabel.font = [UIFont systemFontOfSize:14*SCALE];
    useTimeValueLabel.textColor=[UIColor whiteColor];
    self.useTimeValueLabel = useTimeValueLabel;
    [backView addSubview:useTimeValueLabel];
    
    UIImageView * composeLine = [[UIImageView alloc] init];
    [self.view addSubview:composeLine];
    self.composeLine = composeLine;
    
    /** 立即领取按钮 , 如果已被领取就显示立即使用 , 并跳转到所属店铺 */
     UIButton * gotSoonButton = [[UIButton alloc]init];
    self.gotSoonButton = gotSoonButton;
    [gotSoonButton addTarget:self action:@selector(gotSoonButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//
    [gotSoonButton setTitle:@"立即领取" forState:UIControlStateNormal];
    [self.view addSubview:self.gotSoonButton];
    [self.gotSoonButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    /** 当前优惠券使用情况 , 已有多少人领取 ,  还剩余多少张 */
     UILabel * usedStateLabel = [[UILabel alloc]init];
    self.usedStateLabel = usedStateLabel;
    usedStateLabel.textColor = MainTextColor;
    usedStateLabel.backgroundColor  = [UIColor whiteColor];
    [self.view addSubview:self.usedStateLabel];
//    self.usedStateLabel.text = @"    已有144人领取 , 剩余44张";
    UILabel * descrip =[[UILabel alloc]init];
    self.descrip = descrip;

    descrip.textColor = MainTextColor;
    [self.view addSubview:descrip];
    
    UIScrollView * descripsContainer = [[UIScrollView alloc]init];
    descripsContainer.showsVerticalScrollIndicator=NO;
    self.descripsContainer= descripsContainer;
    [self.view addSubview:descripsContainer];

    
    ///////////////画虚线////////////
//    CALayer * layer = [self gotlayerWithSize:CGSizeMake(backView.bounds.size.width, 5) ] ;
//    layer.position = CGPointMake(backView.bounds.size.width/2  , CGRectGetMaxY(self.backView.frame) );//backView.bounds.size.height);//相当于center
//    [self.view.layer addSublayer:layer];

//
//    CouponsDetailModel * model = [[CouponsDetailModel alloc]init];
//    self.couponsDetailModel = model;
//    [self dontTaiSheZhiShuoMingWithArr:model.discription];
//    [self setsubviewsFrame];
}


/** 2布局控件 */
-(void)setsubviewsFrame
{
    CGFloat toBorderMargin  =  10  ;
    CGFloat toImgTop = toBorderMargin*SCALE ;
    CGFloat toImgBttom = toImgTop;
    
    /** 优惠券图片 */
    
    CGFloat imgH = self.backView.bounds.size.height/5*3 ;
    CGFloat imgW = imgH ;
    CGFloat imgX = toBorderMargin ;
    CGFloat imgY = toBorderMargin ;
//    self.ticketImageView.image = [UIImage imageNamed:@"bg_female baby"];
    self.ticketImageView.frame = CGRectMake(imgX, imgY , imgW,imgH);
    self.ticketImageView.layer.cornerRadius = 5 ;
    self.ticketImageView.layer.masksToBounds = YES;
    
    /** 优惠券面额 */

//    self.ticketPriceLabel.text  =  @"¥50";
    CGSize ticketLimtLabelSize = [@"dd" sizeWithFont:self.ticketPriceLabel.font MaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGRect PriceLabelFrame = CGRectMake(CGRectGetMaxX(self.ticketImageView.frame)+toBorderMargin, CGRectGetMinY(self.ticketImageView.frame)+toImgTop, self.view.bounds.size.width - CGRectGetMaxX(self.ticketImageView.frame), ticketLimtLabelSize.height);
    self.ticketPriceLabel.frame = PriceLabelFrame;
    

    
    
    
    
    
    
    
//TODO//////////////////////
//    self.ticketLimtLabel.text = @"满100可用";
    self.ticketLimtLabel.textColor = [UIColor whiteColor];
    self.ticketLimtLabel.font = [UIFont boldSystemFontOfSize:14];
    CGSize LimtLabelSize = [@"dd" sizeWithFont:self.ticketLimtLabel.font MaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.ticketLimtLabel.frame = CGRectMake(self.ticketPriceLabel.frame.origin.x, CGRectGetMaxY(self.ticketImageView.frame)-toImgBttom- LimtLabelSize.height, self.ticketPriceLabel.bounds.size.width, LimtLabelSize.height);
    /** 店铺名称 */
//    self.shopNameLabel.text = @"卖火柴的小女孩";
    CGSize shopNameLabelSize = [@"dd" sizeWithFont:self.shopNameLabel.font MaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.shopNameLabel.frame = CGRectMake(self.ticketPriceLabel.frame.origin.x, CGRectGetMinY(self.ticketLimtLabel.frame)-    (CGRectGetMinY(self.ticketLimtLabel.frame) - CGRectGetMaxY(self.ticketPriceLabel.frame)) /2-shopNameLabelSize.height/2, self.ticketPriceLabel.bounds.size.width, shopNameLabelSize.height);


    
    
    /** 优惠券使用使用时间提示 */

    /** 优惠券使用时间 */
    CGSize usetimeValueZise = [self.useTimeValueLabel.text sizeWithFont:self.useTimeValueLabel.font MaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,self.useTimeValueLabel.text);
    self.useTimeValueLabel.frame = CGRectMake(10, self.backView.bounds.size.height-usetimeValueZise.height - 5*SCALE, self.backView.bounds.size.width - 10*2, usetimeValueZise.height);
    
    
    
    
    /** 优惠券使用条件提示label */
    
    
    CGSize useTimeKeyLabelSize = [self.useTimeKeyLabel.text sizeWithFont:self.useTimeKeyLabel.font MaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat useTimeKeyLabelW = self.backView.bounds.size.width-toBorderMargin*2 ;
    CGFloat useTimeKeyLabelH = useTimeKeyLabelSize.height ;
    CGFloat useTimeKeyLabelX = CGRectGetMinX(self.useTimeValueLabel.frame) ;
    CGFloat useTimeKeyLabelY = CGRectGetMinY(self.useTimeValueLabel.frame) - useTimeKeyLabelSize.height ;
    
    self.useTimeKeyLabel.frame = CGRectMake(useTimeKeyLabelX, useTimeKeyLabelY, useTimeKeyLabelW, useTimeKeyLabelH);
    
    
    self.composeLine.image = [UIImage imageNamed:@"conposeline"];
    self.composeLine.frame =  CGRectMake(0, CGRectGetMaxY(self.backView.frame) + 6, self.view.bounds.size.width, 6);
    
    /** 领取按钮 */
      self.gotSoonButton.frame = CGRectMake(0, CGRectGetMaxY(self.composeLine.frame) + 8, self.view.bounds.size.width, 60*SCALE);
    
    /** 当前优惠券使用情况 , 已有多少人领取 ,  还剩余多少张 */
    CGFloat margin = 20*SCALE ;
    self.usedStateLabel.frame  =CGRectMake(0, CGRectGetMaxY(self.gotSoonButton.frame)+margin , self.view.bounds.size.width, 44*SCALE);
    
    self.descrip.frame = CGRectMake(0, CGRectGetMaxY(self.usedStateLabel.frame) , self.view.bounds.size.width, 44*SCALE);
    self.descrip.text = @"    说明:";
    
    self.descripsContainer.frame = CGRectMake(20, CGRectGetMaxY(self.descrip.frame), self.view.bounds.size.width-20-10, self.view.bounds.size.height - CGRectGetMaxY(self.descrip.frame)-margin);
    
    /** 布局中间虚线*/
//    [self.midLine removeFromSuperlayer];
//    self.midLine = nil;
//    CAShapeLayer  * midLine = [self gotlayerWithSize:CGSizeMake(self.backView.bounds.size.width - 2*toBorderMargin, 2)];
//    midLine.position = CGPointMake(self.backView.bounds.size.width/2, CGRectGetMaxY(self.ticketImageView.frame)+toBorderMargin);
//    [self.backView.layer addSublayer:midLine];
//    self.midLine = midLine;
    
    
    
//    
//    
//    CouponsDetailModel * model = [[CouponsDetailModel alloc]init];
//    self.couponsDetailModel = model;
//    [self dontTaiSheZhiShuoMingWithArr:model.useDescrips];
    

}

/** 3动态布局优惠券说明 */
-(void)dontTaiSheZhiShuoMingWithArr:(NSArray*)arr
{
    
    
    for (UIView*sub in self.descripsContainer.subviews) {
        if ([sub isKindOfClass:[UILabel class]]) {
            [sub removeFromSuperview];
        }
    }
    CGFloat maxY = 3 ;
    CGFloat margin = 5 ;
    for (int i = 0 ; i  < arr.count ; i++) {
        NSString*subStr=arr[i];
//        subStr = [subStr stringByAppendingString:@"测试是事实和四十是四十岁试是事实和四十是四十岁试是事实和四十是四十岁试是事实和四十是四十岁试是事实和四十是四十岁试是事实和四十是四十岁"];
        
        CGSize  size = [subStr sizeWithFont:[UIFont systemFontOfSize:12] MaxSize:CGSizeMake(self.descripsContainer.bounds.size.width-20, MAXFLOAT)];
        CGRect frame = CGRectMake(20, maxY, self.descripsContainer.bounds.size.width-20, size.height);
        [self creatLabelWithIndex:i andTitle:subStr frame:frame];
        maxY+=(size.height+margin);
    }
    self.descripsContainer.contentSize = CGSizeMake(self.descripsContainer.bounds.size.width, maxY);
}
/** 4抽取创建说明label */
-(void)creatLabelWithIndex:(NSUInteger)index andTitle:(NSString*)title frame:(CGRect)frame
{
    LOG(@"_%@_%d_使用对象标题%@",[self class] , __LINE__,title);
    UILabel * descrip =[[UILabel alloc]initWithFrame:frame];
    //NSParagraphStyle

    descrip.numberOfLines=0;
//    descrip.text = [NSString stringWithFormat:@"%ld.%@",index+1,title];
    descrip.text = [NSString stringWithFormat:@"%@",title];
    descrip.textColor = MainTextColor;
    descrip.font = [UIFont systemFontOfSize:12];
    [self.descripsContainer addSubview:descrip];
    descrip.textColor = SubTextColor;
    
//    NSMutableParagraphStyle*paragraph = [[NSMutableParagraphStyle alloc]init];
//    paragraph.alignment=NSTextAlignmentJustified;
//    paragraph.firstLineHeadIndent=20.0;
//    paragraph.paragraphSpacingBefore=10.0;
//    paragraph.lineSpacing=5;
//    paragraph.hyphenationFactor=1.0;
//    NSDictionary*attributes4 =@{/*NSForegroundColorAttributeName: [UIColor redColor],*/
//                                NSParagraphStyleAttributeName: paragraph};
//    
//    NSAttributedString*attributedText4 = [[NSAttributedString alloc]initWithString: descrip.text attributes:attributes4];
//    descrip.attributedText= attributedText4;
    
    
}



-(void)gotSoonButtonClick:(UIButton*)sender
{
    
    
    if (self.couponsDetailModel.take) {
            //调到店铺页
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"立即使用")
        BaseModel * targetShopModel = [[BaseModel alloc]init];
        targetShopModel.keyParamete = @{@"paramete":self.couponsDetailModel.shopID};
        targetShopModel.actionKey = @"HShopVC";
        [ [SkipManager shareSkipManager] skipByVC:self withActionModel:targetShopModel];
        
    }else{
            //执行领取操作 , 并与服务器交互 self.model.take=yes;
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"立即领取")
        self.couponsDetailModel.judge = YES;
        if ([UserInfo shareUserInfo].isLogin) {//登录情况直接领取
            
            [[UserInfo shareUserInfo] gotCouponsWithCouponsID:self.couponsID  success:^(ResponseObject *responseObject) {
                LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data)
                
                if (responseObject.status>0) {
                    
                    CouponsDetailModel * tempModel = self.couponsDetailModel;
                    tempModel.take = YES;
                    self.couponsDetailModel=tempModel;
                    ///////////////
                    [self gotCouponsDetailDataWithCouponsID:[self.couponsID integerValue] actionType:0 Success:^(ResponseObject *responseObject) {
                        
                        CouponsDetailModel * model = [[CouponsDetailModel alloc]initWithDict:responseObject.data];
                        self.couponsDetailModel = model;
                        [self dontTaiSheZhiShuoMingWithArr:model.discription];
                        [self setsubviewsFrame];
                        
                        
                    } failure:^(NSError *error) {
                        [self showTheViewWhenDisconnectWithFrame:CGRectMake(0, self.startY, self.view.bounds.size.width, self.view.bounds.size.height-self.startY)];
                    }];

                }else{
                    if ([responseObject.data isKindOfClass:[NSString class]] && [responseObject.data  isEqualToString:@"havenotcoupons"] && self.couponsDetailModel.take==NO) {
                        self.gotSoonButton.enabled = NO ;
                        [self.gotSoonButton  setTitleColor:SubTextColor forState:UIControlStateNormal];
                    }else if ([responseObject.data isKindOfClass:[NSString class]] && [responseObject.data  isEqualToString:@"havenotcoupons"] && self.couponsDetailModel.take==YES){
                        self.gotSoonButton.enabled = YES ;
                        [self.gotSoonButton  setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                    }
                     AlertInVC(@"优惠券领取完毕");//优惠券领取完毕
                }
               
                /////////////////
//                AlertInVC(@"领取成功");
//                cell.couponModel=model;
            } failure:^(NSError *error) {
                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"领取失败")
                AlertInVC(@"领取失败")
            }];
        }else{//未登录情况 就先弹出登录界面
            [[SkipManager shareSkipManager] skipByVC:self withActionModel:self.couponsDetailModel];
//            [[SkipManager shareSkipManager] skipForLocalByVC:self withActionModel:self.couponsDetailModel];
            
        }
    }
}

-(void)reconnectClick:(UIButton *)sender
{
    [self removeTheViewWhenConnect];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}
-(void)gotCouponsDetailDataWithCouponsID:(NSUInteger)couponsID  actionType:(LoadDataActionType)actionType Success:(void(^)(ResponseObject *responseObject))success failure:(void(^)(NSError *error))failure
{
    LOG(@"_%@_%d_优惠券id%ld",[self class] , __LINE__,couponsID )

    [[UserInfo shareUserInfo] gotCouponsDetailDataWithCouponsID:couponsID success:^(ResponseObject *responseObject) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data)
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/*
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
/** 返回一条虚线 , size是虚线的宽高 */
-(CAShapeLayer*)gotlayerWithSize:(CGSize)size
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//    shapeLayer.backgroundColor = [UIColor redColor].CGColor;
    [shapeLayer setBounds:CGRectMake(0, 0, size.width, size.height)];
//    [shapeLayer setPosition:self.center];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    // 设置虚线颜色;
    [shapeLayer setStrokeColor:[[UIColor whiteColor] CGColor]];
    // 3.0f设置整条虚线的宽度
    [shapeLayer setLineJoin:kCALineJoinRound];
    // 两个参数分别是 每一小段线的宽度 间距
    // Setup the path
    CGMutablePathRef path = CGPathCreateMutable();
    shapeLayer.lineCap = @"round";
//    CGPathMoveToPoint(path, NULL, 0, 0);
    if (size.height >size.width) {
        [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:size.width],[NSNumber numberWithInt:size.width*2],nil]];
        [shapeLayer setLineWidth:size.width];
        CGPathMoveToPoint(path, NULL, size.width/2, 0);
        CGPathAddLineToPoint(path, NULL, size.width/2,size.height);
    }else{
        [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:size.height],[NSNumber numberWithInt:size.height*2],nil]];
        [shapeLayer setLineWidth:size.height];

        CGPathMoveToPoint(path, NULL, 0, size.height/2);
        CGPathAddLineToPoint(path, NULL, size.width,size.height/2);
    }
//    CGPathMoveToPoint(path, NULL, 0, 89);
//    CGPathAddLineToPoint(path, NULL, 320,89);
//     Setup the path CGMutablePathRef path = CGPathCreateMutable(); // 0,10代表初始坐标的x，y
    // 320,10代表初始坐标的x，y CGPathMoveToPoint(path, NULL, 0, 10);
//    CGPathAddLineToPoint(path, NULL, 320,10);
    
    [shapeLayer setPath:path]; 
    CGPathRelease(path);
    return shapeLayer;
}
-(void)setCouponsDetailModel:(CouponsDetailModel *)couponsDetailModel{
    _couponsDetailModel = couponsDetailModel;

    /** 优惠券图片 */
    [self.ticketImageView sd_setImageWithURL:ImageUrlWithString(couponsDetailModel.img)placeholderImage:placeImage options:SDWebImageCacheMemoryOnly];
    /** 优惠券面额 */
    
    NSString * showDiscountprice = [couponsDetailModel.discount_price convertToYuan];
    
    self.ticketPriceLabel.text = [NSString stringWithFormat:@"¥%@",showDiscountprice] ;
    /** 优惠券使用条件 */
    NSString * showFullprice = [couponsDetailModel.full_price convertToYuan];
    NSString * ticketLimtLabelStr = [NSString stringWithFormat:@"满%@可用",showFullprice];
    if (!couponsDetailModel.full_price) {
        couponsDetailModel.full_price=@"1亿";
    }
    if (!couponsDetailModel.discount_price) {
        couponsDetailModel.discount_price=@"0";
    }
    NSRange ticketLimtLabelRange = [ticketLimtLabelStr rangeOfString:couponsDetailModel.full_price];
    NSMutableAttributedString *ticketLimtAttributStr = [[NSMutableAttributedString alloc]initWithString:ticketLimtLabelStr];
    [ticketLimtAttributStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:22*SCALE] range:ticketLimtLabelRange];
    
    self.ticketLimtLabel.attributedText = ticketLimtAttributStr;
    /** 优惠券所属店铺 */
    self.shopNameLabel.text = couponsDetailModel.shop_name ;
    /** 优惠券使用时间 */
    
    NSString * startTime = [couponsDetailModel.start_time formatterDateString];
    NSString * endTime = [couponsDetailModel.end_time formatterDateString];
    
    self.useTimeValueLabel.text = [NSString stringWithFormat:@"%@-%@",startTime,endTime] ;
//    /** 立即领取按钮 , 如果已被领取就显示立即使用 , 并跳转到所属店铺 */
    if (couponsDetailModel.take) {
        [self.gotSoonButton setTitle:@"立即使用" forState:UIControlStateNormal];
        self.gotSoonButton.backgroundColor = [UIColor colorWithHexString:@"f47238"];
        [self.gotSoonButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];

        
    }else{
        [self.gotSoonButton setTitle:@"立即领取" forState:UIControlStateNormal];
        self.gotSoonButton.backgroundColor = [UIColor colorWithHexString:@"58c2ff"];
    }
    /** 当前优惠券使用情况 , 已有多少人领取 ,  还剩余多少张 */
    
    NSString * usedStateLabelStr = [NSString stringWithFormat:@"    已有%@人领取,剩余%@张",couponsDetailModel.number_rec,couponsDetailModel.leftCount];
    if (!couponsDetailModel.number) {
        couponsDetailModel.number=@"1亿";
    }
    if (!couponsDetailModel.number_rec) {
        couponsDetailModel.number_rec=@"1";
    }
    if (!couponsDetailModel.leftCount) {
        couponsDetailModel.leftCount=@"1";
    }
    NSRange alreadyRange = [usedStateLabelStr rangeOfString:couponsDetailModel.number_rec];
    NSRange leftRange = [usedStateLabelStr rangeOfString:couponsDetailModel.leftCount options:NSBackwardsSearch];
    NSMutableAttributedString *usedStateAttributStr = [[NSMutableAttributedString alloc]initWithString:usedStateLabelStr];
    [usedStateAttributStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:alreadyRange];
        [usedStateAttributStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:leftRange];
    self.usedStateLabel.attributedText = usedStateAttributStr;
    
    [self setsubviewsFrame];
    /**
     NSString *discountStr = [NSString stringWithFormat:@"满%@可用",    self.couponModel.full_price];
     NSMutableAttributedString *discountAttributStr = [[NSMutableAttributedString alloc]initWithString:discountStr];
     NSRange fullPriceRange = [discountStr rangeOfString:self.couponModel.full_price];
     //    LOG(@"_%@_%d_%@",[self class] , __LINE__,NSStringFromRange(fullPriceRange))
     //    NSString * targetStr = [discountStr substringFromIndex:1];
     //    NSRange rr = [contentStr rangeOfString:ss];
     //    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:rr];
     NSRange manRange = [discountStr rangeOfString:@"满"];
     NSRange keRange = [discountStr rangeOfString:@"可"];
     NSRange lastIntRange = NSMakeRange(keRange.location-1, 1);
     
     [discountAttributStr addAttribute:NSKernAttributeName
     value:@(3*SCALE)
     range:manRange];
     [discountAttributStr addAttribute:NSKernAttributeName
     value:@(3*SCALE)
     range:keRange];
     [discountAttributStr addAttribute:NSKernAttributeName//跟右边字符的间距
     value:@(5*SCALE)
     range:lastIntRange];
     
     [discountAttributStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12*SCALE] range:fullPriceRange];
     
     
     self.limit.attributedText = discountAttributStr;

     */
}

@end
