//
//  IndividualVC.m
//  b2c
//
//  Created by wangyuanfei on 16/4/18.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HIndividualVC.h"
//#import "HCellModel.h"
//#import "HCellComposeModel.h"
//#import "HIFocusCell.h"
//#import "HBaseTableView.h"
//#import "BaseWebVC.h"
@interface HIndividualVC ()
/** 初次加载返回的数据 */
//@property(nonatomic,strong)NSMutableArray * homeData ;
///** 猜你喜欢接口的数据 */
//@property(nonatomic,strong)NSMutableArray * guessLikeData ;
///** 上面两个数据的容器数组 , 首页数据分为两部分 */
//@property(nonatomic,strong)NSMutableArray * totalData ;
//
//@property(nonatomic,assign)NSUInteger  guessLikePageNum ;
//
//@property(nonatomic,weak)HIFocusCell * timeCell ;
@end

@implementation HIndividualVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBarRightActionViews = @[self.shopCarBtn];
//    [self configmentNavigation];
//    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(messageCountChanged) name:MESSAGECOUNTCHANGED object:nil];

//    self.view.backgroundColor = [UIColor whiteColor];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cellComposeClick:) name:@"IndividualCellComposeViewClick" object:nil];
//    // Do any additional setup after loading the view.
//    [self gotIndividualDataWithActionType:Init Success:^(ResponseObject *responseObject) {
//        [self setupTableView];
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,self.homeData);
//    } failure:^(NSError *error) {
//       LOG(@"_%@_%d_%@",[self class] , __LINE__,error)
//        [self showTheViewWhenDisconnectWithFrame: CGRectMake(0, self.startY, self.view.bounds.size.width,self.view.bounds.size.height - self.startY)];
//    }];
    
}
//即将跳到cell的通知的执行
//-(void)cellComposeClick:(NSNotification*)notifi
//{
//    HCellComposeModel * model =  ( HCellComposeModel * )notifi.userInfo[@"IndividualCellComposeViewModel"];
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,model.actionKey)
//    [ [SkipManager shareSkipManager]skipByVC:self withActionModel:model];
//    //    [[SkipManager shareSkipManager] skipForHomeByVC:self withActionModel:model];
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
//    // Dispose of any resources that can be recreated.
//}
//
//
//-(void)setupTableView
//{
//    
//    if (!self.tableView) {
//        CGRect frame  = CGRectMake(0, self.startY, self.view.bounds.size.width,self.view.bounds.size.height - self.startY);
//        HBaseTableView * tableView =[[HBaseTableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
//        self.tableView =tableView;
//        tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
//        tableView.showsVerticalScrollIndicator = NO;
//        tableView.rowHeight = UITableViewAutomaticDimension;
//        tableView.estimatedRowHeight=200;
//        
//        HomeRefreshHeader * refreshHeader = [HomeRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
//        self.tableView.mj_header=refreshHeader;
//        
//        HomeRefreshFooter* refreshFooter = [HomeRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(LoadMore)];
//        self.tableView.mj_footer = refreshFooter;
//    }else{
//        if (!self.homeData) {
//            self.tableView.mj_header = nil;
//            self.tableView.mj_footer = nil;
//        }else{
//            if (!self.tableView.mj_footer) {
//                HomeRefreshFooter* refreshFooter = [HomeRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(LoadMore)];
//                self.tableView.mj_footer = refreshFooter;
//            }
//            if (!self.tableView.mj_header) {
//                HomeRefreshHeader * refreshHeader = [HomeRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
//                self.tableView.mj_header=refreshHeader;
//            }
//        }
//    }
//    [self.tableView reloadData];
//}
//
//
//
//#pragma tableView的数据源和代理方法
///** tableView数据源方法 */
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    //      LOG(@"_%@_%d_%ld",[self class] , __LINE__,self.totalData.count)
//    return self.totalData.count;
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    //    LOG(@"_%@_%d_%ld",[self class] , __LINE__,[self.totalData[section] count])
//    return [self.totalData[section] count];
//}
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    HCellModel * cellModel  = self.totalData[indexPath.section][indexPath.row];
//    NSString * cellClassNameStr = cellModel.classKey;
//    
//    HBaseCell * cell = [tableView dequeueReusableCellWithIdentifier:cellClassNameStr];
//    if (!cell) {
//        Class  class = NSClassFromString(cellClassNameStr);
//        cell = [[class alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellClassNameStr];
//    }
//    if (indexPath.section==0 && indexPath.row==0 && [cell isKindOfClass:[HIFocusCell class]]) {
//        if (self.timeCell!=cell) {//
//            [self.timeCell removeTimer];
//            self.timeCell =nil;
//            LOG(@"_%@_%d_打印轮播cell到底会产生几个 ------------------\n\n%@\n\n\n",[self class] , __LINE__,cell);
//            self.timeCell = (HIFocusCell *)cell;//记录轮播图, 好移除定时器
//        }
//    }
//    //    LOG(@"_%@_%d_%@",[self class] , __LINE__,cellModel.classKey)
//    cell.cellModel = cellModel;
//    return cell;
//}
//-(UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    if (section==1) {
//        
//        if (self.guessLikeData.count>0) {
//            UIView * container = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenW, 34*SCALE)];
//            UIImageView   * tempSectionHeader = [[UIImageView alloc]init];
//            tempSectionHeader.bounds=CGRectMake(0, 0, 166*SCALE, 14*SCALE);
//            tempSectionHeader.center = CGPointMake(container.bounds.size.width/2, container.bounds.size.height/2);
//            [container addSubview:tempSectionHeader];
//            //            tempSectionHeader.backgroundColor=[UIColor whiteColor];
//            tempSectionHeader.contentMode = UIViewContentModeScaleAspectFit;
//            tempSectionHeader.image = [UIImage imageNamed:@"title_Guess you like"];
//            return container;
//        }
//    }
//    
//    return nil;;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 0.0000000001;
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    
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
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    if (section == 0)
//        return 30*SCALE;
//    return 0.0000000001;
//}
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
///** 首页数据获取 \ 包含刷新 */
//-(void)gotIndividualDataWithActionType:(LoadDataActionType)actionType Success:(void(^)(ResponseObject *responseObject))success failure:(void(^)(NSError *error))failure
//{
//
//    
//    [[UserInfo shareUserInfo] gotIndividualDataSuccess:^(ResponseObject *responseObject) {
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
//        [self analysisDataWith:responseObject];
//        success(responseObject);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//    
//}
///** 首页数据解析抽取 \ 包含刷新 */
//-(void)analysisDataWith:(ResponseObject*)response
//{
//    
//    [self.homeData removeAllObjects];
//    [self.guessLikeData removeAllObjects];
//    if (!([response.data isKindOfClass:[NSArray class]] ||  [response.data isKindOfClass:[NSMutableArray class]])) {
//        return;
//    }
//    for (NSDictionary * sub in response.data) {
//        HCellModel  * cellModel = [[HCellModel alloc]initWithDict:sub];
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
//                    composeModel.actionKey = cellModel.actionKey;
//                                        LOG(@"_%@_%d_%@",[self class] , __LINE__,composeModel.actionKey)
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
//        if ([cellClassNameStr isEqualToString:@"HBannerCell"]) {
//            cellModel.classKey = @"HIFocusCell";//复制首页的顶部轮播
//            
//            
//        }else if ([cellClassNameStr isEqualToString:@"HHighGradeCell"]){
////            cellModel.classKey = @"HGoodshopCell";
//            cellModel.classKey = @"IHHighGradeCell";
//            
//        }else if ([cellClassNameStr isEqualToString:@"HCouponsCell"]){
//            cellModel.classKey = @"IHCouponsCell";
//        }else if ([cellClassNameStr isEqualToString:@"HHotMarketCell"]){
//            cellModel.classKey = @"IHHotMarketCell";
//        }
//        
//        Class  class = NSClassFromString(cellModel.classKey);
//        
//        if (class && cellModel.items.count>0) {
//            [self.homeData addObject:cellModel];
//        }else{
//            LOG(@"_%@_%d_服务器返回的cell数据对应的classKey 在本地找不到对应的cell类%@",[self class] , __LINE__,cellModel.classKey)
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,cellModel)
//        }
//    }
//    
//    //////////////设置刷新UI/////////////////
//    
//    
//    [[NSOperationQueue mainQueue]addOperationWithBlock:^{
//        
//        [self setupTableView];
//    }];
//}
//
///** 获取加载更多 */
//-(void)gotGuessLikeDataSuccess:(void(^)(ResponseObject *responseObject))success failure:(void(^)(NSError *error))failure{
//    
//    
//    [[UserInfo shareUserInfo] gotGuessLikeDataWithChannel_id:@"99" PageNum:++self.guessLikePageNum success:^(ResponseObject *responseObject) {
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
//        success(responseObject);
//        
//    } failure:^(NSError *error) {
//        failure(error);
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,error)
//        [self.tableView.mj_footer endRefreshing];
//    }];
//    
//    
//    
//}
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
///** 加载更多的回调方法 */
//-(void)LoadMore
//{
//    [super LoadMore];
//    
//    [self gotGuessLikeDataSuccess:^(ResponseObject *responseObject) {
//        [self.tableView reloadData];
//        if (responseObject.data && [responseObject.data[@"items"] isKindOfClass:[NSArray class ]] && [responseObject.data[@"items"] count]>0 ) {
//            
//            [self.tableView.mj_footer endRefreshing];
//        }else{
//            [self.tableView.mj_footer endRefreshingWithNoMoreData];
//        }
//        
//    } failure:^(NSError *error) {
//        
//    }];
//
//}
///** 刷新回调方法 */
//-(void)refreshData
//{
//    [super refreshData];
//    //    [NSThread sleepForTimeInterval:2];
//    [self gotIndividualDataWithActionType:Init Success:^(ResponseObject *responseObject) {
//        self.guessLikePageNum=0;
//        [self.guessLikeData removeAllObjects];
//        [self.tableView.mj_header endRefreshing];
//        [self.tableView.mj_footer endRefreshing];
//        [self setupTableView];
//        
//    } failure:^(NSError *error) {
//        
//    }];
//
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"执行刷新列表")
//}
//-(void)viewDidLayoutSubviews{
//    [super viewDidLayoutSubviews];;
//    [self.tableView reloadData];
//}

-(void)dealloc{
//    if ([self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]) {
//        HFocusCell * cell =  [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//        [cell removeTimer];
//    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
//    [self.timeCell removeTimer]; 
}
@end
