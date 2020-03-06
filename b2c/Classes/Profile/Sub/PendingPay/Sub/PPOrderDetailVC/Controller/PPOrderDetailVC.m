//
//  PPOrderDetailVC.m
//  b2c
//
//  Created by 0 on 16/4/13.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "PPOrderDetailVC.h"
#import "OrderDeatilReceiptAddresCell.h"
#import "PPOrdrDetailStateCell.h"
#import "PPOrderDetailGoodsCell.h"
#import "OrderDetailContactSeller.h"
#import "GuessYouLikeTableHeadr.h"
#import "HGuesslikeCell.h"
#import "HCellModel.h"
#import "OrderDetailModel.h"
#import "HCellModel.h"
#import "HCellComposeModel.h"
#import "TotalOrderRefreshHeader.h"
#import "TotalOrderRefreshAutoFooter.h"
@interface PPOrderDetailVC ()
/**数据源数组*/
@property (nonatomic, strong) NSMutableArray *dataArr;
/**假数据*/
@property (nonatomic, weak) NSArray *data;

@property (nonatomic, weak) HCellModel *guessModel;



@end

@implementation PPOrderDetailVC

- (NSMutableArray *)dataArr{
    if (_dataArr== nil) {
        _dataArr = [[NSMutableArray alloc] init];
        
    }
    return _dataArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNumber = 1;
    [[UserInfo shareUserInfo] gotGuessLikeDataWithChannel_id:@"97" PageNum:1 success:^(ResponseObject *responseObject) {
        NSArray *arr = @[@{@"orderState":@(orderStatusWaitingForBuyerToPay),@"backGroundImageStr":@"gwxq_product_header",@"reasonStr":@""},
                         @{@"receiptName":@"张凯强",@"receiptPhone":@"18614079684",@"receiptAddress":@"北京 北京市 丰台区，航丰路1号时代财富天地2015室"},
                         @{@"storeLogoImage":@"icon_coupon",@"storeName":@"御泥坊 官方旗舰店",@"goodsDetail":@[@{@"orderState":@(orderStatusWaitingForBuyerToPay),@"goodImage":@"zhekouqu",@"goodTitle":@"加减法了；按付款就爱上了咖啡就卡机的房间萨克；的积分卡机的咖啡机阿卡卡的减肥",@"priceLabel":@"99.00",@"countLabel":@"X1"},@{@"orderState":@(orderStatusWaitingForBuyerToPay),@"goodImage":@"zhekouqu",@"goodTitle":@"加减法了；按付款就爱上了咖啡就卡机的房间萨克；的积分卡机的咖啡机阿卡卡的减肥",@"priceLabel":@"99.00",@"countLabel":@"X1"}],@"freightLabel":@"0.00",@"realPaymentLabel":@"$99.00"},
                         @{@"sellerUrl":@"卖家的通讯地址"}];
        for (NSDictionary *dic in arr) {
            OrderDetailModel *orderModel = [OrderDetailModel mj_objectWithKeyValues:dic];
            [self.dataArr addObject:orderModel];
        }
        
        
        
        NSInteger TarRow = 0;
        if (([responseObject.data[@"items"] count] % 2) == 0) {
            TarRow = [responseObject.data[@"items"] count]/2;
        }else{
            TarRow = ([responseObject.data[@"items"] count] - 1)/2 +1;
        }
        NSMutableArray *mutArr = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < TarRow; i++) {
            HCellModel *model = [[HCellModel alloc] init];
            for (NSInteger j = 0; j < 2; j++) {
                NSArray *arr = responseObject.data[@"items"];
                HCellComposeModel *comModel = [[HCellComposeModel alloc] initWithDict:arr[2 *i + j]];
                [model.items addObject:comModel];
            }
            [mutArr addObject:model];
        }
        
        
        [self.dataArr addObject:mutArr];
        
        [self.table reloadData];
    } failure:^(NSError *error) {
        LOG(@"%@,%d,%@",[self class], __LINE__,error)
    }];
    
    
    

    
    
    
   
    
    
    
    [self configmentTable];
    // Do any additional setup after loading the view.
}



- (void)configmentTable{
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.backgroundColor = [UIColor whiteColor];
    self.table.rowHeight = UITableViewAutomaticDimension;
    self.table.estimatedRowHeight = 80;
    self.table.showsVerticalScrollIndicator = NO;
    
    [self.table registerClass:[PPOrdrDetailStateCell class] forCellReuseIdentifier:@"PPOrdrDetailStateCell"];
    [self.table registerClass:[PPOrderDetailGoodsCell class] forCellReuseIdentifier:@"PPOrderDetailGoodsCell"];
    [self.table registerClass:[HGuesslikeCell class] forCellReuseIdentifier:@"HGuesslikeCell"];
    
    [self.table registerClass:[GuessYouLikeTableHeadr class] forHeaderFooterViewReuseIdentifier:@"GuessYouLikeTableHeadr"];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    TotalOrderRefreshHeader *refreashHeader = [TotalOrderRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
    self.table.mj_header = refreashHeader;
    
    TotalOrderRefreshAutoFooter *refreashFooter = [TotalOrderRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];
    self.table.mj_footer = refreashFooter;
}


/**下拉刷新*/
- (void)refreshHeader{
    [self.table.mj_header endRefreshing];
 
}
/**上拉刷新*/
- (void)refreshFooter{
    self.pageNumber++;
    [[UserInfo shareUserInfo] gotGuessLikeDataWithChannel_id:@"97" PageNum:self.pageNumber success:^(ResponseObject *responseObject) {
        NSInteger TarRow = 0;
        if (([responseObject.data[@"items"] count] % 2) == 0) {
            TarRow = [responseObject.data[@"items"] count]/2;
        }else{
            TarRow = ([responseObject.data[@"items"] count] - 1)/2 +1;
        }
        NSMutableArray *mutArr = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < TarRow; i++) {
            HCellModel *model = [[HCellModel alloc] init];
            for (NSInteger j = 0; j < 2; j++) {
                NSArray *arr = responseObject.data[@"items"];
                HCellComposeModel *comModel = [[HCellComposeModel alloc] initWithDict:arr[2 *i + j]];
                [model.items addObject:comModel];
            }
            [mutArr addObject:model];
        }
        
        NSInteger index = self.dataArr.count- 1;
        NSMutableArray *mutableArr = self.dataArr[index];
        [mutableArr addObjectsFromArray:mutArr];
        [self.table.mj_footer endRefreshing];
        [self.table reloadData];
    } failure:^(NSError *error) {
        LOG(@"%@,%d,%@",[self class], __LINE__,error)
    }];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        OrderDetailModel *model = self.dataArr[section];
        return model.goodsDetail.count;
    }
    if (section == 4) {
        NSMutableArray *arr =  self.dataArr[section];
        return arr.count;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    switch (indexPath.section) {
        case 0:
        {
            PPOrdrDetailStateCell *stateCell = [tableView dequeueReusableCellWithIdentifier:@"PPOrdrDetailStateCell" forIndexPath:indexPath];
            
            stateCell.orderTailModel = self.dataArr[indexPath.section];
            cell = stateCell;
        }
            break;
        case 1:
        {
            OrderDeatilReceiptAddresCell *addressCell = [tableView dequeueReusableCellWithIdentifier:@"OrderDeatilReceiptAddresCell" forIndexPath:indexPath];
            addressCell.orderTailModel = self.dataArr[indexPath.section];
            cell = addressCell;
        }
            break;
        case 2:
        {
            PPOrderDetailGoodsCell *goodCell = [tableView dequeueReusableCellWithIdentifier:@"PPOrderDetailGoodsCell" forIndexPath:indexPath];
            OrderDetailModel *orderDetailModel = self.dataArr[indexPath.section];
            if ((orderDetailModel.goodsDetail.count - 1) != indexPath.row) {
                goodCell.lineView.backgroundColor = [UIColor whiteColor];
            }else{
                goodCell.lineView.backgroundColor = BackgroundGray;
            }
            goodCell.orderTailModel = orderDetailModel.goodsDetail[indexPath.row];
            cell = goodCell;
        }
            break;
        case 3:
        {
            OrderDetailContactSeller *contactCell = [tableView dequeueReusableCellWithIdentifier:@"OrderDetailContactSeller" forIndexPath:indexPath];
 
            cell = contactCell;
        }
            break;
        case 4:
        {
            HGuesslikeCell *guessCell =[tableView dequeueReusableCellWithIdentifier:@"HGuesslikeCell" forIndexPath:indexPath];
            NSMutableArray *mutArr= self.dataArr[indexPath.section];
            guessCell.cellModel = mutArr[indexPath.row];
            cell = guessCell;
        }
            break;
            
            
        default:
            break;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return 40;
    }
    if (section == 4) {
        return 40;
    }
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) {
        return 80;
    }
    return 0.00001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        OrderDetailHeader *header = [[OrderDetailHeader alloc] initWithReuseIdentifier:@"OrderDetailHeader"];
        header.orderDetailModel = self.dataArr[section];
        header.delegate = self;
        return header;
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 2) {
        OrderDeatilFooter *footer = [[OrderDeatilFooter alloc] initWithReuseIdentifier:@"OrderDeatilFooter"];
        footer.orderDetailModel = self.dataArr[section];
        return footer;
    }
    return nil;
}

/**点击头部，跳转到商品详情页面*/
- (void)actionToSotreDetail{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"跳转到商品店铺")
//    [[SkipManager shareSkipManager] skipByVC:self urlStr:nil title:nil action:@"HStoreDetailsVC"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
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

@end
