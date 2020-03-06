//
//  ChooseAddressCell.h
//  b2c
//
//  Created by wangyuanfei on 16/5/22.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "BaseCell.h"
@class AMCell;

@protocol ChooseAddressCellDelegate <NSObject>


@end
@class AMCellModel;
@interface ChooseAddressCell : BaseCell
@property(nonatomic,strong)AMCellModel * addressModel ;
@property(nonatomic,weak)id  <ChooseAddressCellDelegate> AddressCellDelegate ;
@end
