//
//  ConfirmOrderVC.m
//  b2c
//
//  Created by wangyuanfei on 16/4/21.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
/**
 返回数据 -> 支付配送 数组改成字典了 TODO
 */
#import "ConfirmOrderVC.h"
#import "SVCGoods.h"
#import "ConfirmOrderNormalCell.h"
#import "ConfirmOrderNormalCellModel.h"
#import "CONormalCompose.h"
#import "ConfirmOrderBar.h"
#import "PayTypeView.h"
#import "ShowgoodsesView.h"
#import "ConfirmOrderAddressView.h"
#import "InvoiceDetailVC.h"
#import "ChooseCounposeVC.h"
#import "ChooseLBVC.h"
#import "ChooseAddressVC.h"
#import "CCCouponsModel.h"
#import "AMCellModel.h"
#import "PayMentManager.h"
#import "GoodsInOrderVC.h"
#import "GDGDAlert.h"
@interface ConfirmOrderVC ()<ConfirmOrderBarDelegate,InvoiceDetailVCDelegate,ChooseCounposeVCDelegate,ChooseLBVCDelegate,ChooseAddressVCDelegate , UITextFieldDelegate>

@property(nonatomic,strong)NSMutableArray * subviewsContainer ;
@property(nonatomic,strong)NSMutableArray * datas ;
@property(nonatomic,weak)UIScrollView * subviewsContainerView ;
@property(nonatomic,assign)CGFloat  subviewsStartY ;
 //地址视图
@property(nonatomic,weak)ConfirmOrderAddressView * confirmOrderAddressView ;
/** 地址模型 */
@property(nonatomic,strong)AMCellModel * addressModel ;
// 展示商品视图
@property(nonatomic,weak)ShowgoodsesView * showgoodsesView ;
 //支付配送视图
@property(nonatomic,weak)PayTypeView * payType ;
//@property(nonatomic,strong)NSMutableArray * praviteGoodsIDs ;//(始终有值) goodsIDs也赋值给这个变量 , goodsid还要用来区分response和goodsids的
// CONormalCompose * invoiceInfo
// CONormalCompose * chooseCoupon
// CONormalCompose * LB
// CONormalCompose * goodsPrice
// CONormalCompose * freight
// CONormalCompose * discountResult
// ConfirmOrderBar * confirmOrderBar;


//发票信息视图
@property(nonatomic,weak)CONormalCompose * invoiceInfo ;
//优惠券视图

@property(nonatomic,weak)CONormalCompose * chooseCoupon ;
//L币视图
@property(nonatomic,weak)CONormalCompose * LB ;
//商品金额视图
@property(nonatomic,weak)CONormalCompose * goodsPrice ;
//运费视图
@property(nonatomic,weak)CONormalCompose * freight ;
//优惠券/ L币折扣信息
@property(nonatomic,weak)CONormalCompose * discountResult ;
//税费
@property(nonatomic,weak)CONormalCompose * taxes ;

//是否显示税费

@property(nonatomic,assign)BOOL  isTaxesDisplay ;
//结算栏
@property(nonatomic,weak)ConfirmOrderBar * confirmOrderBar ;
//结算栏最初的价格
@property(nonatomic,copy)NSString * originMoney ;


/** 选中的优惠券 */
@property(nonatomic,strong)NSMutableArray * choosedCoupons ;
/** 选中优惠券折算的金额 */
@property(nonatomic,assign)CGFloat  totalCouponsMoney ;
/** 使用的L币 */
@property(nonatomic,assign)NSUInteger  usedLB ;
/** 使用的优惠券总额 */
//@property(nonatomic,assign)NSUInteger usedTotalCouponseMoney ;
/** 是否开发票 */
@property(nonatomic,assign)BOOL  setInvoice ;

/** 测试回调 */
@property(nonatomic,strong) PayMentManager * manager ;
/** 当视图disappear时是否销毁当前控制器 */
@property(nonatomic,assign)BOOL  isNeedDestroy ;

/** 给除地址栏以外的视图一个容器视图 ,方便改变frame值 */
//@property(nonatomic,weak)UIView * bottomContainer ;
/** 收货地址的总高 */
@property(nonatomic,assign)CGFloat    addressTotalH ;




/** about idNumber operator */
@property(nonatomic,weak)UIButton * cancleBtn ;
@property(nonatomic,weak)UIButton * confirmBtn ;
@property(nonatomic,weak)UIButton * backEditBtn ;
@property(nonatomic,weak)UIButton * confirmCommitBtn ;
@property(nonatomic,weak) GDGDAlert * editIdNumView  ;
@property(nonatomic,weak) GDGDAlert * confirmIdNumView  ;
@property(nonatomic,strong)AMCellModel * tempAddressModel ;//海外购添加身份证时用于临时保存信息
@property(nonatomic,weak)UILabel * usernameTips ;
@property(nonatomic,weak)UILabel * idNumberTips ;
@property(nonatomic,weak)UITextField * usernameInput ;
@property(nonatomic,weak)UITextField * idNumberInput ;

@end
@implementation ConfirmOrderVC

-(void)setUsedLB:(NSUInteger)usedLB{
    _usedLB = usedLB;
    ConfirmOrderNormalCellModel * model  = self.discountResult.normalCellModel;

    if (usedLB>0) {
        if (self.choosedCoupons.count>0) {
            model.title = @"优惠: L币 / 优惠券";
            model.subtitle = [NSString stringWithFormat:@"-¥%.02lf",usedLB/1000.0+self.totalCouponsMoney];// 会加上优惠券的折扣金额
        }else{
            model.title = @"优惠:  L币";
            model.subtitle = [NSString stringWithFormat:@"-¥%.02lf",usedLB/1000.0]; // 会加上优惠券的折扣金额
        }
    }else{
    
        if (self.choosedCoupons.count>0) {
            model.title = @"优惠:  优惠券";
            model.subtitle = [NSString stringWithFormat:@"-¥%.02f",self.totalCouponsMoney];// 会加上优惠券的折扣金额
        }else{
            model.title = @"优惠:  无";
            model.subtitle = [NSString stringWithFormat:@"¥ 0.00"];
        }
    }
    
    self.discountResult.normalCellModel  = model;
//////////////////////////////////
    ConfirmOrderNormalCellModel * barModel = self.confirmOrderBar.orderBarModel;
    if ([self.originMoney containsString:@"."]) {
        
//        LOG(@"_%@_%d_-------120------>%@",[self class] , __LINE__,self.originMoney);
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"草泥马");
//        CGFloat money = [[self.originMoney convertToFen] integerValue] / 100.0;
//        
////        CGFloat money = [self.originMoney floatValue];
//        LOG(@"_%@_%d_-----122---->%f",[self class] , __LINE__,money);
//        money -=(self.totalCouponsMoney + self.usedLB/1000.0);
//        barModel.subtitle = [NSString stringWithFormat:@"%.02f",money];

        LOG(@"_%@_%d_-------120------>%@",[self class] , __LINE__,self.originMoney);
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"草泥马");
        CGFloat money = [self.originMoney floatValue];
        LOG(@"_%@_%d_-----122---->%f",[self class] , __LINE__,money);
        money -=(self.totalCouponsMoney + self.usedLB/1000.0);
        barModel.subtitle = [NSString stringWithFormat:@"%.02f",money];
    }else{
        CGFloat money = [self.originMoney integerValue];
        money-=(self.totalCouponsMoney+ self.usedLB/1000.0);
        barModel.subtitle = [NSString stringWithFormat:@"%.02f",money];
    }
    self.confirmOrderBar.orderBarModel = barModel  ;
}

-(void)setChoosedCoupons:(NSMutableArray *)choosedCoupons{
    _choosedCoupons = choosedCoupons;
//    NSUInteger temp = 0 ;
    for (CCCouponsModel*couponseModel in choosedCoupons) {
        self.totalCouponsMoney+=[couponseModel.discount_price integerValue]/100.0;
    }
    ConfirmOrderNormalCellModel * model  = self.discountResult.normalCellModel;
    if (choosedCoupons.count>0) {
        
        if (self.usedLB>0) {
                model.title = @"优惠: L币 / 优惠券";
                model.subtitle = [NSString stringWithFormat:@"-¥%.02lf",self.usedLB/1000.0 + self.totalCouponsMoney];// 会加上优惠券的折扣金额
        }else{
            
                model.title = @"优惠:  优惠券";
            //@"只算优惠券"
            model.subtitle = [NSString stringWithFormat:@"-¥%.02f",self.totalCouponsMoney];// 会加上优惠券的折扣金额

        }
        
    }else{
        if (self.usedLB>0) {
            model.title = @"优惠: L币 ";
            model.subtitle = [NSString stringWithFormat:@"-¥%.02lf",self.usedLB/1000.0];// 会加上优惠券的折扣金额
        }else{
            
            model.title = @"优惠:  无";
            model.subtitle = [NSString stringWithFormat:@"¥ 0.00"];// 会加上优惠券的折扣金额
        }
    
    }
    self.discountResult.normalCellModel  = model;
/////////////////////////////////////////////////
    ConfirmOrderNormalCellModel * barModel = self.confirmOrderBar.orderBarModel;
    LOG(@"_%@_%d_----------->%@",[self class] , __LINE__,barModel.subtitle);
    if ([self.originMoney containsString:@"."]) {
        CGFloat money = [self.originMoney floatValue];
        money -=(self.totalCouponsMoney + self.usedLB/1000.0);
                barModel.subtitle = [NSString stringWithFormat:@"%.02f",money];
    }else{
        CGFloat money = [self.originMoney integerValue];
        money-=(self.totalCouponsMoney+ self.usedLB/1000.0);
            barModel.subtitle = [NSString stringWithFormat:@"%.02f",money];
    }
     self.confirmOrderBar.orderBarModel = barModel  ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviTitle = @"确认订单";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shopCarChangedCallBack) name:SHOPCARDATACHANGED object:nil];
    self.automaticallyAdjustsScrollViewInsets = NO;
//    [self addsubviewsOfView];
    if (self.goodsIDs && !self.response) { // 早期时,通过传id获取确认订单详情,在当前控制器请求确认订单数据(为了兼容之前用过此控制器的地方)
        [self setDataToUIWithGoodsIDs];
    }else if (self.response && self.goodsIDs){//后期 , 在购物车界面请求确认订单数据 , 再把数据传过来,再解析 , (利于提前判断)
         [self setDataToUIWithResponse];
    }
    [self testCallBack];
}
-(void)setDataToUIWithResponse
{
    [self analysisData:self.response];
}
-(void)setDataToUIWithGoodsIDs
{
    [self confirmOrderRemoteLoadaWithAtionType:Init addressID: self.addressModel.ID  Success:^(ResponseObject *response) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,response.data);
        self.response = response;
        [self analysisData:self.response];
    
    } failure:^(NSError *error) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"请求失败")
        MBProgressHUD * hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hub.mode=MBProgressHUDModeText;
        [hub hide:YES afterDelay:1.5];
        if (self.showgoodsesView.cellModel.items.count==1) {
            hub.labelText=@"该商品已下架,请您再次购买";
        }else{
            hub.labelText=@"已有商品下架，请刷新重试";
        }
        hub.labelText=@"操作失败";
        hub.completionBlock = ^{
            [self.navigationController popViewControllerAnimated:YES];
        };
//        [self showTheViewWhenDisconnectWithFrame:CGRectMake(0, self.startY, self.view.bounds.size.width, self.view.bounds.size.height - self.startY)];
    }];
    
}
-(void)analysisData:(ResponseObject*)response{ // 选择完地址以后 , 界面是移除所有子控件 ,重新添加并布局一次的
    /**
     AMCellModel * addressModel = cellModel.items.firstObject;
     
     NSString * name = addressModel.username;
     NSString * mobile = addressModel.mobile;
     NSString * address = [NSString stringWithFormat:@"%@%@",addressModel.area,addressModel.address];
     */
     NSLog(@"_%d_%@",__LINE__,response.msg);
     NSLog(@"_%d_%@",__LINE__,response.data);
    if (response.status>0) {
        [self removeTheViewWhenConnect];
        
        
        if ([response.data isKindOfClass:[NSArray class]]) {
            for (int i =0 ; i < [response.data count]; i++ ) {
                NSDictionary * sub = response.data[i];
                ConfirmOrderNormalCellModel * model = [[ConfirmOrderNormalCellModel alloc]initWithDict:sub];

                    if ([model.channel isEqualToString:@"userInfo"]) {
                        for (int i = 0 ; i < model.items.count; i++) {
                            id subsub = model.items[i];
                            AMCellModel * itmeModel = [[AMCellModel alloc]initWithdictionary:subsub];
                            NSString * address =  nil ;
                            
                            CGFloat maxW =  screenW - 10 - 8 -10 -10 - 13- 5 ;
                            CGFloat topH = [@"测试"   stringSizeWithFont:15*SCALE].height ;
                            CGFloat bottomH = 3 ;
                            CGFloat verticalH = 20 ;//纵向间距
                            
                            
                            CGSize  addressLabelSize =  CGSizeZero;
                            CGFloat totalH = 0;//返回还要动态布局地址栏的高度-_-! 好麻烦
                            
                            if (self.addressModel) {
                                 address = [NSString stringWithFormat:@"%@%@",self.addressModel.area,self.addressModel.address] ;

                            }else{
                                address = [NSString stringWithFormat:@"%@%@",itmeModel.area,itmeModel.address] ;
                            }
                            LOG(@"_%@_%d_提前计算出地址的字数------->\n%@\n\n\n b",[self class] , __LINE__,address);
                            addressLabelSize = [address sizeWithFont:[UIFont systemFontOfSize:14 *SCALE] MaxSize:CGSizeMake(maxW, CGFLOAT_MAX)] ;
                            LOG(@"_%@_%d_%@",[self class] , __LINE__,NSStringFromCGSize(addressLabelSize));
                            totalH = topH + addressLabelSize.height + bottomH + verticalH;
                            LOG(@"_%@_%d_地址总高是 - >> %f",[self class] , __LINE__,totalH);
                            self.addressTotalH  = totalH;
                        }
                    }else if([model.channel isEqualToString:@"taxes"]){
                        if (model.is_display == YES ) {
                            self.isTaxesDisplay = YES ;
                        }else{
                            self.isTaxesDisplay = NO ;
                        }
                    }
            }

        }
    }

    [self.subviewsContainerView removeFromSuperview];
    LOG(@"_%@_%d_滚动容器视图 - > %@",[self class] , __LINE__,self.subviewsContainerView);
    [self addsubviewsOfView];
    
    LOG(@"_%@_%d_滚动容器视图 - > %@",[self class] , __LINE__,self.subviewsContainerView);
    //////////////////////////////////////////////////////////////
    
    
    if (response.status>0) {
        [self removeTheViewWhenConnect];
        
        
        if ([response.data isKindOfClass:[NSArray class]]) {
            NSMutableArray * dataArrM = [NSMutableArray array];
            for (int i =0 ; i < [response.data count]; i++ ) {
                NSDictionary * sub = response.data[i];
                ConfirmOrderNormalCellModel * model = [[ConfirmOrderNormalCellModel alloc]initWithDict:sub];
                LOG(@"_%@_%d_%@",[self class] , __LINE__,model.channel);
                if (i==1){//这个是所购买商品的cell  , 对应的没有channel字段 , 只能根据下标取了
                    self.showgoodsesView.cellModel = model;
                }else{
                    if ([model.channel isEqualToString:@"userInfo"]) {
                        NSMutableArray * items = [NSMutableArray array];
                        for (int i = 0 ; i < model.items.count; i++) {
                            id subsub = model.items[i];
                            AMCellModel * itmeModel = [[AMCellModel alloc]initWithdictionary:subsub];
                            if (self.addressModel) {
                                [items addObject:self.addressModel];
                            }else{
                                [items addObject:itmeModel];
                                self.addressModel = itmeModel;
                            }
                            if (i==0) {
                                
                            }
                        }
                        model.items = items;
                        self.confirmOrderAddressView.cellModel = model;
                        
                    }else if ([model.channel isEqualToString:@"pay"]){
                        LOG_METHOD
                        self.payType.cellModel = model;
                    }else if ([model.channel isEqualToString:@"invoice"]){
                        model.showArrow = YES;
                        self.invoiceInfo.normalCellModel = model;
                    }else if ([model.channel isEqualToString:@"coupon"]){
                        
                        //                            model.showArrow = YES;
//                        model.items = self.choosedCoupons ;
                        self.chooseCoupon.normalCellModel=model;
                    }else if ([model.channel isEqualToString:@"Lcoin"]){
                        self.LB.normalCellModel=model;
                    }else if ([model.channel isEqualToString:@"money"]){
                        model.rightTitleColor = [UIColor colorWithRed:233/256.0 green:85/256.0 blue:19/256.0 alpha:1];
                        self.goodsPrice.normalCellModel = model;
                    }else if ([model.channel isEqualToString:@"freight"]){
                        model.rightTitleColor = [UIColor colorWithRed:233/256.0 green:85/256.0 blue:19/256.0 alpha:1];
                        self.freight.normalCellModel = model;
                    }else if ([model.channel isEqualToString:@"taxes"]){//新增税费
                        model.rightTitleColor = [UIColor colorWithRed:233/256.0 green:85/256.0 blue:19/256.0 alpha:1];
                        self.taxes.normalCellModel = model;
                    }else if ([model.channel isEqualToString:@"total"]){
                        self.confirmOrderBar.orderBarModel = model;
                        self.originMoney = model.subtitle;//记录最初的总价
                        
                        
                        
                        /////////////////////
                        
                    }
                    
                }
                
                [dataArrM addObject:model];
            }
            self.datas  = dataArrM.mutableCopy;
            //根据优惠券和LB动态展示
            ConfirmOrderNormalCellModel* discountResultModel =[[ConfirmOrderNormalCellModel alloc]init];
            discountResultModel.rightTitleColor = [UIColor colorWithRed:233/256.0 green:85/256.0 blue:19/256.0 alpha:1];
            
            //                    discountResultModel.subtitle = @"这次折扣了1块钱";
            self.discountResult.normalCellModel = discountResultModel ;
            //                self.choosedCoupons = @[];
            //                self.usedLB = 100 ;
            self.usedLB = 0 ;
//            self.choosedCoupons=nil;//防止选完地址 , 回来后 , 优惠券不显示折扣金额
        }
    }else{
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"操作失败 , 请重新生成订单")
        MBProgressHUD * hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hub.mode=MBProgressHUDModeText;
        [hub hide:YES afterDelay:1.5];
        if (self.showgoodsesView.cellModel.items.count==1) {
            hub.labelText=@"该商品已下架,请您再次购买";
        }else{
            hub.labelText=@"已有商品下架，请刷新重试";
        }
        hub.completionBlock = ^{
            [self.navigationController popViewControllerAnimated:YES];
        };
    }

}
-(void)test
{
}
-(void)addsubviewsOfView
{
    self.subviewsStartY = 0 ;
    CGFloat littleMargin = 10 ;
    //结算栏
    CGFloat confirmOrderBarW = self.view.bounds.size.width ;
    CGFloat confirmOrderBarH = 44*SCALE ;
    CGFloat confirmOrderBarX = 0 ;
    CGFloat confirmOrderBarY = self.view.bounds.size.height - confirmOrderBarH ;
    ConfirmOrderBar * confirmOrderBar = [[ConfirmOrderBar alloc]initWithFrame:CGRectMake(confirmOrderBarX, confirmOrderBarY, confirmOrderBarW, confirmOrderBarH) ];
    confirmOrderBar.delegate = self;
    self.confirmOrderBar = confirmOrderBar;
//    confirmOrderBar.backgroundColor  = randomColor;
    [self.view addSubview:confirmOrderBar];
    //最后再加入数组
    //scrollViewcontainer视图
    CGFloat subviewsContainerViewX  = 0 ;
    CGFloat subviewsContainerViewY  = self.startY ;
    CGFloat subviewsContainerViewW  = self.view.bounds.size.width ;
    CGFloat subviewsContainerViewH  = confirmOrderBarY - self.startY ;
    UIScrollView * subviewsContainerView = [[UIScrollView alloc]initWithFrame:CGRectMake(subviewsContainerViewX, subviewsContainerViewY, subviewsContainerViewW, subviewsContainerViewH)];
    subviewsContainerView.scrollEnabled=YES;
    subviewsContainerView.showsVerticalScrollIndicator = NO ;
    subviewsContainerView.alwaysBounceVertical = YES;
    self.subviewsContainerView = subviewsContainerView;
    subviewsContainerView.backgroundColor = BackgroundGray;
    [self.view addSubview:subviewsContainerView];
    
    //地址视图///////////////////////////////////////////
    CGFloat confirmOrderAddressViewW = self.subviewsContainerView.bounds.size.width ;
    //    CGFloat confirmOrderAddressViewH = 100*SCALE ;//
    CGFloat confirmOrderAddressViewH = self.addressTotalH  ;

    CGFloat confirmOrderAddressViewX =  0;
    CGFloat confirmOrderAddressViewY = self.subviewsStartY ; ;
    
    ConfirmOrderAddressView * confirmOrderAddressView = [[ConfirmOrderAddressView alloc]initWithFrame:CGRectMake(confirmOrderAddressViewX, confirmOrderAddressViewY, confirmOrderAddressViewW, confirmOrderAddressViewH)];
    [confirmOrderAddressView addTarget:self action:@selector(chooseAddressClick:) forControlEvents:UIControlEventTouchUpInside];
    self.confirmOrderAddressView = confirmOrderAddressView;
//    confirmOrderAddressView.backgroundColor = randomColor;
    [self.subviewsContainerView addSubview:confirmOrderAddressView];
    [self.subviewsContainer addObject:confirmOrderAddressView];
    self.subviewsStartY+=confirmOrderAddressViewH;
    self.subviewsStartY+=littleMargin;
    //展示商品视图///////////////////////////////////////////
    CGFloat showgoodsesViewW = self.subviewsContainerView.bounds.size.width ;
    CGFloat showgoodsesViewH = 100*SCALE ;
    CGFloat showgoodsesViewX = 0 ;
    CGFloat showgoodsesViewY = self.subviewsStartY ;
    
    ShowgoodsesView * showgoodsesView = [[ShowgoodsesView alloc]initWithFrame:CGRectMake(showgoodsesViewX, showgoodsesViewY, showgoodsesViewW, showgoodsesViewH)];
    self.showgoodsesView = showgoodsesView;
    [showgoodsesView addTarget:self action:@selector(showGoodsDetail:) forControlEvents:UIControlEventTouchUpInside];
//    showgoodsesView.backgroundColor = randomColor;
    [self.subviewsContainer addObject:showgoodsesView];
    [self.subviewsContainerView addSubview:showgoodsesView];
    self.subviewsStartY+=showgoodsesViewH;
    
    //支付配送视图///////////////////////////////////////////
    CGFloat payTypeW = self.subviewsContainerView.bounds.size.width ;
    CGFloat payTypeH = 60 * SCALE ;
    CGFloat payTypeX = 0 ;
    CGFloat payTypeY = self.subviewsStartY ;
    PayTypeView * payType = [[PayTypeView alloc]initWithFrame:CGRectMake(payTypeX, payTypeY, payTypeW, payTypeH)];
    self.payType = payType;
//    payType.backgroundColor = randomColor;
    [self.subviewsContainerView addSubview:payType];
    [self.subviewsContainer addObject:payType];
    self.subviewsStartY+=payTypeH;
    
    //CONormalCompose
    /** 这一期不要发票了 */
    //发票信息视图
//    CGFloat invoiceInfoW = self.subviewsContainerView.bounds.size.width ;
//    CGFloat invoiceInfoH = 44*SCALE ;
//    CGFloat invoiceInfoX = 0 ;
//    CGFloat invoiceInfoY = self.subviewsStartY ;
//
//    CONormalCompose * invoiceInfo = [[CONormalCompose alloc]init];
//    [invoiceInfo addTarget:self action:@selector(showInvoiceInfo:) forControlEvents:UIControlEventTouchUpInside];
//    self.invoiceInfo = invoiceInfo;
//    invoiceInfo.frame = CGRectMake(invoiceInfoX, invoiceInfoY, invoiceInfoW, invoiceInfoH);
////    invoiceInfo.backgroundColor = randomColor;
//    [self.subviewsContainerView addSubview:invoiceInfo];
//    [self.subviewsContainer addObject:invoiceInfo];
//    self.subviewsStartY+= invoiceInfoH;
//    
//    self.subviewsStartY+=littleMargin;÷÷
    //优惠券视图
    CGFloat chooseCouponW = self.subviewsContainerView.bounds.size.width ;
    CGFloat chooseCouponH = 44*SCALE ;
    CGFloat chooseCouponX = 0 ;
    CGFloat chooseCouponY = self.subviewsStartY ;
    
    CONormalCompose * chooseCoupon = [[CONormalCompose alloc]init];
    self.chooseCoupon = chooseCoupon;
    [chooseCoupon addTarget:self action:@selector(chooseCoupon:) forControlEvents:UIControlEventTouchUpInside];
    chooseCoupon.frame = CGRectMake(chooseCouponX, chooseCouponY, chooseCouponW, chooseCouponH);
//    chooseCoupon.backgroundColor = randomColor;
    [self.subviewsContainerView addSubview:chooseCoupon];
    [self.subviewsContainer addObject:chooseCoupon];
    self.subviewsStartY+= chooseCouponH;
    /** 这一期不要L币了 */
    //L币视图
    
//    CGFloat LBW = self.subviewsContainerView.bounds.size.width ;
//    CGFloat LBH = 44*SCALE ;
//    CGFloat LBX = 0 ;
//    CGFloat LBY = self.subviewsStartY ;
//    
//    CONormalCompose * LB = [[CONormalCompose alloc]init];
//    self.LB = LB;
//    LB.frame = CGRectMake(LBX, LBY, LBW, LBH);
////    LB.backgroundColor = randomColor;
//    [self.subviewsContainerView addSubview:LB];
//    [self.subviewsContainer addObject:LB];
//    [LB addTarget:self action:@selector(chooseLB:) forControlEvents:UIControlEventTouchUpInside];
//    self.subviewsStartY+= LBH;
    //商品金额视图
    CGFloat goodsPriceW = self.subviewsContainerView.bounds.size.width ;
    CGFloat goodsPriceH = 44*SCALE ;
    CGFloat goodsPriceX = 0 ;
    CGFloat goodsPriceY = self.subviewsStartY ;
    
    CONormalCompose * goodsPrice = [[CONormalCompose alloc]init];
    self.goodsPrice = goodsPrice;
    goodsPrice.frame = CGRectMake(goodsPriceX, goodsPriceY, goodsPriceW, goodsPriceH);
//    goodsPrice.backgroundColor = randomColor;
    [self.subviewsContainerView addSubview:goodsPrice];
    [self.subviewsContainer addObject:goodsPrice];
    self.subviewsStartY+= goodsPriceH;
    //运费视图
    CGFloat freightW = self.subviewsContainerView.bounds.size.width ;
    CGFloat freightH = 44*SCALE ;
    CGFloat freightX = 0 ;
    CGFloat freightY = self.subviewsStartY ;
    
    CONormalCompose * freight = [[CONormalCompose alloc]init];
    self.freight = freight;
    freight.frame = CGRectMake(freightX, freightY, freightW, freightH);
//    freight.backgroundColor = randomColor;
    [self.subviewsContainerView addSubview:freight];
    [self.subviewsContainer addObject:freight];
    self.subviewsStartY+= freightH;
    
    
    
    //税费
    
    if (self.isTaxesDisplay) {
        
        CGFloat taxesW = self.subviewsContainerView.bounds.size.width ;
        CGFloat taxesH = 44*SCALE ;
        CGFloat taxesX = 0 ;
        CGFloat taxesY = self.subviewsStartY ;
        
        CONormalCompose * taxes = [[CONormalCompose alloc]init];
        self.taxes = taxes ;
        taxes.frame = CGRectMake(taxesX, taxesY, taxesW, taxesH);
        //    discountResult.backgroundColor = randomColor;
        [self.subviewsContainerView addSubview:taxes];
        self.subviewsStartY+= taxesH;
    }
    
    
    
    
    
    
    
    //优惠券/ L币折扣信息
    
    CGFloat discountResultW = self.subviewsContainerView.bounds.size.width ;
    CGFloat discountResultH = 44*SCALE ;
    CGFloat discountResultX = 0 ;
    CGFloat discountResultY = self.subviewsStartY ;
    
    CONormalCompose * discountResult = [[CONormalCompose alloc]init];
    self.discountResult = discountResult ;
    discountResult.frame = CGRectMake(discountResultX, discountResultY, discountResultW,discountResultH);
//    discountResult.backgroundColor = randomColor;
    [self.subviewsContainerView addSubview:discountResult];
    self.subviewsStartY+= discountResultH;


    
    
    
    
    
    self.subviewsContainerView.contentSize = CGSizeMake(self.subviewsContainerView.bounds.size.width, self.subviewsStartY+ discountResultH);
    
    
    [self.subviewsContainer addObject:confirmOrderBar];
    [self.subviewsContainer addObject:discountResult];
}
-(void)reconnectClick:(UIButton *)sender{
//    [self confirmOrderRemoteLoadaWithAtionType:Refresh Success:^(ResponseObject *response) {
//        if (response.status>0) {
//            [self removeTheViewWhenConnect];
    if (self.goodsIDs && !self.response) {
        
        [self setDataToUIWithGoodsIDs];
    }else if (self.response&& self.goodsIDs){
        [self setDataToUIWithResponse];
    }
//        }else{
//            
//        }
//    } failure:^(NSError *error) {
//        
//    }];

}
//调取确认订单接口 提前到购物车中
-(void)confirmOrderRemoteLoadaWithAtionType:(LoadDataActionType)actionType addressID:(NSString*)addressID Success:(void(^)(ResponseObject *response))success failure:(void(^)(NSError *error))failure{
    
    NSMutableArray  * arrM = [NSMutableArray arrayWithCapacity:self.goodsIDs.count];
    
    for (SVCGoods * goods  in self.goodsIDs) {
        
        [arrM addObject:goods.ID];//fuck 到底是id还是goods_id
//        [arrM addObject:@(goods.goods_id)];
    }
    NSString * jsonStr = [arrM mj_JSONString];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,jsonStr);
    
    [[UserInfo shareUserInfo ] confirmOrderWithGoodsId:jsonStr addressID:addressID success:^(ResponseObject *response) {
         NSLog(@"_%d_%@",__LINE__,response.data);
        success(response);
    } failure:^(NSError *error) {
       LOG(@"_%@_%d_%@",[self class] , __LINE__,error)
        failure(error);
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
}

-(NSMutableArray * )subviewsContainer{
    if(_subviewsContainer==nil){
        _subviewsContainer = [[NSMutableArray alloc]init];
    }
    return _subviewsContainer;
}
-(NSMutableArray * )datas{
    if(_datas==nil){
        _datas = [[NSMutableArray alloc]init];

    }
    return _datas;
}


-(void)operaterAboutOverSeasBuy
{

    UIView * editView = [self editView];
    GDGDAlert * editIdNumView =[[GDGDAlert alloc] init];
    self.editIdNumView = editIdNumView;
//    __weak __typeof(alert)weakAlert = alert;
//    __strong __typeof(weakAlert)strongAlert = weakAlert;
//    [editIdNumView alertInWindowWithCustomView:editView animat:YES dismissComplate:^(id objc) {
//        GDlog(@"销毁后的回调%@",objc);
//        } whitespaceHandle:^(GDGDAlert * alert) {
//        GDlog(@"点击空白的回调");
////        [alert dismissView:@"sbsb"];
//        [[UIApplication sharedApplication].keyWindow endEditing:YES ];
//    }];

    [editIdNumView alertInWindowWithCustomView:editView animat:YES  whitespaceHandle:^(GDGDAlert *alert) {
        [[UIApplication sharedApplication].keyWindow endEditing:YES ];
    }];
    
    GDlog(@"这是海外购商品")
    
}
-(UIView*)confirmView{

    
    CGFloat containerX = 20 ;
    CGFloat containerY = 20 ;
    
    CGFloat containerW = screenW - containerX*2 ;
    
    //1
    CGFloat topLblX = 0 ;
    CGFloat topLblY = 0 ;
    CGFloat topLblW = containerW  ;
    CGFloat topLblH = [[UIFont systemFontOfSize:30*SCALE] lineHeight]  ;
    UILabel * topLbl = [[UILabel alloc]init];
    topLbl.backgroundColor = BackgroundGray;
    topLbl.text = @"    信息确认";
    topLbl.textColor = [UIColor colorWithHexString:@"4D4A4A"];
    topLbl.font = [UIFont systemFontOfSize:20*SCALE];
    topLbl.frame = CGRectMake(topLblX, topLblY, topLblW, topLblH);
    
    //2
    CGFloat desLblX = 20 ;
    CGFloat desLblY = topLblH + 10 ;
    CGFloat desLblW = containerW - desLblX * 2  ;
    UILabel * desLbl = [[UILabel alloc] init];
    desLbl.font = [UIFont systemFontOfSize:12*SCALE];
    desLbl.textColor = [UIColor colorWithHexString:@"F49002"];
    desLbl.text = @"请确认您的身份信息和收货信息是否正确,否则可能无法收到商品";
    desLbl.numberOfLines = 3 ;
    CGSize desLblSize = [desLbl.text sizeWithFont:desLbl.font MaxSize:CGSizeMake(desLblW, MAXFLOAT)];
    CGFloat desLblH = desLblSize.height ;
    desLbl.frame = CGRectMake(desLblX, desLblY, desLblW,desLblH );
    
    //3
    
    CGFloat nameLblX = 20 ;
    CGFloat nameLblW = 84 ;
    CGFloat nameLblY = desLblY + desLblH + 10;
    UILabel * nameLbl = [[UILabel alloc] init];
    nameLbl.font = [UIFont systemFontOfSize:14*SCALE];
    nameLbl.textColor = [UIColor colorWithHexString:@"3D3C3C"];
    CGFloat nameLblH = [nameLbl.font lineHeight] ;
    nameLbl.frame = CGRectMake(nameLblX, nameLblY, nameLblW, nameLblH);
    nameLbl.textAlignment = NSTextAlignmentRight;
    nameLbl.text = @"收货人姓名: ";
    
    //4
    CGFloat idNumX = 20 ;
    CGFloat idNumW = 84 ;
    CGFloat idNumY = nameLblY + nameLblH + 14;
    UILabel * idNum = [[UILabel alloc] init];
    idNum.textColor = [UIColor colorWithHexString:@"3D3C3C"];
    idNum.font = nameLbl.font;
    CGFloat idNumH = [idNum.font lineHeight] ;
    idNum.frame = CGRectMake(idNumX, idNumY, idNumW, idNumH);
    idNum.textAlignment = NSTextAlignmentRight;
    idNum.text = @"身份证号: ";
    
    
    
    
    //5
    
    CGFloat nameInputX = nameLblX + nameLblW + 5 ;
    CGFloat nameInputRightMargin = 20 ;
    CGFloat nameInputW = containerW - nameInputX - nameInputRightMargin ;
    CGFloat nameInputY = nameLblY;
    CGFloat nameInputH = nameLblH ;
    UILabel * nameInput = [[UILabel alloc] init];
    nameInput.font = nameLbl.font;
    nameInput.text = self.tempAddressModel.username;
    nameInput.font = nameLbl.font;
    nameInput.frame = CGRectMake(nameInputX, nameInputY, nameInputW, nameInputH);
    //    nameLbl.textAlignment = NSTextAlignmentRight;
    //    nameLbl.text = @"收货人姓名:";
    
    
    //6
    CGFloat idNumInputX = nameInputX;
    CGFloat idNumInputW = containerW - idNumInputX - nameInputRightMargin ;
    CGFloat idNumInputY = idNumY;
    CGFloat idNumInputH = idNumH ;
    UILabel * idNumInput = [[UILabel alloc] init];
    idNumInput.font = nameLbl.font;
    idNumInput.text = self.tempAddressModel.id_number;
    idNumInput.font = idNum.font;
    idNumInput.frame = CGRectMake(idNumInputX, idNumInputY, idNumInputW, idNumInputH);
    
    
    
    
    //9
    CGFloat buttonW = 96*SCALE;
    CGFloat buttonH = 40*SCALE;
    CGFloat marginBetweenBtn = 38 ;
    
    
    CGFloat cancleX = (containerW - buttonW * 2 - marginBetweenBtn)/2 ;
    CGFloat btnToIdnum = 20 ;
    CGFloat cancleY = idNumY + idNumH + btnToIdnum ;
    CGFloat cancleW = buttonW ;
    CGFloat cancleH = buttonH ;
    UIButton * cancle = [[UIButton alloc]init];
    cancle.frame = CGRectMake(cancleX, cancleY, cancleW, cancleH);
    [cancle setTitleColor:[UIColor colorWithHexString:@"7F7F7F"] forState:UIControlStateNormal];
    cancle.backgroundColor = [UIColor colorWithHexString:@"E5E5E5"];
    [cancle  setTitle:@"返回修改" forState:UIControlStateNormal];
    [cancle addTarget:self  action:@selector(backEditClick:) forControlEvents:UIControlEventTouchUpInside];
    //10
    CGFloat confirmX = cancleX + cancleW + marginBetweenBtn;
    CGFloat confirmY = cancleY ;
    CGFloat confirmW = buttonW ;
    CGFloat confirmH = buttonH ;
    UIButton * confirm = [[UIButton alloc]init];
    [confirm addTarget:self  action:@selector(confirmCommitClick:) forControlEvents:UIControlEventTouchUpInside];
    confirm.frame = CGRectMake(confirmX, confirmY, confirmW, confirmH);
    confirm.backgroundColor = [UIColor colorWithHexString:@"C455B1"];
    [confirm  setTitle:@"确定" forState:UIControlStateNormal];
    CGFloat btnToBottom = 20 ;
    CGFloat containerH = confirmY + confirmH +   btnToBottom;
    
    UIView * container = [[UIView alloc] initWithFrame:CGRectMake(containerX, containerY, containerW, containerH)];
    [container addSubview:topLbl];
    [container addSubview:desLbl];
    [container addSubview:nameLbl];
    [container addSubview:idNum];
    [container addSubview:nameInput];
    [container addSubview:idNumInput];
    [container addSubview:cancle];
    [container addSubview:confirm];
    container.backgroundColor = [UIColor whiteColor];
    return  container;
}

-(UIView*)editView
{
    if (!self.tempAddressModel) {
        self.tempAddressModel = self.addressModel.copy;
    }
    CGFloat containerX = 20 ;
    CGFloat containerY = 20 ;
    
    CGFloat containerW = screenW - containerX*2 ;
    
    //1
    CGFloat topLblX = 0 ;
    CGFloat topLblY = 0 ;
    CGFloat topLblW = containerW  ;
    CGFloat topLblH = [[UIFont systemFontOfSize:30*SCALE] lineHeight]  ;
    UILabel * topLbl = [[UILabel alloc]init];
    topLbl.backgroundColor = BackgroundGray;
    topLbl.text = @"    实名认证";
    topLbl.textColor = [UIColor colorWithHexString:@"4D4A4A"];
    topLbl.font = [UIFont systemFontOfSize:20*SCALE];
    topLbl.frame = CGRectMake(topLblX, topLblY, topLblW, topLblH);
    
    //2
    CGFloat desLblX = 20 ;
    CGFloat desLblY = topLblH + 10 ;
    CGFloat desLblW = containerW - desLblX * 2  ;
    UILabel * desLbl = [[UILabel alloc] init];
    desLbl.font = [UIFont systemFontOfSize:12*SCALE];
    desLbl.textColor = [UIColor colorWithHexString:@"F49002"];
    desLbl.text = @"根据海关要求:购买本订单商品需要对收货人进行实名认证";
    desLbl.numberOfLines = 3 ;
    CGSize desLblSize = [desLbl.text sizeWithFont:desLbl.font MaxSize:CGSizeMake(desLblW, MAXFLOAT)];
    CGFloat desLblH = desLblSize.height ;
    desLbl.frame = CGRectMake(desLblX, desLblY, desLblW,desLblH );
    
    //3
    
    CGFloat nameLblX = 20 ;
    CGFloat nameLblW = 84 ;
    CGFloat nameLblY = desLblY + desLblH + 10;
    UILabel * nameLbl = [[UILabel alloc] init];
    nameLbl.font = [UIFont systemFontOfSize:14*SCALE];
    nameLbl.textColor = [UIColor colorWithHexString:@"3D3C3C"];
    CGFloat nameLblH = [nameLbl.font lineHeight] ;
    nameLbl.frame = CGRectMake(nameLblX, nameLblY, nameLblW, nameLblH);
    nameLbl.textAlignment = NSTextAlignmentRight;
    nameLbl.text = @"收货人姓名: ";
    
    //4
    CGFloat idNumX = 20 ;
    CGFloat idNumW = 84 ;
    CGFloat idNumY = nameLblY + nameLblH + 32*SCALE;
    UILabel * idNum = [[UILabel alloc] init];
    idNum.font = [UIFont systemFontOfSize:14*SCALE];
    idNum.textColor = [UIColor colorWithHexString:@"3D3C3C"];
    //    nameLbl.font = [UIFont systemFontOfSize:<#(CGFloat)#>]
    CGFloat idNumH = [idNum.font lineHeight] ;
    idNum.frame = CGRectMake(idNumX, idNumY, idNumW, idNumH);
    idNum.textAlignment = NSTextAlignmentRight;
    idNum.text = @"身份证号: ";
    

    
    
    //5
    
    CGFloat nameInputX = nameLblX + nameLblW + 5 ;
    CGFloat nameInputRightMargin = 20 ;
    CGFloat nameInputW = containerW - nameInputX - nameInputRightMargin ;
    CGFloat nameInputY = nameLblY;
    CGFloat nameInputH = nameLblH * 1.5 ;
    UITextField * nameInput = [[UITextField alloc] init];
    nameInput.font = [UIFont systemFontOfSize:14*SCALE];

    nameInput.leftViewMode = UITextFieldViewModeAlways;
    nameInput.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, nameInputH)];
    //    nameLbl.font = [UIFont systemFontOfSize:<#(CGFloat)#>]
    nameInput.text = self.tempAddressModel.username;
    nameInput.backgroundColor = BackgroundGray;
    nameInput.frame = CGRectMake(nameInputX, nameInputY, nameInputW, nameInputH);
    nameInput.center = CGPointMake(nameInputX + nameInputW/2, nameLbl.center.y);
    self.usernameInput = nameInput;
    self.usernameInput.delegate = self ;
    //    nameLbl.textAlignment = NSTextAlignmentRight;
    //    nameLbl.text = @"收货人姓名:";
    
    
    //6
    CGFloat idNumInputX = nameInputX;
    CGFloat idNumInputW = containerW - idNumInputX - nameInputRightMargin ;
    CGFloat idNumInputY = idNumY;
    CGFloat idNumInputH = idNumH * 1.5 ;
    UITextField * idNumInput = [[UITextField alloc] init];
    idNumInput.font = nameLbl.font;
    self.idNumberInput = idNumInput;
    self.idNumberInput.delegate = self ;
    idNumInput.backgroundColor = BackgroundGray;
    idNumInput.leftViewMode = UITextFieldViewModeAlways;
    idNumInput.text = self.tempAddressModel.id_number;
    idNumInput.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, idNumInputH)];
    //    nameLbl.font = [UIFont systemFontOfSize:<#(CGFloat)#>]
    idNumInput.frame = CGRectMake(idNumInputX, idNumInputY, idNumInputW, idNumInputH);
    idNumInput.center= CGPointMake(idNumInputX + idNumInputW / 2, idNum.center.y);
    
    
    
    
    //7
    CGFloat nameTipsX = nameInputX ;
    CGFloat nameTipsW = containerW - nameTipsX ;
    CGFloat nameTipsY = nameInputY + nameInputH ;
    UILabel * nameTips = [[UILabel alloc] init];
    
    nameTips.font = [UIFont systemFontOfSize:10*SCALE];
    nameTips.textColor = [UIColor colorWithHexString:@"E77373"];
    //    nameLbl.font = [UIFont systemFontOfSize:<#(CGFloat)#>]
    CGFloat nameTipsH = [nameTips.font lineHeight] ;
    nameTips.frame = CGRectMake(nameTipsX, nameTipsY, nameTipsW, nameTipsH);
    nameTips.text = @"此收货人姓名会同步到订单收货人姓名";
    nameTips.hidden = YES ;
    self.usernameTips = nameTips;
    
    
    //8
    CGFloat idNumTipsX = idNumInputX ;
    CGFloat idNumTipsW = containerW - idNumTipsX ;
    CGFloat idNumTipsY = idNumInputY + idNumInputH ;
    UILabel * idNumTips = [[UILabel alloc] init];
    idNumTips.font = [UIFont systemFontOfSize:10*SCALE];
    idNumTips.textColor = [UIColor redColor];
    idNumTips.textColor = [UIColor colorWithHexString:@"E77373"];
    //    nameLbl.font = [UIFont systemFontOfSize:<#(CGFloat)#>]
    CGFloat idNumTipsH = [idNumTips.font lineHeight] ;
    idNumTips.frame = CGRectMake(idNumTipsX, idNumTipsY, idNumTipsW,idNumTipsH);
    idNumTips.text = @"身份证号码填写不正确";
    idNumTips.hidden = YES ;
    self.idNumberTips = idNumTips;
    
    
    //9
    CGFloat buttonW = 96*SCALE;
    CGFloat buttonH = 40*SCALE;
    CGFloat marginBetweenBtn = 38 ;
    
    
    CGFloat cancleX = (containerW - buttonW * 2 - marginBetweenBtn)/2 ;
    CGFloat btnToIdnumTips = 20 ;
    CGFloat cancleY = idNumTipsY + idNumTipsH + btnToIdnumTips ;
    CGFloat cancleW = buttonW ;
    CGFloat cancleH = buttonH ;
    UIButton * cancle = [[UIButton alloc]init];
    cancle.frame = CGRectMake(cancleX, cancleY, cancleW, cancleH);
    [cancle setTitleColor:[UIColor colorWithHexString:@"7F7F7F"] forState:UIControlStateNormal];
    cancle.backgroundColor = [UIColor colorWithHexString:@"E5E5E5"];
    [cancle  setTitle:@"取消" forState:UIControlStateNormal];
    [cancle addTarget:self  action:@selector(cancleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //10
    CGFloat confirmX = cancleX + cancleW + marginBetweenBtn;
    CGFloat confirmY = cancleY ;
    CGFloat confirmW = buttonW ;
    CGFloat confirmH = buttonH ;
    UIButton * confirm = [[UIButton alloc]init];
    [confirm addTarget:self  action:@selector(confirmClick:) forControlEvents:UIControlEventTouchUpInside];
    confirm.frame = CGRectMake(confirmX, confirmY, confirmW, confirmH);
    confirm.backgroundColor = [UIColor colorWithHexString:@"C455B1"];
    [confirm  setTitle:@"确定" forState:UIControlStateNormal];
    CGFloat btnToBottom = 20 ;
    CGFloat containerH = confirmY + confirmH +   btnToBottom;
    
    UIView * container = [[UIView alloc] initWithFrame:CGRectMake(containerX, containerY, containerW, containerH)];
    [container addSubview:topLbl];
    [container addSubview:desLbl];
    [container addSubview:nameLbl];
    [container addSubview:idNum];
    [container addSubview:nameInput];
    [container addSubview:idNumInput];
    [container addSubview:nameTips];
    [container addSubview:idNumTips];
    [container addSubview:cancle];
    [container addSubview:confirm];
    container.backgroundColor = [UIColor whiteColor];
    return  container;
}
-(void)cancleClick:(UIButton*)sender
{
    self.tempAddressModel = nil ;
    [self.editIdNumView dismissView:@"取消编辑" dismissComplate:^(id objc) {
            GDlog(@"取消编辑")
    }];
    GDlog(@"取消编辑")
}
-(void)confirmClick:(UIButton*)sender
{
    //luojipan
    
    //1判断用户名
    if (self.usernameInput.text.length>15 || self.usernameInput.text.length<2) {
        AlertInVC(@"收货人为2~15个字符")
        return;
    }
    
    if ([self idNumberLawful:self.idNumberInput.text]) {
        self.idNumberTips.hidden = YES ;
    }else{
        self.idNumberTips.hidden = NO ;
        return;
    }
    self.tempAddressModel.id_number = self.idNumberInput.text;
    self.tempAddressModel.username = self.usernameInput.text;
    [self.editIdNumView dismissView:@"取消编辑" dismissComplate:^(id objc) {
        GDlog(@"取消编辑")
        GDlog(@"编辑完成")
        UIView * confirmView = [self confirmView];
        GDGDAlert * confirmIdNumView =[[GDGDAlert alloc] init];
        self.confirmIdNumView = confirmIdNumView;
        //    __weak __typeof(alert)weakAlert = alert;
        //    __strong __typeof(weakAlert)strongAlert = weakAlert;
//        [confirmIdNumView alertInWindowWithCustomView:confirmView animat:YES dismissComplate:^(id objc) {
//            GDlog(@"销毁后的回调%@",objc);
//        } whitespaceHandle:^(GDGDAlert * alert) {
//            GDlog(@"点击空白的回调");
//            //        [alert dismissView:@"sbsb"];
//            [[UIApplication sharedApplication].keyWindow endEditing:YES ];
//        }];
        [confirmIdNumView alertInWindowWithCustomView:confirmView animat:YES  whitespaceHandle:^(GDGDAlert *alert) {
            [[UIApplication sharedApplication].keyWindow endEditing:YES ];
        }];
    }];
   
}
-(void)backEditClick:(UIButton*)sender
{
    [self.confirmIdNumView dismissView:@"" dismissComplate:^(id objc) {
        UIView * editView = [self editView];
        GDGDAlert * editIdNumView =[[GDGDAlert alloc] init];
        self.editIdNumView = editIdNumView;
        //    __weak __typeof(alert)weakAlert = alert;
        //    __strong __typeof(weakAlert)strongAlert = weakAlert;
//        [editIdNumView alertInWindowWithCustomView:editView animat:YES dismissComplate:^(id objc) {
//            GDlog(@"销毁后的回调%@",objc);
//        } whitespaceHandle:^(GDGDAlert * alert) {
//            GDlog(@"点击空白的回调");
//            //        [alert dismissView:@"sbsb"];
//            [[UIApplication sharedApplication].keyWindow endEditing:YES ];
//        }];

        [editIdNumView alertInWindowWithCustomView:editView animat:YES  whitespaceHandle:^(GDGDAlert *alert) {
             [[UIApplication sharedApplication].keyWindow endEditing:YES ];
        }];
    }];
    GDlog(@"返回继续编辑")
}
-(void)confirmCommitClick:(UIButton*)sender
{
    
    [self.confirmIdNumView dismissView:@"" dismissComplate:^(id objc) {
        GDlog(@"确认成功,前往下单")
        
    }];
    
    [[UserInfo shareUserInfo] editAddressWithAddressModel:self.tempAddressModel success:^(ResponseObject *responseObject) {
        self.addressModel.id_number = self.tempAddressModel.id_number;
        [self creatOrderClickWithConfirmOrderBar:self.confirmOrderBar];
        self.tempAddressModel = nil ;
    } failure:^(NSError *error) {
        AlertInVC(@"操作失败,请重试");
    }];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == self.usernameInput) {
        self.usernameTips.hidden = NO ;
    }
    if (self.idNumberInput == textField) {
              self.idNumberTips.hidden = YES ;
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.idNumberInput == textField) {
        if (![self idNumberLawful:self.idNumberInput.text]) {
            self.idNumberTips.hidden = NO ;
        }else{
            self.idNumberTips.hidden = YES ;
        }
    }
}
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
////    GDlog(@"%@",textField.text)
////    GDlog(@"%@",NSStringFromRange(range))
////    GDlog(@"%@",string)
//    if (textField == self.usernameInput) {
//        self.usernameTips.hidden = NO ;
//    }else if (self.idNumberInput == textField) {
//        NSString * currentStr = textField.text;
//        NSString * willBeStr = [currentStr stringByReplacingCharactersInRange:range withString:string];
//        GDlog(@"%@",willBeStr)
//        if (![self idNumberLawful:willBeStr] ) {
//            self.idNumberTips.hidden = NO ;
//        }else{
//            self.idNumberTips.hidden = YES ;
//        }
//    }
//    
//    return YES;
//}
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



//点击方法
-(void)creatOrderClickWithConfirmOrderBar:(ConfirmOrderBar*)confirmOrderBar{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"立即下单")
    if ([self.addressModel.id_number length] == 0 && self.taxes) {
        [self operaterAboutOverSeasBuy];
        return;
    }
    NSMutableArray * tempArrM = [NSMutableArray array];
    for (CCCouponsModel*couponseModel in self.choosedCoupons) {
        [tempArrM addObject:couponseModel.cid];
    }
    NSString * tempJsonStr = [tempArrM mj_JSONString];
    LOG(@"_%@_%d_优惠券id%@",[self class] , __LINE__,tempJsonStr);
    BaseModel * creatOrderModel = [[BaseModel alloc]init];
    
    NSMutableArray * goodsIDArr = [NSMutableArray array ];
    
    for (SVCGoods * goods in self.goodsIDs) {
        [goodsIDArr addObject:goods.ID]; //到底是id还是goods_id
//        [goodsIDArr addObject:@(goods.goods_id)];
    }
    NSString * goodsIDsJson = [goodsIDArr mj_JSONString];
    creatOrderModel.actionKey = @"CreateOrderVC";
    LOG(@"%@,%d,%ld,%d,%@%@%@%@%@",[self class], __LINE__,self.usedLB,self.setInvoice,self.addressModel.ID,@"",goodsIDsJson,tempJsonStr,@"")
    if (!(self.addressModel.ID||goodsIDsJson||tempJsonStr)) {
        AlertInVC(@"订单已失效,请重新选择商品");
        return;
    }
    NSDictionary    *  keyParamete =     @{
                                        @"usedLB":@(self.usedLB),
                                        @"setInvoice":@(self.setInvoice),
                                        @"addressID":self.addressModel.ID,
                                        @"shipping":@"",
                                        @"goodsIDs":goodsIDsJson,
                                        @"couponseIDs":tempJsonStr,
                                        @"payment":@""
                                        };
    NSString * usedLB = keyParamete[@"usedLB"];
    NSString * setInvoice = keyParamete[@"setInvoice"];
    NSString * addressID = keyParamete[@"addressID"];
    NSString * shipping = keyParamete[@"shipping"];
    NSString * goodsIDs = keyParamete[@"goodsIDs"];
    NSString * couponseIDs = keyParamete[@"couponseIDs"];
    NSString * payment = keyParamete[@"payment"];
    LOG(@"%@,%d,%@",[self class], __LINE__,goodsIDs)
    LOG(@"%@,%d,%@",[self class], __LINE__,payment)
    LOG(@"%@,%d,%@",[self class], __LINE__,shipping)
    LOG(@"%@,%d,%@",[self class], __LINE__,couponseIDs)
    LOG(@"%@,%d,%@",[self class], __LINE__,usedLB)
    LOG(@"%@,%d,%@",[self class], __LINE__,addressID)
    [[UserInfo shareUserInfo] creatOrderWithUserGoods_ID:goodsIDs payMent:payment shipingType:shipping invoiceOrNot:setInvoice couponsIDs:couponseIDs LBCount:usedLB  addressID:addressID  success:^(ResponseObject *responseObject) {
        if (responseObject.status>0) {
           

            LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
            creatOrderModel.keyParamete = @{
                                            @"paramete":responseObject.data
                                            };
            [[SkipManager shareSkipManager] skipByVC:self withActionModel:creatOrderModel];
            
        }else{
            MBProgressHUD * hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hub.mode=MBProgressHUDModeText;
            [hub hide:YES afterDelay:1.5];
            if (self.showgoodsesView.cellModel.items.count==1) {
                hub.labelText=@"该商品已下架,请您再次购买";
            }else{
                hub.labelText=@"已有商品下架，请刷新重试";
            }
            hub.completionBlock = ^{
                [self.navigationController popViewControllerAnimated:YES];
            };
        }
        
    } failure:^(NSError *error) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
        MBProgressHUD * hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hub.mode=MBProgressHUDModeText;
        [hub hide:YES afterDelay:1.5];
        if (self.showgoodsesView.cellModel.items.count==1) {
            hub.labelText=@"该商品已下架,请您再次购买";
        }else{
            hub.labelText=@"已有商品下架，请刷新重试";
        }
        hub.completionBlock = ^{
            [self.navigationController popViewControllerAnimated:YES];
        };
    }];

}
#pragma 跳转并选择相应的选项 , 并通过代理回传值
-(void)chooseAddressClick:(ConfirmOrderAddressView*)sender
{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"选择地址")
//    BaseModel * chooseAddressModel = [[BaseModel alloc]init];
//    chooseAddressModel.actionKey = @"ChooseAddressVC";
//    [[SkipManager shareSkipManager] skipByVC:self withActionModel:chooseAddressModel];
//    
    
    ChooseAddressVC * chooseAddressVC = [[ChooseAddressVC alloc]init];
    chooseAddressVC.choosedAddressID = [self.addressModel.ID integerValue];
    chooseAddressVC.ChooseAddressDelegate = self;
    [self.navigationController pushViewController:chooseAddressVC animated:YES];
}
-(void)chooseTheAddressModel:(AMCellModel *)addressModel{
    self.addressModel = addressModel;
    
    [self setDataToUIWithGoodsIDs];//地址改了重新算运费
//    [self analysisData:self.response];
}

-(void)showGoodsDetail:(ShowgoodsesView*)sender
{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"查看所选商品")
      NSMutableArray * goodsIDArr  = [NSMutableArray array];
    for (NSDictionary * sub in sender.cellModel.items) {
        NSNumber*goodsID = sub[@"id"];
        [goodsIDArr addObject:goodsID];
    }
    NSString * jsonGoodsID = [goodsIDArr mj_JSONString];

//    BaseModel * goodsInOrderModel = [[BaseModel alloc]init];
//    
//    goodsInOrderModel.actionKey = @"GoodsInOrderVC";
//    goodsInOrderModel.keyParamete = @{@"paramete":jsonGoodsID};
//    
//    [[SkipManager shareSkipManager] skipByVC:self withActionModel:goodsInOrderModel];
    
    GoodsInOrderVC * vc = [[GoodsInOrderVC alloc]init];
    vc.goodsID = jsonGoodsID;
    vc.addressModel = self.addressModel;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
-(void)showInvoiceInfo:(CONormalCompose*)sender
{
    self.setInvoice=NO;
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"查看发票信息")
    InvoiceDetailVC * invoiceDetailVC = [[InvoiceDetailVC alloc]init];
    invoiceDetailVC.InvoiceDetailDelegate=self;
    [self.navigationController pushViewController:invoiceDetailVC animated:YES];
}
//设置发票信息的代理
-(void)setInvoiceOrNot:(BOOL)setIvnoice{
    if (setIvnoice) {
            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"设置了发票信息");
    }else{
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"没设置发票信息");
    }
    self.setInvoice = setIvnoice;
}
//选择优惠券
-(void)chooseCoupon:(CONormalCompose*)sender
{
    if (self.chooseCoupon.normalCellModel.items.count==0) {
        return;
    }
    self.totalCouponsMoney = 0 ;
    
   
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"选择优惠券")
    //如果有优惠券就可点击  否则就不能点击
    NSMutableArray * goodsIDArr  = [NSMutableArray array];
    for (NSDictionary * sub in self.showgoodsesView.cellModel.items) {
        NSNumber*goodsID = sub[@"id"];
        [goodsIDArr addObject:goodsID];
    }
    NSString * jsonGoodsID = [goodsIDArr mj_JSONString];
    ChooseCounposeVC * chooseCounposeVC = [[ChooseCounposeVC alloc]init];
    chooseCounposeVC.ChooseCounposeDelegate=self;
    chooseCounposeVC.goodsID = jsonGoodsID;
    chooseCounposeVC.selectCouponses= self.choosedCoupons.mutableCopy;
    [self.navigationController pushViewController:chooseCounposeVC animated:YES];
    
}
-(void)chooseCouponseWithConposeArr:(NSArray *)conposeArr{
    //先把上次选择的清空
    self.choosedCoupons = nil;
    self.totalCouponsMoney = 0 ;
    self.choosedCoupons = conposeArr.mutableCopy;
}
//选择LB
-(void)chooseLB:(CONormalCompose*)sender{
    self.usedLB= 0;
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"选择L币")
    //如果有L币就可点击  否则就不能点击
    if ( [self.LB.normalCellModel.subtitle integerValue]>0) {
        ChooseLBVC * lbVC = [[ChooseLBVC alloc]init];
        lbVC.lb = [self.LB.normalCellModel.subtitle integerValue];
        lbVC.ChooseLBDelegate=self;
        [self.navigationController pushViewController:lbVC animated:YES];
    }
}
-(void)chooseLBCount:(NSUInteger)lbCount{//lb不用传 , 当前控制器可以获取
    if (lbCount==0) {
        return;
    }
    //先把上次选择的清空
    self.usedLB =0;
    //判断总价钱和lb总数的关系 , 如果lb小于总价 , 就是全部使用  , 如果lb大于总价 , 就使用总价对应的lb的数量
    LOG(@"_%@_%d_使用了lb的数量%lu",[self class] , __LINE__,lbCount);
    NSUInteger lb = [self.LB.normalCellModel.subtitle integerValue];
    if (lb>[self.originMoney integerValue]*1000) {
        self.usedLB = (NSInteger)[self.originMoney integerValue]*1000;
    }else{
        self.usedLB = lb;
    
    }
}
-(void)setAddressModel:(AMCellModel *)addressModel{
    _addressModel = addressModel;
    ConfirmOrderNormalCellModel * viewModel = [[ConfirmOrderNormalCellModel alloc]init];
    viewModel.items = [@[addressModel] mutableCopy];
    self.confirmOrderAddressView.cellModel = viewModel;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (self.isNeedDestroy) {
        self.isNeedDestroy=NO ;
        [self removeFromParentViewController];
    }
}
-(void)testCallBack
{
//    PayMentManager * manager = [[PayMentManager alloc]init];
//    self.manager = manager;
//    manager.myCallBack = ^(id result){
//        LOG(@"_%@_%d_执行结果%@",[self class] , __LINE__,result );
//
//    }  ;
//    [manager payWithParemete:@"开始调用支付控件" payMentType:AliPay];
//    
}
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//
//    [self.manager testWithParamete:@"模拟支付成功的回调结果"];
//
//}

-(void)shopCarChangedCallBack
{
    self.isNeedDestroy=YES ;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}







-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}










////////*************///////////////



//-(void)setUsedLB:(NSUInteger)usedLB{
//    _usedLB = usedLB;
//    ConfirmOrderNormalCellModel * model  = self.discountResult.normalCellModel;
//    
//    if (usedLB>0) {
//        if (self.choosedCoupons.count>0) {
//            model.title = @"优惠: L币 / 优惠券";
//            model.subtitle = [NSString stringWithFormat:@"-¥%.02lf",usedLB/1000.0+self.totalCouponsMoney];// 会加上优惠券的折扣金额
//        }else{
//            model.title = @"优惠:  L币";
//            model.subtitle = [NSString stringWithFormat:@"-¥%.02lf",usedLB/1000.0]; // 会加上优惠券的折扣金额
//        }
//    }else{
//        
//        if (self.choosedCoupons.count>0) {
//            model.title = @"优惠:  优惠券";
//            model.subtitle = [NSString stringWithFormat:@"-¥%.02f",self.totalCouponsMoney];// 会加上优惠券的折扣金额
//        }else{
//            model.title = @"优惠:  无";
//            model.subtitle = [NSString stringWithFormat:@"¥ 0.0"];
//        }
//    }
//    
//    self.discountResult.normalCellModel  = model;
//    //////////////////////////////////
//    ConfirmOrderNormalCellModel * barModel = self.confirmOrderBar.orderBarModel;
//    if ([self.originMoney containsString:@"."]) {
//        CGFloat money = [self.originMoney floatValue];
//        money -=(self.totalCouponsMoney + self.usedLB/1000.0);
//        barModel.subtitle = [NSString stringWithFormat:@"%.02f",money];
//    }else{
//        CGFloat money = [self.originMoney integerValue];
//        money-=(self.totalCouponsMoney+ self.usedLB/1000.0);
//        barModel.subtitle = [NSString stringWithFormat:@"%.02f",money];
//    }
//    self.confirmOrderBar.orderBarModel = barModel  ;
//}
//
//-(void)setChoosedCoupons:(NSMutableArray *)choosedCoupons{
//    _choosedCoupons = choosedCoupons;
//    //    NSUInteger temp = 0 ;
//    for (CCCouponsModel*couponseModel in choosedCoupons) {
//        self.totalCouponsMoney+=[couponseModel.discount_price integerValue]/100.0;
//    }
//    ConfirmOrderNormalCellModel * model  = self.discountResult.normalCellModel;
//    if (choosedCoupons.count>0) {
//        
//        if (self.usedLB>0) {
//            model.title = @"优惠: L币 / 优惠券";
//            model.subtitle = [NSString stringWithFormat:@"-¥%.02lf",self.usedLB/1000.0 + self.totalCouponsMoney];// 会加上优惠券的折扣金额
//        }else{
//            
//            model.title = @"优惠:  优惠券";
//            //@"只算优惠券"
//            model.subtitle = [NSString stringWithFormat:@"-¥%.02f",self.totalCouponsMoney];// 会加上优惠券的折扣金额
//            
//        }
//        
//    }else{
//        if (self.usedLB>0) {
//            model.title = @"优惠: L币 ";
//            model.subtitle = [NSString stringWithFormat:@"-¥%.02lf",self.usedLB/1000.0];// 会加上优惠券的折扣金额
//        }else{
//            
//            model.title = @"优惠:  无";
//            model.subtitle = [NSString stringWithFormat:@"¥ 0.0"];// 会加上优惠券的折扣金额
//        }
//        
//    }
//    self.discountResult.normalCellModel  = model;
//    /////////////////////////////////////////////////
//    ConfirmOrderNormalCellModel * barModel = self.confirmOrderBar.orderBarModel;
//    if ([self.originMoney containsString:@"."]) {
//        CGFloat money = [self.originMoney floatValue];
//        money -=(self.totalCouponsMoney + self.usedLB/1000.0);
//        barModel.subtitle = [NSString stringWithFormat:@"%.02f",money];
//    }else{
//        CGFloat money = [self.originMoney integerValue];
//        money-=(self.totalCouponsMoney+ self.usedLB/1000.0);
//        barModel.subtitle = [NSString stringWithFormat:@"%.02f",money];
//    }
//    self.confirmOrderBar.orderBarModel = barModel  ;
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.naviTitle = @"确认订单";
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shopCarChangedCallBack) name:SHOPCARDATACHANGED object:nil];
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    //    [self addsubviewsOfView];
//    if (self.goodsIDs && !self.response) { // 早期时,通过传id获取确认订单详情,在当前控制器请求确认订单数据(为了兼容之前用过此控制器的地方)
//        [self setDataToUIWithGoodsIDs];
//    }else if (self.response && self.goodsIDs){//后期 , 在购物车界面请求确认订单数据 , 再把数据传过来,再解析 , (利于提前判断)
//        [self setDataToUIWithResponse];
//    }
//    [self testCallBack];
//}
//-(void)setDataToUIWithResponse
//{
//    [self analysisData:self.response];
//}
//-(void)setDataToUIWithGoodsIDs
//{
//    [self confirmOrderRemoteLoadaWithAtionType:Init Success:^(ResponseObject *response) {
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,response.data);
//        self.response = response;
//        [self analysisData:self.response];
//        
//    } failure:^(NSError *error) {
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"请求失败")
//        MBProgressHUD * hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        hub.mode=MBProgressHUDModeText;
//        [hub hide:YES afterDelay:1.5];
//        if (self.showgoodsesView.cellModel.items.count==1) {
//            hub.labelText=@"该商品已下架,请您再次购买";
//        }else{
//            hub.labelText=@"已有商品下架，请刷新重试";
//        }
//        hub.labelText=@"操作失败";
//        hub.completionBlock = ^{
//            [self.navigationController popViewControllerAnimated:YES];
//        };
//        //        [self showTheViewWhenDisconnectWithFrame:CGRectMake(0, self.startY, self.view.bounds.size.width, self.view.bounds.size.height - self.startY)];
//    }];
//    
//}
//-(void)analysisData:(ResponseObject*)response{
//    /**
//     AMCellModel * addressModel = cellModel.items.firstObject;
//     
//     NSString * name = addressModel.username;
//     NSString * mobile = addressModel.mobile;
//     NSString * address = [NSString stringWithFormat:@"%@%@",addressModel.area,addressModel.address];
//     */
//    
//    if (response.status>0) {
//        [self removeTheViewWhenConnect];
//        
//        
//        if ([response.data isKindOfClass:[NSArray class]]) {
//            for (int i =0 ; i < [response.data count]; i++ ) {
//                NSDictionary * sub = response.data[i];
//                ConfirmOrderNormalCellModel * model = [[ConfirmOrderNormalCellModel alloc]initWithDict:sub];
//                
//                if ([model.channel isEqualToString:@"userInfo"]) {
//                    for (int i = 0 ; i < model.items.count; i++) {
//                        id subsub = model.items[i];
//                        AMCellModel * itmeModel = [[AMCellModel alloc]initWithdictionary:subsub];
//                        NSString * address =  nil ;
//                        
//                        CGFloat maxW =  screenW - 10 - 8 -10 -10 - 13- 5 ;
//                        CGFloat topH = [@"测试"   stringSizeWithFont:15*SCALE].height ;
//                        CGFloat bottomH = 3 ;
//                        CGFloat verticalH = 20 ;//纵向间距
//                        
//                        
//                        CGSize  addressLabelSize =  CGSizeZero;
//                        CGFloat totalH = 0;//返回还要动态布局地址栏的高度-_-! 好麻烦
//                        
//                        if (self.addressModel) {
//                            address = [NSString stringWithFormat:@"%@%@",self.addressModel.area,self.addressModel.address] ;
//                            
//                        }else{
//                            address = [NSString stringWithFormat:@"%@%@",itmeModel.area,itmeModel.address] ;
//                        }
//                        LOG(@"_%@_%d_提前计算出地址的字数------->\n%@\n\n\n b",[self class] , __LINE__,address);
//                        addressLabelSize = [address sizeWithFont:[UIFont systemFontOfSize:14 *SCALE] MaxSize:CGSizeMake(maxW, CGFLOAT_MAX)] ;
//                        LOG(@"_%@_%d_%@",[self class] , __LINE__,NSStringFromCGSize(addressLabelSize));
//                        totalH = topH + addressLabelSize.height + bottomH + verticalH;
//                        LOG(@"_%@_%d_地址总高是 - >> %f",[self class] , __LINE__,totalH);
//                        self.addressTotalH  = totalH;
//                    }
//                }
//            }
//            
//        }
//    }
//    
//    [self.subviewsContainerView removeFromSuperview];
//    LOG(@"_%@_%d_滚动容器视图 - > %@",[self class] , __LINE__,self.subviewsContainerView);
//    [self addsubviewsOfView];
//    
//    LOG(@"_%@_%d_滚动容器视图 - > %@",[self class] , __LINE__,self.subviewsContainerView);
//    //////////////////////////////////////////////////////////////
//    
//    
//    if (response.status>0) {
//        [self removeTheViewWhenConnect];
//        
//        
//        if ([response.data isKindOfClass:[NSArray class]]) {
//            NSMutableArray * dataArrM = [NSMutableArray array];
//            for (int i =0 ; i < [response.data count]; i++ ) {
//                NSDictionary * sub = response.data[i];
//                ConfirmOrderNormalCellModel * model = [[ConfirmOrderNormalCellModel alloc]initWithDict:sub];
//                LOG(@"_%@_%d_%@",[self class] , __LINE__,model.channel);
//                if (i==1){
//                    self.showgoodsesView.cellModel = model;
//                }else{
//                    if ([model.channel isEqualToString:@"userInfo"]) {
//                        NSMutableArray * items = [NSMutableArray array];
//                        for (int i = 0 ; i < model.items.count; i++) {
//                            id subsub = model.items[i];
//                            AMCellModel * itmeModel = [[AMCellModel alloc]initWithdictionary:subsub];
//                            if (self.addressModel) {
//                                [items addObject:self.addressModel];
//                            }else{
//                                [items addObject:itmeModel];
//                                self.addressModel = itmeModel;
//                            }
//                            if (i==0) {
//                                
//                            }
//                        }
//                        model.items = items;
//                        self.confirmOrderAddressView.cellModel = model;
//                        
//                    }else if ([model.channel isEqualToString:@"pay"]){
//                        LOG_METHOD
//                        self.payType.cellModel = model;
//                    }else if ([model.channel isEqualToString:@"invoice"]){
//                        model.showArrow = YES;
//                        self.invoiceInfo.normalCellModel = model;
//                    }else if ([model.channel isEqualToString:@"coupon"]){
//                        
//                        //                            model.showArrow = YES;
//                        self.chooseCoupon.normalCellModel=model;
//                    }else if ([model.channel isEqualToString:@"Lcoin"]){
//                        self.LB.normalCellModel=model;
//                    }else if ([model.channel isEqualToString:@"money"]){
//                        model.rightTitleColor = [UIColor colorWithRed:233/256.0 green:85/256.0 blue:19/256.0 alpha:1];
//                        self.goodsPrice.normalCellModel = model;
//                    }else if ([model.channel isEqualToString:@"freight"]){
//                        model.rightTitleColor = [UIColor colorWithRed:233/256.0 green:85/256.0 blue:19/256.0 alpha:1];
//                        self.freight.normalCellModel = model;
//                    }else if ([model.channel isEqualToString:@"total"]){
//                        self.confirmOrderBar.orderBarModel = model;
//                        self.originMoney = model.subtitle;//记录最初的总价
//                        
//                    }
//                    
//                }
//                
//                [dataArrM addObject:model];
//            }
//            self.datas  = dataArrM.mutableCopy;
//            //根据优惠券和LB动态展示
//            ConfirmOrderNormalCellModel* discountResultModel =[[ConfirmOrderNormalCellModel alloc]init];
//            discountResultModel.rightTitleColor = [UIColor colorWithRed:233/256.0 green:85/256.0 blue:19/256.0 alpha:1];
//            
//            //                    discountResultModel.subtitle = @"这次折扣了1块钱";
//            self.discountResult.normalCellModel = discountResultModel ;
//            //                self.choosedCoupons = @[];
//            //                self.usedLB = 100 ;
//            self.usedLB = 0 ;
//            self.choosedCoupons=nil;
//        }
//    }else{
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"操作失败 , 请重新生成订单")
//        MBProgressHUD * hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        hub.mode=MBProgressHUDModeText;
//        [hub hide:YES afterDelay:1.5];
//        if (self.showgoodsesView.cellModel.items.count==1) {
//            hub.labelText=@"该商品已下架,请您再次购买";
//        }else{
//            hub.labelText=@"已有商品下架，请刷新重试";
//        }
//        hub.completionBlock = ^{
//            [self.navigationController popViewControllerAnimated:YES];
//        };
//    }
//    
//}
//-(void)test
//{
//}
//-(void)addsubviewsOfView
//{
//    self.subviewsStartY = 0 ;
//    CGFloat littleMargin = 10 ;
//    //结算栏
//    CGFloat confirmOrderBarW = self.view.bounds.size.width ;
//    CGFloat confirmOrderBarH = 44*SCALE ;
//    CGFloat confirmOrderBarX = 0 ;
//    CGFloat confirmOrderBarY = self.view.bounds.size.height - confirmOrderBarH ;
//    ConfirmOrderBar * confirmOrderBar = [[ConfirmOrderBar alloc]initWithFrame:CGRectMake(confirmOrderBarX, confirmOrderBarY, confirmOrderBarW, confirmOrderBarH) ];
//    confirmOrderBar.delegate = self;
//    self.confirmOrderBar = confirmOrderBar;
//    //    confirmOrderBar.backgroundColor  = randomColor;
//    [self.view addSubview:confirmOrderBar];
//    //最后再加入数组
//    //scrollViewcontainer视图
//    CGFloat subviewsContainerViewX  = 0 ;
//    CGFloat subviewsContainerViewY  = self.startY ;
//    CGFloat subviewsContainerViewW  = self.view.bounds.size.width ;
//    CGFloat subviewsContainerViewH  = confirmOrderBarY - self.startY ;
//    UIScrollView * subviewsContainerView = [[UIScrollView alloc]initWithFrame:CGRectMake(subviewsContainerViewX, subviewsContainerViewY, subviewsContainerViewW, subviewsContainerViewH)];
//    subviewsContainerView.scrollEnabled=YES;
//    subviewsContainerView.showsVerticalScrollIndicator = NO ;
//    subviewsContainerView.alwaysBounceVertical = YES;
//    self.subviewsContainerView = subviewsContainerView;
//    subviewsContainerView.backgroundColor = BackgroundGray;
//    [self.view addSubview:subviewsContainerView];
//    
//    //地址视图///////////////////////////////////////////
//    CGFloat confirmOrderAddressViewW = self.subviewsContainerView.bounds.size.width ;
//    //    CGFloat confirmOrderAddressViewH = 100*SCALE ;//
//    CGFloat confirmOrderAddressViewH = self.addressTotalH  ;
//    
//    CGFloat confirmOrderAddressViewX =  0;
//    CGFloat confirmOrderAddressViewY = self.subviewsStartY ; ;
//    
//    ConfirmOrderAddressView * confirmOrderAddressView = [[ConfirmOrderAddressView alloc]initWithFrame:CGRectMake(confirmOrderAddressViewX, confirmOrderAddressViewY, confirmOrderAddressViewW, confirmOrderAddressViewH)];
//    [confirmOrderAddressView addTarget:self action:@selector(chooseAddressClick:) forControlEvents:UIControlEventTouchUpInside];
//    self.confirmOrderAddressView = confirmOrderAddressView;
//    //    confirmOrderAddressView.backgroundColor = randomColor;
//    [self.subviewsContainerView addSubview:confirmOrderAddressView];
//    [self.subviewsContainer addObject:confirmOrderAddressView];
//    self.subviewsStartY+=confirmOrderAddressViewH;
//    self.subviewsStartY+=littleMargin;
//    //展示商品视图///////////////////////////////////////////
//    CGFloat showgoodsesViewW = self.subviewsContainerView.bounds.size.width ;
//    CGFloat showgoodsesViewH = 100*SCALE ;
//    CGFloat showgoodsesViewX = 0 ;
//    CGFloat showgoodsesViewY = self.subviewsStartY ;
//    
//    ShowgoodsesView * showgoodsesView = [[ShowgoodsesView alloc]initWithFrame:CGRectMake(showgoodsesViewX, showgoodsesViewY, showgoodsesViewW, showgoodsesViewH)];
//    self.showgoodsesView = showgoodsesView;
//    [showgoodsesView addTarget:self action:@selector(showGoodsDetail:) forControlEvents:UIControlEventTouchUpInside];
//    //    showgoodsesView.backgroundColor = randomColor;
//    [self.subviewsContainer addObject:showgoodsesView];
//    [self.subviewsContainerView addSubview:showgoodsesView];
//    self.subviewsStartY+=showgoodsesViewH;
//    
//    //支付配送视图///////////////////////////////////////////
//    CGFloat payTypeW = self.subviewsContainerView.bounds.size.width ;
//    CGFloat payTypeH = 60 * SCALE ;
//    CGFloat payTypeX = 0 ;
//    CGFloat payTypeY = self.subviewsStartY ;
//    PayTypeView * payType = [[PayTypeView alloc]initWithFrame:CGRectMake(payTypeX, payTypeY, payTypeW, payTypeH)];
//    self.payType = payType;
//    //    payType.backgroundColor = randomColor;
//    [self.subviewsContainerView addSubview:payType];
//    [self.subviewsContainer addObject:payType];
//    self.subviewsStartY+=payTypeH;
//    
//    //CONormalCompose
//    /** 这一期不要发票了 */
//    //发票信息视图
//    //    CGFloat invoiceInfoW = self.subviewsContainerView.bounds.size.width ;
//    //    CGFloat invoiceInfoH = 44*SCALE ;
//    //    CGFloat invoiceInfoX = 0 ;
//    //    CGFloat invoiceInfoY = self.subviewsStartY ;
//    //
//    //    CONormalCompose * invoiceInfo = [[CONormalCompose alloc]init];
//    //    [invoiceInfo addTarget:self action:@selector(showInvoiceInfo:) forControlEvents:UIControlEventTouchUpInside];
//    //    self.invoiceInfo = invoiceInfo;
//    //    invoiceInfo.frame = CGRectMake(invoiceInfoX, invoiceInfoY, invoiceInfoW, invoiceInfoH);
//    ////    invoiceInfo.backgroundColor = randomColor;
//    //    [self.subviewsContainerView addSubview:invoiceInfo];
//    //    [self.subviewsContainer addObject:invoiceInfo];
//    //    self.subviewsStartY+= invoiceInfoH;
//    //
//    //    self.subviewsStartY+=littleMargin;÷÷
//    //优惠券视图
//    CGFloat chooseCouponW = self.subviewsContainerView.bounds.size.width ;
//    CGFloat chooseCouponH = 44*SCALE ;
//    CGFloat chooseCouponX = 0 ;
//    CGFloat chooseCouponY = self.subviewsStartY ;
//    
//    CONormalCompose * chooseCoupon = [[CONormalCompose alloc]init];
//    self.chooseCoupon = chooseCoupon;
//    [chooseCoupon addTarget:self action:@selector(chooseCoupon:) forControlEvents:UIControlEventTouchUpInside];
//    chooseCoupon.frame = CGRectMake(chooseCouponX, chooseCouponY, chooseCouponW, chooseCouponH);
//    //    chooseCoupon.backgroundColor = randomColor;
//    [self.subviewsContainerView addSubview:chooseCoupon];
//    [self.subviewsContainer addObject:chooseCoupon];
//    self.subviewsStartY+= chooseCouponH;
//    /** 这一期不要L币了 */
//    //L币视图
//    
//    //    CGFloat LBW = self.subviewsContainerView.bounds.size.width ;
//    //    CGFloat LBH = 44*SCALE ;
//    //    CGFloat LBX = 0 ;
//    //    CGFloat LBY = self.subviewsStartY ;
//    //
//    //    CONormalCompose * LB = [[CONormalCompose alloc]init];
//    //    self.LB = LB;
//    //    LB.frame = CGRectMake(LBX, LBY, LBW, LBH);
//    ////    LB.backgroundColor = randomColor;
//    //    [self.subviewsContainerView addSubview:LB];
//    //    [self.subviewsContainer addObject:LB];
//    //    [LB addTarget:self action:@selector(chooseLB:) forControlEvents:UIControlEventTouchUpInside];
//    //    self.subviewsStartY+= LBH;
//    //商品金额视图
//    CGFloat goodsPriceW = self.subviewsContainerView.bounds.size.width ;
//    CGFloat goodsPriceH = 44*SCALE ;
//    CGFloat goodsPriceX = 0 ;
//    CGFloat goodsPriceY = self.subviewsStartY ;
//    
//    CONormalCompose * goodsPrice = [[CONormalCompose alloc]init];
//    self.goodsPrice = goodsPrice;
//    goodsPrice.frame = CGRectMake(goodsPriceX, goodsPriceY, goodsPriceW, goodsPriceH);
//    //    goodsPrice.backgroundColor = randomColor;
//    [self.subviewsContainerView addSubview:goodsPrice];
//    [self.subviewsContainer addObject:goodsPrice];
//    self.subviewsStartY+= goodsPriceH;
//    //运费视图
//    CGFloat freightW = self.subviewsContainerView.bounds.size.width ;
//    CGFloat freightH = 44*SCALE ;
//    CGFloat freightX = 0 ;
//    CGFloat freightY = self.subviewsStartY ;
//    
//    CONormalCompose * freight = [[CONormalCompose alloc]init];
//    self.freight = freight;
//    freight.frame = CGRectMake(freightX, freightY, freightW, freightH);
//    //    freight.backgroundColor = randomColor;
//    [self.subviewsContainerView addSubview:freight];
//    [self.subviewsContainer addObject:freight];
//    self.subviewsStartY+= freightH;
//    //优惠券/ L币折扣信息
//    
//    CGFloat discountResultW = self.subviewsContainerView.bounds.size.width ;
//    CGFloat discountResultH = 44*SCALE ;
//    CGFloat discountResultX = 0 ;
//    CGFloat discountResultY = self.subviewsStartY ;
//    
//    CONormalCompose * discountResult = [[CONormalCompose alloc]init];
//    self.discountResult = discountResult ;
//    discountResult.frame = CGRectMake(discountResultX, discountResultY, discountResultW,discountResultH);
//    //    discountResult.backgroundColor = randomColor;
//    [self.subviewsContainerView addSubview:discountResult];
//    self.subviewsStartY+= discountResultH;
//    
//    self.subviewsContainerView.contentSize = CGSizeMake(self.subviewsContainerView.bounds.size.width, self.subviewsStartY+ discountResultH);
//    
//    
//    [self.subviewsContainer addObject:confirmOrderBar];
//    [self.subviewsContainer addObject:discountResult];
//}
//-(void)reconnectClick:(UIButton *)sender{
//    //    [self confirmOrderRemoteLoadaWithAtionType:Refresh Success:^(ResponseObject *response) {
//    //        if (response.status>0) {
//    //            [self removeTheViewWhenConnect];
//    if (self.goodsIDs && !self.response) {
//        
//        [self setDataToUIWithGoodsIDs];
//    }else if (self.response&& self.goodsIDs){
//        [self setDataToUIWithResponse];
//    }
//    //        }else{
//    //
//    //        }
//    //    } failure:^(NSError *error) {
//    //
//    //    }];
//    
//}
////调取确认订单接口 提前到购物车中
//-(void)confirmOrderRemoteLoadaWithAtionType:(LoadDataActionType)actionType Success:(void(^)(ResponseObject *response))success failure:(void(^)(NSError *error))failure{
//    
//    NSMutableArray  * arrM = [NSMutableArray arrayWithCapacity:self.goodsIDs.count];
//    
//    for (SVCGoods * goods  in self.goodsIDs) {
//        
//        [arrM addObject:goods.ID];//fuck 到底是id还是goods_id
//        //        [arrM addObject:@(goods.goods_id)];
//    }
//    NSString * jsonStr = [arrM mj_JSONString];
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,jsonStr);
//    
//    [[UserInfo shareUserInfo ] confirmOrderWithGoodsId:jsonStr success:^(ResponseObject *response) {
//        
//        success(response);
//    } failure:^(NSError *error) {
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,error)
//        failure(error);
//    }];
//    
//}
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
//}
//
//-(NSMutableArray * )subviewsContainer{
//    if(_subviewsContainer==nil){
//        _subviewsContainer = [[NSMutableArray alloc]init];
//    }
//    return _subviewsContainer;
//}
//-(NSMutableArray * )datas{
//    if(_datas==nil){
//        _datas = [[NSMutableArray alloc]init];
//        
//    }
//    return _datas;
//}
////点击方法
//-(void)creatOrderClickWithConfirmOrderBar:(ConfirmOrderBar*)confirmOrderBar{
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"立即下单")
//    NSMutableArray * tempArrM = [NSMutableArray array];
//    for (CCCouponsModel*couponseModel in self.choosedCoupons) {
//        [tempArrM addObject:couponseModel.cid];
//    }
//    NSString * tempJsonStr = [tempArrM mj_JSONString];
//    LOG(@"_%@_%d_优惠券id%@",[self class] , __LINE__,tempJsonStr);
//    BaseModel * creatOrderModel = [[BaseModel alloc]init];
//    
//    NSMutableArray * goodsIDArr = [NSMutableArray array ];
//    
//    for (SVCGoods * goods in self.goodsIDs) {
//        [goodsIDArr addObject:goods.ID]; //到底是id还是goods_id
//        //        [goodsIDArr addObject:@(goods.goods_id)];
//    }
//    NSString * goodsIDsJson = [goodsIDArr mj_JSONString];
//    creatOrderModel.actionKey = @"CreateOrderVC";
//    LOG(@"%@,%d,%ld,%d,%@%@%@%@%@",[self class], __LINE__,self.usedLB,self.setInvoice,self.addressModel.ID,@"",goodsIDsJson,tempJsonStr,@"")
//    if (!(self.addressModel.ID||goodsIDsJson||tempJsonStr)) {
//        AlertInVC(@"订单已失效,请重新选择商品");
//        return;
//    }
//    NSDictionary    *  keyParamete =     @{
//                                           @"usedLB":@(self.usedLB),
//                                           @"setInvoice":@(self.setInvoice),
//                                           @"addressID":self.addressModel.ID,
//                                           @"shipping":@"",
//                                           @"goodsIDs":goodsIDsJson,
//                                           @"couponseIDs":tempJsonStr,
//                                           @"payment":@""
//                                           };
//    NSString * usedLB = keyParamete[@"usedLB"];
//    NSString * setInvoice = keyParamete[@"setInvoice"];
//    NSString * addressID = keyParamete[@"addressID"];
//    NSString * shipping = keyParamete[@"shipping"];
//    NSString * goodsIDs = keyParamete[@"goodsIDs"];
//    NSString * couponseIDs = keyParamete[@"couponseIDs"];
//    NSString * payment = keyParamete[@"payment"];
//    LOG(@"%@,%d,%@",[self class], __LINE__,goodsIDs)
//    LOG(@"%@,%d,%@",[self class], __LINE__,payment)
//    LOG(@"%@,%d,%@",[self class], __LINE__,shipping)
//    LOG(@"%@,%d,%@",[self class], __LINE__,couponseIDs)
//    LOG(@"%@,%d,%@",[self class], __LINE__,usedLB)
//    LOG(@"%@,%d,%@",[self class], __LINE__,addressID)
//    [[UserInfo shareUserInfo] creatOrderWithUserGoods_ID:goodsIDs payMent:payment shipingType:shipping invoiceOrNot:setInvoice couponsIDs:couponseIDs LBCount:usedLB  addressID:addressID  success:^(ResponseObject *responseObject) {
//        if (responseObject.status>0) {
//            
//            
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
//            creatOrderModel.keyParamete = @{
//                                            @"paramete":responseObject.data
//                                            };
//            [[SkipManager shareSkipManager] skipByVC:self withActionModel:creatOrderModel];
//            
//        }else{
//            MBProgressHUD * hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//            hub.mode=MBProgressHUDModeText;
//            [hub hide:YES afterDelay:1.5];
//            if (self.showgoodsesView.cellModel.items.count==1) {
//                hub.labelText=@"该商品已下架,请您再次购买";
//            }else{
//                hub.labelText=@"已有商品下架，请刷新重试";
//            }
//            hub.completionBlock = ^{
//                [self.navigationController popViewControllerAnimated:YES];
//            };
//        }
//        
//    } failure:^(NSError *error) {
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
//        MBProgressHUD * hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        hub.mode=MBProgressHUDModeText;
//        [hub hide:YES afterDelay:1.5];
//        if (self.showgoodsesView.cellModel.items.count==1) {
//            hub.labelText=@"该商品已下架,请您再次购买";
//        }else{
//            hub.labelText=@"已有商品下架，请刷新重试";
//        }
//        hub.completionBlock = ^{
//            [self.navigationController popViewControllerAnimated:YES];
//        };
//    }];
//    
//}
//#pragma 跳转并选择相应的选项 , 并通过代理回传值
//-(void)chooseAddressClick:(ConfirmOrderAddressView*)sender
//{
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"选择地址")
//    //    BaseModel * chooseAddressModel = [[BaseModel alloc]init];
//    //    chooseAddressModel.actionKey = @"ChooseAddressVC";
//    //    [[SkipManager shareSkipManager] skipByVC:self withActionModel:chooseAddressModel];
//    //
//    
//    ChooseAddressVC * chooseAddressVC = [[ChooseAddressVC alloc]init];
//    chooseAddressVC.choosedAddressID = [self.addressModel.ID integerValue];
//    chooseAddressVC.ChooseAddressDelegate = self;
//    [self.navigationController pushViewController:chooseAddressVC animated:YES];
//}
//-(void)chooseTheAddressModel:(AMCellModel *)addressModel{
//    self.addressModel = addressModel;
//    
//    [self analysisData:self.response];
//}
//
//-(void)showGoodsDetail:(ShowgoodsesView*)sender
//{
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"查看所选商品")
//    NSMutableArray * goodsIDArr  = [NSMutableArray array];
//    for (NSDictionary * sub in sender.cellModel.items) {
//        NSNumber*goodsID = sub[@"id"];
//        [goodsIDArr addObject:goodsID];
//    }
//    NSString * jsonGoodsID = [goodsIDArr mj_JSONString];
//    
//    BaseModel * goodsInOrderModel = [[BaseModel alloc]init];
//    
//    goodsInOrderModel.actionKey = @"GoodsInOrderVC";
//    goodsInOrderModel.keyParamete = @{@"paramete":jsonGoodsID};
//    
//    [[SkipManager shareSkipManager] skipByVC:self withActionModel:goodsInOrderModel];
//}
//-(void)showInvoiceInfo:(CONormalCompose*)sender
//{
//    self.setInvoice=NO;
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"查看发票信息")
//    InvoiceDetailVC * invoiceDetailVC = [[InvoiceDetailVC alloc]init];
//    invoiceDetailVC.InvoiceDetailDelegate=self;
//    [self.navigationController pushViewController:invoiceDetailVC animated:YES];
//}
////设置发票信息的代理
//-(void)setInvoiceOrNot:(BOOL)setIvnoice{
//    if (setIvnoice) {
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"设置了发票信息");
//    }else{
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"没设置发票信息");
//    }
//    self.setInvoice = setIvnoice;
//}
////选择优惠券
//-(void)chooseCoupon:(CONormalCompose*)sender
//{
//    if (self.chooseCoupon.normalCellModel.items.count==0) {
//        return;
//    }
//    self.totalCouponsMoney = 0 ;
//    
//    
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"选择优惠券")
//    //如果有优惠券就可点击  否则就不能点击
//    NSMutableArray * goodsIDArr  = [NSMutableArray array];
//    for (NSDictionary * sub in self.showgoodsesView.cellModel.items) {
//        NSNumber*goodsID = sub[@"id"];
//        [goodsIDArr addObject:goodsID];
//    }
//    NSString * jsonGoodsID = [goodsIDArr mj_JSONString];
//    ChooseCounposeVC * chooseCounposeVC = [[ChooseCounposeVC alloc]init];
//    chooseCounposeVC.ChooseCounposeDelegate=self;
//    chooseCounposeVC.goodsID = jsonGoodsID;
//    chooseCounposeVC.selectCouponses= self.choosedCoupons.mutableCopy;
//    [self.navigationController pushViewController:chooseCounposeVC animated:YES];
//    
//}
//-(void)chooseCouponseWithConposeArr:(NSArray *)conposeArr{
//    //先把上次选择的清空
//    self.choosedCoupons = nil;
//    self.totalCouponsMoney = 0 ;
//    self.choosedCoupons = conposeArr.mutableCopy;
//}
////选择LB
//-(void)chooseLB:(CONormalCompose*)sender{
//    self.usedLB= 0;
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"选择L币")
//    //如果有L币就可点击  否则就不能点击
//    if ( [self.LB.normalCellModel.subtitle integerValue]>0) {
//        ChooseLBVC * lbVC = [[ChooseLBVC alloc]init];
//        lbVC.lb = [self.LB.normalCellModel.subtitle integerValue];
//        lbVC.ChooseLBDelegate=self;
//        [self.navigationController pushViewController:lbVC animated:YES];
//    }
//}
//-(void)chooseLBCount:(NSUInteger)lbCount{//lb不用传 , 当前控制器可以获取
//    if (lbCount==0) {
//        return;
//    }
//    //先把上次选择的清空
//    self.usedLB =0;
//    //判断总价钱和lb总数的关系 , 如果lb小于总价 , 就是全部使用  , 如果lb大于总价 , 就使用总价对应的lb的数量
//    LOG(@"_%@_%d_使用了lb的数量%lu",[self class] , __LINE__,lbCount);
//    NSUInteger lb = [self.LB.normalCellModel.subtitle integerValue];
//    if (lb>[self.originMoney integerValue]*1000) {
//        self.usedLB = (NSInteger)[self.originMoney integerValue]*1000;
//    }else{
//        self.usedLB = lb;
//        
//    }
//}
//-(void)setAddressModel:(AMCellModel *)addressModel{
//    _addressModel = addressModel;
//    ConfirmOrderNormalCellModel * viewModel = [[ConfirmOrderNormalCellModel alloc]init];
//    viewModel.items = [@[addressModel] mutableCopy];
//    self.confirmOrderAddressView.cellModel = viewModel;
//}
//
//-(void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//    if (self.isNeedDestroy) {
//        self.isNeedDestroy=NO ;
//        [self removeFromParentViewController];
//    }
//}
//-(void)testCallBack
//{
//    //    PayMentManager * manager = [[PayMentManager alloc]init];
//    //    self.manager = manager;
//    //    manager.myCallBack = ^(id result){
//    //        LOG(@"_%@_%d_执行结果%@",[self class] , __LINE__,result );
//    //
//    //    }  ;
//    //    [manager payWithParemete:@"开始调用支付控件" payMentType:AliPay];
//    //
//}
////-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
////
////    [self.manager testWithParamete:@"模拟支付成功的回调结果"];
////
////}
//
//-(void)shopCarChangedCallBack
//{
//    self.isNeedDestroy=YES ;
//}
//-(void)dealloc{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}




@end
