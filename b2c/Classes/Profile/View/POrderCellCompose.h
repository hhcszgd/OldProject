//
//  POrderCellCompose.h
//  b2c
//
//  Created by wangyuanfei on 4/8/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//
/**
 上面图片下面文字视图 尺寸为 全部订单和我的资产 专门定制
 */

#import "ActionBaseView.h"

@class POrderCellComposeModel;
@interface POrderCellCompose : ActionBaseView
@property(nonatomic,strong)UIImage * topImage ;
@property(nonatomic,copy)NSString * bottomTitle ;
@property(nonatomic,assign)NSInteger  cornerCount ;
@property(nonatomic,strong)POrderCellComposeModel * orderComposeModel ;
@end
