//
//  ConfirmOrderVC.h
//  b2c
//
//  Created by wangyuanfei on 16/4/21.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "SecondBaseVC.h"

@interface ConfirmOrderVC : SecondBaseVC
//会有一个包含多个商品id和数量的模型
@property(nonatomic,strong  ) NSMutableArray * goodsIDs  ;
/** 从购物车界面传过来的确认订单数据 */
@property(nonatomic,strong)  ResponseObject *response ;
@end
