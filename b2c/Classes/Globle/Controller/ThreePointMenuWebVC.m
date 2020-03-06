//
//  ThreePointMenuWebVC.m
//  b2c
//
//  Created by wangyuanfei on 7/22/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "ThreePointMenuWebVC.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "MyInputAccessoryView.h"
#import "AuthForPaypsdVC.h"
#import "ChangePasswordVC.h"

#import "UMSocialData.h"

#import "UMSocialSnsService.h"
#import "b2c-Swift.h"
#import "UMSocialSnsPlatformManager.h"
@interface ThreePointMenuWebVC ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler,MyInputAccessoryViewDelegate,UMSocialUIDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

/** 确认收货相关  开始 */
{
    /** 接收用户密码的隐形输入框 */
@private
    UITextField * _acceptPassword;
}

/** 辅助键盘 */
@property(nonatomic,weak)MyInputAccessoryView * myAccessoryView ;

@property(nonatomic,weak)UIButton * corverView ;

/** 确认收货相关  结束 */


@property(nonatomic,weak)UIButton * testRightButton ;
/**
 https:/ /m.baidu.com/?from=844b&vit=fps
 */
@property(nonatomic,copy)NSString * confirmInceptOrderID ;//确认收货专用id
@property(nonatomic,copy)NSString * confirmInceptShopID ;//确认收货专用shopID
@property(nonatomic,strong)UIActivityIndicatorView * activetyIndicator ;


@end

@implementation ThreePointMenuWebVC

-(UIActivityIndicatorView * )activetyIndicator{
    if(_activetyIndicator==nil){
        _activetyIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self.view addSubview:_activetyIndicator];
        _activetyIndicator.center = self.view.center;
        
    }
    return _activetyIndicator;
}
-(instancetype)initWithURLStr:(NSString*)urlStr{
    if (self=[super init]) {
        self.originURL = urlStr;
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviTitle=nil;
    if (self.keyParamete[@"paramete"]) {
//        self.originURL = self.keyParamete[@"paramete"];
//        self.originURL = [NSString stringWithFormat:@"%@?token=%@",self.keyParamete[@"paramete"],[UserInfo shareUserInfo].token];

        NSString * urlStr = self.keyParamete[@"paramete"];
        if ([urlStr isKindOfClass:[NSString class]]) {
            if (![urlStr hasPrefix:@"http"]) {
                urlStr = [@"https://" stringByAppendingString:urlStr];
            }
            self.originURL = urlStr ;
            if ([urlStr containsString:@"?"]) {
                self.originURL = [NSString stringWithFormat:@"%@&token=%@",urlStr,[UserInfo shareUserInfo].token];
                
            }else{
                self.originURL = [NSString stringWithFormat:@"%@?token=%@",urlStr,[UserInfo shareUserInfo].token];
            }
        }else{
            [GDAlertView alert:@"链接类型错误" image:nil  time:3 complateBlock:^{}];
        }
        NSLog(@"%@, %d ,%@",[self class],__LINE__,self.originURL);
    }else if (self.originURL){
        //
//        self.originURL = [NSString stringWithFormat:@"%@?token=%@",self.originURL,[UserInfo shareUserInfo].token];
        if (![self.originURL hasSuffix:@"http"]) {
            self.originURL = [@"https://" stringByAppendingString:self.originURL];
        }
        if ([self.originURL containsString:@"?"]) {
            self.originURL = [NSString stringWithFormat:@"%@&token=%@",self.originURL,[UserInfo shareUserInfo].token];
            
        }else{
            self.originURL = [NSString stringWithFormat:@"%@?token=%@",self.originURL,[UserInfo shareUserInfo].token];
        }
    }else {
        AlertInVC(@"url is null\nplease try again");
        return;
    }
    [self setupWebView];
    //    [self testCustomGesture];
    //    UIButton * testRightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    //    self.testRightButton = testRightButton;
    //    [testRightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    //    [testRightButton setTitle:@"测试" forState:UIControlStateNormal];
    //    [testRightButton addTarget:self action:@selector(testRight) forControlEvents:UIControlEventTouchUpInside];
    //    self.navigationBarRightActionViews = @[testRightButton];
    
    /** 确认收货开始 */
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
    
    MyInputAccessoryView * myAccessoryView   = [[MyInputAccessoryView alloc]initWithFrame:CGRectMake(0, 0, 300, 128*SCALE)];;
    self.myAccessoryView = myAccessoryView;
    myAccessoryView.InputAccessoryViewDelegate = self;
    UITextField * acceptPassword = [[UITextField alloc]init];
    acceptPassword.inputAccessoryView = myAccessoryView;
    acceptPassword.keyboardType=UIKeyboardTypeNumberPad;
    _acceptPassword=acceptPassword;
    [self.view addSubview:acceptPassword];
    /** 确认收货结束 */
    
    
    // Do any additional setup after loading the view.
}

//-(void)testCustomGesture
//{
//    // 获取系统自带滑动手势的target对象
////    id target = self.interactivePopGestureRecognizer.delegate;
//    id target = [[self valueForKey:@"interactivePopGestureRecognizer"] objectForKey:@"delegate"];
//    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
//    // 设置手势代理，拦截手势触发
//    pan.delegate = self;
//    // 给导航控制器的view添加全屏滑动手势
//    [self.view addGestureRecognizer:pan];
//    // 禁止使用系统自带的滑动手势
//    [[self valueForKey:@"interactivePopGestureRecognizer"] setValue:@(0) forKey:@"enable"];
//}
//- (void)goForward:(nullable id)sender{}








/*! @abstract The minimum font size in points.
 @discussion The default value is 0.
 */
//@property (nonatomic) CGFloat minimumFontSize;

/*! @abstract A Boolean value indicating whether JavaScript is enabled.
 @discussion The default value is YES.
 */
//@property (nonatomic) BOOL javaScriptEnabled;

/*! @abstract A Boolean value indicating whether JavaScript can open
 windows without user interaction.
 @discussion The default value is NO in iOS and YES in OS X.
 */
//@property (nonatomic) BOOL javaScriptCanOpenWindowsAutomatically;

//#if !TARGET_OS_IPHONE
/*! @abstract A Boolean value indicating whether Java is enabled.
 @discussion The default value is NO.
 */
//@property (nonatomic) BOOL javaEnabled;

/*! @abstract A Boolean value indicating whether plug-ins are enabled.
 @discussion The default value is NO.
 */
//@property (nonatomic) BOOL plugInsEnabled;
-(void)setupWebView
{
    
    
    
    
    
    
    CGRect frame = CGRectMake(0,64, self.view.bounds.size.width, self.view.bounds.size.height-self.startY);
    WKWebViewConfiguration* config = [[WKWebViewConfiguration alloc]init];
//    config.preferences.javaScriptEnabled = YES;
//    config.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    [config.userContentController addScriptMessageHandler:self name:@"zjlao"];//传值的关键 , 释放的时候记得移除
    
    LOG(@"_%@_%d_%@",[self class] , __LINE__,config.userContentController);
    
    WKWebView * webview = [[WKWebView alloc]initWithFrame:frame configuration:config];
    
    webview.navigationDelegate = self;
    webview.UIDelegate = self;
    webview.allowsBackForwardNavigationGestures = YES;
    //    webview.allowsLinkPreview = YES;
    //    self.view.backgroundColor=randomColor;
    self.webview=webview;
    [self.view addSubview:webview];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,self.originURL);
    //字符串加百分号转义使用编码 (这个方法会把参数里面的东西转义)
    NSString * targetUrlStr  = [self.originURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//转义一下,把中文部分转义
    NSLog(@"_%d_%@",__LINE__,targetUrlStr);
    //字符串替换百分号转义使用编码
    //    NSString *str1 = [targetUrlStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//反转义,把被转义成中文的部分 转回中文
    //     NSLog(@"_%d_%@",__LINE__,str1);
    //    NSURL * url = [[NSURL alloc]initWithString:self.originURL];如果给的字符串有中文的话 , 会初始化NSURL失败 , 所以要转义一下
    NSURL * url = [[NSURL alloc]initWithString:targetUrlStr];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url];
    [self.webview loadRequest:request];
    HomeRefreshHeader * refreshHeader = [HomeRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    self.webview.scrollView.mj_header=refreshHeader;
    
}

-(void )refreshData
{
    [self.webview reload];
}

-(void)test
{
    //    WKScriptMessageHandler
    //    - (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message;
    
    /**
     let conf = WKWebViewConfiguration()
     conf.userContentController.addScriptMessageHandler(self, name: "OOXX")
     
     self.wk = WKWebView(frame: self.view.frame, configuration: conf)
     */
}

/**
 - (void)evaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^)(id, NSError *))completionHandler;
 ///不建议使用这个办法  因为会在内部等待webView 的执行结果
 - (NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)javaScriptString __deprecated_msg("Method deprecated. Use [evaluateJavaScript:completionHandler:]");
 
 
 */
-(void)testRight
{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"可以测试了")
    //    NSString * js = @"WVcallBack(1);";
    NSString * js = [NSString stringWithFormat:@"WVcallBack(%@);",[UserInfo shareUserInfo].member_id];
#pragma   app传递数据到js
    __weak typeof(self) weakSelf = self;
    [self.webview evaluateJavaScript:js completionHandler:^(id _Nullable parama, NSError * _Nullable error) {
        LOG(@"_%@_%d_%@",[weakSelf class] , __LINE__,parama);
        LOG(@"_%@_%d_%@",[weakSelf class] , __LINE__,error)
    }];
    
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    //    LOG_METHOD
#pragma    js传递数据到app
    LOG(@"_%@_%d_%@",[self class] , __LINE__,message.body);
    LOG(@"_%@_%d_%@",[self class] , __LINE__,message.name);
    [self analysisTheDateFromJS:message];
    
    //    15142302652
}

-(void)analysisTheDateFromJS:(WKScriptMessage*)message{
    if ([message.name isEqualToString:@"zjlao"]) {
        if (message.body && [message.body isKindOfClass:[NSDictionary class]]) {
            NSString * action =message.body[@"action"];
            if (action) {
                if ([action isEqualToString:@"alert"]) {
                    [self performAlertWith:message.body];
                }else if ([action isEqualToString:@"confirm"]){
                    [self performConfirmWith:message.body];
                }else if ([action isEqualToString:@"jump"]){
                    [self performJumpWith:message.body];
                }else if ([action isEqualToString:@"pay"]){
                    [self performPayWith:message.body];
                }else if ([action isEqualToString:@"share"]){
                    [self performShareWith:message.body];
                }else if ([action isEqualToString:@"closewebview"]){
                    [self.navigationController popViewControllerAnimated:YES];
                }else if ([action isEqualToString:@"OpenFile"]){
                    [self uploadimg];
                }else if ([action isEqualToString:@"addcar"]){
                    [self performAddToShoppingCar:message.body];
                }
            }
            //            LOG(@"_%@_%d_%@",[self class] , __LINE__,message.body[@"action"]);
        }
    }else{
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"js的方法名未在本地注册");
    }
    
}
-(void)performAddToShoppingCar:(id)data{
    NSDictionary * paramete = (NSDictionary*)data ;
    NSString * type = paramete[@"type"];
    if (type) {
        if ([type isEqualToString:@"0"]) {//无规格,直接执行加入购物车动画(wap页自己执行)
            NSString * goodsID = paramete[@"goodsid"]; //所操作的商品的id
            
        }else if([type isEqualToString:@"1"]){//有规格 , 先弹出原生的选规格提示框  , 点击完成后 , 调用js传递参数 , 并执行加入购物车动画
            NSString * goodsID = paramete[@"goodsid"]; //所操作的商品的id
        }
    }
}
-(void)performAlertWith:(id)data{
    NSDictionary * paramete = (NSDictionary*)data ;
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:paramete[@"title"] message:paramete[@"content"] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * actioin = [UIAlertAction actionWithTitle:paramete[@"buttonT"] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:actioin];
    [self presentViewController:alert animated:YES completion:nil ];
    
}
-(void)performConfirmWith:(id)data{
    NSDictionary * paramete = (NSDictionary*)data ;
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:paramete[@"title"] message:paramete[@"content"] preferredStyle:UIAlertControllerStyleAlert];
    //    UIAlertController * alert =[[UIAlertController alloc]init];
    UIAlertAction * actioin1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString * js = @"WVcallBack(1);";
        [self.webview evaluateJavaScript:js completionHandler:^(id _Nullable parama, NSError * _Nullable error) {//给js传值1
            LOG(@"_%@_%d_%@",[self class] , __LINE__,parama);
            LOG(@"_%@_%d_%@",[self class] , __LINE__,error)
        }];
    }];
    UIAlertAction * actioin2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSString * js = @"WVcallBack('0');";
        __weak typeof(self) weakSelf = self;
        
        [self.webview evaluateJavaScript:js completionHandler:^(id _Nullable parama, NSError * _Nullable error) {//给js传值0
            LOG(@"_%@_%d_%@",[weakSelf class] , __LINE__,parama);
            LOG(@"_%@_%d_%@",[weakSelf class] , __LINE__,error)
        }];
    }];
    
    [alert addAction:actioin2];
    [alert addAction:actioin1];
    [self presentViewController:alert animated:YES completion:nil ];
}
-(void)performJumpWith:(id)data{
    NSDictionary * paramete = (NSDictionary*)data ;
    NSString * type = paramete[@"type"];
    if (type) {
        if ([type isEqualToString:@"goods"]) {
            NSString * goodsID = paramete[@"id"];//要跳转到商品详情的商品id
            LOG(@"_%@_%d_即将跳转到商品详情页 , 商品id为 :%@",[self class] , __LINE__,goodsID);
            BaseModel * GoodsVCModel = [[BaseModel alloc]init];
            GoodsVCModel.actionKey = @"HGoodsVC";
            GoodsVCModel.keyParamete = @{@"paramete":goodsID};
            [[SkipManager shareSkipManager] skipByVC:self withActionModel:GoodsVCModel];
        }else if([type isEqualToString:@"coupon"]){
            NSString * couponID = paramete[@"id"];//要跳转到优惠券的优惠券idCouponsDetailVC
            LOG(@"_%@_%d_即将跳转到优惠券详情页 , 优惠券id 为 : %@",[self class] , __LINE__,couponID);
            BaseModel * CouponsDetailVCModel = [[BaseModel alloc]init];
            CouponsDetailVCModel.actionKey = @"CouponsDetailVC";
            CouponsDetailVCModel.keyParamete = @{@"paramete":couponID};
            [[SkipManager shareSkipManager] skipByVC:self withActionModel:CouponsDetailVCModel];
        }else if([type isEqualToString:@"couponList"]){
            //直接跳转到优惠券列表页面
            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"即将跳转到优惠券列表页");
            BaseModel * couponseListModel = [[BaseModel alloc]init];
            couponseListModel.actionKey = @"HCouponsVC";
            [[SkipManager shareSkipManager] skipByVC:self withActionModel:couponseListModel];
        }else if([type isEqualToString:@"shop"]){
            NSString * shopID = paramete[@"id"];//要跳转到店铺的店铺id
            LOG(@"_%@_%d_即将跳转到店铺首页 , 店铺id 为 :%@",[self class] , __LINE__,shopID);
            BaseModel * ShopVCModel = [[BaseModel alloc]init];
            ShopVCModel.actionKey = @"HShopVC";
            ShopVCModel.keyParamete = @{@"paramete":shopID};
            [[SkipManager shareSkipManager] skipByVC:self withActionModel:ShopVCModel];
        }else if([type isEqualToString:@"similarityGoods"]){//相似商品  , 记得取出id
            NSString * goodsID = paramete[@"id"];//相似商品的id
            LOG(@"_%@_%d_即将跳转到当前商品的相似商品的列表页 , 当前商品的id为 : %@",[self class] , __LINE__,goodsID);
        }else if ( [type isEqualToString:@"url"]){
            NSString * url = paramete[@"url"];
            BaseModel * CouponsDetailVCModel = [[BaseModel alloc]init];
            CouponsDetailVCModel.actionKey = @"BaseWebVC";
            CouponsDetailVCModel.keyParamete = @{@"paramete":url};
            [[SkipManager shareSkipManager] skipByVC:self withActionModel:CouponsDetailVCModel];
        }else if ( [type isEqualToString:@"chat"]){
            NSString * userName = paramete[@"name"];
            XMPPJID * userJid = [XMPPJID jidWithUser:userName domain:JabberDomain resource:nil];
            BaseModel * model = [[BaseModel alloc]init];
            model.actionKey=ChatVCName;
            model.keyParamete = @{@"paramete":userJid};
            [[SkipManager shareSkipManager] skipByVC:self withActionModel:model];
        }else if ( [type isEqualToString:@"search"]){//wap页传关键词 ,跳转到搜索列表页(原生的)
            
            NSString * searchType = paramete[@"searchtype"];//搜索类型 1 搜商品 , 2 , 搜店铺
            NSString * keyword = paramete[@"keyword"];//关键词
            NSString * searchArea = paramete[@"searcharea"];//(搜商品时:) 1 在全网范围内搜索 , 2 , 在单个店铺内搜索
            if ([searchType isEqualToString:@"1"] && [searchArea isEqualToString:@"1"]) {
                BaseModel * model = [[BaseModel alloc]init];
                model.actionKey=@"HSearchgoodsListVC";
                if (keyword) {
                    model.keyParamete = @{ @"paramete":keyword};
                }else{
                    model.keyParamete = @{ @"paramete":@"热搜"};
                }
                [[SkipManager shareSkipManager] skipByVC:self withActionModel:model];
            }
            
        }else if ( [type isEqualToString:@"gotoshopcart"]){//跳转到原生的购物车
            //TODO 等待执行跳转到购物车
            BaseModel *baseModel = [[BaseModel alloc] init];
            baseModel.judge = YES;
            baseModel.actionKey = @"ShopCarVC";
            [[SkipManager shareSkipManager] skipByVC:self withActionModel:baseModel];
        }
    }
    
}

-(void)performPayWith:(id)data
{    NSDictionary * paramete = (NSDictionary*)data ;
    NSString * type = paramete[@"type"];
    if ([type isEqualToString:@"order"]) {
        NSString * orderID = paramete[@"id"];
        LOG(@"_%@_%d_即将执行支付  , 订单id 为 : %@",[self class] , __LINE__,orderID);
        BaseModel *baseModel = [[BaseModel alloc] init];
        baseModel.actionKey = @"ChoosePaymentVC";
        NSDictionary * targetParamete = @{@"orderID":orderID};
        baseModel.keyParamete = @{@"paramete":targetParamete};
        [[SkipManager shareSkipManager] skipByVC:self withActionModel:baseModel];
    }else if ([type isEqualToString:@"check"]){//wap页确认收货时验证支付密码
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"wap页确认收货时验证支付密码");
        self.confirmInceptOrderID=paramete[@"orderid"];
        self.confirmInceptShopID = paramete[@"shopid"];
        [self performpay:nil];
#pragma   app传递数据到js
        //        NSString * js = @"paypassword(283,37,1);";
        //        __weak typeof(self) weakSelf = self;
        //        [self.webview evaluateJavaScript:js completionHandler:^(id _Nullable parama, NSError * _Nullable error) {
        //            LOG(@"_%@_%d_%@",[weakSelf class] , __LINE__,parama);
        //            LOG(@"_%@_%d_%@",[weakSelf class] , __LINE__,error)
        //        }];
        
    }
    
}

/** 确认支付密码相关   ------开始---------- */

-(void)performpay:(UIButton*)sender
{
    ////////////////////////
    //    if (!self.orderID) {
    //        AlertInVC(@"订单id为空")
    //        return;
    //    }
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
        }//走到了确认收货这一步说明一定有了支付密码(不一定啊)
        else{//
            UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请设置支付密码" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //                BaseModel * model = [[BaseModel alloc]init];
                //                model.actionKey = @"";
                ChangePasswordVC * setPayPsdVC  = [[ChangePasswordVC alloc]initWithType:SetPayPassword];
                [self.navigationController pushViewController:setPayPsdVC animated:YES];
                
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
                //                [self enterPayPasswordAndPayWithBanlance];
                //                };
                [self.corverView removeFromSuperview];
                self.corverView=nil;
                [self.view endEditing:YES];
                _acceptPassword.text=nil;
                [self.myAccessoryView trendsChangeInputViewWithLength:0];
#pragma   app传递数据到js
                NSString * js = [NSString stringWithFormat:@"paypassword(%@,%@,1);",self.confirmInceptOrderID,self.confirmInceptShopID];
                __weak typeof(self) weakSelf = self;
                [self.webview evaluateJavaScript:js completionHandler:^(id _Nullable parama, NSError * _Nullable error) {
                    LOG(@"_%@_%d_%@",[weakSelf class] , __LINE__,parama);
                    LOG(@"_%@_%d_%@",[weakSelf class] , __LINE__,error)
                    
                }];
            }
        } failure:^{
            
        }];
        
    }
}
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    if ([self.webview.backForwardList.currentItem.URL.absoluteString containsString:@"orderlist5"]) {
//        [self.webview reload];
//    }
//}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if( ![self.webview.backForwardList.currentItem.URL.absoluteString containsString:@"priceappeal2"]){
        
        [self.webview reload];////////
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

-(void)checkPayPassword
{
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
                //                ChangePasswordVC * setPayPsdVC  = [[ChangePasswordVC alloc]initWithType:SetPayPassword];
                //                [self.navigationController pushViewController:setPayPsdVC animated:YES];
                
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
//-(void)checkPayPasswordSuccess:(void(^)(BOOL payPasswordLawful))success failure:(void(^)())failure//判断支付密码的有无
//{
//    if (1) {
//        success(YES);
//        //        success(NO);
//    }else{
//        failure();
//    }
//}


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


/** 辅助键盘代理 */

-(void)forgetPasswordActionWithAccessoryView:(MyInputAccessoryView *)accessoryView{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"代理执行成功");
    //    BaseModel * model = [[BaseModel alloc]init];
    //    model.actionKey = @"AuthForPaypsdVC";
    //    [[SkipManager shareSkipManager] skipByVC:self withActionModel:model];
    [self.corverView removeFromSuperview];
    self.corverView = nil ;
    
    [self.view endEditing:YES];
    AuthForPaypsdVC * authForPayPsdVC = [[AuthForPaypsdVC alloc]init];
    [self.navigationController pushViewController:authForPayPsdVC animated:YES];
}

-(void)removeCorver
{
    [self.view endEditing:YES];
    [self.corverView removeFromSuperview];
    self.corverView=nil;
}
//-(void)enterPayPasswordAndPayWithBanlance
//{
//    [[UserInfo shareUserInfo] payByBalanceWithOrderID:self.orderID success:^(ResponseObject *responseObject) {
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
//        if (responseObject.status>0) {
//
//            [self theViewWithPayResult:PaySuccess];
//        }else{
//            NSString  * result =responseObject.msg;
//            AlertInVC(result);
//        }
//    } failure:^(NSError *error) {
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
//        [self theViewWithPayResult:PayFailure];
//    }];
//}


/** 确认收货结束 */
-(void)performShareWith:(id)data{
    NSDictionary * paramete = (NSDictionary*)data ;
    NSString * type = paramete[@"type"];
    if (type) {
        if ([type isEqualToString:@"goods"]) {//分享商品 , 记得取出id
            NSString * goodsID = paramete[@"id"];
            LOG(@"_%@_%d_即将分享当前商品 ,商品 ID为 : %@",[self class] , __LINE__,goodsID);
        }else if([type isEqualToString:@"coupon"]){//分享优惠券 , 记得取出id
            NSString *imageUrl = [NSString stringWithFormat:@"%@/%@", IMGDOMAIN,paramete[@"logo"]];
            NSString * couponID = paramete[@"id"];
            [UMSocialData defaultData].extConfig.title = paramete[@"shop"];
            NSString *url = [NSString stringWithFormat:@"%@/Index/couponsdetail/id/%@.html", WAPDOMAIN, couponID];
            [UMSocialData defaultData].extConfig.qqData.url = url;
            [UMSocialData defaultData].extConfig.wechatSessionData.url=url;
            [UMSocialData defaultData].extConfig.wechatTimelineData.url=url;
            [UMSocialData defaultData].extConfig.qzoneData.url=url;
            [UMSocialData defaultData].extConfig.wechatTimelineData.shareText = [NSString stringWithFormat:@"我在直接捞发现了一个超值的优惠券快来看看吧 :%@",paramete[@"shop"]];
            [UMSocialData defaultData].extConfig.sinaData.shareText = [NSString stringWithFormat:@"我在直接捞发现了一个超值的优惠券快来看看吧 %@ @直接捞 %@",paramete[@"shop"],url];
            UIImageView *sharImage = [[UIImageView alloc] init];
            NSLog(@"%@, %d ,%@",[self class],__LINE__,imageUrl);

            
            [sharImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:placeImage options:SDWebImageCacheMemoryOnly completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                NSLog(@"%@, %d ,%@",[self class],__LINE__,image);
                
                UIImage *img = [image imageByScalingToSize:CGSizeMake(100, 100)];
                [UMSocialData defaultData].extConfig.sinaData.shareImage = img;
                [UMSocialData defaultData].extConfig.wechatTimelineData.shareImage = img;
                
                [UMSocialSnsService presentSnsIconSheetView:self
                                                     appKey:@"574e769467e58efcc2000937"
                                                  shareText:[NSString stringWithFormat:@"我在直接捞发现一个超值的优惠券，快来看看吧"]
                                                 shareImage:img
                                            shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ]
                                                   delegate:self];
            }];

            
            
            
            
            
            
        }else if([type isEqualToString:@"shop"]){//分享店铺 , 记得取出id
            NSString * shopID = paramete[@"id"];
            LOG(@"_%@_%d_即将分享当前店铺 , 店铺id为 : %@",[self class] , __LINE__,shopID);
        }
    }
    
}
/** 友盟的回调方法 */
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的平台名
        LOG(@"_%@_%d_分享到的平台名->%@",[self class] , __LINE__,[[response.data allKeys] objectAtIndex:0]);
        //        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}
//UIDElegate
/** 弹框提示 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    LOG_METHOD
    LOG(@"_%@_%d_%@",[self class] , __LINE__,message)
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * actioin = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:actioin];
    [self presentViewController:alert animated:YES completion:nil ];
    completionHandler();
}

/** 确认/取消(也是弹框的形式 , 需要给wap传值) */
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    LOG_METHOD
    LOG(@"_%@_%d_%@",[self class] , __LINE__,message)
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * actioin = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:actioin];
    [self presentViewController:alert animated:YES completion:nil ];
    completionHandler(YES);
}

/*! @abstract Displays a JavaScript text input panel.
 @param webView The web view invoking the delegate method.
 @param message The message to display.
 @param defaultText The initial text to display in the text entry field.
 @param frame Information about the frame whose JavaScript initiated this call.
 @param completionHandler The completion handler to call after the text
 input panel has been dismissed. Pass the entered text if the user chose
 OK, otherwise nil.
 @discussion For user security, your app should call attention to the fact
 that a specific website controls the content in this panel. A simple forumla
 for identifying the controlling website is frame.request.URL.host.
 The panel should have two buttons, such as OK and Cancel, and a field in
 which to enter text.
 
 If you do not implement this method, the web view will behave as if the user selected the Cancel button.
 */
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler{
    __weak typeof(self) weakSelf = self;
    LOG(@"_%@_%d_%@",[weakSelf  class] , __LINE__,prompt)
    LOG_METHOD
    completionHandler(@"dddd");
    
}





//////////navigationDelegate//////////////

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{//1
    [self.activetyIndicator startAnimating];
    LOG_METHOD
    LOG(@"_%@_%d_%@",[self class] , __LINE__,navigationAction.request)
    decisionHandler(YES);
    
}

/*! @abstract Decides whether to allow or cancel a navigation after its
 response is known.
 @param webView The web view invoking the delegate method.
 @param navigationResponse Descriptive information about the navigation
 response.
 @param decisionHandler The decision handler to call to allow or cancel the
 navigation. The argument is one of the constants of the enumerated type WKNavigationResponsePolicy.
 @discussion If you do not implement this method, the web view will allow the response, if the web view can show it.
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{//3
    
    LOG_METHOD
    LOG_METHOD
    LOG(@"_%@_%d_%@",[self class] , __LINE__,navigationResponse.response.URL)
    decisionHandler(YES);
    
}
/*! @abstract Invoked when a main frame navigation starts.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{//2
    LOG_METHOD
    //    [self.activetyIndicator startAnimating];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,webView.title);

}


/*! @abstract Invoked when a server redirect is received for the main
 frame.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    LOG_METHOD
    LOG(@"_%@_%d_%@",[self class] , __LINE__,webView.title);
    [self.activetyIndicator stopAnimating];
    //    LOG(@"_%@_%d_%@",[self class] , __LINE__,navigation)
    
}


/*! @abstract Invoked when an error occurs while starting to load data for
 the main frame.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 @param error The error that occurred.
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    LOG_METHOD
    LOG(@"_%@_%d_%@",[self class] , __LINE__,webView.title);
    AlertInVC(@"加载失败,请重试")
     NSLog(@"_%d_%@",__LINE__,error);
    [self.activetyIndicator stopAnimating];

    
}


/*! @abstract Invoked when content starts arriving for the main frame.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    LOG_METHOD
    LOG(@"_%@_%d_%@",[self class] , __LINE__,webView.title);
    
    
}


/*! @abstract Invoked when a main frame navigation completes.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    LOG_METHOD
    LOG(@"_%@_%d_%@",[self class] , __LINE__,webView.title);
    [self.activetyIndicator stopAnimating];
    self.naviTitle = webView.title;
    
    
    
    [self.webview evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none'" completionHandler:nil];
    [self.webview evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none'" completionHandler:nil];//禁止长按webView弹出原始连接
    self.webview.scrollView.mj_header.state = MJRefreshStateIdle;

}


/*! @abstract Invoked when an error occurs during a committed main frame
 navigation.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 @param error The error that occurred.
 */
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    LOG_METHOD
    LOG(@"_%@_%d_%@",[self class] , __LINE__,webView.title);
    
    
    self.webview.scrollView.mj_header.state = MJRefreshStateIdle;

}


/*! @abstract Invoked when the web view needs to respond to an authentication challenge.
 @param webView The web view that received the authentication challenge.
 @param challenge The authentication challenge.
 @param completionHandler The completion handler you must invoke to respond to the challenge. The
 disposition argument is one of the constants of the enumerated type
 NSURLSessionAuthChallengeDisposition. When disposition is NSURLSessionAuthChallengeUseCredential,
 the credential argument is the credential to use, or nil to indicate continuing without a
 credential.
 @discussion If you do not implement this method, the web view will respond to the authentication challenge with the NSURLSessionAuthChallengeRejectProtectionSpace disposition.
 */
//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *__nullable credential))completionHandler{
//    LOG_METHOD
//    completionHandler(nil,nil);
//}








-(void)navigationBack
{
 
    NSLog(@"_%d_%@",__LINE__,self.webview.backForwardList.currentItem.URL.absoluteString );
    [self.webview stopLoading];
    if (self.webview.canGoBack) {
        NSUInteger count = self.webview.backForwardList.backList.count ;
         NSLog(@"_%d_%@,%lu",__LINE__,@"总个数",count);
        for (int i = 0 ; i < count; i++) {
            WKBackForwardListItem * item = self.webview.backForwardList.backList[count - 1 - i];
             NSLog(@"_%d_下标%d_%@",__LINE__,i,item.URL.absoluteString);
            if ([item.URL.absoluteString containsString:@"nottaken"]) {
                if (i==count-1) {//如果栈底的还不需要在返回的时候显示,就直接pop到上一个控制器
                    
                    [self.webview.configuration.userContentController removeScriptMessageHandlerForName:@"zjlao"];
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }
                
            }else{
                    [self.webview goToBackForwardListItem:item];
                if ([item.URL.absoluteString containsString:@"orderlist"]) {//待评价页面返回时需要重新加载
                    [self.webview reload];
                }
                break ;
            }
        }
        
    }else{

        [self.webview.configuration.userContentController removeScriptMessageHandlerForName:@"zjlao"];
        [self.navigationController popViewControllerAnimated:YES];

    }
}




-(void)navigationBackXXX
{

    NSLog(@"_%d_%@",__LINE__,self.webview.backForwardList.currentItem.URL.absoluteString );
    
    if (self.webview.canGoBack) {
            [self.webview goBack];

    }else{
        [self.webview.configuration.userContentController removeScriptMessageHandlerForName:@"zjlao"];
        [self.navigationController popViewControllerAnimated:YES];
    }
}





////////////////////

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (![self.webview canGoBack]) {
        [self.webview.configuration.userContentController removeScriptMessageHandlerForName:@"zjlao"];
    }
    //    if ([self.webview canGoForward]) {
    //        return NO ;
    //    }
    // 注意：只有非根控制器才有滑动返回功能，根控制器没有。
    // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
    if (self.childViewControllers.count == 1) {
        // 表示用户在根控制器界面，就不需要触发滑动手势，
        return NO;
    }
    
    return  YES;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


#pragma 投诉时上传图片

-(void)uploadimg
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

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *photo = info[UIImagePickerControllerEditedImage];//UIImagePickerControllerEditedImage;//
    
    //    LOG(@"_%@_%d_%@",[self class] , __LINE__,photo)
    //    self.iconImageView.img=photo;
    [self uploadPicktreWithImage:photo];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)uploadPicktreWithImage:(UIImage *)image
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData * imgData = UIImageJPEGRepresentation(image, 0.1);
        //        [self setuserIconToIMSeverWithimgData:imgData];
        NSString * imgBase64 =  [imgData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        [[UserInfo shareUserInfo] uploadPictureWithPicBase64:imgBase64   targetType:2  success:^(ResponseObject*  response) {
            //图片上传成功 , 调js
             NSLog(@"_%d_%@",__LINE__,response.data);
            [self.webview evaluateJavaScript:[NSString stringWithFormat:@"saveimgs(\"%@\")",response.data] completionHandler:nil];
            LOG(@"_%@_%d_%@",[self class] , __LINE__,response.msg)
        } failure:^(NSError *error) {
            AlertInVC(@"上传失败,请重试")
            LOG(@"_%@_%d_%@",[self class] , __LINE__,error)
        }];
    });
    
}

@end