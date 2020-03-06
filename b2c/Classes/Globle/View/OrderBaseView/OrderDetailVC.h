//
//  OrderDetailVC.h
//  b2c
//
//  Created by 0 on 16/4/13.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "SecondBaseVC.h"
#import "OrderDeatilReceiptAddresCell.h"
#import "OrderDetailContactSeller.h"
#import "OrderDetailStateCell.h"
#import "OrderDetailGoodsCell.h"
#import "OrderDetailHeader.h"
#import "OrderDeatilFooter.h"
@interface OrderDetailVC : SecondBaseVC<refundDelegate,OrderDetailToStoreDelegate>
@property (nonatomic, strong) UITableView *table;
/**猜你喜欢分页页码*/
@property (nonatomic, assign) NSInteger pageNumber;
@end
