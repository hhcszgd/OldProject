



//
//  HomeVC.m
//  b2c
//
//  Created by wangyuanfei on 3/23/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "HomeVC.h"
#import "HBaseTableView.h"
#import "GDGDAlert.h"
#import "HBaseCell.h"
#import "HCellComposeModel.h"
#import "HCellModel.h"
#import "HFocusCell.h"
#import "CaculateManager.h"

//#import "ChatVC.h"
//#import "NewChatVC.h"
#import "b2c-Swift.h"
@interface HomeVC ()
//@property(nonatomic,assign)CGFloat  or ;
/** 存放每组数据对应的cell的名字 */
/** 初次加载返回的数据 */
@property(nonatomic,strong)NSMutableArray * homeData ;
/** 猜你喜欢接口的数据 */
@property(nonatomic,strong)NSMutableArray * guessLikeData ;
/** 上面两个数据的容器数组 , 首页数据分为两部分 */
@property(nonatomic,strong)NSMutableArray * totalData ;

@property(nonatomic,assign)NSUInteger  guessLikePageNum ;

@property(nonatomic,assign)BOOL checkVersion ;//启动一次只检查一次版本 NO 检查 , yes不检查

@property (nonatomic, strong) ResponseObject *priviousObject;

/**猜你喜欢的数据模型*/
@property (nonatomic, strong) HCellModel *guesslikeModel;
@property(nonatomic,strong)  GDStorgeManager * mgr ;

@end

@implementation HomeVC


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //重复点击tabBar按钮的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(homeTabBarReclick) name:@"GDHomeTabBarReclick" object:nil];

    self.priviousObject = [ResponseObject read];
    if (!self.priviousObject) {
        self.priviousObject = [[ResponseObject alloc] init];
    }
    //即将跳到原生的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cellComposeClick:) name:@"HCellComposeViewClick" object:nil];
    [self gotHomeDataSuccess:^{ }];
    [self changenavigationBarBackGroundAlphaWithScale:0];
}
-(void)homeTabBarReclick{

    self.tableView.mj_header.state = MJRefreshStateRefreshing ;
}

//即将跳到原生的通知的执行
-(void)cellComposeClick:(NSNotification*)notifi
{
    HCellComposeModel * model =  ( HCellComposeModel * )notifi.userInfo[@"HCellComposeViewModel"];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,model.actionKey)
    [[SkipManager shareSkipManager]skipByVC:self withActionModel:model];
//    GDBaseModel *gdModel = [[GDBaseModel alloc] initWithDict:nil];
//    gdModel.actionkey = model.actionKey;
//    gdModel.keyparamete = model.keyParamete;
//    [GDSkipManager skipWithViewController:self model:gdModel];
}


/** 初始化tableView 和 根据数据动态设置刷新控件 */
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

//返回行高的代理方法

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HCellModel * cellModel  = self.totalData[indexPath.section][indexPath.row];
    NSString * cellClassNameStr = cellModel.classKey;
    if ([cellClassNameStr isEqualToString:@"HFocusCell"]) {
        CGFloat subheight = 576.0/750.0 * screenW;
        CGFloat height =  [CaculateManager caculateRowHeightWithItemsCount:1 itemHeight:subheight itemMargin: 1 columnCount:1 topHeight:0 bottomHeight:0 topMargin:0 bottomMargin:0 ];
        return height ;
    }else if ([cellClassNameStr isEqualToString:@"HNavCell"]) {
        return [CaculateManager caculateRowHeightWithItemsCount:cellModel.items.count itemHeight:screenW /5  itemMargin: 0 columnCount:5 topHeight:0 bottomHeight:0 topMargin:0 bottomMargin:0 ];;
    } else if ([cellClassNameStr isEqualToString:@"HShopStoryCell"]){
        CGFloat width =  screenW;
        CGFloat height = 372.0/750.0 * width;
        return 33 * SCALE + height;
        
    } else if ([cellClassNameStr isEqualToString:@"HValuePurchaseCell"]){
        CGFloat otherWidth = (screenW - 4.0)/3.0;
        CGFloat otherHeight = 385.0/246.0 * otherWidth;
        CGFloat height = 33 * SCALE + 2;
        return  height + otherHeight * 2 + 2;
        
    } else if ([cellClassNameStr isEqualToString:@"HBestShopCell"]){
        CGFloat propert = 250.0/750.0;
        CGFloat firthHeith = propert * screenW;
        CGFloat otherWidth = (screenW - 2.0)/2.0;
        CGFloat otherHeight = 322.0/372.0 * otherWidth;
        CGFloat height = 33 * SCALE + firthHeith + 6;
        return  height + otherHeight * 2 + 2;
        
    } else if ([cellClassNameStr isEqualToString:@"HBestCargoCell"]){
        CGFloat perprot = 274.0/248.0;
        CGFloat width = (screenW - 4)/3.0;
        CGFloat height = width * perprot;
        
        CGFloat fourthWidth = ((375.0 - 2.0)/2.0/375.0) * screenW;
        CGFloat fourthHeight = (70.0/((375.0-2.0)/2.0)) * fourthWidth;
        return 33 * SCALE + 2.0 + height + 2 + fourthHeight;
        
    }else if ([cellClassNameStr isEqualToString:@"HPrereleaseCell"]) {
        CGFloat perprot = 274.0/186.0;
        CGFloat width = (screenW - 6)/4.0;
        CGFloat height = width * perprot;
        return height * 2.0 + 4 + 33 * SCALE;
    }else if ([cellClassNameStr isEqualToString:@"HStoryCell"]) {
        return 35 *SCALE;
    }else if ([cellClassNameStr isEqualToString:@"HLaoCell"]) {
        //        return 355 *SCALE;
        CGFloat midMargin = 1 ;
        CGFloat topBottomMargin = 1 ;
        CGFloat oneH  = 75.5*SCALE ;
        //        CGFloat oneW  = (self.bounds.size.width - midMargin)/2;
        
        CGFloat topH = 38*SCALE ;
        
        CGFloat topMargin = 10*SCALE;
        
        return [CaculateManager caculateRowHeightWithItemsCount:cellModel.items.count itemHeight:oneH itemMargin:midMargin columnCount:2 topHeight:topH bottomHeight:0 topMargin:topMargin bottomMargin:0];
        
    }else if ([cellClassNameStr isEqualToString:@"HAllbuyCell"]) {
        
        /*        CGFloat topImageViewH = 38*SCALE ;
         CGFloat totalTopMargin = 11*SCALE ;
         CGFloat collectionViewH = 155*SCALE;*/
        return  [CaculateManager caculateRowHeightWithItemsCount:1 itemHeight:155*SCALE itemMargin: 0 columnCount:1 topHeight:38*SCALE bottomHeight:0 topMargin:11*SCALE bottomMargin:0 ];
        
        //        return 205 *SCALE;
    }else if ([cellClassNameStr isEqualToString:@"HPostCell"]) {
        /**
         
         CGFloat topImageViewH = 38*SCALE ;
         CGFloat totalTopMargin = 11*SCALE ;
         CGFloat collectionViewH = 148*SCALE;
         
         
         */
        return  [CaculateManager caculateRowHeightWithItemsCount:1 itemHeight:148*SCALE itemMargin: 1 columnCount:4 topHeight:38*SCALE bottomHeight:0 topMargin:11*SCALE bottomMargin:0 ];
        //        return 198 *SCALE;
    }else if ([cellClassNameStr isEqualToString:@"HSingleadsCell"]) {
        CGFloat height = 340.0/750.0 * screenW;
        return   [CaculateManager caculateRowHeightWithItemsCount:1 itemHeight:height itemMargin: 0 columnCount:1 topHeight:0 bottomHeight:0 topMargin:6 bottomMargin:6 ];
        //        return 104 *SCALE;
    }else if ([cellClassNameStr isEqualToString:@"HGoodshopCell"]) {
        
        CGFloat itemMargin = 1 ;
        CGFloat topH = 38*SCALE ;
        CGFloat topMargin = 11*SCALE ;
        //        CGFloat collectionViewH = 146*SCALE;
        CGFloat shopNameH = [UIFont systemFontOfSize:16].lineHeight ;
        CGFloat itemH = (screenW - 2*1)/3 * 0.5  + shopNameH;
        
        return [CaculateManager caculateRowHeightWithItemsCount:1 itemHeight:itemH itemMargin:itemMargin columnCount:1 topHeight:topH bottomHeight:0 topMargin:topMargin bottomMargin:0];
        
        //        return 196 *SCALE;
    }else if ([cellClassNameStr isEqualToString:@"HHotclassifyCell"]) {
        NSInteger col = 4 ;
        CGFloat itemsMargin = 1 ;
        CGFloat itemHeight =  (screenW - itemsMargin*(col -1))/ col ;
        
        return   [CaculateManager caculateRowHeightWithItemsCount:cellModel.items.count itemHeight:itemHeight itemMargin: itemsMargin columnCount:col topHeight:38*SCALE bottomHeight:0 topMargin:11*SCALE bottomMargin:0 ];
        //        return 329 *SCALE;
    }else if ([cellClassNameStr isEqualToString:@"HGoodbrandCell"]) {
        
        CGFloat itemMargin = 1 ;
        
        CGFloat topViewH = 38*SCALE ;
        CGFloat topMargin = 11*SCALE ;
        NSInteger col = 4 ;//列数
        CGFloat itemW = (screenW - itemMargin * (col -1))/col ;
        return [CaculateManager caculateRowHeightWithItemsCount:cellModel.items.count itemHeight:itemW/2 itemMargin:itemMargin columnCount:col topHeight:topViewH bottomHeight:0 topMargin:topMargin bottomMargin:0];
        //        return 150 *SCALE;
    }else if ([cellClassNameStr isEqualToString:@"HGuesslikeCell"]) {
        return 251 *SCALE + 2;
    } if ([cellClassNameStr isEqualToString:@"HGoodsProductCell"]) {
        //地道好物的高度
        CGFloat firthWidth = 239 * SCALE * 0.5;
        CGFloat firthHeight = 472.0/239.0 * firthWidth;
        
        
        CGFloat fifthWidth = 358 * SCALE * 0.5;
        CGFloat fifthHeight = fifthWidth * 144.0/358;
        
        return firthHeight + fifthHeight + 12;
        
    } if ([cellClassNameStr isEqualToString:@"HColorfulCell"]) {
        CGFloat width = 566.0/750.0 * screenW;
        CGFloat height = 202.0/566.0 * width;
        return  33 * SCALE + height;
        
        
        
    } if ([cellClassNameStr isEqualToString:@"HCategaryCell"]) {
        CGFloat perprot = 295.0/248.0;
        CGFloat width = (screenW - 4)/3.0;
        CGFloat height = width * perprot;
        return height * 2 + 2;
    } else{
        return 0.0000001;
    }
}

//子类实现
-(void)navigationBarRightClickAction
{
    
    //    [[SkipManager shareSkipManager] skipByVC:self urlStr:nil title:nil action:@"HomeBaseVC"];
}
////////////////////////////////////////////////////////////////////////////////////////////

#pragma tableView的数据源和代理方法
/** tableView数据源方法 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //      LOG(@"_%@_%d_%ld",[self class] , __LINE__,self.totalData.count)
    return self.totalData.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    LOG(@"_%@_%d_%ld",[self class] , __LINE__,[self.totalData[section] count])
    return [self.totalData[section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.totalData.count==0)  return nil ;
    
    HCellModel * cellModel  = self.totalData[indexPath.section][indexPath.row];
    NSString * cellClassNameStr = cellModel.classKey;
    
    HBaseCell * cell = [tableView dequeueReusableCellWithIdentifier:cellClassNameStr];
    if (!cell) {
        Class  class = NSClassFromString(cellClassNameStr);
        
        cell = [[class alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellClassNameStr];
    }
    //    LOG(@"_%@_%d_%@",[self class] , __LINE__,cellModel.classKey)
    cell.cellModel = cellModel;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.0000000001;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section==0) {
        
        //        if (self.guessLikeData.count>0) {
        UIView * container = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenW, 34*SCALE)];
        
        UIImageView   * tempSectionHeader = [[UIImageView alloc]init];
//        NSURL *url;
//        if ([self.guesslikeModel.imgStr hasPrefix:@"http"]) {
//            url = [NSURL URLWithString:self.guesslikeModel.imgStr];
//        }else {
//            url = ImageUrlWithString(self.guesslikeModel.imgStr);
//        }
//        CGFloat scale = [[UIScreen mainScreen] scale];
//        UIImage *pImage = [UIImage imageNamed:@"title_08"];
//        if (self.guesslikeModel.isRefreshImageCached) {
//            [tempSectionHeader sd_setImageWithURL:url placeholderImage:pImage options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                tempSectionHeader.bounds = CGRectMake(0, 0, image.size.width/scale, image.size.height/scale);
//                self.guesslikeModel.isRefreshImageCached = NO;
//            }];
//            
//        } else {
//            [tempSectionHeader sd_setImageWithURL:url placeholderImage:pImage options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                tempSectionHeader.bounds = CGRectMake(0, 0, image.size.width/scale, image.size.height/scale);
//            }];
//        }
//        
        
        
        tempSectionHeader.image = [UIImage imageNamed:@"title_08"];
        tempSectionHeader.bounds=CGRectMake(0, 0, 184.5*SCALE, 23*SCALE);
        tempSectionHeader.backgroundColor = [UIColor whiteColor];
        tempSectionHeader.center = CGPointMake(container.bounds.size.width/2, container.bounds.size.height/2);
        [container addSubview:tempSectionHeader];
        //            tempSectionHeader.backgroundColor=[UIColor whiteColor];
        tempSectionHeader.contentMode = UIViewContentModeScaleAspectFit;
        container.backgroundColor = [UIColor whiteColor];
        return container;
        //        }
    }
    
    return nil;;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if ( section == 0)
        return 30*SCALE;
    return 0.0000000001;
}
////////////////////////////////////////////////////////////////////////////////////////////

#pragma 数据操作
-(NSMutableArray * )totalData{
    if(_totalData==nil){
        _totalData = [[NSMutableArray alloc]init];
        [_totalData addObject:self.homeData];
        [_totalData addObject:self.guessLikeData];
    }
    return _totalData;
}
-(NSMutableArray * )homeData{
    if(_homeData==nil){
        _homeData = [[NSMutableArray alloc]init];
    }
    return _homeData;
}
-(NSMutableArray * )guessLikeData{
    if(_guessLikeData==nil){
        _guessLikeData = [[NSMutableArray alloc]init];
        //        [_guessLikeData addObject:@"HAllbuyCell"];
    }
    return _guessLikeData;
}

/** 刷新回调方法 */
-(void)refreshData
{
    [super refreshData];
    //    [NSThread sleepForTimeInterval:2];
    [self gotHomeDataSuccess:^{
        self.guessLikePageNum=0;
        [self.guessLikeData removeAllObjects];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self setupTableView];
    }];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"执行刷新列表")
}

/**
 // 加载自定义名称为Resources.bundle中对应images文件夹中的图片
 // 思路:从mainbundle中获取resources.bundle
 NSString *strResourcesBundle = [[NSBundle mainBundle] pathForResource:@”Resources” ofType:@”bundle”];
 // 找到对应images夹下的图片
 NSString *strC = [[NSBundle bundleWithPath:strResourcesBundle] pathForResource:@”C” ofType:@”png” inDirectory:@”images”];
 UIImage *imgC = [UIImage imageWithContentsOfFile:strC];
 [_imageCustomBundle setImage:imgC];
 */
/** 加载更多的回调方法 */
-(void)LoadMore
{
    [super LoadMore];
    [self gotGuessLikeDataSuccess:^{
        
        
        [self.tableView reloadData];
        LOG(@"_%@_%d_\n\n\n%@\n\n\n",[self class] , __LINE__,[NSThread currentThread]);
        //        [self.tableView.mj_footer endRefreshing];
        
    }];
}

/** 网络获取首页数据(不含猜你喜欢) */
-(void)gotHomeDataSuccess:(void(^)())success
{
    [[UserInfo shareUserInfo] gotHomeDataSuccess:^(ResponseObject *responseObject) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data)
        // NSLog(@"_%d_%@",__LINE__,responseObject.data);
        [responseObject save];
        
        [self analysisDataWith:responseObject];
        success();
    } failure:^(NSError *error) {
        [self ifNetwordErrorGotDataFromDisk];
        
        if (self.homeData.count>0) {
            //             [self.tableView.mj_header endRefreshing];
        }else{
            //            self.tableView.mj_header = nil;
            //            self.tableView.mj_footer = nil;
        }
        [self.tableView.mj_header endRefreshing];
    }];
    
}


-(void)ifNetwordErrorGotDataFromDisk_
{
    /**
     - (BOOL)fileExistsAtPath:(NSString *)path;
     */
    ResponseObject * dictHome = [ResponseObject read];
    if (dictHome) {
        [self analysisDataWith:dictHome];
    }else{
        NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
        NSString *path=[docPath stringByAppendingPathComponent:@"HomeData.plist"];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"沙盒中的首页数据存在 , 从沙盒取")
            //        NSString *strResourcesBundle = [[NSBundle mainBundle] pathForResource:@"Resource" ofType:@"bundle"];
            //        NSString *path = [[NSBundle bundleWithPath:strResourcesBundle] pathForResource:@"HomeData" ofType:@"plist" inDirectory:@"Txt"];
            NSDictionary * dictHome = [[NSDictionary alloc]initWithContentsOfFile:path];
            LOG(@"_%@_%d_\n从沙河取出的数据\n%@",[self class] , __LINE__,dictHome);
            ResponseObject * getFromDisk = [[ResponseObject alloc]initWithDict:dictHome];//
            [self analysisDataWith:getFromDisk];
        }else{
            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"沙盒中的首页数据不存在 , 从bundle中取")
            NSString *strResourcesBundle = [[NSBundle mainBundle] pathForResource:@"Resource" ofType:@"bundle"];
            NSString *path = [[NSBundle bundleWithPath:strResourcesBundle] pathForResource:@"HomeData" ofType:@"plist" inDirectory:@"Txt"];
            NSDictionary * dictHome = [[NSDictionary alloc]initWithContentsOfFile:path];
            ResponseObject * getFromDisk = [[ResponseObject alloc]initWithDict:dictHome];//
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                
            });
            [self analysisDataWith:getFromDisk];
        }
        
        
    }
    
}
-(void)ifNetwordErrorGotDataFromDisk
{
    /**
     - (BOOL)fileExistsAtPath:(NSString *)path;
     */
    ResponseObject * dictHome = [ResponseObject read];
    if (dictHome) {
        [self analysisDataWith:dictHome];
    }else{
        NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
        NSString *path=[docPath stringByAppendingPathComponent:@"HomeData.plist"];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"沙盒中的首页数据存在 , 从沙盒取")
            //        NSString *strResourcesBundle = [[NSBundle mainBundle] pathForResource:@"Resource" ofType:@"bundle"];
            //        NSString *path = [[NSBundle bundleWithPath:strResourcesBundle] pathForResource:@"HomeData" ofType:@"plist" inDirectory:@"Txt"];
            NSDictionary * dictHome = [[NSDictionary alloc]initWithContentsOfFile:path];
            LOG(@"_%@_%d_\n从沙河取出的数据\n%@",[self class] , __LINE__,dictHome);
            ResponseObject * getFromDisk = [[ResponseObject alloc]initWithDict:dictHome];//
            [self analysisDataWith:getFromDisk];
        }else{
            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"沙盒中的首页数据不存在 , 从bundle中取")
            NSString *strResourcesBundle = [[NSBundle mainBundle] pathForResource:@"Resource" ofType:@"bundle"];
            NSString *path = [[NSBundle bundleWithPath:strResourcesBundle] pathForResource:@"HomeData" ofType:@"plist" inDirectory:@"Txt"];
            NSDictionary * dictHome = [[NSDictionary alloc]initWithContentsOfFile:path];
            ResponseObject * getFromDisk = [[ResponseObject alloc]initWithDict:dictHome];//
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                
            });
            [self analysisDataWith:getFromDisk];
        }

    
    }
    
    
    
    
}
/** 首页数据解析抽取 */
-(void)analysisDataWith:(ResponseObject*)response
{
    if (!response.data )  return;
    
    [self.homeData removeAllObjects];
    
    if (!([response.data isKindOfClass:[NSArray class]] ||  [response.data isKindOfClass:[NSMutableArray class]])) {
        return;
    }
    
    BOOL isRefreshImage = NO;
    if (response.modify_time > self.priviousObject.modify_time) {
        isRefreshImage = YES;
        
    }
    for (NSDictionary * sub in response.data) {
        HCellModel  * cellModel = [[HCellModel alloc]initWithDict:sub];
        if ([cellModel.classKey isEqualToString:@"HGuessCell"]) {
            self.guesslikeModel = cellModel;
        }
        cellModel.isRefreshImageCached = isRefreshImage;
        if (!NSClassFromString(cellModel.classKey)) {//对应的cell不存在就不解析,也不展示
            LOG(@"_%@_%d_\n这个classKey找不到与之对应的cell , 不解析不展示,跳出当次循环%@\n",[self class] , __LINE__,cellModel.classKey);
            continue;
        }
        NSMutableArray * tempArrM = [NSMutableArray array];
        
        if (!([cellModel.items isKindOfClass:[NSArray class]] ||  [cellModel.items isKindOfClass:[NSMutableArray class]])) {
            continue;
        }
        for (id  subsub in cellModel.items) {//subsub是数组或字典
            if ([subsub isKindOfClass:[NSArray class]]) {
                //                     LOG(@"_%@_%d_%@",[self class] , __LINE__,subsub)
                NSMutableArray * containLeftAndRightItemArrM = [NSMutableArray array];
                for (NSDictionary * subsubsub in subsub) {//约定好,到这儿一定是字典(优惠券cell的模型->itmes(元素是数组 , 数组里有两个模型))
                    HCellComposeModel * composeModel = [[HCellComposeModel alloc]initWithDict:subsubsub];
                    //是否进行更新
                    composeModel.isRefreshImageCached = isRefreshImage;
                    
                    [containLeftAndRightItemArrM addObject:composeModel];
                    //                    LOG(@"_%@_%d_%@",[self class] , __LINE__,composeModel.actionKey)
                }
                [tempArrM addObject:containLeftAndRightItemArrM];
                
            }else if ([subsub isKindOfClass:[NSDictionary class]]){//其他cell ->items属性里是直接包含模型的数组
                HCellComposeModel * composeModel = [[HCellComposeModel alloc]initWithDict:subsub];
                [tempArrM addObject:composeModel];
            }
        }
        cellModel.items = tempArrM;
        NSString * cellClassNameStr = cellModel.classKey;
        Class  class = NSClassFromString(cellClassNameStr);
        
        if (class && cellModel.items.count>0) {
            [self.homeData addObject:cellModel];
        }else{
            LOG(@"_%@_%d_服务器返回的cell数据对应的classKey 在本地找不到对应的cell类%@, 或者这的cell的子items为空",[self class] , __LINE__,cellModel.classKey)
        }
    }
        //////////////设置刷新UI/////////////////
    [self setupTableView];
    
}
/** 获取加载更多gai */
-(void)gotGuessLikeDataSuccess:(void(^)())success{
    
    
    [[UserInfo shareUserInfo] gotGuessLikeDataWithChannel_id:@"97" PageNum:++self.guessLikePageNum success:^(ResponseObject *responseObject) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data)
        NSString * classKey = responseObject.data[@"key"];
        NSString * prefixUpper = [classKey customFirstCharUpper];
        NSMutableString *mutableStr = [NSMutableString string];
        NSString * classNameStr = [mutableStr stringByAppendingFormat:@"H%@Cell",prefixUpper];//待用
        //        LOG(@"_%@_%d_%@",[self class] , __LINE__,classNameStr)
        
        NSArray * items = responseObject.data[@"items"];
        NSInteger guessLikeItemsCount = items.count;
        NSInteger tarGetCellCount = 0 ;
        if (guessLikeItemsCount%2==0) {
            tarGetCellCount = guessLikeItemsCount/2;
        }else{
            tarGetCellCount = guessLikeItemsCount/2 + 1 ;
        }
        NSMutableArray * containCellsArrM = [NSMutableArray array];
        for (int i = 0 ; i < tarGetCellCount; i++) {
            HCellModel * cellModel = [[HCellModel alloc]init];
            cellModel.classKey=classNameStr;//在这儿用
            [containCellsArrM addObject:cellModel];
        }
        for (int k=0 ;  k < guessLikeItemsCount; k++) {
            NSDictionary * dict = items[k];
            HCellComposeModel * composeModel = [[HCellComposeModel alloc]initWithDict:dict];
            HCellModel * cellModel =  containCellsArrM[k/2];
            [cellModel.items addObject:composeModel];
        }
        [self.guessLikeData addObjectsFromArray:containCellsArrM];
        /** 处理底部加载控件 */
        if (items.count >0) {
            LOG_METHOD
            [self.tableView.mj_footer endRefreshing];
        }else{
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            LOG_METHOD
        }
        /** 处理结束 */
        success();
        
    } failure:^(NSError *error) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,error)
        [self.tableView.mj_footer endRefreshing];
    }];
    
    
    
}
////////////////////////////////////////////////////////////////////////////////////////////
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if ([self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]) {
        HFocusCell * cell =  [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [cell removeTimer];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//     NSLog(@"_%d_%@",__LINE__,[GDStorgeManager share].d );
//    [GDStorgeManager share].xmppQueue
    
//    [[GDStorgeManager share] gotSortKeyValueWithMaxOrMin:@"" dbQueue:[GDStorgeManager share].xmppQueue  result:^(NSInteger? result) {
//        
//    }];
//    [[GDStorgeManager share] gotSortKeyValueWithMaxOrMin:@"max" dbQueue:[GDStorgeManager share].xmppQueue result:^(NSInteger resultValue) {
//        NSLog(@"_%d_%d",__LINE__,resultValue);
//    }];
//    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (!self.checkVersion) {
        self.checkVersion=YES;
        //        dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        
        [self checkAppVersion ];

    }
//    if (!self.mgr) {
//        
//        GDStorgeManager * mgr = [[GDStorgeManager alloc] init];
//        self.mgr = mgr;
//    }
//    NSString * insert = @"insert into message (my_account) values (\"wnagyuanfei\")";
//    [self.mgr executeQueryWithSQLStr:insert dbQueue:self.mgr.xmppQueue];
//    NSString *  select  = @"select * from  message  ";
//    [self.mgr selectQueryWithSQLStr:select dbQueue:self.mgr.xmppQueue queryResult:^int(NSDictionary *resultsDictionary) {
//        NSLog(@"_%d_%@",__LINE__,resultsDictionary);
//        return 0;
//    }];


//    NSString * userName = @"JohnLock";
//    XMPPJID * userJid = [XMPPJID jidWithUser:userName domain:@"jabber.zjlao.com" resource:@"iOS"];
//    ChatVC * chatvc = [[ChatVC alloc]init];
//    chatvc.UserJid = userJid;
//    [[GDKeyVC share ] pushViewController:chatvc animated:YES];


//    [[GDStorgeManager share] gotRecentContact];
//    [[GDStorgeManager share] deleteFormContentWithUserName:nil];
//    [[GDStorgeManager share] delete]
//    [[GDStorgeManager share] deleteUserFileWithPath:@""];
    
    /** 请求历史消息并插入数据库 */
//    [[GDStorgeManager share] insertHistoryMessageFrom:@"kefu" to:@"wangyuanfei" messageID:@"1488440402209120" callBack:^(NSInteger isSuccess,  NSString * resultStr ) {
//        
//    }];
    /*
    [[UserInfo shareUserInfo] gotHistoryMessageFrom:@"kefu" to:@"wangyuanfei" messageID:@"1488440402209120" Success:^(ResponseObject *response) {
        GDlog(@"%d",response.status)//200表示成功
        GDlog(@"%@",response.msg)
        GDlog(@"%@",response.data)
        
        if (response.status >= 0  && [response.data isKindOfClass:[NSArray class]]) {
            NSArray * msgArr = (NSArray*)response.data;
            for (int i =  0 ; i < msgArr.count; i++) {
                if ([msgArr[i] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary * msgDict = (NSDictionary *)msgArr[i];
                    NSString * from = msgDict[@"from"];
                    if (![from containsString:@"@"]) {
                        continue;
                    }
                    NSRange fromRange = [from rangeOfString:@"@"];
                    from = [from substringToIndex:fromRange.location];
                    
                    NSString * to = msgDict[@"to"];
                    if (![to containsString:@"@"]) {
                        continue;
                    }
                    NSRange toRange = [to rangeOfString:@"@"];
                    to = [to substringToIndex:toRange.location];
                    
                    
                    NSString * serverID = msgDict[@"id"];
                    NSString * body = msgDict[@"body"];
                    
                    
                    XMPPMessage * msg = [XMPPMessage messageWithType:@"char"];
//                    msg.body = msgDict[@"body"];
                    [msg addBody:body];

                    NSXMLElement *archive = [NSXMLElement elementWithName:@"archived" xmlns:@"urn:xmpp:mam:tmp"];
                    [archive addAttributeWithName:@"id" stringValue:serverID];///////////////
                    [msg addChild:archive];

                    [[GDStorgeManager share] insertMessageToDatabaseWithMessage:msg isMax:@"min" from:from to:to];
                    
                    
                }
                
                
            }
        }

    } failure:^(NSError *error) {
        GDlog(@"%@",error)
    }];
    */
    
//    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]])
//    {
//            [[UIApplication sharedApplication]
//             openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
//    }
    
    [self testGDGDAlert];
}

-(void )testGDGDAlert
{
    UIView * v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    v.backgroundColor = [UIColor redColor];
//    [[[GDGDAlert alloc] init] alertInWindowWithCustomView:v  animat:YES  dismissComplate:^(id objc) {
//        GDlog(@"%@",objc)
//        [[[GDGDAlert alloc] init] alertInWindowWithCustomView:v  animat:YES  dismissComplate:^(id objc) {
//            GDlog(@"%@",objc)
//        }];
//    }];
}
/*
-(void)testAnimate
{
    UIImageView * temp = [[UIImageView alloc]init];

    self.imageView = temp ;
    [self.view addSubview:self.imageView];
    [self.view bringSubviewToFront:self.imageView];
    self.imageView.backgroundColor = [UIColor redColor];
    //self.imageView.image = img;
    self.imageView.frame    = CGRectMake(10, 10, 55, 55);
    self.imageView.contentMode = UIViewContentModeScaleAspectFill ;
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 4 ];
    rotationAnimation.duration = 1.0;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 0;
    
    //这个是让旋转动画慢于缩放动画执行
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.imageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    });
    [UIView animateWithDuration:1.0 animations:^{
        self.imageView.frame=CGRectMake(333, 333, 55, 55);
    } completion:^(BOOL finished) {
        //动画完成后做的事
        [self.imageView removeFromSuperview];
        self.imageView = nil ;
    }];
 
}
 */
-(void)checkAppVersion
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
                //                AlertInSubview(@"已是最新版本")
            }else if (result == NSOrderedAscending){
                //                AlertInSubview(@"已是最新版本")
                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"版本降了(不可能)");
            }else if(result == NSOrderedDescending){
                [[NSUserDefaults standardUserDefaults] setValue:currentAppVersion forKey:@"appVersion"];
                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"弹框提示更新版本");
                /** 弹框提示前往qppstore更新版本 */
                [self performNotisGotoUpdateVersionWithType:type];
            }
            
            
        }else{
            //            AlertInSubview(@"操作失败,请重试")
        }
    } failure:^(NSError *error) {
        
        //        AlertInSubview(@"已是最新版本")
        LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
    }];
    
}

-(void)performNotisGotoUpdateVersionWithType:(NSString*)type
{
    
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"有新版本喽" preferredStyle:UIAlertControllerStyleAlert];
    if ([type isEqualToString:@"1"]) {//1:提示升级
        UIAlertAction * ac1 = [UIAlertAction actionWithTitle:@"残忍拒绝" style:UIAlertActionStyleDestructive  handler:^(UIAlertAction * _Nonnull action) {
            return ;
        }];
        [alertVC addAction:ac1];
        
    }else if ([type isEqualToString:@"2"]){// 2:强制升级
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

-(void)createEmojiPlist
{
    
    
    NSString * emojpath =  [[NSBundle mainBundle] pathForResource:@"map.json" ofType:nil];
    //    NSJSONSerialization;
    NSData * emojdata = [NSData dataWithContentsOfFile:emojpath];
    NSArray * emojarr = [NSJSONSerialization JSONObjectWithData:emojdata options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves |NSJSONReadingAllowFragments error:nil ];
    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *path=[docPath stringByAppendingPathComponent:@"brow.plist"];
    
    BOOL chenggong =  [emojarr writeToFile:path atomically:YES];
    if (chenggong) {
        
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"表情写入成功");
    }else{
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"表情写入失败");
    }
    
    
}
@end









































































































































































































































































////
////  HomeVC.m
////  b2c
////
////  Created by wangyuanfei on 3/23/16.
////  Copyright © 2016 www.16lao.com. All rights reserved.
////
//
//#import "HomeVC.h"
//#import "HBaseTableView.h"
//#import "HBaseCell.h"
//#import "HCellComposeModel.h"
//#import "HCellModel.h"
//#import "HFocusCell.h"
//
//
//@interface HomeVC ()
////@property(nonatomic,assign)CGFloat  or ;
///** 存放每组数据对应的cell的名字 */
///** 初次加载返回的数据 */
//@property(nonatomic,strong)NSMutableArray * homeData ;
///** 猜你喜欢接口的数据 */
//@property(nonatomic,strong)NSMutableArray * guessLikeData ;
///** 上面两个数据的容器数组 , 首页数据分为两部分 */
//@property(nonatomic,strong)NSMutableArray * totalData ;
//
//@property(nonatomic,assign)NSUInteger  guessLikePageNum ;
//
//@property(nonatomic,assign)BOOL checkVersion ;//启动一次只检查一次版本 NO 检查 , yes不检查
//@end
//
//@implementation HomeVC
//
//
//-(UIStatusBarStyle)preferredStatusBarStyle{
//    return UIStatusBarStyleLightContent;
//}
//
//- (void)viewDidLoad {
//    
//    [super viewDidLoad];
//    //即将跳到原生的通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cellComposeClick:) name:@"HCellComposeViewClick" object:nil];
//    [self gotHomeDataSuccess:^{ }];
//    [self changenavigationBarBackGroundAlphaWithScale:0];
//}
//
//
////即将跳到原生的通知的执行
//-(void)cellComposeClick:(NSNotification*)notifi
//{
//    HCellComposeModel * model =  ( HCellComposeModel * )notifi.userInfo[@"HCellComposeViewModel"];
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,model.actionKey)
//       [ [SkipManager shareSkipManager]skipByVC:self withActionModel:model];
//}
//
//
///** 初始化tableView 和 根据数据动态设置刷新控件 */
//-(void)setupTableView
//{
//
//    if (!self.tableView) {
//        CGRect frame  = CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height - self.tabBarController.tabBar.bounds.size.height);
//        HBaseTableView * tableView =[[HBaseTableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
//        self.tableView =tableView;
//        tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
//        tableView.showsVerticalScrollIndicator = NO;
//        tableView.rowHeight = UITableViewAutomaticDimension;
////        tableView.estimatedRowHeight=200;
//
////        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
////
////            dispatch_async(dispatch_get_main_queue(), ^{
//                HomeRefreshHeader * refreshHeader = [HomeRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
//                self.tableView.mj_header=refreshHeader;
//                
//                HomeRefreshFooter* refreshFooter = [HomeRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(LoadMore)];
//                self.tableView.mj_footer = refreshFooter;
//                
//                
//                
////            });
////            
////        });
//        
////        HomeRefreshHeader * refreshHeader = [HomeRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
////        self.tableView.mj_header=refreshHeader;
////        
////        HomeRefreshFooter* refreshFooter = [HomeRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(LoadMore)];
////        self.tableView.mj_footer = refreshFooter;
//    }
//        [self.tableView reloadData];
//    
//}
////为了在 ios8上 不卡 ,豁出去了
//-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    HCellModel * cellModel  = self.totalData[indexPath.section][indexPath.row];
//    NSString * cellClassNameStr = cellModel.classKey;
//    if ([cellClassNameStr isEqualToString:@"HFocusCell"]) {
//        return 187.5 *SCALE;
//    }else if ([cellClassNameStr isEqualToString:@"HNavCell"]) {
//        return 150 *SCALE;
//    }else if ([cellClassNameStr isEqualToString:@"HStoryCell"]) {
//        return 35 *SCALE;
//    }else if ([cellClassNameStr isEqualToString:@"HLaoCell"]) {
//        return 355 *SCALE;
//    }else if ([cellClassNameStr isEqualToString:@"HAllbuyCell"]) {
//        return 205 *SCALE;
//    }else if ([cellClassNameStr isEqualToString:@"HPostCell"]) {
//        return 198 *SCALE;
//    }else if ([cellClassNameStr isEqualToString:@"HSingleadsCell"]) {
//        return 104 *SCALE;
//    }else if ([cellClassNameStr isEqualToString:@"HGoodshopCell"]) {
//        return 196 *SCALE;
//    }else if ([cellClassNameStr isEqualToString:@"HHotclassifyCell"]) {
//        return 329 *SCALE;
//    }else if ([cellClassNameStr isEqualToString:@"HGoodbrandCell"]) {
//        return 150 *SCALE;
//    }else if ([cellClassNameStr isEqualToString:@"HGuesslikeCell"]) {
//        return 253 *SCALE;
//    }else{
//        return 0.0000001;
//    }
// 
//}
//
////子类实现
//-(void)navigationBarRightClickAction
//{
//    
////    [[SkipManager shareSkipManager] skipByVC:self urlStr:nil title:nil action:@"HomeBaseVC"];
//}
//////////////////////////////////////////////////////////////////////////////////////////////
//
//#pragma tableView的数据源和代理方法
///** tableView数据源方法 */
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
////      LOG(@"_%@_%d_%ld",[self class] , __LINE__,self.totalData.count)
//    return self.totalData.count;
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
////    LOG(@"_%@_%d_%ld",[self class] , __LINE__,[self.totalData[section] count])
//    return [self.totalData[section] count];
//}
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (self.totalData.count==0)  return nil ;
//
//    HCellModel * cellModel  = self.totalData[indexPath.section][indexPath.row];
//    NSString * cellClassNameStr = cellModel.classKey;
//    
//    HBaseCell * cell = [tableView dequeueReusableCellWithIdentifier:cellClassNameStr];
//    if (!cell) {
//        Class  class = NSClassFromString(cellClassNameStr);
//        
//        cell = [[class alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellClassNameStr];
//    }
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,cellModel.classKey)
//    cell.cellModel = cellModel;
//    return cell;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//
//    return 0.0000000001;
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    if (section==0) {
//        
////        if (self.guessLikeData.count>0) {
//            UIView * container = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenW, 34*SCALE)];
//            UIImageView   * tempSectionHeader = [[UIImageView alloc]init];
//            tempSectionHeader.bounds=CGRectMake(0, 0, 166*SCALE, 14*SCALE);
//            tempSectionHeader.center = CGPointMake(container.bounds.size.width/2, container.bounds.size.height/2);
//            [container addSubview:tempSectionHeader];
//            //            tempSectionHeader.backgroundColor=[UIColor whiteColor];
//            tempSectionHeader.contentMode = UIViewContentModeScaleAspectFit;
//            tempSectionHeader.image = [UIImage imageNamed:@"title_Guess you like"];
//            return container;
////        }
//    }
//    
//    return nil;;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    if ( section == 0)
//        return 30*SCALE;
//    return 0.0000000001;
//}
//////////////////////////////////////////////////////////////////////////////////////////////
//
//#pragma 数据操作
//-(NSMutableArray * )totalData{
//    if(_totalData==nil){
//        _totalData = [[NSMutableArray alloc]init];
//        [_totalData addObject:self.homeData];
//        [_totalData addObject:self.guessLikeData];
//    }
//    return _totalData;
//}
//-(NSMutableArray * )homeData{
//    if(_homeData==nil){
//        _homeData = [[NSMutableArray alloc]init];
//    }
//    return _homeData;
//}
//-(NSMutableArray * )guessLikeData{
//    if(_guessLikeData==nil){
//        _guessLikeData = [[NSMutableArray alloc]init];
//        //        [_guessLikeData addObject:@"HAllbuyCell"];
//    }
//    return _guessLikeData;
//}
//
///** 刷新回调方法 */
//-(void)refreshData
//{
//    [super refreshData];
//    //    [NSThread sleepForTimeInterval:2];
//    [self gotHomeDataSuccess:^{
//        self.guessLikePageNum=0;
//        [self.guessLikeData removeAllObjects];
//        [self.tableView.mj_header endRefreshing];
//        [self.tableView.mj_footer endRefreshing];
//        [self setupTableView];
//    }];
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"执行刷新列表")
//}
//
///**
// // 加载自定义名称为Resources.bundle中对应images文件夹中的图片
// // 思路:从mainbundle中获取resources.bundle
// NSString *strResourcesBundle = [[NSBundle mainBundle] pathForResource:@”Resources” ofType:@”bundle”];
// // 找到对应images夹下的图片
// NSString *strC = [[NSBundle bundleWithPath:strResourcesBundle] pathForResource:@”C” ofType:@”png” inDirectory:@”images”];
// UIImage *imgC = [UIImage imageWithContentsOfFile:strC];
// [_imageCustomBundle setImage:imgC];
// */
///** 加载更多的回调方法 */
//-(void)LoadMore
//{
//    [super LoadMore];
//    [self gotGuessLikeDataSuccess:^{
//
//        
//        [self.tableView reloadData];
//        LOG(@"_%@_%d_\n\n\n%@\n\n\n",[self class] , __LINE__,[NSThread currentThread]);
////        [self.tableView.mj_footer endRefreshing];
//
//    }];
//}
//
///** 网络获取首页数据(不含猜你喜欢) */
//-(void)gotHomeDataSuccess:(void(^)())success
//{
//    
//    
//    
//
//    
//    [[UserInfo shareUserInfo] gotHomeDataSuccess:^(ResponseObject *responseObject) {
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data)
////        [responseObject save];
//        
//        [self analysisDataWith:responseObject];
//        success();
//    } failure:^(NSError *error) {
//        [self ifNetwordErrorGotDataFromDisk];
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,error)
//        if (self.homeData.count>0) {
////             [self.tableView.mj_header endRefreshing];
//        }else{
////            self.tableView.mj_header = nil;
////            self.tableView.mj_footer = nil;
//        }
//        [self.tableView.mj_header endRefreshing];
//    }];
//    
//}
//
//
//-(void)ifNetwordErrorGotDataFromDisk
//{
//    /**
//     - (BOOL)fileExistsAtPath:(NSString *)path;
//     */
//    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
//    NSString *path=[docPath stringByAppendingPathComponent:@"HomeData.plist"];
//    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"沙盒中的首页数据存在 , 从沙盒取")
//        //        NSString *strResourcesBundle = [[NSBundle mainBundle] pathForResource:@"Resource" ofType:@"bundle"];
//        //        NSString *path = [[NSBundle bundleWithPath:strResourcesBundle] pathForResource:@"HomeData" ofType:@"plist" inDirectory:@"Txt"];
//        NSDictionary * dictHome = [[NSDictionary alloc]initWithContentsOfFile:path];
//        LOG(@"_%@_%d_\n从沙河取出的数据\n%@",[self class] , __LINE__,dictHome);
//        ResponseObject * getFromDisk = [[ResponseObject alloc]initWithDict:dictHome];//
//                [self analysisDataWith:getFromDisk];
//    }else{
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"沙盒中的首页数据不存在 , 从bundle中取")
//        NSString *strResourcesBundle = [[NSBundle mainBundle] pathForResource:@"Resource" ofType:@"bundle"];
//        NSString *path = [[NSBundle bundleWithPath:strResourcesBundle] pathForResource:@"HomeData" ofType:@"plist" inDirectory:@"Txt"];
//        NSDictionary * dictHome = [[NSDictionary alloc]initWithContentsOfFile:path];
//        ResponseObject * getFromDisk = [[ResponseObject alloc]initWithDict:dictHome];//
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            
//            
//        });
//        [self analysisDataWith:getFromDisk];
//    }
//    
//
//}
///** 首页数据解析抽取 */
//-(void)analysisDataWith:(ResponseObject*)response
//{
//    if (!response.data )  return;
//    
//    [self.homeData removeAllObjects];
//
//    if (!([response.data isKindOfClass:[NSArray class]] ||  [response.data isKindOfClass:[NSMutableArray class]])) {
//        return;
//    }
//    for (NSDictionary * sub in response.data) {
//        HCellModel  * cellModel = [[HCellModel alloc]initWithDict:sub];
//        if (!NSClassFromString(cellModel.classKey)) {//对应的cell不存在就不解析,也不展示
//            LOG(@"_%@_%d_\n这个classKey找不到与之对应的cell , 不解析不展示,跳出当次循环%@\n",[self class] , __LINE__,cellModel.classKey);
//            continue;
//        }
//        NSMutableArray * tempArrM = [NSMutableArray array];
//        
//        if (!([cellModel.items isKindOfClass:[NSArray class]] ||  [cellModel.items isKindOfClass:[NSMutableArray class]])) {
//            continue;
//        }
//        for (id  subsub in cellModel.items) {//subsub是数组或字典
//            if ([subsub isKindOfClass:[NSArray class]]) {
//                //                     LOG(@"_%@_%d_%@",[self class] , __LINE__,subsub)
//                NSMutableArray * containLeftAndRightItemArrM = [NSMutableArray array];
//                for (NSDictionary * subsubsub in subsub) {//约定好,到这儿一定是字典(优惠券cell的模型->itmes(元素是数组 , 数组里有两个模型))
//                    HCellComposeModel * composeModel = [[HCellComposeModel alloc]initWithDict:subsubsub];
//                    [containLeftAndRightItemArrM addObject:composeModel];
////                    LOG(@"_%@_%d_%@",[self class] , __LINE__,composeModel.actionKey)
//                }
//                [tempArrM addObject:containLeftAndRightItemArrM];
//                
//            }else if ([subsub isKindOfClass:[NSDictionary class]]){//其他cell ->items属性里是直接包含模型的数组
//                HCellComposeModel * composeModel = [[HCellComposeModel alloc]initWithDict:subsub];
//                [tempArrM addObject:composeModel];
//            }
//        }
//        cellModel.items = tempArrM;
//        NSString * cellClassNameStr = cellModel.classKey;
//        Class  class = NSClassFromString(cellClassNameStr);
//
//        if (class && cellModel.items.count>0) {
////            if (![cellModel.classKey isEqualToString:@"HAllbuyCell"]) {
////                continue ;
////            }
//            
//            [self.homeData addObject:cellModel];
//        }else{
//            LOG(@"_%@_%d_服务器返回的cell数据对应的classKey 在本地找不到对应的cell类%@, 或者这的cell的子items为空",[self class] , __LINE__,cellModel.classKey)
//        }
//    }
//    //////////////设置刷新UI/////////////////
//    [self setupTableView];
//
//}
///** 获取加载更多gai */
//-(void)gotGuessLikeDataSuccess:(void(^)())success{
//    
//    
//    [[UserInfo shareUserInfo] gotGuessLikeDataWithChannel_id:@"97" PageNum:++self.guessLikePageNum success:^(ResponseObject *responseObject) {
//                LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data)
//        NSString * classKey = responseObject.data[@"key"];
//        NSString * prefixUpper = [classKey customFirstCharUpper];
//        NSMutableString *mutableStr = [NSMutableString string];
//        NSString * classNameStr = [mutableStr stringByAppendingFormat:@"H%@Cell",prefixUpper];//待用
//        //        LOG(@"_%@_%d_%@",[self class] , __LINE__,classNameStr)
//        
//        NSArray * items = responseObject.data[@"items"];
//        NSInteger guessLikeItemsCount = items.count;
//        NSInteger tarGetCellCount = 0 ;
//        if (guessLikeItemsCount%2==0) {
//            tarGetCellCount = guessLikeItemsCount/2;
//        }else{
//            tarGetCellCount = guessLikeItemsCount/2 + 1 ;
//        }
//        NSMutableArray * containCellsArrM = [NSMutableArray array];
//        for (int i = 0 ; i < tarGetCellCount; i++) {
//            HCellModel * cellModel = [[HCellModel alloc]init];
//            cellModel.classKey=classNameStr;//在这儿用
//            [containCellsArrM addObject:cellModel];
//        }
//        for (int k=0 ;  k < guessLikeItemsCount; k++) {
//            NSDictionary * dict = items[k];
//            HCellComposeModel * composeModel = [[HCellComposeModel alloc]initWithDict:dict];
//            HCellModel * cellModel =  containCellsArrM[k/2];
//            [cellModel.items addObject:composeModel];
//        }
//        [self.guessLikeData addObjectsFromArray:containCellsArrM];
//        /** 处理底部加载控件 */
//        if (items.count >0) {
//            LOG_METHOD
//            [self.tableView.mj_footer endRefreshing];
//        }else{
//            [self.tableView.mj_footer endRefreshingWithNoMoreData];
//            LOG_METHOD
//        }
//        /** 处理结束 */
//        success();
//
//    } failure:^(NSError *error) {
//                LOG(@"_%@_%d_%@",[self class] , __LINE__,error)
//        [self.tableView.mj_footer endRefreshing];
//    }];
//    
//    
//
//}
//////////////////////////////////////////////////////////////////////////////////////////////
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
//    // Dispose of any resources that can be recreated.
//}
//
//-(void)dealloc{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    if ([self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]) {
//        HFocusCell * cell =  [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//        [cell removeTimer];
//    }
//}
//
//
//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    if (!self.checkVersion) {
//        self.checkVersion=YES;
////        dispatch_sync(dispatch_get_global_queue(0, 0), ^{
//        
//            [self checkAppVersion ];
//        
////        });
//    }
//   
//
//}
//
//-(void)checkAppVersion
//{
//    [[UserInfo shareUserInfo] checkVersionInfoSuccess:^(ResponseObject *responseObject) {
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
//        if ([responseObject.data isKindOfClass:[NSDictionary class]]) {
//            
//            NSString * type = responseObject.data[@"type"];
//            
//            NSString * versionStrByInternet = responseObject.data[@"version_code"];
//            // 实时获取App的版本号
//            NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
//            NSString *currentAppVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
//            
//            NSComparisonResult result = [versionStrByInternet compare:currentAppVersion];
//            LOG(@"_%@_%d_%lu",[self class] , __LINE__,result);
//            if (result == NSOrderedSame) {
//                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"版本没变");
////                AlertInSubview(@"已是最新版本")
//            }else if (result == NSOrderedAscending){
////                AlertInSubview(@"已是最新版本")
//                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"版本降了(不可能)");
//            }else if(result == NSOrderedDescending){
//                [[NSUserDefaults standardUserDefaults] setValue:currentAppVersion forKey:@"appVersion"];
//                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"弹框提示更新版本");
//                /** 弹框提示前往qppstore更新版本 */
//                [self performNotisGotoUpdateVersionWithType:type];
//            }
//            
//            
//        }else{
////            AlertInSubview(@"操作失败,请重试")
//        }
//    } failure:^(NSError *error) {
//        
////        AlertInSubview(@"已是最新版本")
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
//    }];
//    
//}
//
//-(void)performNotisGotoUpdateVersionWithType:(NSString*)type
//{
//    
//    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"有新版本喽" preferredStyle:UIAlertControllerStyleAlert];
//    if ([type isEqualToString:@"1"]) {//1:提示升级
//        UIAlertAction * ac1 = [UIAlertAction actionWithTitle:@"残忍拒绝" style:UIAlertActionStyleDestructive  handler:^(UIAlertAction * _Nonnull action) {
//            return ;
//        }];
//        [alertVC addAction:ac1];
//        
//    }else if ([type isEqualToString:@"2"]){// 2:强制升级
//    }
//    
//    UIAlertAction * ac2 = [UIAlertAction actionWithTitle:@"更新去喽" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",@"1133780608"];
//        NSURL * url = [NSURL URLWithString:str];
//        
//        if ([[UIApplication sharedApplication] canOpenURL:url])
//        {
//            [[UIApplication sharedApplication] openURL:url];
//        }
//        else
//        {
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"can not open");
//        }
//        
//        
//    }];
//    [alertVC addAction:ac2];
//    
//    [self presentViewController:alertVC animated:YES completion:^{
//        
//    }];
//}
//
//-(void)createEmojiPlist
//{
//    
//  
//    NSString * emojpath =  [[NSBundle mainBundle] pathForResource:@"map.json" ofType:nil];
//    //    NSJSONSerialization;
//    NSData * emojdata = [NSData dataWithContentsOfFile:emojpath];
//   NSArray * emojarr = [NSJSONSerialization JSONObjectWithData:emojdata options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves |NSJSONReadingAllowFragments error:nil ];
//    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
//    NSString *path=[docPath stringByAppendingPathComponent:@"brow.plist"];
//    
//    BOOL chenggong =  [emojarr writeToFile:path atomically:YES];
//    if (chenggong) {
//        
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"表情写入成功");
//    }else{
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"表情写入失败");
//    }
//    
//    
//}
//@end
