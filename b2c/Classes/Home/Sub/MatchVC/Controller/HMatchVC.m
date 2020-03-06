//
//  MatchVC.m
//  b2c
//
//  Created by wangyuanfei on 16/4/18.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HMatchVC.h"
//#import "LaoStoryTabCell.h"
//#import "LaoStoryCellModel.h"

@interface HMatchVC ()
//<LaoStoryTabCellDelegate>
//@property(nonatomic,strong)NSMutableArray * stories ;
//
//@property(nonatomic,assign)NSUInteger  pageNum ;


@end

@implementation HMatchVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarRightActionViews:@[self.shopCarBtn]];
//    [self setupTableView];
//    self.pageNum = 1 ;
//    [self gotStoryDataWithPageNum:self.pageNum actionType:Init Success:^{
//        [self setupRefreshUI];
//        [self.tableView reloadData];
//    } failure:^{
//        [self setupRefreshUI];
//        [self showTheViewWhenDisconnectWithFrame:self.view.bounds];
//    }];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}
- (void)dealloc{
    NSLog(@"%@, %d ,%@",[self class],__LINE__,@"销毁");

}
//-(void)setupRefreshUI
//{
//    
//    if (self.stories.count>0) {
//        if (!self.tableView.mj_header) {
//            HomeRefreshHeader * refreshHeader = [HomeRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
//            self.tableView.mj_header=refreshHeader;
//        }
//        if (!self.tableView.mj_footer) {
//            HomeRefreshFooter* refreshFooter = [HomeRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(LoadMore)];
//            self.tableView.mj_footer = refreshFooter;
//        }
//        
//    }else{
//        self.tableView.mj_header=nil;
//        self.tableView.mj_footer = nil;
//    }
//    
//    
//    
//    //    [self.tableView reloadData];
//    
//}
//
//-(void)reconnectClick:(UIButton *)sender{
//    [self gotStoryDataWithPageNum:1 actionType:Init Success:^{
//        if (self.stories.count>0) {
//            [self removeTheViewWhenConnect];
//            [self setupRefreshUI];
//        }
//    } failure:^{
//        
//    }];
//}
//
//
//-(void)gotStoryDataWithPageNum:(NSInteger)pageNum actionType:(LoadDataActionType)actionType Success:(void(^)())success failure:(void(^)())failure
//{
//    
//    [[UserInfo shareUserInfo] gotLaoStoryDataWithPageNum:pageNum success:^(ResponseObject *responseObject) {
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data)
//        
//        if (actionType==0 || actionType==1) {
//            [self.stories removeAllObjects];
//        }
//        
//        
//        if (![responseObject.data isKindOfClass:[NSDictionary class]]) {
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"获取捞便宜数据格式有误")
//            [self.tableView.mj_footer endRefreshingWithNoMoreData];
//            return ;
//        }
//        NSArray * items = responseObject.data[@"items"];
//        if (![items isKindOfClass:[NSArray class]]){
//            [self.tableView.mj_footer endRefreshingWithNoMoreData];
//
//                return;
//        }
////        for (int k=0 ;  k < items.count; k++) {
//            //数据结构变奇葩了,不能用kvc了
//            
//            //            NSDictionary * dict = items[k];
//            //            LaoStoryCellModel * composeModel = [[LaoStoryCellModel alloc]initWithDict:dict];
//            //            [self.stories addObject:composeModel];
//            /** {
//             story = {
//             img = http://s0.zjlao.com/app_img/1.jpg;
//             summary = æ¯ä¸ªè®¾è®¡åé¢é½æä¸ä¸ªæ
//             äºï¼ããæ¯ä¸ªåçèåé½æå
//             ¶ç¬æçç§å¯â¦â¦ããä»ä»¬çlogoæ å¿å°±æ¯æµç¼©äºç¾å¤å¹´çåå²è±¡å¾ããè´å«çåå§äººä¸å¶è¡¨å¸çå¿è;
//             id = 13;
//             }
//             ;
//             shop = {
//             img = <null>;
//             title = 零经验卖家筹备店铺的一点点感受;
//             }
//             ;
//             link = {
//             name = 查看原文;
//             url = http://m.zjlao.com/Shop/storyDetail/id/13.html;
//             actionkey = story;
//             }
//             ;
//             }
//             
//             */
//        if (items.count>0) {
//            for (int i = 0 ; i<items.count; i++) {
//                id sub = items[i];
//                if ([sub isKindOfClass:[NSDictionary class]]) {
//                    LaoStoryCellModel * composeModel = [[LaoStoryCellModel alloc]init];
//                    /** @property(nonatomic,copy)NSString * shopLogo ;
//                     @property(nonatomic,copy)NSString * shopName ;
//                     @property(nonatomic,copy)NSString * bigIcon ;
//                     @property(nonatomic,copy)NSString * longTitle ;
//                     */
//                    if ([sub[@"story"] isKindOfClass:[NSDictionary class]]) {
//                        composeModel.bigIcon = sub[@"story"][@"img"];
//                        composeModel.longTitle =sub[@"story"][@"summary"];
//                    }
//                    if ([sub[@"shop"] isKindOfClass:[NSDictionary class]]) {
//                        composeModel.shopName = sub[@"shop"][@"title"];
//                        composeModel.shopLogo = sub[@"shop"][@"img"];
//                        composeModel.shopID =sub[@"shop"][@"shop_id"];
//                    }
//                    if ([sub[@"link"] isKindOfClass:[NSDictionary class]]) {
//                        composeModel.url = sub[@"link"][@"url"];
//                        if (composeModel.url) {
//                            composeModel.keyParamete = @{@"paramete":composeModel.url};
//                            
//                        }
//                    }
//                    [self.stories addObject:composeModel];
//                }
//                
//            }
//        }else{
//            [self.tableView.mj_footer  endRefreshingWithNoMoreData];
//            
//        }
//        
//        [self.tableView reloadData];
//        success();
//    } failure:^(NSError *error) {
//        
//        failure();
//    }];
//}
///** 刷新回调方法 */
//-(void)refreshData
//{
//    [super refreshData];
//    self.pageNum=1;
//    [self gotStoryDataWithPageNum:self.pageNum actionType:Refresh Success:^{
//        [self.tableView reloadData];
//        [self.tableView.mj_header endRefreshing];
//    } failure:^{
//        [self.tableView.mj_header endRefreshing];
//        
//    }];
//    
//}
///** 加载更多的回调方法 */
//-(void)LoadMore
//{
//    [super LoadMore];
//    [self gotStoryDataWithPageNum:++self.pageNum actionType:LoadMore Success:^{
//        [self.tableView reloadData];
//        [self.tableView.mj_footer endRefreshing];
//    } failure:^{
//        [self.tableView.mj_footer endRefreshing];
//        
//    }];
//    
//}
//
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
//    
//    // Dispose of any resources that can be recreated.
//}
//
//-(void)setupTableView
//{
//    //    CGRect frame  = CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height - self.tabBarController.tabBar.bounds.size.height);
//    CGRect frame = CGRectMake(0, self.startY, self.view.bounds.size.width, self.view.bounds.size.height-self.startY);
//    UITableView     * tableView =[[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
//    self.tableView =tableView;
//    tableView.separatorStyle=0;
//    tableView.showsVerticalScrollIndicator = NO;
//    tableView.backgroundColor = BackgroundGray;
//    tableView.delegate=self;
//    tableView.dataSource = self;
//    //    tableView.rowHeight = UITableViewAutomaticDimension;
//    //    tableView.estimatedRowHeight=200;
//    tableView.rowHeight = 200 ;
//    
//    
//}
//
///** cell的代理方法 */
//-(void) skipInLaoStoryTabCell:(LaoStoryTabCell*)storyTabCell WithComposeModel:(BaseModel*)composeModel {
//    [[SkipManager shareSkipManager] skipByVC:self withActionModel:composeModel];
//    //    [[SkipManager shareSkipManager] skipForLocalByVC:self withActionModel:composeModel];
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0.00000000001;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 0.000000000000001;
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,self.stories)
//    return self.stories.count;
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    LaoStoryTabCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (!cell) {
//        cell = [[LaoStoryTabCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    }
//
//    LaoStoryCellModel * cellModel = self.stories[indexPath.row];
//    cell.laoStoryCellModel = cellModel;
//    cell.delegate=self;
//    return cell;
//}
///*
// #pragma mark - Navigation
// 
// // In a storyboard-based application, you will often want to do a little preparation before navigation
// - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
// // Get the new view controller using [segue destinationViewController].
// // Pass the selected object to the new view controller.
// }
// */
//-(void)viewWillLayoutSubviews{
//    [super viewWillLayoutSubviews];
////    self.tableView.frame = self.view.bounds;
//}
////-(void)viewWillAppear:(BOOL)animated{
////    [super viewWillAppear:animated];
////    self.tableView.frame= self.view.bounds;
////}
//
//-(NSMutableArray * )stories{
//    if(_stories==nil){
//        _stories = [[NSMutableArray alloc]init];
//        //        for (int i = 0 ;  i < 10; i++) {
//        //            [_stories addObject:[NSString stringWithFormat:@"%d",i]];
//        //        }
//    }
//    return _stories;
//}
//
//
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    
//    
//}
@end
