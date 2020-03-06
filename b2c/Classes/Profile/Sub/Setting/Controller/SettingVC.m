//
//  SettingVC.m
//  b2c
//
//  Created by wangyuanfei on 3/30/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "SettingVC.h"
#import "CustomDetailCell.h"
#import "GDAudioTool.h"
#import "LoginNavVC.h"


#import "GDXmppStreamManager.h"

@interface SettingVC ()
@property(nonatomic,assign)CGFloat  maxY ;
@property(nonatomic,weak)UIButton * loginOutButton ;
@property(nonatomic,strong)NSArray * leftTitles ;
@property(nonatomic,weak)UISwitch * setMessageSound ;
@property(nonatomic,weak)CustomDetailCell * imgQuarlity ;
//@property(nonatomic,weak)
@property(nonatomic,weak)UILabel * currentVersionNum ;
@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackgroundGray;
//    [self layoutsubviews];
//    [self gotCacheSize];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    
    // Dispose of any resources that can be recreated.
}
-(void)layoutsubviews
{
    [super layoutsubviews];
    CGFloat toTopMargin = 20 ;
    CGFloat startPointY = self.startY + toTopMargin ;
    self.maxY = startPointY ;
    CGFloat subH = 44 ;
    CGFloat cellMargin = 5 ;
//    for (int i = 0 ;  i< 5; i++) {
    for (int i = 0 ;  i< 4; i++) {
        CustomDetailCell * sub = [[CustomDetailCell alloc]initWithFrame:CGRectMake(0, self.maxY, screenW, subH)];
        sub.backgroundColor = [UIColor whiteColor];
        sub.leftTitleFont = [UIFont systemFontOfSize:13];
        sub.leftTitle = self.leftTitles[i];
        if (i==0) {
            sub.arrowHidden = YES;
            [self.view addSubview:sub];
            UISwitch * setMessageSound = [[UISwitch alloc]init];
            setMessageSound.on=[[[NSUserDefaults standardUserDefaults] objectForKey:NOTICESOUNDMODE] boolValue];
            self.setMessageSound =setMessageSound ;
            [setMessageSound addTarget:self action:@selector(changeMessageSoundState:) forControlEvents:UIControlEventValueChanged];
            CGFloat W= setMessageSound.bounds.size.width;
//            CGFloat H= setMessageSound.bounds.size.height;
            setMessageSound.center = CGPointMake(sub.bounds.size.width-10 - W/2,sub.bounds.size.height/2);
            [sub addSubview:setMessageSound];

        }else if(i==1){
            /**
             property(nonatomic,copy)NSString * actionKey ;
             @property(nonatomic,copy)NSString * title ;
              是否需要判断是否登录 默认是NO
            @property(nonatomic,assign)BOOL  judge ;
             */
            [sub addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:sub];
            sub.tag = 1818 ;
                NSInteger currentImgMode = [[[NSUserDefaults standardUserDefaults] objectForKey:@"currentImgMode"] integerValue];
            if (currentImgMode==0) {
              sub.rightDetailTitle = @"智能模式";
            }else if (currentImgMode==1){
            sub.rightDetailTitle = @"高质量(适合wifi环境)";
            }else if (currentImgMode==2){
            sub.rightDetailTitle = @"普通(适合3G或者2G环境)";
            }
            self.imgQuarlity = sub;
        }else if (i==2){
            [sub addTarget:self action:@selector(clearDiskCacheMemory:) forControlEvents:UIControlEventTouchUpInside];
            sub.arrowHidden = YES;
//            sub.rightDetailTitle = [NSString stringWithFormat:@"%dMB",(NSUInteger)[self gotCacheSize]];
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                [self gotCacheSize:^(NSInteger size) {
                    
                      dispatch_async(dispatch_get_main_queue(), ^{
                    sub.rightDetailTitle = [NSString stringWithFormat:@"%ldMB",(NSUInteger)[self gotCacheSize]];
                           });
                }];
                
                
            });
            
            
//            [self gotCacheSize:^(NSInteger size) {
//               sub.rightDetailTitle = [NSString stringWithFormat:@"%dMB",(NSUInteger)[self gotCacheSize]];
//            }];
            [self.view addSubview:sub];
            sub.tag = 2828;
        }/*else if(i==3){
            [sub addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:sub];
            sub.tag = 3838;
        }*/else{
            [sub addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:sub];
            sub.tag = 4848;
        }
        
        self.maxY += (subH+cellMargin);
    }
    
    UILabel * currentVersionNum = [[UILabel alloc]init ];
    currentVersionNum.font = [UIFont systemFontOfSize:12];
    currentVersionNum.textAlignment = NSTextAlignmentCenter;
    currentVersionNum.textColor = SubTextColor;
    self.currentVersionNum = currentVersionNum;
    currentVersionNum.bounds = CGRectMake(0, 0, screenW, 20);
    currentVersionNum.center = CGPointMake(screenW/2, self.maxY+currentVersionNum.bounds.size.height/2);
//     [[NSUserDefaults standardUserDefaults] setValue:currentAppVersion forKey:@"appVersion"];
    NSString * currentnum =    [[NSUserDefaults standardUserDefaults] objectForKey:@"appVersion"];
    currentVersionNum.text = [NSString stringWithFormat:@"当前版本号为%@",currentnum];
    [self.view addSubview:currentVersionNum];
    
    
    
    UIButton * loginOutButton = [[UIButton alloc]init];
    [loginOutButton setTitle:@"退出登录" forState:UIControlStateNormal];
    loginOutButton.bounds = CGRectMake(0, 0, screenW-40, 50);
    loginOutButton.center = CGPointMake(self.view.center.x, self.maxY + 100);
    [loginOutButton addTarget:self action:@selector(loginOutClick:) forControlEvents:UIControlEventTouchUpInside];
    loginOutButton.backgroundColor = [UIColor redColor];
    loginOutButton.layer.cornerRadius = 5 ;
    loginOutButton.layer.masksToBounds = YES;
    [self.view  addSubview:loginOutButton];
    self.loginOutButton = loginOutButton ;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    self.loginOutButton.hidden = ![UserInfo shareUserInfo].isLogin ;
    NSInteger currentImgMode = [[[NSUserDefaults standardUserDefaults] objectForKey:@"currentImgMode"] integerValue];
    if (currentImgMode==0) {
        self.imgQuarlity.rightDetailTitle = @"智能模式";
    }else if (currentImgMode==1){
        self.imgQuarlity.rightDetailTitle = @"高质量(适合wifi环境)";
    }else if (currentImgMode==2){
        self.imgQuarlity.rightDetailTitle = @"普通(适合3G或者2G环境)";
    }
    

}
-(void)cellClick:(CustomDetailCell*)sender
{
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"点击cell")
    if (sender.tag == 1818) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"切换图片质量");
        BaseModel * model = [[BaseModel alloc]init];
        model.actionKey = @"ImageQualityVC";
        [[SkipManager shareSkipManager] skipByVC:self withActionModel:model];
        
    }else if (sender.tag == 3838){
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"检查版本");
//        [self checkVersion];
//        [[UserInfo shareUserInfo] checkVersionInfoSuccess:^(ResponseObject *responseObject) {
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.msg);
//            LOG(@"_%@_%d_%d",[self class] , __LINE__,responseObject.status);
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
//            NSString * type = responseObject.data[@"type"];//1:提示升级 2:强制升级
//            if ([type isEqualToString:@"1"]) {
//                
//            }else if ([type isEqualToString:@"2"]){
//                
//            }
//        } failure:^(NSError *error) {
//           AlertInSubview(@"已是最新版本")
//        }];
//        
    }else if (sender.tag == 4848){
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"去给我评分");
        
        NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",@"1133780608"];
        NSURL * url = [NSURL URLWithString:str];
        
        if ([[UIApplication sharedApplication] canOpenURL:url])
        {
            [[UIApplication sharedApplication] openURL:url];
        }
        else
        {
            NSLog(@"can not open");
        }
    }
}
-(void)checkVersion
{
    [[UserInfo shareUserInfo] checkVersionInfoSuccess:^(ResponseObject *responseObject) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
        if ([responseObject.data isKindOfClass:[NSDictionary class]]) {
            
            NSString * type = responseObject.data[@"type"];
            
                NSString * versionStrByInternet = responseObject.data[@"version_code"];
                // 实时获取App的版本号
                NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
                NSString *currentAppVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
                
                NSComparisonResult result = [versionStrByInternet compare:currentAppVersion];
                LOG(@"_%@_%d_%lu",[self class] , __LINE__,result);
                if (result == NSOrderedSame) {
                    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"版本没变");
                    AlertInSubview(@"已是最新版本")
                }else if (result == NSOrderedAscending){
                    AlertInSubview(@"已是最新版本")
                    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"版本降了(不可能)");
                }else if(result == NSOrderedDescending){
                    [[NSUserDefaults standardUserDefaults] setValue:currentAppVersion forKey:@"appVersion"];
                    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"弹框提示更新版本");
                    /** 弹框提示前往qppstore更新版本 */
                    [self performNotisGotoUpdateVersionWithType:type];
                }


        }else{
            AlertInSubview(@"操作失败,请重试")
        }
    } failure:^(NSError *error) {
        
        AlertInSubview(@"已是最新版本")
        LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
    }];

}

-(void)performNotisGotoUpdateVersionWithType:(NSString*)type
{
    
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"有新版本喽" preferredStyle:UIAlertControllerStyleAlert];
     if ([type isEqualToString:@"1"]) {//1:提示升级
//        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"有新版本喽" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * ac1 = [UIAlertAction actionWithTitle:@"残忍拒绝" style:UIAlertActionStyleDestructive  handler:^(UIAlertAction * _Nonnull action) {
            return ;
        }];
//        UIAlertAction * ac2 = [UIAlertAction actionWithTitle:@"更新去喽" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//            NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",@"1133780608"];
//            NSURL * url = [NSURL URLWithString:str];
//            
//            if ([[UIApplication sharedApplication] canOpenURL:url])
//            {
//                [[UIApplication sharedApplication] openURL:url];
//            }
//            else
//            {
//                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"can not open");
//            }
//            
//            
//        }];
        
        [alertVC addAction:ac1];
//        [alertVC addAction:ac2];
        


    }else if ([type isEqualToString:@"2"]){// 2:强制升级
//        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"有新版本喽" preferredStyle:UIAlertControllerStyleAlert];

//        UIAlertAction * ac2 = [UIAlertAction actionWithTitle:@"更新去喽" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//            NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",@"1133780608"];
//            NSURL * url = [NSURL URLWithString:str];
//            
//            if ([[UIApplication sharedApplication] canOpenURL:url])
//            {
//                [[UIApplication sharedApplication] openURL:url];
//            }
//            else
//            {
//                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"can not open");
//            }
//            
//            
//        }];
//        [alertVC addAction:ac2];
        


    }
    
    UIAlertAction * ac2 = [UIAlertAction actionWithTitle:@"更新去喽" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",@"1133780608"];
        NSURL * url = [NSURL URLWithString:str];
        
        if ([[UIApplication sharedApplication] canOpenURL:url])
        {
            [[UIApplication sharedApplication] openURL:url];
        }
        else
        {
            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"can not open");
        }
        
        
    }];
    [alertVC addAction:ac2];

    [self presentViewController:alertVC animated:YES completion:^{
        
    }];
}

-(void)loginOutClick:(UIButton * )sender
{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"退出登录")
    if (NetWorkingStatus == AFNetworkReachabilityStatusUnknown || NetWorkingStatus == AFNetworkReachabilityStatusNotReachable) {
        //标记
        NSString * mark = @"isNeedLoginoutAfterReconnectToNetworking" ;
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:mark];
        //再在网络恢复的地方调用退出接口
    }
    if ([UserInfo shareUserInfo].isLogin) {
        /** 运行在手机上的退出方法(需要权限去清空服务器端的token) */
        [[UserInfo shareUserInfo] loginOutSuccess:^(ResponseObject *responseObject) {
            LOG(@"_%@_%d_退出结果%@",[self class] , __LINE__,responseObject);
//            LoginNavVC * loginVC  = [[LoginNavVC alloc]initLoginNavVC];
//            [[KeyVC shareKeyVC] presentViewController:loginVC animated:YES completion:nil];
             [[NSNotificationCenter defaultCenter] postNotificationName:LOGINOUTSUCCESS object:nil];
            [self.navigationController  popViewControllerAnimated:YES];
        } failure:^(NSError *error) {
            AlertInVC(@"操作失败,请重试");
            LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
        }];
        
        /** 运行在模拟器上的退出方法 */
//        [[UserInfo  shareUserInfo] loginOutResult:^(BOOL paramete) {
//            if (paramete) {
////                            AlertInVC(@"退出成功");
//                LoginNavVC * loginVC  = [[LoginNavVC alloc]initLoginNavVC];
//                [[KeyVC shareKeyVC] presentViewController:loginVC animated:YES completion:nil];
//
//                [[NSNotificationCenter defaultCenter] postNotificationName:LOGINOUTSUCCESS object:nil];
//                [[GDXmppStreamManager ShareXMPPManager].XmppStream disconnect];
//            }else{
//                AlertInVC(@"未登陆")
//            }
//        }];
    }else{
     AlertInVC(@"未登陆")
    }
}
-(void)changeMessageSoundState:(UISwitch*)sender
{
//    [[GDAudioTool sharAudioTool].player play];
    [[NSUserDefaults standardUserDefaults] setValue:@(sender.isOn) forKey:NOTICESOUNDMODE];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,[NSString stringWithFormat:@"状态改变了%d",sender.isOn])
}
-(NSArray * )leftTitles{
    if(_leftTitles==nil){
//        _leftTitles = @[@"消息通知提示",@"图片质量",@"清除本地缓存",@"检查版本",@"给我们评分"];
        _leftTitles = @[@"消息通知提示",@"图片质量",@"清除本地缓存",@"给我们评分"];
    
    }
    return _leftTitles;
}

//获取磁盘缓存(单位mb)

-(CGFloat)gotCacheSize
{
    SDImageCache * cache = [SDImageCache sharedImageCache];
    LOG(@"_%@_%d_磁盘缓存大小%ldMB",[self class] , __LINE__,cache.getSize/1024/1024)
    return cache.getSize/1024/1024 ;

}

-(void)gotCacheSize:(void(^)(NSInteger size))callBack
{
    SDImageCache * cache = [SDImageCache sharedImageCache];
    LOG(@"_%@_%d_磁盘缓存大小%ldMB",[self class] , __LINE__,cache.getSize/1024/1024)
    NSInteger s = cache.getSize/1024/1024 ;
    callBack(s);
}

//清空磁盘缓存
-(void)clearDiskCacheMemory:(CustomDetailCell*)sender
{
    
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache] cleanDisk];
    [[SDImageCache sharedImageCache] clearDisk];
    sender.rightDetailTitle = [NSString stringWithFormat:@"%luMB",(NSUInteger)[self gotCacheSize]];
    AlertInVC(@"缓存清除成功")
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"清空了磁盘缓存")
//    [[SDWebImageManager sharedManager] cancelAll];
}


-(void)test1
{
//    NSString *  ss[]  = {} ;
}











//-(void)layoutsubviews
//{
//    [super layoutsubviews];
//    CGFloat toTopMargin = 20 ;
//    CGFloat startPointY = self.startY + toTopMargin ;
//    self.maxY = startPointY ;
//    CGFloat subH = 44 ;
//    CGFloat cellMargin = 5 ;
//    //    for (int i = 0 ;  i< 5; i++) {
//    for (int i = 0 ;  i< 4; i++) {
//        CustomDetailCell * sub = [[CustomDetailCell alloc]initWithFrame:CGRectMake(0, self.maxY, screenW, subH)];
//        sub.backgroundColor = [UIColor whiteColor];
//        sub.leftTitleFont = [UIFont systemFontOfSize:13];
//        sub.leftTitle = self.leftTitles[i];
//        if (i==0) {
//            sub.arrowHidden = YES;
//            [self.view addSubview:sub];
//            UISwitch * setMessageSound = [[UISwitch alloc]init];
//            setMessageSound.on=[[[NSUserDefaults standardUserDefaults] objectForKey:NOTICESOUNDMODE] boolValue];
//            self.setMessageSound =setMessageSound ;
//            [setMessageSound addTarget:self action:@selector(changeMessageSoundState:) forControlEvents:UIControlEventValueChanged];
//            CGFloat W= setMessageSound.bounds.size.width;
//            //            CGFloat H= setMessageSound.bounds.size.height;
//            setMessageSound.center = CGPointMake(sub.bounds.size.width-10 - W/2,sub.bounds.size.height/2);
//            [sub addSubview:setMessageSound];
//            
//        }else if(i==1){
//            /**
//             property(nonatomic,copy)NSString * actionKey ;
//             @property(nonatomic,copy)NSString * title ;
//             是否需要判断是否登录 默认是NO
//             @property(nonatomic,assign)BOOL  judge ;
//             */
//            [sub addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
//            [self.view addSubview:sub];
//            sub.tag = 1818 ;
//            NSInteger currentImgMode = [[[NSUserDefaults standardUserDefaults] objectForKey:@"currentImgMode"] integerValue];
//            if (currentImgMode==0) {
//                sub.rightDetailTitle = @"智能模式";
//            }else if (currentImgMode==1){
//                sub.rightDetailTitle = @"高质量(适合wifi环境)";
//            }else if (currentImgMode==2){
//                sub.rightDetailTitle = @"普通(适合3G或者2G环境)";
//            }
//            self.imgQuarlity = sub;
//        }else if (i==2){
//            [sub addTarget:self action:@selector(clearDiskCacheMemory:) forControlEvents:UIControlEventTouchUpInside];
//            sub.arrowHidden = YES;
//            sub.rightDetailTitle = [NSString stringWithFormat:@"%luMB",(NSUInteger)[self gotCacheSize]];
//            [self.view addSubview:sub];
//            sub.tag = 2828;
//        }else if(i==3)/*{
//                       [sub addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
//                       [self.view addSubview:sub];
//                       sub.tag = 3838;
//                       }else*/{
//                           [sub addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
//                           [self.view addSubview:sub];
//                           sub.tag = 4848;
//                       }
//        
//        self.maxY += (subH+cellMargin);
//    }
//    
//    UILabel * currentVersionNum = [[UILabel alloc]init ];
//    currentVersionNum.font = [UIFont systemFontOfSize:12];
//    currentVersionNum.textAlignment = NSTextAlignmentCenter;
//    currentVersionNum.textColor = SubTextColor;
//    self.currentVersionNum = currentVersionNum;
//    currentVersionNum.bounds = CGRectMake(0, 0, screenW, 20);
//    currentVersionNum.center = CGPointMake(screenW/2, self.maxY+currentVersionNum.bounds.size.height/2);
//    //     [[NSUserDefaults standardUserDefaults] setValue:currentAppVersion forKey:@"appVersion"];
//    NSString * currentnum =    [[NSUserDefaults standardUserDefaults] objectForKey:@"appVersion"];
//    currentVersionNum.text = [NSString stringWithFormat:@"当前版本号为%@",currentnum];
//    [self.view addSubview:currentVersionNum];
//    
//    
//    
//    UIButton * loginOutButton = [[UIButton alloc]init];
//    [loginOutButton setTitle:@"退出登录" forState:UIControlStateNormal];
//    loginOutButton.bounds = CGRectMake(0, 0, screenW-40, 50);
//    loginOutButton.center = CGPointMake(self.view.center.x, self.maxY + 100);
//    [loginOutButton addTarget:self action:@selector(loginOutClick:) forControlEvents:UIControlEventTouchUpInside];
//    loginOutButton.backgroundColor = [UIColor redColor];
//    loginOutButton.layer.cornerRadius = 5 ;
//    loginOutButton.layer.masksToBounds = YES;
//    [self.view  addSubview:loginOutButton];
//    self.loginOutButton = loginOutButton ;
//    
//}
@end
