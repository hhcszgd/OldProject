//
//  POrderCell.h
//  b2c
//
//  Created by wangyuanfei on 3/30/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "BaseCell.h"

#import "PBaseCell.h"
@class PTableCellModel;
@interface POrderCell : PBaseCell
@property(nonatomic,copy)NSString * cellTitle ;
@property(nonatomic,strong)PTableCellModel * cellModel ;
@end
