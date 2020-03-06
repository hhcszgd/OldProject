//
//  ShopCarVC.m
//  b2c
//
//  Created by wangyuanfei on 3/23/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
/**
要点 : 当没收藏商品时 ,在tableHeader中显示空空如也
      当有收藏商品时 , 各自分组显示(失效宝贝归为一组,每个店铺归为一组 , 猜你喜欢归为一组)
*/

#import "ShopCarVC.h"
#import "ShopCarFullVC.h"
#import "ShopCarEmptyVC.h"
@interface ShopCarVC ()<ShopCarFullVCDelegate,ShopCarEmptyVCDelegate>
/** 底部结算条 , 当tabbar显示时 , 贴近tabbar最上端,当tabbar隐藏时 , 贴近屏幕底边 , 当购物车为空时隐藏 */
@property(nonatomic,strong)NSMutableArray * shopCarData ;
//@property(nonatomic,weak)UIView * bottomMenuBar ;
@property(nonatomic,weak) ShopCarFullVC * shopCarFullVC  ;
@property(nonatomic,weak) ShopCarEmptyVC * shopCarEmptyVC  ;
@property(nonatomic,assign)BOOL   hasChanged ;
@end

@implementation ShopCarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shopCarChangedCallBack) name:SHOPCARDATACHANGED object:nil];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(FromShopCarEmptyVCToRootVC) name:@"FromShopCarEmptyVCToRootVC" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shopCarChangedCallBack) name:LOGINSUCCESS object:nil];
    self.view.backgroundColor=BackgroundGray;
    self.automaticallyAdjustsScrollViewInsets=NO;
        self.naviTitle=@"购物车";
//    [self switchFullOrEmptyWithBoll:NO];//在这儿临时更改(现在是真实数据, 不用在这模拟了)
    [self gotShopCarDataByrRemoteLoadSuccess:^{
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"成功回调")
    } failure:^{
        [self showTheViewWhenDisconnectWithFrame:CGRectMake(0, self.startY, self.view.bounds.size.width, self.view.bounds.size.height-self.startY - self.tabBarController.tabBar.bounds.size.height)];
    }];//真实数据

}
-(void)FromShopCarEmptyVCToRootVC
{
    [self.navigationController popToRootViewControllerAnimated:NO];
}
-(void)reconnectClick:(UIButton *)sender{
    [self gotShopCarDataByrRemoteLoadSuccess:^{
        [self removeTheViewWhenConnect];
    } failure:^{
        AlertInVC(@"无网络");
    }];
}
-(void)switchFullOrEmptyWithBoll:(BOOL)change// 根据网络返回的真实数据,判断购物车是否有商品,再掉这个方法,其他不动
{
//    [self hiddenBottomMenuBarWithShopCarIsFull:change];
    if (change) {//购物车有商品就传yes , menuBar放在有商品的控制器view里
        [self setupShopCarFullVC];
    }else{//购物车没有商品就传NO
        [self setupShopCarEmptyVC];
    }

}

-(void)setupShopCarFullVC
{
    [self.shopCarEmptyVC.view removeFromSuperview];
    [self.shopCarEmptyVC removeFromParentViewController];
    self.shopCarEmptyVC=nil;
    
    if (!self.shopCarFullVC) {
        
        ShopCarFullVC * fullVC = [[ShopCarFullVC alloc] init];
        fullVC.delegate=self;
        self.shopCarFullVC= fullVC;
        [self addChildViewController:fullVC];
        [self.view addSubview:fullVC.view];
//        [self.view bringSubviewToFront:self.bottomMenuBar];
        
    }
    [self layoutShopCarFullVC];
}

-(void)layoutShopCarFullVC
{

    CGFloat  viewX = 0 ;
    CGFloat  viewY = self.startY ;
    CGFloat  viewW = self.view.bounds.size.width;
    CGFloat  viewH =0;
    if (self.tabBarController.tabBar.isHidden) {
        viewH = self.view.bounds.size.height-self.startY;
    }else{
        viewH =self.view.bounds.size.height-self.startY - self.tabBarController.tabBar.bounds.size.height;
    }
    self.shopCarFullVC.view.frame = CGRectMake(viewX,viewY,viewW,viewH);

}

-(void)setupShopCarEmptyVC
{
    [self.shopCarFullVC.view removeFromSuperview];
    [self.shopCarFullVC removeFromParentViewController];
    self.shopCarFullVC=nil;
    
    
    if (!self.shopCarEmptyVC) {
        ShopCarEmptyVC * shopCarEmptyVC = [[ShopCarEmptyVC alloc] init];
        self.shopCarEmptyVC= shopCarEmptyVC;
        self.shopCarEmptyVC.delegate = self;
        [self addChildViewController:shopCarEmptyVC];
        [self.view addSubview:shopCarEmptyVC.view];
//        [self.view bringSubviewToFront:self.bottomMenuBar];
    }
    [self layoutShopCarEmptyVC];
}
-(void)layoutShopCarEmptyVC
{
    
    CGFloat  viewX = 0 ;
    CGFloat  viewY = self.startY ;
    CGFloat  viewW = self.view.bounds.size.width;
    CGFloat  viewH =0;
    if (self.tabBarController.tabBar.isHidden) {
        viewH = self.view.bounds.size.height-self.startY;
    }else{
        viewH =self.view.bounds.size.height-self.startY - self.tabBarController.tabBar.bounds.size.height ;
    }
    
    self.shopCarEmptyVC.view.frame = CGRectMake(viewX,viewY,viewW,viewH);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray * )shopCarData{
    if(_shopCarData==nil){
        _shopCarData = [[NSMutableArray alloc]init];
    }
    return _shopCarData;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(self.hasChanged ){
        self.hasChanged = NO ;
        [self gotShopCarDataByrRemoteLoadSuccess:^{
            [self removeTheViewWhenConnect];
        } failure:^{
            [self showTheViewWhenDisconnectWithFrame:CGRectMake(0, self.startY, self.view.bounds.size.width, self.view.bounds.size.height-self.startY - self.tabBarController.tabBar.bounds.size.height)];
        }];
        
//        [self gotShopCarDataByrRemoteLoadSuccess:^{
//            
//        } failure:^{
//            
//        }];//购物车发生变化的时候才让它调用,里面会刷新
//        [self.shopCarFullVC.tableView reloadData];
    }

}
-(void)shopCarChangedCallBack
{
    self.hasChanged = YES;
}
-(void)gotShopCarDataByrRemoteLoadSuccess:(void(^)())success failure:(void(^)())failure//每删除一个购物车数据也要调用一下这个方法 //但不在同一个控制器,就用代理调这个方法
{
    
    
    [[UserInfo shareUserInfo] gotShopingCarSuccess:^(ResponseStatus response) {
        
        self.shopCarData = [[UserInfo shareUserInfo].shoppingCarData mutableCopy];
        //把结算toolbar显示 , self.toobar.hidden = NO ;
        if (self.shopCarData.count>0) {
            [self switchFullOrEmptyWithBoll:YES];
            
#pragma 在这儿赋值,再重写set方法
            //            self.networkHasChange = NO;
            self.shopCarFullVC.shopCarData = self.shopCarData;
            [UserInfo shareUserInfo].shopCarDataHasChange=NO;
        }else{
            [self switchFullOrEmptyWithBoll:NO];
        }
        if (success) {
            success();
            
        }
    } failure:^(NSError *error) {
        if (failure) {

            failure();
            
        }
    }];
}
//-(void)gotShopCarDataByrRemoteLoad//每删除一个购物车数据也要调用一下这个方法 //但不在同一个控制器,就用代理调这个方法
//{
//    
//    
//    [[UserInfo shareUserInfo] gotShopingCarSuccess:^(ResponseStatus response) {
//       self.shopCarData = [[UserInfo shareUserInfo].shoppingCarData mutableCopy];
//        //把结算toolbar显示 , self.toobar.hidden = NO ;
//        if (self.shopCarData.count>0) {
//            [self switchFullOrEmptyWithBoll:YES];
//#pragma 在这儿赋值,再重写set方法
////            self.networkHasChange = NO;
//            self.shopCarFullVC.shopCarData = self.shopCarData;
//            [UserInfo shareUserInfo].shopCarDataHasChange=NO;
//        }else{
//            [self switchFullOrEmptyWithBoll:NO];
//        }
//        
//    } failure:^(NSError *error) {
//        
//    }];
//}
//fullVCDelegate
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//-(void) shopCarDataHasChanged:(ShopCarEmptyVC*)emptyVC {
//    [self gotShopCarDataByrRemoteLoadSuccess:^{
//        [self removeTheViewWhenConnect];
//    } failure:^{
//        [self showTheViewWhenDisconnectWithFrame:CGRectMake(0, self.startY, self.view.bounds.size.width, self.view.bounds.size.height-self.startY - self.tabBarController.tabBar.bounds.size.height)];
//    }];
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"数据更新代理执行成功")
//}
-(void) shopCarDataHasChanged:(ShopCarFullVC*)fullVC {
    [self gotShopCarDataByrRemoteLoadSuccess:^{
         [self removeTheViewWhenConnect];
    } failure:^{
        [self showTheViewWhenDisconnectWithFrame:CGRectMake(0, self.startY, self.view.bounds.size.width, self.view.bounds.size.height-self.startY - self.tabBarController.tabBar.bounds.size.height)];
    }];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"数据更新代理执行成功")
}

//-(void)setNetworkingStatus:(NetworkingStatus)networkingStatus{
//    [super setNetworkingStatus:networkingStatus];
//    LOG(@"_%@_%d_首页的网络状态改变了%ld",[self class] , __LINE__,networkingStatus)
//    if (networkingStatus!=0) {
//
//        [self gotShopCarDataByrRemoteLoad];
//        
//    }
//    
//}

@end
