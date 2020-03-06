//
//  OrderDeatilFooter.h
//  b2c
//
//  Created by 0 on 16/4/18.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailModel.h"
@interface OrderDeatilFooter : UITableViewHeaderFooterView
/**运费*/
@property (nonatomic, strong) UILabel *freightLabel;
/**实付款*/
@property (nonatomic, strong) UILabel *realPaymentLabel;
/**model*/
@property (nonatomic, strong) OrderDetailModel *orderDetailModel;
@end
