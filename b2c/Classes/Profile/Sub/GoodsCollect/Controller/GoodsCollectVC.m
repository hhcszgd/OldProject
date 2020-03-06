//
//  GoodsCollectVC.m
//  b2c
//
//  Created by wangyuanfei on 3/30/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "GoodsCollectVC.h"
#import "GCCell.h"
#import "GCModel.h"
#import "CustomFRefresh.h"
@interface GoodsCollectVC ()
/**数据源数组*/
@property (nonatomic, strong) NSMutableArray *dataArray;
/**table*/
@property (nonatomic, strong) UITableView  *table;
@end

@implementation GoodsCollectVC

//- (NSMutableArray *)dataArray{
//    if (_dataArray == nil) {
//        _dataArray = [NSMutableArray array];
//    }
//    return _dataArray;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,self.keyParamete);
    self.originURL = self.keyParamete[@"paramete"];
//    [self configmentTable];
//    
//    
//    
//    [[UserInfo shareUserInfo] gotGoodsFavoriteSuccess:^(ResponseObject *response) {
//        
//        if ([response.data isKindOfClass:[NSDictionary class]]) {
//            
//            NSArray *dataArr = response.data[@"items"];
//            
//            for (NSDictionary *dic in dataArr) {
//                GCModel *model =[GCModel mj_objectWithKeyValues:dic];
//                LOG(@"%@,%d,%@",[self class], __LINE__,model)
//                [self.dataArray addObject:model];
//            }
//           
//        }
//        if ([response.data isKindOfClass:[NSArray class]]) {
//            
//        }
//         [self.table reloadData];
//    } failure:^(NSError *error) {
//        
//        [self showTheViewWhenDisconnectWithFrame:self.view.bounds];
//        
//        
//    }];
//    
//    
//    
//   
//
//    
//    
//    [self configmentNav];
//    
   
}

#pragma mark -- 点击重连
//- (void)reconnectClick:(UIButton *)sender{
//    [[UserInfo shareUserInfo] gotGoodsFavoriteSuccess:^(ResponseObject *response) {
//        [self removeTheViewWhenConnect];
//        if ([response.data isKindOfClass:[NSDictionary class]]) {
//            
//            NSArray *dataArr = response.data[@"items"];
//            
//            for (NSDictionary *dic in dataArr) {
//                GCModel *model =[GCModel mj_objectWithKeyValues:dic];
//                LOG(@"%@,%d,%@",[self class], __LINE__,model)
//                [self.dataArray addObject:model];
//            }
//            [self.table reloadData];
//        }
//        if ([response.data isKindOfClass:[NSArray class]]) {
//            
//        }
//    } failure:^(NSError *error) {
//        
//        [self showTheViewWhenDisconnectWithFrame:self.view.bounds];
//        
//        
//    }];
//    
//}
//
//
//
//- (void)configmentNav{
//    //控制器标题
//    self.title = @"商品收藏";
//}
//
//- (void)configmentTable{
//    
//    UITableView *shopTable = [[UITableView alloc] initWithFrame:CGRectMake(0, self.startY, screenW, screenH - self.startY) style:UITableViewStylePlain];
//    shopTable.delegate = self;
//    shopTable.dataSource = self;
//    shopTable.rowHeight = UITableViewAutomaticDimension;
//    shopTable.estimatedRowHeight = 100;
//    shopTable.separatorStyle = UITableViewCellSeparatorStyleNone;
//    shopTable.backgroundColor= BackgroundGray;
//    [shopTable registerClass:[GCCell class] forCellReuseIdentifier:@"GCCell"];
//    _table = shopTable;
//    CustomFRefresh *footerR = [CustomFRefresh footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];
//    self.table.mj_footer = footerR;
//    [self.view addSubview:shopTable];
//    
//    
//  
//}
///**下拉刷新*/
//- (void)refreshFooter{
//    [[UserInfo shareUserInfo] gotGoodsFavoriteSuccess:^(ResponseObject *response) {
//        [self removeTheViewWhenConnect];
//        if ([response.data isKindOfClass:[NSDictionary class]]) {
//            
//            NSArray *dataArr = response.data[@"items"];
//            
//            for (NSDictionary *dic in dataArr) {
//                GCModel *model =[GCModel mj_objectWithKeyValues:dic];
//                LOG(@"%@,%d,%@",[self class], __LINE__,model)
//                [self.dataArray addObject:model];
//            }
//            [self.table.mj_footer endRefreshing];
//            [self.table reloadData];
//            
//        }
//        if ([response.data isKindOfClass:[NSArray class]]) {
//            
//        }
//    } failure:^(NSError *error) {
//        
//        [self showTheViewWhenDisconnectWithFrame:self.view.bounds];
//        
//        
//    }];
//}
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
//    GCCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GCCell" forIndexPath:indexPath];
//    GCModel *model = self.dataArray[indexPath.row];
//    cell.gcModel = model;
//    return cell;
//}
//
//
//
//
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
////    [[SkipManager shareSkipManager] skipByVC:self urlStr:nil title:nil action:@"HGoodsVC"];
//}
//
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
