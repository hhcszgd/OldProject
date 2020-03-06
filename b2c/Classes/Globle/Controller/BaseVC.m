//
//  BaseVC.m
//  b2c
//
//  Created by wangyuanfei on 3/23/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "BaseVC.h"

@interface BaseVC ()
@property(nonatomic,weak)UIView * viewWhenDisconnect ;
@property(nonatomic,assign)NSUInteger  refreshOrLoadMoreCount ;

@property(nonatomic,strong)UIActivityIndicatorView * activetyIndicator ;
@end

@implementation BaseVC
-(UIActivityIndicatorView * )activetyIndicator{
    if(_activetyIndicator==nil){
        _activetyIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self.view addSubview:_activetyIndicator];
        _activetyIndicator.center = self.view.center;
        
    }
    return _activetyIndicator;
}
- (void)viewDidLoad {
//    [self setupNetworkStatus];
    [super viewDidLoad];
    
//    LOG(@"_%@_%d_这是基类中 取到的网络状态  %ld",[self class] , __LINE__,NetWorkingStatus)
//    LOG(@"_%@_%d_这是基类中 取到的网络状态  %ld",[self class] , __LINE__,self.netStatus)
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netchangeed) name:AFNetworkingReachabilityDidChangeNotification object:nil];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];//导航栏左右两侧按钮颜色
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{ NSForegroundColorAttributeName :[UIColor whiteColor] }];//导航栏标题颜色
    
    self.view.backgroundColor=[UIColor colorWithHexString:@"f4f4f4"];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.navigationController.navigationBarHidden=YES;
    
//    LOG(@"_%@_%d_%f",[self class] , __LINE__,NavigationBarHeight)
    // Do any additional setup after loading the view.
}


-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
//    [self setupNetworkStatus];
}
//-(void)netchangeed
//{
//    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus==-1) {
//        //断开
//        self.networkingStatus=NETERROR;
//    }else if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus==0){
//        //无法连接
//        self.networkingStatus=NETERROR;
//    }else if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus==1){
//        //3g
//        self.networkingStatus=NETMOBILE;
//    }else if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus==2){
//        //wifi
//        self.networkingStatus=NETWIFI;
//    }
//    LOG(@"_%@_%d_这个是afn监听的网络状态的改变%ld",[self class] , __LINE__,[AFNetworkReachabilityManager sharedManager].networkReachabilityStatus)
//
//    LOG(@"_%@_%d_这是自己定义的网络状态属性%ld",[self class] , __LINE__,self.networkingStatus)
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    [[SDWebImageManager sharedManager] cancelAll];
    [[SDImageCache sharedImageCache] clearMemory];
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
-(void)setNetStatus:(NetworkingStatus)netStatus{
    if (_netStatus!=netStatus && netStatus>0) {
        self.networkChanged = YES;
        if ([UserInfo shareUserInfo].currentImgMode==0) {
            if (self.netStatus==NETMOBILE) {
                [[UserInfo shareUserInfo] setupNetworkStates:1 success:^(ResponseObject *responseObject) {
                    LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
                } failure:^(NSError *error) {
                    LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
                }];
            }else if (self.netStatus == NETWIFI){
                
                [[UserInfo shareUserInfo] setupNetworkStates:0 success:^(ResponseObject *responseObject) {
                    LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
                } failure:^(NSError *error) {
                    LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
                }];
            }

        }
        
        
        
    }
    _netStatus = netStatus;
}
-(void)netchangeed
{
    self.netStatus = NetWorkingStatus;

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.netStatus = NetWorkingStatus;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.networkChanged = NO;
}
-(void)setTableView:(UITableView *)tableView{
    _tableView = tableView ;
    [self.view addSubview:tableView];
    tableView.delegate =self;
    tableView.dataSource = self;
}
//-(void)setupNetworkStatus
//{
//    __weak typeof(self) weakSelf = self;
    
//    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        switch (status) {
//            case AFNetworkReachabilityStatusUnknown:
//                LOG(@"_%@_%d_%@",[weakSelf class] , __LINE__,@"UnknownNetworking")
//                weakSelf.networkingStatus = NETERROR;
//                weakSelf.networkHasChange=YES;
//                break;
//                
//            case AFNetworkReachabilityStatusNotReachable:
//                LOG(@"_%@_%d_%@",[weakSelf class] , __LINE__,@"disconnect")
//                weakSelf.networkingStatus = NETERROR;
//                weakSelf.networkHasChange=YES;
//                //            [self viewWhenNetWorkingError];
//                
//                break;
//            case AFNetworkReachabilityStatusReachableViaWWAN:
//                //            [self.viewWhenNetWorkingError removeFromSuperview];
//                LOG(@"_%@_%d_%@",[weakSelf class] , __LINE__,@"mobileNet")
//                weakSelf.networkingStatus = NETMOBILE;
//                weakSelf.networkHasChange=YES;
//                //            [self reloadWhenNecworkingReconnect];
//                break;
//            case AFNetworkReachabilityStatusReachableViaWiFi:
//                //            [self.viewWhenNetWorkingError removeFromSuperview];
//                LOG(@"_%@_%d_%@",[weakSelf class] , __LINE__,@"wifi")
//                weakSelf.networkingStatus = NETWIFI;
//                weakSelf.networkHasChange=YES;
//                //            [self reloadWhenNecworkingReconnect];
//                break;
//            default:
//                LOG(@"_%@_%d_%@",[weakSelf class] , __LINE__,@"sssssssss")
//                weakSelf.networkHasChange = YES;
//                break;
//        }
//        
//    } ];
//    [[AFNetworkReachabilityManager sharedManager] startMonitoring];

//}

///////////////////////
//-(void)setNetworkingStatus:(NetworkingStatus)networkingStatus{
//    _networkingStatus = networkingStatus;
//    switch (networkingStatus) {
//        case NETERROR:
//        {
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"UnknownNetworking")
////            ALERT(@"网络错误")
//        }
//            break;
//
//        case NETMOBILE:
//        {
//            //            [self.viewWhenNetWorkingError removeFromSuperview];
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"mobileNet")
////            ALERT(@"网络连接成功")
//        }
//            break;
//        case NETWIFI:
//        {
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"wifi")
////            ALERT(@"当前网络为wifi")
//        }
//            break;
//        default:
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"未知错误")
//            break;
//    }
//}

//
//-(void)netWorkingChangeWithStatus:(AFNetworkReachabilityStatus)status
//{
//    switch (status) {
//        case AFNetworkReachabilityStatusUnknown:
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"UnknownNetworking")
//            self.networkingStatus = NETERROR;
//            break;
//            
//        case AFNetworkReachabilityStatusNotReachable:
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"disconnect")
//            self.networkingStatus = NETERROR;
//            //            [self viewWhenNetWorkingError];
//            
//            break;
//        case AFNetworkReachabilityStatusReachableViaWWAN:
//            //            [self.viewWhenNetWorkingError removeFromSuperview];
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"mobileNet")
//            self.networkingStatus = NETMOBILE;
//            //            [self reloadWhenNecworkingReconnect];
//            break;
//        case AFNetworkReachabilityStatusReachableViaWiFi:
//            //            [self.viewWhenNetWorkingError removeFromSuperview];
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"wifi")
//            self.networkingStatus = NETWIFI;
//            //            [self reloadWhenNecworkingReconnect];
//            break;
//        default:
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"sssssssss")
//            break;
//    }
//}
/** 当没有网络的时候掉一下这个方法 */
-(void)showTheViewWhenDisconnectWithFrame:(CGRect)frame{
    
    [self removeTheViewWhenConnect];
//    UIView * viewWhenDisconnect = [[UIView alloc]initWithFrame:frame];
//    viewWhenDisconnect.backgroundColor = [UIColor purpleColor];
//    self.viewWhenDisconnect = viewWhenDisconnect;
//    [self.view addSubview:viewWhenDisconnect];
    UIButton * viewWhenDisconnect = [[UIButton alloc]initWithFrame:frame];
    viewWhenDisconnect.backgroundColor = BackgroundGray;
    [viewWhenDisconnect setImage:[UIImage imageNamed:@"networkError"] forState:UIControlStateNormal];
    viewWhenDisconnect.imageView.contentMode =UIViewContentModeScaleAspectFit ;
    /**@property(nonatomic)          BOOL         adjustsImageWhenHighlighted;    // default is YES. if YES, image is drawn darker when highlighted(pressed)
     @property(nonatomic)          BOOL         adjustsImageWhenDisabled;       // default is YES. if YES, image is drawn lighter when disabled
     @property(nonatomic)          BOOL         showsTouchWhenHighlighted __TVOS_PROHIBITED;
     */
    
    viewWhenDisconnect.adjustsImageWhenHighlighted = NO ;
    [viewWhenDisconnect addTarget:self action:@selector(reconnectClick:) forControlEvents:UIControlEventTouchUpInside];
    self.viewWhenDisconnect = viewWhenDisconnect;
    [self.view addSubview:viewWhenDisconnect];
    
}

-(void)reconnectClick:(UIButton*)sender{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"在跟控制器中  , 点击重连的回调方法")

}
//-(void)clickTry:(UIButton*)sender
//{
//}
/** 当恢复网络的时候调一下这个方法 */
-(void)removeTheViewWhenConnect{
    [self.viewWhenDisconnect removeFromSuperview];
    self.viewWhenDisconnect = nil;
}


-(void)dealloc{
    
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"销毁")
    [[NSNotificationCenter defaultCenter] removeObserver:self ];
    //    [self.view removeObserver:self forKeyPath:@"subviews"];
}
-(void)refreshData{
    self.refreshOrLoadMoreCount++;
    if (!(NetWorkingStatus>0) && self.refreshOrLoadMoreCount%3==0) {
        AlertInVC(@"网络连接错误")
    }
}
-(void)LoadMore{
    self.refreshOrLoadMoreCount++;
    if (!(NetWorkingStatus>0) && self.refreshOrLoadMoreCount%3==0) {
        AlertInVC(@"网络连接错误")
    }
}

-(void)showLoadingView{
     [self.activetyIndicator startAnimating];
}
-(void)hiddenLoadingView{
    
    [self.activetyIndicator stopAnimating];
    [self.activetyIndicator removeFromSuperview];
    self.activetyIndicator=nil ;
}
@end
