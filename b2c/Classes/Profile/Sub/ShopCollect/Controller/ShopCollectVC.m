//
//  ShopCollectVC.m
//  b2c
//
//  Created by wangyuanfei on 3/30/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//
/**收藏控制器*/
#import "ShopCollectVC.h"
#import "ShopCollectionCell.h"
#import "ShopCollectionDetailCell.h"
#import "CustomFRefresh.h"
#import "SCModel.h"
#import "SCCellSubModel.h"
#define detailCell @"ShopCollectionDetailCell"
#define titleCell @"ShopCollectionCell"
@interface  ShopCollectVC()
@property (nonatomic, strong) UITableView *shopTable;

@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ShopCollectVC
//- (NSMutableArray *)dataArray{
//    if (_dataArray == nil) {
//        _dataArray = [[NSMutableArray alloc] init];
//    }
//    return _dataArray;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.originURL  = self.keyParamete[@"paramete"];
//    self.naviTitle = @"店铺收藏";
//    [[UserInfo shareUserInfo] gotShopFavoriteSuccess:^(ResponseObject *response) {
//        LOG(@"%@,%d,%@",[self class], __LINE__,response.data)
//        for (NSDictionary *dic in response.data[@"items"]) {
//            SCModel *scModel = [SCModel mj_objectWithKeyValues:dic];
//            scModel.Cell = @"ShopCollectionCell";
//            scModel.isShopCollectionDetailCell = NO;
//            [self.dataArray addObject:scModel];
//        }
//        [self.shopTable reloadData];
//    } failure:^(NSError *error) {
//        [self showTheViewWhenDisconnectWithFrame:self.view.bounds];
//    }];
//    
//    
//    
//    self.view.backgroundColor = [UIColor whiteColor];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    //数据请求
//    
//    
//    
//    [self configmentNav];
    
}
#pragma mark -- 点击重新连接
//- (void)reconnectClick:(UIButton *)sender{
//    [self.dataArray removeAllObjects];
//    [[UserInfo shareUserInfo] gotShopFavoriteSuccess:^(ResponseObject *response) {
//        LOG(@"%@,%d,%@",[self class], __LINE__,response.data)
//        for (NSDictionary *dic in response.data[@"items"]) {
//            SCModel *scModel = [SCModel mj_objectWithKeyValues:dic];
//            scModel.Cell = @"ShopCollectionCell";
//            scModel.isShopCollectionDetailCell = NO;
//            [self.dataArray addObject:scModel];
//            [self.shopTable reloadData];
//        }
//        
//    } failure:^(NSError *error) {
//        [self showTheViewWhenDisconnectWithFrame:self.view.bounds];
//    }];
//}
//
//
//
//- (void)configmentNav{
//    UIBarButtonItem *barOne = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shop_more-1"] style:UIBarButtonItemStylePlain target:self action:@selector(showBackView)];
//    self.navigationController.navigationItem.rightBarButtonItem = barOne;
//}
////显示北京图片
//- (void)showBackView{
//    
//}
//- (UITableView *)shopTable{
//    if (_shopTable == nil) {
//        _shopTable = [[UITableView alloc] initWithFrame:CGRectMake(0, self.startY, screenW, screenH - self.startY) style:UITableViewStylePlain];
//        _shopTable.backgroundColor = BackgroundGray;
//        _shopTable.delegate = self;
//        _shopTable.dataSource = self;
//        _shopTable.rowHeight = UITableViewAutomaticDimension;
//        _shopTable.estimatedRowHeight = 100;
//        _shopTable.separatorStyle = UITableViewCellSeparatorStyleNone;
//        
//        [_shopTable registerClass:[ShopCollectionCell class] forCellReuseIdentifier:@"ShopCollectionCell"];
//        [_shopTable registerClass:[ShopCollectionDetailCell class] forCellReuseIdentifier:@"ShopCollectionDetailCell"];
//        CustomFRefresh *footerR = [CustomFRefresh footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
//        _shopTable.mj_footer = footerR;
//        [self.view addSubview:_shopTable];
//    }
//    return _shopTable;
//}
//#pragma mark -- 下拉加载更多
//- (void)footerRefresh{
//    [[UserInfo shareUserInfo] gotShopFavoriteSuccess:^(ResponseObject *response) {
//        LOG(@"%@,%d,%@",[self class], __LINE__,response.data)
//        for (NSDictionary *dic in response.data[@"items"]) {
//            SCModel *scModel = [SCModel mj_objectWithKeyValues:dic];
//            scModel.Cell = @"ShopCollectionCell";
//            scModel.isShopCollectionDetailCell = NO;
//            [self.dataArray addObject:scModel];
//            [self.shopTable.mj_footer endRefreshing];
//            [self.shopTable reloadData];
//            
//        }
//        
//    } failure:^(NSError *error) {
//        [self showTheViewWhenDisconnectWithFrame:self.view.bounds];
//    }];
//}
//
//
//
//
//
//
//
//#pragma mark -- tableView的代理
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.dataArray.count;
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    static UITableViewCell *myCell = nil;
//    SCModel *model = self.dataArray[indexPath.row];
//    if ([model.Cell isEqualToString:@"ShopCollectionCell"]) {
//        
//        ShopCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopCollectionCell" forIndexPath:indexPath];
//        cell.tableView = tableView;
//        cell.model = model;
//        
//        cell.myBlock =  ^(NSIndexPath *index){
//           
//            
//            if (!model.isShopCollectionDetailCell) {
//                //打开
//                //修改index位置测cell的模型值
//                
//                model.isShopCollectionDetailCell = YES;
//                //插入一条新的数据
//                
//                
//                SCModel *newModel = [[SCModel alloc] init];
//                newModel.isShopCollectionDetailCell = YES;
//                newModel.Cell = @"ShopCollectionDetailCell";
//                newModel.items = [NSMutableArray arrayWithArray:model.items];
//                
//                
//               
//                [self.dataArray insertObject:newModel atIndex:index.row + 1];
//                
//                [tableView beginUpdates];
//                NSIndexPath *path = [NSIndexPath indexPathForItem:index.row + 1 inSection:index.section];
//                [tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationBottom];
//                [tableView endUpdates];
//                
//            }else{
//                //关闭
//                model.isShopCollectionDetailCell = NO;
//                [self.dataArray removeObjectAtIndex:index.row +1];
//                
//                [tableView beginUpdates];
//                NSIndexPath *path = [NSIndexPath indexPathForItem:index.row + 1 inSection:index.section];
//                [tableView deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationTop];
//                [tableView endUpdates];
//            }
//        };
//        
//        myCell = cell;
//    }else {
//        
//        ShopCollectionDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopCollectionDetailCell" forIndexPath:indexPath];
//        
//        cell.data = model.items;
//        cell.shopCollectionDetailBlock = ^(SCCellSubModel *model){
////            [[SkipManager shareSkipManager] skipByVC:self urlStr:nil title:nil action:@"HGoodsVC"];
//        };
//       
//        myCell = cell;
//    }
//    myCell.selectionStyle = UITableViewCellSelectionStyleNone;
//    return myCell;
//    
//    
//}
//
//
//
//
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
////    [[SkipManager shareSkipManager] skipByVC:self urlStr:nil title:nil action:@"HStoreDetailsVC"];
//}
//
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
//    SCModel *model = self.dataArray[indexPath.row];
//    if ([model.Cell isEqualToString:@"ShopCollectionDetailCell"]||model.isShopCollectionDetailCell) {
//        return NO;
//    }
//    
//    return YES;
//}
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return UITableViewCellEditingStyleDelete;
//}
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        
//        [self.dataArray removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:YES];
//        
//        
//    }
//}
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return @"删除";
//}
//
//
//- (void)viewWillAppear:(BOOL)animated{
//    //    self.navigationController.navigationBarHidden = NO;
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
//    ;
//}
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}



@end
