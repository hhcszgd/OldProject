//
//  COrderGooditemCell.h
//  b2c
//
//  Created by 0 on 16/5/24.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "BaseCell.h"
#import "COrderGoodSubModel.h"
@interface COrderGooditemCell : BaseCell
@property (nonatomic, strong) COrderGoodSubModel *goodsModel;
@property (nonatomic, strong) UIView *separator;
/**判断是否是最后一个产品cell*/
@property (nonatomic, assign) BOOL isEndCell;
@end
