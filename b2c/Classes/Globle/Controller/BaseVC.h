//
//  BaseVC.h
//  b2c
//
//  Created by wangyuanfei on 3/23/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
/**
 工程里所用viewcontroller的父控制器
 */

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    NETDISCONNECT=-1,
    NETERROR=0,
    NETMOBILE=1,
    NETWIFI=2
} NetworkingStatus;
typedef enum : NSUInteger {
    Init=0,
    Refresh=1,
    LoadMore=2
} LoadDataActionType;

/**
 AFNetworkReachabilityStatusUnknown          = -1,
 AFNetworkReachabilityStatusNotReachable     = 0,
 AFNetworkReachabilityStatusReachableViaWWAN = 1,
 AFNetworkReachabilityStatusReachableViaWiFi = 2,
 */
@interface BaseVC : UIViewController <UITableViewDelegate,UITableViewDataSource>

/** 控制器初始化时 所需要的 字典类型 的参数 , 字典里就一个键值对 其中键是paramete 与模型相对应*/
@property(nonatomic,strong)NSDictionary * keyParamete ;

@property(nonatomic,weak)UITableView * tableView ;
/** 当前网络状态 */
@property(nonatomic,assign)NetworkingStatus  netStatus ;
@property(nonatomic,assign)BOOL  networkChanged ;
/** 当没有网络的时候掉一下这个方法 */
-(void)showTheViewWhenDisconnectWithFrame:(CGRect)frame;

/** 当恢复网络的时候调一下这个方法 */
-(void)removeTheViewWhenConnect;

/** 点击重连的回调方法 */
-(void)reconnectClick:(UIButton*)sender;
//-(void)clickTry:(UIButton*)sender;
/** 刷新的方法 */
-(void)refreshData;
-(void)LoadMore;
-(void)showLoadingView;
-(void)hiddenLoadingView;
@end
