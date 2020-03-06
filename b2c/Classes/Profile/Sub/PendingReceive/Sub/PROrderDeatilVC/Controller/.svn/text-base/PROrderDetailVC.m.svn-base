//
//  PROrderDetailVC.m
//  b2c
//
//  Created by 0 on 16/4/18.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "PROrderDetailVC.h"
#import "PROrderDetailGoodsCell.h"
#import "PSORefundVC.h"
#import "PROrderDetailStateCell.h"
@interface PROrderDetailVC ()

@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation PROrderDetailVC
- (NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *arr = @[@{@"orderState":@(orderStatusWaitingForDelivery),@"backGroundImageStr":@"gwxq_product_header",@"reasonStr":@""},
                     @{@"receiptName":@"张凯强",@"receiptPhone":@"18614079684",@"receiptAddress":@"北京 北京市 丰台区，航丰路1号时代财富天地2015室"},
                     @{@"storeLogoImage":@"icon_coupon",@"storeName":@"御泥坊 官方旗舰店",@"goodsDetail":@[@{@"orderState":@(orderStatusWaitingForDelivery),@"goodImage":@"zhekouqu",@"goodTitle":@"加减法了；按付款就爱上了咖啡就卡机的房间萨克；的积分卡机的咖啡机阿卡卡的减肥",@"priceLabel":@"99.00",@"countLabel":@"X1"},@{@"orderState":@(orderStatusWaitingForDelivery),@"goodImage":@"zhekouqu",@"goodTitle":@"加减法了；按付款就爱上了咖啡就卡机的房间萨克；的积分卡机的咖啡机阿卡卡的减肥",@"priceLabel":@"99.00",@"countLabel":@"X1"}],@"freightLabel":@"0.00",@"realPaymentLabel":@"$99.00"},
                     @{@"sellerUrl":@"卖家的通讯地址"}];
    for (NSDictionary *dic in arr) {
        OrderDetailModel *orderModel = [OrderDetailModel mj_objectWithKeyValues:dic];
        [self.dataArr addObject:orderModel];
    }
    [self configmentTable];
    [self configmentBottomView];
    
    
    
    // Do any additional setup after loading the view.
}
#pragma mark -- 添加快捷按钮
- (void)configmentBottomView{
    UIView *bottomView = [[UIView alloc] init];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.table.mas_bottom).offset(0);
        make.left.bottom.right.equalTo(self.view);
    }];
    UILabel *confirmLabel = [[UILabel alloc] init];
    [bottomView addSubview:confirmLabel];
    confirmLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *confirmTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(confirm:)];
    [confirmLabel addGestureRecognizer:confirmTap];
    
    UILabel *logisticsLabel = [[UILabel alloc] init];
    [bottomView addSubview:logisticsLabel];
    
    logisticsLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *logisticsTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(logistics:)];
    [logisticsLabel addGestureRecognizer:logisticsTap];
    
    
    UILabel *receiptLabel = [[UILabel alloc] init];
    [bottomView addSubview:receiptLabel];
    
    receiptLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *receiptTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(receipt:)];
    [receiptLabel addGestureRecognizer:receiptTap];
    
    
    
    [confirmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView);
        make.right.equalTo(bottomView).offset(-20);
         make.width.equalTo(@(70));
        make.height.equalTo(@(30 * SCALE));
    }];
    [logisticsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView);
        make.right.equalTo(confirmLabel.mas_left).offset(-10);
        make.width.equalTo(@(70));
        make.height.equalTo(@(30 * SCALE));
    }];
    [receiptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView);
        make.right.equalTo(logisticsLabel.mas_left).offset(-10);
         make.width.equalTo(@(70));
        make.height.equalTo(@(30 * SCALE));
    }];
    [confirmLabel configmentfont:[UIFont systemFontOfSize:13] textColor:[UIColor blackColor] backColor:[UIColor clearColor] textAligement:1 cornerRadius:6 text:@"确认收货"];
    confirmLabel.layer.borderColor = [[UIColor redColor] CGColor];
    confirmLabel.layer.borderWidth = 1;
    [logisticsLabel configmentfont:[UIFont systemFontOfSize:13] textColor:[UIColor blackColor] backColor:[UIColor clearColor] textAligement:1 cornerRadius:6 text:@"查看物流"];
    logisticsLabel.layer.borderWidth = 1;
    logisticsLabel.layer.borderColor = [[UIColor blackColor] CGColor];
    [receiptLabel configmentfont:[UIFont systemFontOfSize:13] textColor:[UIColor blackColor] backColor:[UIColor clearColor] textAligement:1 cornerRadius:6 text:@"延迟收货"];
    receiptLabel.layer.borderWidth = 1;
    receiptLabel.layer.borderColor = [[UIColor blackColor] CGColor];
}
#pragma mark -- 确认收货
- (void)confirm:(UITapGestureRecognizer *)tap{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"确认收货")
}
#pragma mark -- 查看物流
- (void)logistics:(UITapGestureRecognizer *)logisticsTap{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"查看物流")
}
#pragma mark -- 延长收货
- (void)receipt:(UITapGestureRecognizer *)receiptTap{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"延长收货")
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}

- (void)configmentTable{
     self.table.backgroundColor = BackgroundGray;
     self.table.delegate = self;
     self.table.dataSource = self;
     
     self.table.rowHeight = UITableViewAutomaticDimension;
     self.table.estimatedRowHeight = 80;
     self.table.showsVerticalScrollIndicator = NO;
     [self.table registerClass:[OrderDeatilReceiptAddresCell class] forCellReuseIdentifier:@"OrderDeatilReceiptAddresCell"];
     [self.table registerClass:[PROrderDetailStateCell class] forCellReuseIdentifier:@"PROrderDetailStateCell"];
     [self.table registerClass:[PROrderDetailGoodsCell class] forCellReuseIdentifier:@"PROrderDetailGoodsCell"];
     
     [self.table registerClass:[OrderDetailContactSeller class] forCellReuseIdentifier:@"OrderDetailContactSeller"];
     
     self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
     self.table.frame = CGRectMake(0, self.startY, screenW, screenH - self.startY - 50 * SCALE);
     
 }
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        OrderDetailModel *model = self.dataArr[section];
        return model.goodsDetail.count;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
   
    OrderDetailModel *orderDetailModel = self.dataArr[indexPath.section];
    switch (indexPath.section) {
        case 0:
        {
            PROrderDetailStateCell *stateCell = [tableView dequeueReusableCellWithIdentifier:@"PROrderDetailStateCell" forIndexPath:indexPath];
            
            stateCell.orderTailModel = orderDetailModel;
            cell = stateCell;
        }
            break;
        case 1:
        {
            OrderDeatilReceiptAddresCell *addressCell = [tableView dequeueReusableCellWithIdentifier:@"OrderDeatilReceiptAddresCell" forIndexPath:indexPath];
            addressCell.orderTailModel = orderDetailModel;
            cell = addressCell;
        }
            break;
        case 2:
        {
            PROrderDetailGoodsCell *goodCell = [tableView dequeueReusableCellWithIdentifier:@"PROrderDetailGoodsCell" forIndexPath:indexPath];
            NSArray *arr = orderDetailModel.goodsDetail;
            goodCell.orderTailModel = arr[indexPath.row];
            if ((orderDetailModel.goodsDetail.count - 1) != indexPath.row) {
                goodCell.lineView.backgroundColor = [UIColor whiteColor];
            }else{
                goodCell.lineView.backgroundColor = BackgroundGray;
            }
            goodCell.delegate = self;
            cell = goodCell;
        }
            break;
        case 3:
        {
            OrderDetailContactSeller *contactCell = [tableView dequeueReusableCellWithIdentifier:@"OrderDetailContactSeller" forIndexPath:indexPath];
            cell = contactCell;
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
- (void)refundModel:(OrderDetailModel *)orderDetailModel{
    
    PSORefundVC *refundVC = [[PSORefundVC alloc] init];
    refundVC.orderDetailModel = orderDetailModel;
    [self.navigationController pushViewController:refundVC animated:YES];
}




@end
