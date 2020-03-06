//
//  OrderDeatilReceiptAddresCell.h
//  b2c
//
//  Created by 0 on 16/4/13.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailModel.h"
@interface OrderDeatilReceiptAddresCell : UITableViewCell
/**收货人*/
@property (nonatomic, strong) UILabel *receiptName;
/**收货人电话*/
@property (nonatomic, strong) UILabel *receiptPhone;
/**收货人地址*/
@property (nonatomic, strong) UILabel *receiptAddress;
/**地位小图标*/
@property (nonatomic, strong) UIImageView *locationImage;
@property (nonatomic, strong) OrderDetailModel *orderTailModel;
@end
