//
//  AppDelegate.m
//  b2c
//
//  Created by wangyuanfei on 3/22/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "AppDelegate.h"
#import <AlipaySDK/AlipaySDK.h>
#import "KeyVC.h"
#import "MainTabBarVC.h"

#import <AlipaySDK/AlipaySDK.h>

#import "UMSocial.h"

#import "UMSocialQQHandler.h"

#import "UMSocialSinaSSOHandler.h"

#import "UMSocialSnsData.h"

#import "UMSocialWechatHandler.h"

//#import <UMSocial.h>

#import "GDXmppStreamManager.h"
#import "NewFeatureVC.h"

#import "NewChatVC.h"
//微信支付头文件
#import "WXApi.h"
#import "WXApiObject.h"

#import "b2c-Swift.h"
//#import "UPPaymentControl.h"

#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>
#import "PayResultVC.h"
#import "PayMentManager.h"
#import <UserNotifications/UserNotifications.h>

#import "ThreePointMenuWebVC.h"

@interface AppDelegate ()<NewFeatureDelegate, UNUserNotificationCenterDelegate>
//@property(nonatomic,strong)KeyVC * keyVC ;
@property(nonatomic,strong)GDKeyVC * keyVC ;
@property(nonatomic,weak)UIView * adView ;//广告视图

/** 定时器 */
@property(nonatomic,strong)NSTimer * timer ;
/** 重新发送倒计时时间 */
@property(nonatomic,assign)NSInteger  time ;

/**临时保存呢的通知数据 , 等tabBarVC的视图完全出来了再执行通知相应的跳转  , 跳转完就清空 */
@property(nonatomic,strong)id  notificationData ;

@end

@implementation AppDelegate

//+(void)load{
//    [[AFNetworkReachabilityManager manager] startMonitoring];
//}


- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions {
    
//    [UIImage imageWithContentsOfFile:<#(nonnull NSString *)#>]加载的图片是随着页面消失在内存中释放的。
    LOG(@"_%@_%d_%@",[self class] , __LINE__,launchOptions);
     NSLog(@"_%d_%@",__LINE__,UUID);
    return YES;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    LOG(@"\n\n\n\n_%@_%d_%@\n\n\n\n",[self class] , __LINE__,[UIDevice currentDevice].identifierForVendor.UUIDString);
    
  ;
//    [GDAlertView alert:@"xxxdfghsdf你好啊xxx" image:  [UIImage imageNamed:@"bg_collocation"]  time:5 complateBlock:nil ];
    //    id paramete = launchOptions[UIApplicationLaunchOptionsLocalNotificationKey];
    //
  
    //    LOG(@"_%@_%d_%@",[self class] , __LINE__,paramete);
    //    UIApplicationLaunchOptionsLocalNotificationKey;
    //    UIApplicationLaunchOptionsSourceApplicationKey
    //    UIApplicationLaunchOptionsURLKey
    LOG(@"_%@_%d_app启动了((didFinishLaunchingWithOptions:)),%@",[self class] , __LINE__,launchOptions);
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self setupNetworkStatus];
        [self setuoJpushWithLaunchOptions:launchOptions];
        
    });
    
    // Override point for customization after application launch.
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        
        [self setupAboutUmengShare];
        [self setNotification];
    });
//    application.statusBarStyle=UIStatusBarStyleLightContent;
    [self setupKeyVC];
    //    [self testSwiftFile];
    //    [self setNotification];
    //    [self setupNavigaBar];
    
    
    if (launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]) {
        [self dealWithNotificationWith:launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]];
    }else if(launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey]){
        [self dealWithNotificationWith:launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey]];
    }
    //1.0，向微信注册自己的APPid
//    微信支付应用APPID
//    wx3a7ea08db2d63a24
//    曹恒辉  17:17:23
//    微信支付商户号
//    1368287102
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        
        //        if ([UserInfo shareUserInfo].isLogin) [self performLoginIM];
        //微信支付注册appid,2012/10/12修改appid
        [WXApi registerApp:@"wxc0d79f109e1cf9c5"withDescription:@"zjlao"];
    });
    [self checkoutNotifacitionEnable];
//    [self   showAdvertisementView];wxc0d79f109e1cf9c5
   // [self testAlertUUID];//ios10.2,生产模式下同一个开发者账号的uuid相同 , 开发环境下不一样 , ios10.0.1还不是这样的 , 法克 , 官方文档也不说下
    
    
    return YES;
}
- (void)testAlertUUID {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:[UIDevice currentDevice].identifierForVendor.UUIDString message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"qued" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    [alert addAction:action];
    
    [[KeyVC shareKeyVC] presentViewController:alert animated:YES completion:^{
        
    }];
}
-(void )checkoutNotifacitionEnable {
    if ([[UIApplication sharedApplication] currentUserNotificationSettings].types  == UIRemoteNotificationTypeNone) {
//        NSLog(@"通知关闭了");
    }else{
//        NSLog(@"通知开着呢");
    }

}

-(void)setuoJpushWithLaunchOptions:(NSDictionary*)launchOptions
{
    [JPUSHService  resetBadge] ;
    //通过极光的方式注册远程推送
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    }
    else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }
    else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
        
    }
        //注册结束
    //初始化极光代码
    [JPUSHService setupWithOption:launchOptions appKey:@"c6e1f4cb5d8a863e1d4a0a20"
                          channel:@"appStroe"
                 apsForProduction:YES
            advertisingIdentifier:nil];
    
    
    
//    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
//    
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
//        //可以添加自定义categories
//        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
//                                                          UIUserNotificationTypeSound | 
//                                                          UIUserNotificationTypeAlert)
//                                              categories:nil];
//    } else {
//        //categories 必须为nil
//        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
//                                                          UIRemoteNotificationTypeSound |
//                                                          UIRemoteNotificationTypeAlert)
//                                              categories:nil];
//    }
//    
//    //如不需要使用IDFA，advertisingIdentifier 可为nil
//    [JPUSHService setupWithOption:launchOptions appKey:@"c6e1f4cb5d8a863e1d4a0a20"
//                          channel:@"Publish channel"
//                 apsForProduction:FALSE
//            advertisingIdentifier:advertisingId];
    

}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString * deviceTokenStr =  deviceToken.description;
     NSLog(@"_%d_前%@",__LINE__,deviceTokenStr);
    if ([deviceTokenStr containsString:@"<"]) {
        deviceTokenStr = [deviceTokenStr stringByReplacingOccurrencesOfString:@"<" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, 1)];
    }
    if ([deviceTokenStr containsString:@">"]) {
                deviceTokenStr = [deviceTokenStr stringByReplacingOccurrencesOfString:@">" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(deviceTokenStr.length-1, 1)];
    }
     NSLog(@"_%d_后%@",__LINE__,deviceTokenStr);

   // UIAlertController * a  = [UIAlertController alertControllerWithTitle:deviceTokenStr message:deviceTokenStr preferredStyle:UIAlertControllerStyleAlert];
    //[[KeyVC shareKeyVC] presentViewController:a  animated:YES completion:^{
        
    //}];
    [[UserInfo shareUserInfo] registerPushNotificationID:deviceTokenStr  registerID:nil  Success:^(ResponseObject *response) {
         NSLog(@"_%d_%@",__LINE__,response.data);
        NSLog(@"_%d_%@",__LINE__,@"保存devicetoken成功");
    } failure:^(NSError *error) {
         NSLog(@"_%d_%@",__LINE__,error);
        NSLog(@"_%d_%@",__LINE__,@"保存devicetoken失败");
    }];
    //先保存deviceToken
    
     NSLog(@"_%d_%@",__LINE__,deviceTokenStr);
    LOG(@"_%@_%d_\n\n\n 这是DeviceToken: -->%@\n\n\n",[self class] , __LINE__,deviceToken.description);
    
    [JPUSHService registerDeviceToken:deviceToken];
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        NSLog(@"_%d_极光初始化结果 状态码%d",__LINE__,resCode);
         NSLog(@"_%d_极光初始化结果 注册ID: %@",__LINE__,registrationID);//在这儿上传到服务器
        //保存极光的registerID
        [[UserInfo shareUserInfo] registerPushNotificationID:nil  registerID:registrationID Success:^(ResponseObject *response) {
             NSLog(@"_%d_%@",__LINE__,response.data);
            NSLog(@"_%d_%@",__LINE__,@"保存极光注册id成功");
        } failure:^(NSError *error) {
            NSLog(@"_%d_%@",__LINE__,@"保存极光注册id失败");
        }];
        
    }];
}
- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
/*
-(void)dealWithNotificationWith:(NSDictionary*)info//old
{
    if (!info) return;
    NSDictionary * userinfo = info[@"aps"] ;
    if (!userinfo) {return ;}
    
    NSString * actionkey = userinfo[@"actionkey"];
    if (![actionkey isKindOfClass:[NSString class]] || actionkey.length<=0) {
        return ;
    }else{NSLog(@"推送的actionkey为空");} ;
    
   if ([actionkey isEqualToString:@"im"]) {
       if (! [UserInfo shareUserInfo].isLogin) {
           AlertInSubview(@"请登录")
           return ;
       }
        NSString * userName = userinfo[@"value"];
        XMPPJID * userJid = [XMPPJID jidWithUser:userName domain:@"jabber.zjlao.com" resource:nil];
        ChatVC * chatvc = [[ChatVC alloc]init];
        chatvc.UserJid = userJid;
        [[KeyVC shareKeyVC] pushViewController:chatvc animated:YES];
        
   }else if ([actionkey isEqualToString:@"orderlist"]){
       NSString * value = userinfo[@"value"];
       if (value && value.length > 0) {
           //跳转到订单列表
           ThreePointMenuWebVC * vc = [[ThreePointMenuWebVC alloc]  init];
           vc.keyParamete = @{@"paramete" : value};
           [[KeyVC shareKeyVC] pushViewController:vc  animated:YES];
           
       }else{NSLog(@"键:%@对应的value为空" ,actionkey);}
       
       
       
   }else if ([actionkey isEqualToString:@"somethingOthers"]){
       //DoSomethingOthers
   }else if ([actionkey isEqualToString:@"shop"]){
       //DoSomethingOthers
   }else if ([actionkey isEqualToString:@"goods"]){
       //DoSomethingOthers
   }else if ([actionkey isEqualToString:@"update"]){
       NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",@"1133780608"];
       NSURL * url = [NSURL URLWithString:str];
        
       if ([[UIApplication sharedApplication] canOpenURL:url])
       {
           [[UIApplication sharedApplication] openURL:url];
       }
   }
}
 */


-(void)dealWithNotificationWith:(NSDictionary*)userinfo//new
{
    
    //为了确保执行push出推送的页面之前所有的准备工作都做好(如token是否生成 , 是否是keyVC的第二个子控制器<点击返回时保证能返回到首页>) , 在首页页面出来之后执行这个处理通知的方法    ,   注意: 并不是每次首页的viewDidAppear都执行这个推送解析 , 只有是通过点击通知启动 XXXXXX这么做不严密  ,万一页面不在首页怎么办, 如在个人中心 , 就不会调用首页的viewDidAppear方法了?
     //所以就用tabBarVC的viewDidAppear吧
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [JPUSHService resetBadge] ;
    if (!userinfo) return;
//    NSDictionary * userinfo = info[@"aps"] ;
//    if (!userinfo) {return ;}
    
    NSString * actionkey = userinfo[@"actionkey"];
    NSLog(@"actionkey:%@", actionkey);
    if (![actionkey isKindOfClass:[NSString class]] || actionkey.length<=0) {
        return ;
    }else{NSLog(@"推送的actionkey为空");} ;
    
    if ([actionkey isEqualToString:@"im"]) {
        if (! [UserInfo shareUserInfo].isLogin) {
            AlertInSubview(@"登录以查看消息")
            return ;
        }
        NSString * userName = userinfo[@"value"];
        XMPPJID * userJid = [XMPPJID jidWithUser:userName domain:JabberDomain resource:@"iOS"];
//        ChatVC * chatvc = [[ChatVC alloc]init];

        NewChatVC * chatvc = [[NewChatVC alloc]init];
        chatvc.UserJid = userJid;
        [[GDKeyVC share] pushViewController:chatvc animated:YES];
        
    }else if ([actionkey isEqualToString:@"orderlist"]){
        if (! [UserInfo shareUserInfo].isLogin) {
            //AlertInSubview(@"登录以查看订单状态")
            [GDAlertView alert:@"登录以查看订单状态" image:nil time:4 complateBlock:nil];
            return ;
        }
        NSString * value = userinfo[@"value"];
        if ([value  isKindOfClass:[NSString class]] && value.length > 0) {
            //跳转到订单列表
            ThreePointMenuWebVC * vc = [[ThreePointMenuWebVC alloc]  init];
            vc.keyParamete = @{@"paramete" : value};
            [[KeyVC shareKeyVC] pushViewController:vc  animated:YES];
            
        }else{NSLog(@"键:%@对应的value为空" ,actionkey);}
        
        
        
    }else if ([actionkey isEqualToString:@"somethingOthers"]){
        //DoSomethingOthers
    }else if ([actionkey isEqualToString:@"shop"]){
        //DoSomethingOthers
    }else if ([actionkey isEqualToString:@"goods"]){
        //DoSomethingOthers
    }else if ([actionkey isEqualToString:@"update"]){
        NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",@"1133780608"];
        NSURL * url = [NSURL URLWithString:str];
        
        if ([[UIApplication sharedApplication] canOpenURL:url])
        {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}



-(void)setNotification
{
//    [[UIApplication sharedApplication] registerForRemoteNotifications];
//    UIUserNotificationSettings * setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound|UIUserNotificationTypeBadge categories:nil];
//    [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
    
    
    
    
    if([[UIDevice currentDevice].systemVersion floatValue] >= 10.0){
        UNUserNotificationCenter * notiCenter = [UNUserNotificationCenter currentNotificationCenter];
        notiCenter.delegate = self  ;
        [notiCenter requestAuthorizationWithOptions:UNAuthorizationOptionBadge|UNAuthorizationOptionSound|UNAuthorizationOptionAlert completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                 NSLog(@"_%d_注册通知%@",__LINE__,@"成功");
            }else{
                 NSLog(@"_%d_注册通知失败%@",__LINE__,error);
            }
        }];
//        novifiCenter.requestAuthorization(options: [UNAuthorizationOptions.alert , UNAuthorizationOptions.sound , UNAuthorizationOptions.badge], completionHandler: { (resule, error) in
//            if(resule ){
//                mylog("成功")
//            }else{
//                mylog("注册失败\(error)")
//            }
//        })
    }else{
            [[UIApplication sharedApplication] registerForRemoteNotifications];
            UIUserNotificationSettings * setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound|UIUserNotificationTypeBadge categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
    }
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    [[NSNotificationCenter  defaultCenter] addObserver:self  selector:@selector(performNotifacationAction) name:@"PerformNotifacationActionAfterViewLoad" object:nil ];
    
}
- (void) performNotifacationAction{
    if (self.notificationData) {//有通知数据才执行
        [self dealWithNotificationWith:self.notificationData];
    }
}
-(void)performLoginIM
{
    if ((![GDXmppStreamManager ShareXMPPManager].XmppStream.isConnected && ![GDXmppStreamManager ShareXMPPManager].XmppStream.isConnecting) && [UserInfo shareUserInfo].isLogin) {
//        LOG(@"_%@_%d_登录IM时用得token%@",[self class] , __LINE__,[UserInfo shareUserInfo].token);
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,[UserInfo shareUserInfo].imName);
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,[UserInfo shareUserInfo].token);
        [[GDXmppStreamManager ShareXMPPManager]loginWithJID:[XMPPJID jidWithUser:[UserInfo shareUserInfo].imName domain:JabberDomain resource:@"iOS"] passWord:[UserInfo shareUserInfo].token];
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"执行登录");
    }

    //    //登录
    //    [[GDXmppStreamManager ShareXMPPManager]loginWithJID:[XMPPJID jidWithUser:@"wangyuanfei" domain:@"chh-PC" resource:@"iOS"] passWord:@"123456"];
    //登录
//    LOG(@"_%@_%d_登录IM时用得token%@",[self class] , __LINE__,[UserInfo shareUserInfo].token);
//    [[GDXmppStreamManager ShareXMPPManager]loginWithJID:[XMPPJID jidWithUser:[UserInfo shareUserInfo].imName domain:@"jabber.zjlao.com" resource:@"iOS"] passWord:[UserInfo shareUserInfo].token];
}

//-(void)setupAboutUmengShare
//{
//    [UMSocialData setAppKey:@"574e769467e58efcc2000937"];
//    //设置微信AppId、appSecret，分享url
//    [UMSocialWechatHandler setWXAppId:@"wxb492c56c72430e98" appSecret:@"f63e2681b3a9e3dc0cc090da97e1af3a" url:@"http://www.zjlao.com"];
//    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
//    [UMSocialQQHandler setQQWithAppId:@"1105439736" appKey:@"aJbFYZkasoNQpnC0" url:@"http://www.zjlao.com"];
//    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
//    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"2902225909"
//                                              secret:@"a3e63bcc8f6b2e65bfe6c3bc6c5b55ed"
//                                         RedirectURL:@"http://www.zjlao.com/resave.php"];
//    
//    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline,UMShareToSina]];
//    
//}
-(void)setupAboutUmengShare
{
    [UMSocialData setAppKey:@"574e769467e58efcc2000937"];
    //设置微信AppId、appSecret，分享url
//    [UMSocialWechatHandler setWXAppId:@"wx3a7ea08db2d63a24" appSecret:@"7dfe03cdfdd99e4ee82a17fe026b276b" url:@"https://www.zjlao.com"];
    [UMSocialWechatHandler setWXAppId:@"wxc0d79f109e1cf9c5" appSecret:@"c39641d9614e13d2b49b93506940da1f" url:MAINDOMAIN];
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
//    [UMSocialQQHandler setQQWithAppId:@"1105439736" appKey:@"aJbFYZkasoNQpnC0" url:MAINDOMAIN];
    [UMSocialQQHandler setQQWithAppId:@"101388596" appKey:@"1dec6385b883dfd63b45d4587a7f6db2" url:MAINDOMAIN];
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
//    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"2902225909"
//                                              secret:@"a3e63bcc8f6b2e65bfe6c3bc6c5b55ed"
//                                         RedirectURL:[NSString stringWithFormat:@"%@/resave.php", MAINDOMAIN]];
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"1282515910"
                                              secret:@"d5cee28d79ef7fc7fa7c8688929b6aed"
                                         RedirectURL:[NSString stringWithFormat:@"%@/resave.php", MAINDOMAIN]];
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline,UMShareToSina]];
    
}
-(void)testSwiftFile{
    //    TestFile * f = [[TestFile alloc]init];
    //    [f testMethod];
    
}

-(void)setupNetworkStatus
{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

-(void)setupKeyVC
{
    
    if (!self.window) {
        
        self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        self.window.backgroundColor = [UIColor redColor];
    }
    if (!self.keyVC) {
        GDKeyVC * keyVC = [GDKeyVC share];
        self.keyVC = keyVC;
        //keyVC.navigationBarHidden=YES;
    }
    
    
    if ([self checkVersion]) {
        NewFeatureVC * newFeatureVC = [[NewFeatureVC alloc]init];
        newFeatureVC.NewFeatureVCDelegate = self;
        
        self.window.rootViewController = newFeatureVC;
        [self.window makeKeyAndVisible];
        
    }else{
        
        self.window.rootViewController = self.keyVC;
        [self.window makeKeyAndVisible];
        
        ////新特性展示完再显示广告 //zhanshigemao
        //            [self   showAdvertisementView];
        
        
        
    }
    
    
}

/*
-(void)setupKeyVC
{
    
    if (!self.window) {
        
        self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        self.window.backgroundColor = [UIColor redColor];
    }
    if (!self.keyVC) {
        KeyVC * keyVC = [KeyVC shareKeyVC];
        self.keyVC = keyVC;
        MainTabBarVC * mainVC = [[MainTabBarVC alloc]init];
        keyVC.rootViewController = mainVC ;
        [keyVC addChildViewController:mainVC];
        keyVC.navigationBarHidden=YES;
    }
    
    
    if ([self checkVersion]) {
        NewFeatureVC * newFeatureVC = [[NewFeatureVC alloc]init];
        newFeatureVC.NewFeatureVCDelegate = self;
        
        self.window.rootViewController = newFeatureVC;
        [self.window makeKeyAndVisible];
        
    }else{
        
        self.window.rootViewController = self.keyVC;
        [self.window makeKeyAndVisible];
        
        ////新特性展示完再显示广告 //zhanshigemao
//            [self   showAdvertisementView];
        
        
        
    }
    
    
}
*/
-(void)setupNavigaBar
{
    //    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
    //    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}



- (void)applicationDidEnterBackground:(UIApplication *)application {
//    [GDXmppStreamManager ShareXMPPManager].isNeedReconnect =  NO ;
//    [[GDXmppStreamManager ShareXMPPManager] xmppLoginout];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    //    application.
//    [GDXmppStreamManager ShareXMPPManager].isNeedReconnect = YES;
//    [self performLoginIM];
    [application setApplicationIconBadgeNumber:0];
    [JPUSHService resetBadge] ;
    [application cancelAllLocalNotifications];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [self performLoginIM];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [UMSocialSnsService  applicationDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//通用链接相关
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray *))restorationHandler
{
    if ([userActivity.activityType isEqualToString:NSUserActivityTypeBrowsingWeb]) {
        NSURL *webpageURL = userActivity.webpageURL;

        
        
        NSLog(@"_%d_absoluteString:%@",__LINE__,webpageURL.absoluteString);
        NSLog(@"_%d_relativeString:%@",__LINE__,webpageURL.relativeString);
        NSLog(@"_%d_baseURL:%@",__LINE__,webpageURL.baseURL);
        NSLog(@"_%d_absoluteURL:%@",__LINE__,webpageURL.absoluteURL);
        NSLog(@"_%d_scheme:%@",__LINE__,webpageURL.scheme);
        NSLog(@"_%d_resourceSpecifier:%@",__LINE__,webpageURL.resourceSpecifier);
        NSLog(@"_%d_host:%@",__LINE__,webpageURL.host);
        NSLog(@"_%d_port:%@",__LINE__,webpageURL.port);
        NSLog(@"_%d_user:%@",__LINE__,webpageURL.user);
        NSLog(@"_%d_password:%@",__LINE__,webpageURL.password);
        NSLog(@"_%d_path:%@",__LINE__,webpageURL.path);
        NSLog(@"_%d_fragment:%@",__LINE__,webpageURL.fragment);
        NSLog(@"_%d_parameterString:%@",__LINE__,webpageURL.parameterString);
        NSLog(@"_%d_query:%@",__LINE__,webpageURL.query);
        NSLog(@"_%d_relativePath:%@",__LINE__,webpageURL.relativePath);
        /**/
        /**/
        
        NSString *host = webpageURL.host;
        if ([host isEqualToString:@"zjlao.com"] || [host isEqualToString:@"www.zjlao.com"] || [host isEqualToString:@"m.zjlao.com"] || [host isEqualToString:@"www.m.zjlao.com"]) {
            //进行我们需要的处理
             NSLog(@"_%d_%@",__LINE__,@"通用链接测试成功");
             NSLog(@"_%d_%@",__LINE__,webpageURL.absoluteString);
            NSURLComponents * components = [NSURLComponents componentsWithString:webpageURL.absoluteString];
            NSArray * queryItems =  components.queryItems;
            NSString * actionkey =  nil ;
            NSString * ID = nil ;
            for (NSURLQueryItem * item  in queryItems) {
                if ([item.name isEqualToString:@"actionkey"]) {
                    if ([item.value isEqualToString:@"shop"]) {
                        actionkey = @"HShopVC";
                    }else if ([item.value isEqualToString:@"goods"]){
                        actionkey = @"HGoodsVC";
                    }else{
                        actionkey = item.value;
                    }
                    NSLog(@"_%d_%@",__LINE__,item.value);
                }else if ([item.name isEqualToString:@"ID"]){
                    ID = item.value;
                    NSLog(@"_%d_%@",__LINE__,item.value);
                }

                NSLog(@"_%d_%@",__LINE__,item.name);
                NSLog(@"_%d_%@",__LINE__,item.value);
            }
            if (actionkey && ID ) {
                BaseModel * model = [[[BaseModel alloc] init]initWithDict:@{@"actionkey":actionkey,@"paramete":ID}];
                model.actionKey = actionkey;
                model.keyParamete = @{@"paramete":ID};
                [[SkipManager shareSkipManager] skipByVC:[KeyVC shareKeyVC] withActionModel:model];
            }
        }
        else {
            if ([[UIApplication sharedApplication]canOpenURL:webpageURL]) {
                
                [[UIApplication sharedApplication]openURL:webpageURL];
            }
        }
        
    }
    return YES;
    
}
- (BOOL)application:(UIApplication *)application  openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication  annotation:(id)annotation {
    LOG(@"_%@_%d_((application:openURL:sourceApplication:annotation:))%@-->%@-->%@-->",[self class] , __LINE__,url,sourceApplication,annotation);
    
//    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    ///////////////////套友盟/////////////////
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    NSLog(@"%@, %d ,%@",[self class],__LINE__,url.host);

    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
        //////////////////支付宝began//////////////////
        if ([url.host isEqualToString:@"safepay"]) {
            //跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {  [self dealWithTheResultOfAlipy:resultDic];  }];
        }
        
        
        
        /////////////////支付宝end///////////////////
        //调用微信的sdk
        if ([url.host isEqualToString:@"pay"]) {
            return [WXApi handleOpenURL:url delegate:[PayMentManager sharManager]];
        }
        //调用银联支付系统
        
    }
    return result;
}

-(void)dealWithTheResultOfAlipy:(NSDictionary *)resultDic
{
    //                NSLog(@"_%@_%d_支付结果\n%@",[self class] , __LINE__,resultDic);
    LOG(@"_%@_%d_处理返回结果%@",[self class] , __LINE__,resultDic);
    NSDictionary * resultDict = (NSDictionary *) resultDic;
    if ([resultDict[@"resultStatus"] isEqualToString:@"9000"]) {
        [self theViewWithPayResult:PaySuccess];
        /** 暂时不做二次验证 */
//        [[UserInfo shareUserInfo] dealTheResultAfterAlipayWithPayType:@"1" payResult:[resultDict mj_JSONString] success:^(ResponseObject *responseObject) {
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
//            LOG(@"_%@_%d_%d",[self class] , __LINE__,responseObject.status);
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.msg);
//            
//            if (responseObject.status>0) {
//                //验证成功
//                [self theViewWithPayResult:PaySuccess];
//            }
//        } failure:^(NSError *error) {
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
//            //                        AlertInVC(@"支付成功")
//        }];
    }else{
        /**
         9000 : 订单支付成功
         8000 : 正在处理中
         6002 : 网络连接出错
         6001 : 用户中途取消
         4000 : 订单支付失败
         
         */
        [self theViewWithPayResult:PayFailure];
        //                    AlertInVC(@"支付失败,请重试");
    }
}

-(void)theViewWithPayResult:(PayResult)payResult
{
    PayResultVC * payResultVC = [[PayResultVC alloc]init];
    payResultVC.payResult = payResult;

    [[GDKeyVC share]  pushViewController:payResultVC animated:YES];
    
}
// NOTE: 9.0以后使用新API接口

//
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    
    LOG(@"_%@_%d_((ios 9  以后 的新方法application:openURL:options:))openURL-->%@ options-->%@",[self class] , __LINE__,url,options);
    NSLog(@"%@, %d ,%@",[self class],__LINE__,url);
    NSLog(@"%@, %d ,%@",[self class],__LINE__,url.host );

    BOOL result = [UMSocialSnsService handleOpenURL:url];
     NSLog(@"_%d打印openurl结果_%d",__LINE__,result);
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
        //////////////////支付宝began//////////////////
        if ([url.host isEqualToString:@"safepay"]) {
            //跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {   [self dealWithTheResultOfAlipy:resultDic]; }];
        }
        
        /////////////////支付宝end///////////////////
        if ([url.host isEqualToString:@"pay"]) {
            return [WXApi handleOpenURL:url delegate:[PayMentManager sharManager]];
        }
        
    }
    

    return result;
    //       return YES;
}

-(BOOL)checkVersion
{
    /** 存储着的app版本号 */
    NSString * storageAppVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"appVersion"];
    
    // 实时获取App的版本号
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentAppVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    
    NSComparisonResult result = [currentAppVersion compare:storageAppVersion];
    LOG(@"_%@_%d_%lu",[self class] , __LINE__,result);
    if (result == NSOrderedSame) {
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"版本没变");
        return NO;
    }else if (result == NSOrderedAscending){
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"版本降了(不可能)");
        return NO ;
    }else if(result == NSOrderedDescending){
        [[NSUserDefaults standardUserDefaults] setValue:currentAppVersion forKey:@"appVersion"];
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"版本更新了");
        /** 开始展示新特性 */
        return YES;
        
    }else{
        return NO ;
    }
    
    
    LOG(@"_%@_%d_%@",[self class] , __LINE__,currentAppVersion);
}
-(void)finishedShowNewFeature:(NewFeatureVC *)newFeatureVC{
    [self setupKeyVC];
    
}

/** 远程通知 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    LOG(@"_%@_%d_通过远程通知启动程序 userinfo-->%@",[self class] , __LINE__,userInfo);
    [JPUSHService handleRemoteNotification:userInfo];
    LOG(@"_%@_%d_收到通知:-->%@",[self class] , __LINE__,[self logDic:userInfo]);
    
    if (application.applicationState!=UIApplicationStateActive) {
        [self dealWithNotificationWith:userInfo];
    }else{//
        if ([userInfo[@"actionkey"] isEqualToString:@"orderlist"]) {
            NSDictionary * userinfo = @{@"state":@"1"};
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ProfileRedPointShow" object:nil userInfo:userinfo];
        }
    }
}

/**iOS10的接收远程推送方法*/
#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support //程序在前台的通知
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if ([userInfo[@"actionkey"] isEqualToString:@"orderlist"]) {
        NSDictionary * userinfo = @{@"state":@"1"};
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ProfileRedPointShow" object:nil userInfo:userinfo];
    }
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support//程序在后台或退出时的通知
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
    [self dealWithNotificationWith:userInfo];
}


- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}
/** 本地通知 */
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    LOG(@"_%@_%d_通过本地通知启动程序 userinfo-->%@",[self class] , __LINE__,notification);
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
    if (!(application.applicationState==UIApplicationStateActive)) {
        [self dealWithNotificationWith:notification.userInfo];
    }
}

/** 广告视图操作 */
-(void)deleteTimer
{
    [self.timer invalidate];
    self.timer=nil;
}
-(void)creatTimer
{
    self.time = 0 ;
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(daojishi) userInfo:nil repeats:YES];
    self.timer= timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

}
-(void)daojishi
{
    
    self.time+=1;
    if (self.time>=4) {
        [self removeTheAdview];
    }
}
-(void)removeTheAdview
{
    [self deleteTimer];
    [UIView animateWithDuration:2 animations:^{
        self.adView.alpha=0.0;
    } completion:^(BOOL finished) {
        [self.adView removeFromSuperview];
        self.adView = nil;
    }];
}

-(void)showAdvertisementView
{
    if (1) {
        [self creatTimer];
        UIImageView * adView = [[UIImageView alloc]init];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(enterAdd:)];
        [adView addGestureRecognizer:tap];
        
        adView.userInteractionEnabled=YES;
//        adView.backgroundColor = [UIColor whiteColor];
        self.adView=adView;
//        adView.image = [UIImage imageNamed:@"bg_icon_im"];
        [adView sd_setImageWithURL:[NSURL URLWithString:@"http://www.sinaimg.cn/large/6d188eacgw1es9ca9l71fj20c80gaab2.jpg"]];
        [[UIApplication sharedApplication].keyWindow addSubview:adView];
        adView.frame = [UIApplication sharedApplication].keyWindow.bounds;
        CGFloat btnW = 88*SCALE ;
        CGFloat btnH = 44*SCALE ;
        CGFloat btnX = screenW-btnW - 10 ;
        CGFloat btnY = 20 ;
        
        UIButton * jumpBtn = [[UIButton alloc]initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
        [adView addSubview:jumpBtn];
        [jumpBtn setTitleColor:SubTextColor forState:UIControlStateNormal];
        [jumpBtn setTitle:@"跳过" forState:UIControlStateNormal];
        [jumpBtn addTarget:self action:@selector(jumpAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
}

-(void)jumpAction
{
    [self creatTimer];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"点击跳过");
    [self.adView removeFromSuperview];
    self.adView = nil;
}

-(void)enterAdd:(id)sender
{
    LOG(@"_%@_%d_点击进入广告%@",[self class] , __LINE__,sender);
    [self jumpAction];
    //再push出一个新控制器
}
@end

//@implementation NSURLRequest(DataController)
//+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host
//{
//    return YES;
//}
//@end
