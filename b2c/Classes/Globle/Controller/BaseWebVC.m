//
//  BaseWebVC.m
//  b2c
//
//  Created by wangyuanfei on 16/5/3.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//
#import "HSepcSubModel.h"
#import "HSepcSubTypeDetailModel.h"
#import "HSelectSpecView.h"



#import "BaseWebVC.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "MyInputAccessoryView.h"
#import "AuthForPaypsdVC.h"
#import "ChangePasswordVC.h"
#import "Base64.h"

#import "UMSocialData.h"
#import "HSelectSpecView.h"
#import "UMSocialSnsService.h"
#import "LoginNavVC.h"
#import "b2c-Swift.h"
#import "UMSocialSnsPlatformManager.h"

@interface BaseWebVC ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler,MyInputAccessoryViewDelegate,UMSocialUIDelegate, HSelectSpecViewDelegate>

/** 确认收货相关  开始 */
{
    /** 接收用户密码的隐形输入框 */
@private
    UITextField * _acceptPassword;
}

/**选规格的模型*/
@property (nonatomic, weak) HSelectSpecView *specView;



/** 辅助键盘 */
@property(nonatomic,weak)MyInputAccessoryView * myAccessoryView ;
/**选规格弹窗*/
@property(nonatomic,weak)HSelectSpecView * spaceView ;
/**点击添加购物车后传递给原生的数据*/
@property(nonatomic,strong)id   clickAddShopcarData ;

@property(nonatomic,weak)UIButton * corverView ;
@property(nonatomic,weak)UIButton * testRightButton ;
/**
 https:/ /m.baidu.com/?from=844b&vit=fps
 */
@property(nonatomic,copy)NSString * confirmInceptOrderID ;//确认收货专用id
@property(nonatomic,copy)NSString * confirmInceptShopID ;//确认收货专用shopID

@property(nonatomic,weak)UIImageView * imageView ; //加入购物车的动画view

@property(nonatomic,weak)UIView * customWebTitleView ;
@property(nonatomic,weak)UIButton * imgTitle ;
@property(nonatomic,weak)UILabel * txtTitle ;
@end


@implementation BaseWebVC
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
- (HSpecSubGoodsDeatilModel *)goodsDetailModel{
    if (_goodsDetailModel == nil) {
        _goodsDetailModel  = [[HSpecSubGoodsDeatilModel alloc] init];
        
        //选中的数量默认是1
        _goodsDetailModel.reserced = @"1";
    }
    return _goodsDetailModel;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviTitle=nil;
    if (self.keyParamete[@"paramete"]) {
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
        if (![self.originURL hasSuffix:@"http"]) {
            self.originURL = [@"https://" stringByAppendingString:self.originURL];
        }
        if ([self.originURL containsString:@"?"]) {
            self.originURL = [NSString stringWithFormat:@"%@&token=%@",self.originURL,[UserInfo shareUserInfo].token];
            
        }else{
            self.originURL = [NSString stringWithFormat:@"%@?token=%@",self.originURL,[UserInfo shareUserInfo].token];
        }
    }else{
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
//- (void)addShopCarAnimationWith:(CGPoint )beginPoint endRect:(CGPoint )endPoint imageV:(UIImageView *)imageV time:(NSInteger) time{
//    UIBezierPath *path = [[UIBezierPath alloc] init];
//    CGPoint controlPoint = CGPointMake((endPoint.x - beginPoint.x)/2.0 + beginPoint.x, (endPoint.y - beginPoint.y)/2.0 + beginPoint.y);
//    //起点
//    [path moveToPoint:beginPoint];
//    [path addQuadCurveToPoint:endPoint controlPoint:controlPoint];
//    path.lineCapStyle = kCGLineCapRound;
//    path.lineJoinStyle = kCGLineJoinRound;
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//    animation.toValue = [[NSNumber alloc] initWithDouble:M_PI * 11.0];
//    animation.duration = 1.0;
//    [animation setCumulative:YES];
//    animation.repeatCount = 0;
//    [imageV.layer addAnimation:animation forKey:@"rotationAnimation"];
//    
//    
//    CAKeyframeAnimation *animation2 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    animation2.path = path.CGPath;
//    animation2 = false
//    animation2.fillMode = kCAFillModeForwards
//    animation2.duration = 1.0
//    animation2.delegate = self
//    animation2.autoreverses = false
//    animation2.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseIn)
//    imageV.layer.add(animation, forKey: "buy")
//    
//}




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
    HomeRefreshHeader * refreshHeader = [HomeRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshGDWebView)];
    self.webview.scrollView.mj_header=refreshHeader;

}

-(void )refreshGDWebView
{
    [self.webview reload];
}

/**
 -(void)setupTableView
 {
 
 if (!self.tableView) {
 CGRect frame  = CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height - self.tabBarController.tabBar.bounds.size.height);
 HBaseTableView * tableView =[[HBaseTableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
 self.tableView =tableView;
 tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
 tableView.showsVerticalScrollIndicator = NO;
 
 HomeRefreshHeader * refreshHeader = [HomeRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
 self.tableView.mj_header=refreshHeader;
 
 HomeRefreshFooter* refreshFooter = [HomeRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(LoadMore)];
 self.tableView.mj_footer = refreshFooter;
 
 }
 [self.tableView reloadData];
 
 }

 */

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
    NSLog(@"%@, %d ,%@",[self class],__LINE__,message);

    id data = message.body;
    LOG(@"_%@_%d_%@",[self class] , __LINE__,data);
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
                
                }else if ([action isEqualToString:@"addcart"]){
                    if (![UserInfo shareUserInfo].isLogin) {
                        LoginNavVC *login = [[LoginNavVC alloc] initLoginNavVC];
                        [[GDKeyVC share] presentViewController:login animated:YES  completion:nil ];
                        return ;
                    }
                    [[UserInfo shareUserInfo] gotShopCarNumberSuccess:^(ResponseObject *responseObject) {
                        NSString * num =  [NSString stringWithFormat:@"%@", responseObject.data];
                        if (num.integerValue >= 100 ) {
                            [GDAlertView alert:@"购物车已满\n请先结算已有商品" image:nil  time:3 complateBlock:^{}];
                        }else{
                            [self performAddToShoppingCar:message.body];

                        }
                    } failure:^(NSError *error) {
                        [GDAlertView alert:@"操作失败" image:nil  time:3 complateBlock:^{}];
                    }];
                }
            }
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,message.body[@"action"]);
        }
    }else{
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"js的方法名未在本地注册");
    }

}
-(void)performAddToShoppingCar:(id)data{
    
    
    
    if (self.clickAddShopcarData) {
        return ;
    }else{
        self.clickAddShopcarData = data ;//保存添加到购物车后 , js传给原生的数据
    }
    NSDictionary * paramete = (NSDictionary*)data ;
    NSString * goodsid =  paramete[@"goodid"]; // 商品id
    id goodsID = paramete[@"goodid"];
    NSString * goodidStr = goodsid ;
    if ([goodsID isKindOfClass:[NSNumber class]]) {
        NSNumber * goodsidN  = (NSNumber*) goodsID ;
        goodidStr = goodsidN.stringValue ;
    }else if ([goodsID  isKindOfClass:[NSString class]]){ }

    /*
    NSString * imgSizeStr =  paramete[@"size"]; //字符串格式 , 需要截取成CGSize格式
    NSString * imgBase64Str =  paramete[@"pic"]; //字符串格式 , 需要转换成UIImage格式
    NSData * imgData = [imgBase64Str dataUsingEncoding:NSUTF8StringEncoding];//[Base64 decode:imgBase64Str]
    UIImage * img = [UIImage imageWithData:imgData];
    NSRange  dourange = [imgSizeStr rangeOfString:@","];
    NSString * width = [imgBase64Str substringToIndex:dourange.location-1];
    NSString * height = [imgBase64Str substringFromIndex:dourange.location+1];
    */

    if (goodidStr.length > 0 && ![goodidStr isEqualToString:@"0"]) {//有规格
        
        /** 确认收货相关  结束 */
        CGRect rect = CGRectMake(0, 0, screenW, screenH);
        HSelectSpecView *specView = [[HSelectSpecView alloc] initWithFrame:rect typeofView:addToShopCar goods_id:goodidStr];
        specView.delegate = self;
        
        __weak typeof(specView) weapSpecView = specView;

        weapSpecView.block = ^(){
            [weapSpecView presentSemiView:weapSpecView backView:nil target:[UIApplication sharedApplication].keyWindow ScreenShot:YES];
        };


        //1 , 弹出原生规格框
        //2 , 选完规格通过掉api接口加完购物车
        //3 , 添加成功后执行添加动画
        //4 , 动画执行完毕 , 掉js 方法 @"refreshcart(token)"
        
    }else{//无规格
        //1 , 执行添加动画
        //2 , 动画执行完毕 , 掉js 方法 @"refreshcart(token)"
        [self  performAddShopCarAnimate:data];
    }
}
//选完规格成功的代理方法
- (void)viewHiddenAndBeginAnimation{
    [self  performAddShopCarAnimate:self.clickAddShopcarData];//在选完规格的回调方法用

}

//选完规格失败的代理方法
-(void)addshopCarfail{
    self.clickAddShopcarData = nil ;

}

-(void)performAddShopCarAnimate:(id)data
{
    
    NSString * isCartoon = [NSString stringWithFormat:@"%@",data[@"cartoon"]];
    
    if ([isCartoon isEqualToString:@"2"]) {//执行动画
        
        NSDictionary * paramete = (NSDictionary*)data ;
        
        //图片
        NSString * imgBase64Str =  paramete[@"pic"]; //字符串格式 , 需要转换成UIImage格式
        //    NSData *_decodedImageData   = [[NSData alloc] initWithBase64Encoding:imgBase64Str];
        //    UIImage *_decodedImage      = [UIImage imageWithData:_decodedImageData];
        NSData * imgData = [[NSData alloc] initWithBase64Encoding:imgBase64Str];//[imgBase64Str dataUsingEncoding:NSUTF8StringEncoding];//[Base64 decode:imgBase64Str]
        UIImage * img = [UIImage imageWithData:imgData];
        if (!img) {
            img = [UIImage imageNamed:@"placeHolderMonkey"];
        }
        NSLog(@"_%d_%@",__LINE__,img);
        
        //尺寸
        CGFloat width =  0;
        CGFloat height =  0 ;
        NSString * widthStr = [NSString stringWithFormat:@"%@",paramete[@"size"]];//宽高相等 , 只传一个值
        if ([widthStr isKindOfClass:[NSString class]]) {
            width =  (CGFloat)widthStr.floatValue;
            if (width < 35) {
                width = 35 ;
            }else if(width > 66){
                width = 66 ;
            }
            height =  width ;
        }else if ([widthStr isKindOfClass:[NSNull class]]){
            width = 37 ;
            height = width ;
        }else{
            width = 37 ;
            height = width ;
        }
        
        
        //起始坐标
        //    NSValue * startxV =  (NSValue * )paramete[@"startx"];
        //    NSValue *  startyV = (NSValue * ) paramete[@"starty"];
        
        
        
        
        
        
        id startxID =  paramete[@"startx"];
        id startyID =  paramete[@"starty"];
        NSString * startxStr = nil ;
        NSString * startyStr =  nil ;
        if ([startxID isKindOfClass:[NSNumber class]]) {
            NSNumber * startxN = (NSNumber*)startxID;
            startxStr = startxN.stringValue;
        }else if ([startxID isKindOfClass:[NSString class]]){
            startxStr =  (NSString * )startxID;
        }else{//double类型
            NSLog(@"_%d_%@",__LINE__,paramete[@"startx"]);
            startxStr = [NSString stringWithFormat:@"%@" , paramete[@"startx"]];
        }
        if ([startyID isKindOfClass:[NSNumber class]]) {
            NSNumber * startyN = (NSNumber*)startyID;
            startyStr = startyN.stringValue;
        }else if ([startyID isKindOfClass:[NSString class]]){
            startyStr =  (NSString * )startyID;
        }else{//double类型
            startyStr = [NSString stringWithFormat:@"%@" , paramete[@"starty"]];
        }
        CGFloat startx = startxStr.floatValue;
        CGFloat starty = startyStr.floatValue;
        
        
        UIImageView * temp = [[UIImageView alloc]init];
        self.imageView = temp ;
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self.imageView];
        [window bringSubviewToFront:self.imageView];
        self.imageView.backgroundColor = [UIColor redColor];
        self.imageView.image = img;
        CGFloat navigationBarHeight = 64 ;
        self.imageView.frame    = CGRectMake(startx, starty + navigationBarHeight, width, height);
        self.imageView.layer.cornerRadius =  width / 2 ;
        self.imageView.layer.masksToBounds = YES ;
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFill ;
        CABasicAnimation* rotationAnimation;
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//绕z轴旋转
        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 8 ];
        rotationAnimation.duration = 1.5;
        rotationAnimation.cumulative = YES;
        rotationAnimation.repeatCount = 0;
        
        //这个是让旋转动画慢于缩放动画执行
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.imageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        });
        
        [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            //        self.imageView.frame=CGRectMake(screenW - 44 + 44 / 3 , 20 + 44 / 4 , width/2, height/2);//写死
            self.imageView.frame=CGRectMake(self.shopCarIconFrame.origin.x + 44 / 3  , self.shopCarIconFrame.origin.y + 44 / 4 , width/1.6, height/1.6);
        } completion:^(BOOL finished) {
            //动画完成后做的事
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AddToShopCartSuccessInWapPage" object:nil];
            [self.imageView removeFromSuperview];
            [self AddToShopCartSuccessInWapPage];
            self.imageView = nil ;
            self.clickAddShopcarData = nil ;
        }];
    }else{//不执行动画 , 直接执行添加购物车操作

        [[NSNotificationCenter defaultCenter] postNotificationName:@"AddToShopCartSuccessInWapPage" object:nil];
        [self.imageView removeFromSuperview];
        [self AddToShopCartSuccessInWapPage];
        self.imageView = nil ;
        self.clickAddShopcarData = nil ;
    }
    
    


}

-(void)AddToShopCartSuccessInWapPage//子类实现
{
    self.clickAddShopcarData = nil ;
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
    NSString * type = [NSString stringWithFormat:@"%@",paramete[@"type"]];
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
        } else if ( [type isEqualToString:@"chat"]){
            NSString * userName = paramete[@"name"];
            XMPPJID * userJid = [XMPPJID jidWithUser:userName domain:JabberDomain resource:nil];
            BaseModel * model = [[BaseModel alloc]init];
            model.actionKey=ChatVCName;
            model.keyParamete = @{@"paramete":userJid};
            [[SkipManager shareSkipManager] skipByVC:self withActionModel:model];
        }else if ( [type isEqualToString:@"profile"]){
//            NSString * userName = paramete[@"name"];
//            XMPPJID * userJid = [XMPPJID jidWithUser:userName domain:@"jabber.zjlao.com" resource:nil];
//            BaseModel * model = [[BaseModel alloc]init];
//            model.actionKey=@"ChatVC";
//            model.keyParamete = @{@"paramete":userJid};
            [self.navigationController popViewControllerAnimated:YES];
//            [[SkipManager shareSkipManager] skipByVC:self withActionModel:model];
        }else if ( [type isEqualToString:@"search"]){//wap页传关键词 ,跳转到搜索列表页(原生的)
            
            NSString * searchType =  [NSString stringWithFormat:@"%@",paramete[@"searchtype"]];//搜索类型 1 搜商品 , 2 , 搜店铺
            NSString * keyword = paramete[@"keyword"];//关键词
            NSString * searchArea = [NSString stringWithFormat:@"%@",paramete[@"searcharea"]];//(搜商品时:) 1 在全网范围内搜索 , 2 , 在单个店铺内搜索
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
            
        }else if ( [type isEqualToString:@"somethingElse"]){//跳转到原生的购物车
            //todo
            

            
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
//    [self.webview reload];
//}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //[self.webview reload];////
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
            NSString * couponID = paramete[@"id"];
            LOG(@"_%@_%d_即将分享当前优惠券 , 优惠券id为:%@",[self class] , __LINE__,couponID);
            NSLog(@"%@, %d ,%@",[self class],__LINE__,paramete);

            NSString *url = [NSString stringWithFormat:@"%@/Index/couponsdetail/id/%@.html",WAPDOMAIN,couponID];
            [UMSocialData defaultData].extConfig.title = paramete[@"shop"];
            [UMSocialData defaultData].extConfig.qqData.url = url;
            [UMSocialData defaultData].extConfig.wechatSessionData.url=url;
            [UMSocialData defaultData].extConfig.wechatTimelineData.url=url;
            [UMSocialData defaultData].extConfig.qzoneData.url=url;
            [UMSocialData defaultData].extConfig.wechatTimelineData.shareText = [NSString stringWithFormat:@"我在直接捞发现了一个超值的优惠券快来看看吧 :%@",paramete[@"shop"]];
            [UMSocialData defaultData].extConfig.sinaData.shareText = [NSString stringWithFormat:@"我在直接捞发现了一个超值的优惠券快来看看吧 %@ @直接捞 %@",paramete[@"shop"],url];
            UIImageView *sharImage = [[UIImageView alloc] init];
            [sharImage sd_setImageWithURL:ImageUrlWithString(paramete[@"logo"]) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                UIImage *img = [image imageByScalingToSize:CGSizeMake(100, 100)];
                [UMSocialData defaultData].extConfig.sinaData.shareImage = img;
                [UMSocialData defaultData].extConfig.wechatTimelineData.shareImage = img;
                [UMSocialSnsService presentSnsIconSheetView:self
                                                     appKey:@"574e769467e58efcc2000937"
                                                  shareText:[NSString stringWithFormat:@"我在直接捞发现一个超值的优惠券快来看看吧 %@",paramete[@"shop"]]
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
    GDlog(@"%@", webView.URL.absoluteString)//当点击以后即将调到下一个url界面 , 但absoluteString还是当前页面的
    
    
    

    
    decisionHandler(YES);
    
}


-(void)setupWebViewTitle:(WKWebView * )webView{
    if (!self.customWebTitleView) {
        CGFloat  viewW =  [UIScreen mainScreen].bounds.size.width - 44 * 4 ;
        CGFloat  viewH =  44;
        CGFloat  viewX =  ([UIScreen mainScreen].bounds.size.width - viewW ) /2;
        CGFloat  viewY =  20;
        UIView * customWebTitleView = [[UIView alloc] initWithFrame:CGRectMake(viewX, viewY, viewW, viewH)] ;
        UILabel * txtTitle = [[UILabel alloc] init];
        [txtTitle sizeToFit];
        [customWebTitleView addSubview:txtTitle];
        
        
        UIButton * imgTitle = [[UIButton alloc] init] ;
        imgTitle.imageView.contentMode = UIViewContentModeScaleAspectFit;
        imgTitle.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        [customWebTitleView  addSubview:imgTitle];
        self.customWebTitleView = customWebTitleView;
        self.imgTitle  = imgTitle ;
        self.txtTitle = txtTitle;
        self.navigationCustomView = customWebTitleView;
//        self.navigationCustomView.backgroundColor = [UIColor greenColor];
    }
    
    //    if (!self.naviTitle) {
    GDlog(@"%@" , webView.URL.absoluteString)
    NSString* strA = [webView.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//第一次解码 , 解码失败会返回空
    NSURLComponents * components = [NSURLComponents componentsWithString:strA];//第二次解码
    NSArray * queryItems =  components.queryItems;
    NSString * title =  nil ;
    NSString * imgName = nil ;
    
    
    for (NSURLQueryItem * item  in queryItems) {
        if ([item.name isEqualToString:@"img"]) {
            if (item.value ) {
                imgName = item.value;
                GDlog(@"读取到链接参数图片名:%@",imgName)
            }
        }else if ([item.name isEqualToString:@"title"]){
            title = item.value;
            GDlog(@"读取到链接参数title:%@",title)
        }
        
    }
    
    
//    GDlog(@"%@",self.txtTitle)
    if (title && imgName ) {//链接字符串里有图有文字
        self.imgTitle.hidden = NO;
        self.txtTitle.text = title;
        [self.txtTitle sizeToFit];
        NSString * imgUrlStr = [NSString stringWithFormat:@"https://i0.zjlao.com/dms/%@.png",imgName];
        //        __weak __typeof(self)weakSelf = self;
        //        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [self.imgTitle sd_setImageWithURL:[NSURL URLWithString:imgUrlStr] forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (error) {
                //图片加载错误
//                GDlog(@"%@",[NSThread currentThread])
                dispatch_async(dispatch_get_main_queue(), ^{
//                self.txtTitle.backgroundColor = randomColor;
                    CGFloat  titW =   self.txtTitle.bounds.size.width;
                    CGFloat  titH =   self.txtTitle.bounds.size.height;
                    CGFloat  titX =  (self.customWebTitleView.bounds.size.width - titW)/2 ;
                    CGFloat  titY =  self.txtTitle.frame.origin.y;
                    self.txtTitle.frame = CGRectMake(titX, titY, titW, titH);
                });
            }
            //            GDlog(@"%@",error)
            //            GDlog(@"%@",imageURL)
            //            GDlog(@"%@",image)
        }];
        CGFloat  imgW =  44;
        CGFloat  imgH =  44;
        CGFloat  txtW =   self.txtTitle.frame.size.width;
        CGFloat  txtH =   self.txtTitle.frame.size.height;
        
        CGFloat  imgX =  (self.customWebTitleView.bounds.size.width - imgW - txtW)/2 ;
        CGFloat  imgY =     0;
        CGFloat  txtX =  imgW + imgX;
        CGFloat  txtY =  (imgH - txtH ) /2;
        self.imgTitle.frame = CGRectMake(imgX, imgY, imgW, imgH);
        self.txtTitle.frame = CGRectMake(txtX, txtY, txtW,txtH);
        
        //执行图文混排
    }else if (title){//链接字符串里只有文字
        self.txtTitle.text = title;
        [self.txtTitle sizeToFit];
        
        CGFloat  txtW =   self.txtTitle.frame.size.width;
        CGFloat  txtH =   self.txtTitle.frame.size.height;
        CGFloat  txtX =  (self.customWebTitleView.bounds.size.width - txtW)/2;
        CGFloat  txtY =  (44 - txtH ) /2;

        
        self.txtTitle.frame = CGRectMake(txtX, txtY, txtW,txtH);
        self.imgTitle.hidden = YES;
        
        //执行设置文字
    }else{//链接字符串里没有文字 , 从webView的title里读取
        GDlog(@"读取wapView的title:%@",webView.title)
        if (webView.title.length==0) {
            return;
        }
        self.txtTitle.text = webView.title;
        [self.txtTitle sizeToFit];
        
        CGFloat  txtW =   self.txtTitle.frame.size.width;
        CGFloat  txtH =   self.txtTitle.frame.size.height;
        CGFloat  txtX =  (self.customWebTitleView.bounds.size.width - txtW)/2;
        CGFloat  txtY =  (44 - txtH ) /2;
        
        
        self.txtTitle.frame = CGRectMake(txtX, txtY, txtW,txtH);
        self.imgTitle.hidden = YES;
        
        //执行设置文字
    }
    

}

-(void)setwebViewTitle:(WKWebView * )webView
{
    self.imgTitle = nil ;
    self.txtTitle = nil ;
    self.customWebTitleView = nil ;
    
    
//    if (!self.naviTitle) {
    GDlog(@"%@" , webView.URL.absoluteString)
    NSString* strA = [webView.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//第一次解码 , 解码失败会返回空
    NSURLComponents * components = [NSURLComponents componentsWithString:strA];//第二次解码
    NSArray * queryItems =  components.queryItems;
    NSString * title =  nil ;
    NSString * imgName = nil ;


    for (NSURLQueryItem * item  in queryItems) {
        if ([item.name isEqualToString:@"img"]) {
            if (item.value ) {
                imgName = item.value;
                GDlog(@"%@",imgName)
            }
        }else if ([item.name isEqualToString:@"title"]){
            title = item.value;
            GDlog(@"%@",title)
        }
        
    }
    
    
    
    UIView * customWebTitleView = [[UIView alloc] init];
   __block UILabel * txtTitle = [[UILabel alloc] init];
    [customWebTitleView addSubview:txtTitle];

    if (title && imgName ) {//链接字符串里有图有文字
        txtTitle.text = title;
        [txtTitle sizeToFit];
        UIButton * imgTitle = [[UIButton alloc] init] ;
        imgTitle.imageView.contentMode = UIViewContentModeScaleAspectFit;
        imgTitle.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
//        [customWebTitleView addSubview:txtTitle];
        [customWebTitleView  addSubview:imgTitle];
        
        NSString * imgUrlStr = [NSString stringWithFormat:@"https://i0.zjlao.com/dms/%@.png",imgName];
        //        [imgTitle sd_setImageWithURL:[NSURL URLWithString:imgUrlStr] forState:UIControlStateNormal];
//        __weak __typeof(self)weakSelf = self;
//        __strong __typeof(weakSelf)strongSelf = weakSelf;


        [imgTitle sd_setImageWithURL:[NSURL URLWithString:imgUrlStr] forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

            if (error) {
                //图片加载错误
                GDlog(@"%@",[NSThread currentThread])
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    CGFloat  txtW =   txtTitle.bounds.size.width;
                    CGFloat  txtH =   txtTitle.bounds.size.height;
                    CGFloat  txtX =  0;
                    CGFloat  txtY =  txtTitle.frame.origin.y;
                    txtTitle.frame = CGRectMake(txtX, txtY, txtW, txtH);
                });
            }
//            GDlog(@"%@",error)
//            GDlog(@"%@",imageURL)
//            GDlog(@"%@",image)
        }];
        
        CGFloat  imgW =  44;
        CGFloat  imgH =  44;
        CGFloat  imgX =  0 ;
        CGFloat  imgY =     0;
        CGFloat  txtW =   txtTitle.frame.size.width;
        CGFloat  txtH =   txtTitle.frame.size.height;
        CGFloat  txtX =  imgW;
        CGFloat  txtY =  (imgH - txtH ) /2;
        CGFloat  viewW =  imgW + txtW;
        CGFloat  viewH =  44;
        CGFloat  viewX =  ([UIScreen mainScreen].bounds.size.width - viewW ) /2;
        CGFloat  viewY =  20;
        
        imgTitle.frame = CGRectMake(imgX, imgY, imgW, imgH);
        txtTitle.frame = CGRectMake(txtX, txtY, txtW,txtH);
        customWebTitleView.frame = CGRectMake(viewX, viewY, viewW, viewH);
        
        GDlog(@"%@",NSStringFromCGSize(imgTitle.currentImage.size))
        
        self.navigationCustomView = customWebTitleView;//先设置frame属性 , 再往 self.navigationCustomView上赋值
        self.customWebTitleView = customWebTitleView;
        self.txtTitle = txtTitle;
        self.imgTitle = imgTitle;
        //执行图文混排
    }else if (title){//链接字符串里只有文字
        txtTitle.text = title;
        [txtTitle sizeToFit];
        
        CGFloat  txtW =   txtTitle.frame.size.width;
        CGFloat  txtH =   txtTitle.frame.size.height;
        CGFloat  txtX =  0;
        CGFloat  txtY =  (44 - txtH ) /2;
        CGFloat  viewW =  txtW;
        CGFloat  viewH =  44;
        CGFloat  viewX =  ([UIScreen mainScreen].bounds.size.width - viewW ) /2;
        CGFloat  viewY =  20;
        
        txtTitle.frame = CGRectMake(txtX, txtY, txtW,txtH);
        customWebTitleView.frame = CGRectMake(viewX, viewY, viewW, viewH);
        self.navigationCustomView = customWebTitleView;//先设置frame属性 , 再往 self.navigationCustomView上赋值
        self.customWebTitleView = customWebTitleView;
        self.txtTitle = txtTitle;

        //执行设置文字
    }else{//链接字符串里没有文字 , 从webView的title里读取
        GDlog(@"%@",webView.title)
        if (webView.title.length==0) {
            return;
        }
        txtTitle.text = webView.title;
        [txtTitle sizeToFit];
        CGFloat  txtW =   txtTitle.frame.size.width;
        CGFloat  txtH =   txtTitle.frame.size.height;
        CGFloat  txtX =  0;
        CGFloat  txtY =  (44 - txtH ) /2;
        CGFloat  viewW =  txtW;
        CGFloat  viewH =  44;
        CGFloat  viewX =  ([UIScreen mainScreen].bounds.size.width - viewW ) /2;
        CGFloat  viewY =  20;
        txtTitle.frame = CGRectMake(txtX, txtY, txtW,txtH);
        customWebTitleView.frame = CGRectMake(viewX, viewY, viewW, viewH);
        self.navigationCustomView = customWebTitleView;//先设置frame属性 , 再往 self.navigationCustomView上赋值
        self.customWebTitleView = customWebTitleView;
        self.txtTitle = txtTitle;

        //执行设置文字
    }
    
//    }
}





-(void )setupWebNaviTitleView: (NSString*) title imageName:(NSString*)imgName
{
    if (imgName) {
        UIView * customWebTitleView = [[UIView alloc] init];
        UIButton * imgTitle = [[UIButton alloc] init] ;
        imgTitle.imageView.contentMode = UIViewContentModeScaleAspectFit;
        imgTitle.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        UILabel * txtTitle = [[UILabel alloc] init];
        txtTitle.text = title;
        [txtTitle sizeToFit];
        [customWebTitleView  addSubview:imgTitle];
        [customWebTitleView addSubview:txtTitle];
        
        NSString * imgUrlStr = [NSString stringWithFormat:@"https://i0.zjlao.com/dms/%@.png",imgName];
        //        [imgTitle sd_setImageWithURL:[NSURL URLWithString:imgUrlStr] forState:UIControlStateNormal];
        [imgTitle sd_setImageWithURL:[NSURL URLWithString:imgUrlStr] forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (error) {
                //图片加载错误
            }
            GDlog(@"%@",error)
            GDlog(@"%@",imageURL)
            GDlog(@"%@",image)
        }];
        
        CGFloat  imgW =  44;
        CGFloat  imgH =  44;
        CGFloat  imgX =  0 ;
        CGFloat  imgY =     0;
        CGFloat  txtW =   txtTitle.frame.size.width;
        CGFloat  txtH =   txtTitle.frame.size.height;
        CGFloat  txtX =  imgW;
        CGFloat  txtY =  (imgH - txtH ) /2;
        CGFloat  viewW =  imgW + txtW;
        CGFloat  viewH =  44;
        CGFloat  viewX =  ([UIScreen mainScreen].bounds.size.width - viewW ) /2;
        CGFloat  viewY =  20;
        
        imgTitle.frame = CGRectMake(imgX, imgY, imgW, imgH);
        txtTitle.frame = CGRectMake(txtX, txtY, txtW,txtH);
        customWebTitleView.frame = CGRectMake(viewX, viewY, viewW, viewH);
        
        GDlog(@"%@",NSStringFromCGSize(imgTitle.currentImage.size))
        
        self.navigationCustomView = customWebTitleView;//先设置frame属性 , 再往 self.navigationCustomView上赋值
        self.customWebTitleView = customWebTitleView;
        self.txtTitle = txtTitle;
        self.imgTitle = imgTitle;
    }else{
        
    }
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


//    LOG(@"_%@_%d_%@",[self class] , __LINE__,navigationResponse.response.URL)
     GDlog(@"%@", webView.URL.absoluteString)
    decisionHandler(YES);
    
}
/*! @abstract Invoked when a main frame navigation starts.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{//2
//    LOG_METHOD
//    [self.activetyIndicator startAnimating];
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,webView.title);
    GDlog(@"%@", webView.URL.absoluteString) //  当点击跳转到下一个url 时  , absoluteString 是下一个界面的url
    //传过来的链接encode了两次
    //加载之前 , 提前判断
    NSString* strA = [webView.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//第一次解码 , 解码失败会返回空
    NSURLComponents * components = [NSURLComponents componentsWithString:strA];//第二次解码
    NSArray * queryItems =  components.queryItems;
    NSString * title =  nil ;
    NSString * imgName = nil ;
    
    
    for (NSURLQueryItem * item  in queryItems) {
        if ([item.name isEqualToString:@"img"]) {
            if (item.value ) {
                imgName = item.value;
//                GDlog(@"%@",imgName)
            }
        }else if ([item.name isEqualToString:@"title"]){
            title = item.value;
//            GDlog(@"%@",title)
        }
        
    }
    if (title) {
        [self setupWebViewTitle:webView];
    }
    



}


/*! @abstract Invoked when a server redirect is received for the main
 frame.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
//    LOG_METHOD
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,webView.title);
     GDlog(@"%@", webView.URL.absoluteString)
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
     GDlog(@"%@", webView.URL.absoluteString)
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,webView.title);
     NSLog(@"_%d_ , 加载失败,请重试 ,%@",__LINE__,error.userInfo);
     NSLog(@"_%d_%@",__LINE__,error);
    AlertInVC(@"加载失败,请重试")
        [self.activetyIndicator stopAnimating];


}


/*! @abstract Invoked when content starts arriving for the main frame.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
//    LOG_METHOD
    LOG(@"_%@_%d_%@",[self class] , __LINE__,webView.title);

    
}


/*! @abstract Invoked when a main frame navigation completes.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
//    LOG_METHOD
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,webView.title);
    [self.activetyIndicator stopAnimating];
//    self.naviTitle = webView.title;
    if (![self.txtTitle.text isEqualToString:webView.title] ) {
        [self setupWebViewTitle:webView];
    }

    self.webview.scrollView.mj_header.state = MJRefreshStateIdle;

    [self.webview evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none'" completionHandler:nil];
    [self.webview evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none'" completionHandler:nil];//禁止长按webView弹出原始连接
    
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
    if (![self.txtTitle.text isEqualToString:webView.title] ) {
        [self setupWebViewTitle:webView];
    }
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








-(void)navigationBackXXXXXXXXX
{
    if (self.webview.canGoBack) {
        [self.webview goBack];
    }else{
//        [self.webview removeFromSuperview];
//        self.webview = nil ;
//        [self.webview stopLoading];
        [self.webview.configuration.userContentController removeScriptMessageHandlerForName:@"zjlao"];
        [self.navigationController popViewControllerAnimated:YES];
//        [self removeFromParentViewController];
//        self.webview.navigationDelegate = nil;
//        self.webview.UIDelegate = nil;
//        [self.webview removeFromSuperview];
//        self.webview=nil ;
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
//    if (self.childViewControllers.count == 1) {
        // 表示用户在根控制器界面，就不需要触发滑动手势，
//        return NO;
//    }
    
    return  YES;
}

-(void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
            [self.webview evaluateJavaScript:[NSString stringWithFormat:@"saveimgs(%@)",response.data] completionHandler:nil];
            LOG(@"_%@_%d_%@",[self class] , __LINE__,response.msg)
        } failure:^(NSError *error) {
            LOG(@"_%@_%d_%@",[self class] , __LINE__,error)
        }];
    });
    
}

@end
