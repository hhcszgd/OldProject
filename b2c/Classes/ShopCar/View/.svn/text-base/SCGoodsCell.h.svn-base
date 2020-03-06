//
//  SCGoodsCell.h
//  b2c
//
//  Created by wangyuanfei on 16/4/19.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "ShopCarBaseComposeView.h"
@class SCGoodsCell;
@protocol SCGoodsCellDelegate <NSObject>
-(void)chooseGoodsButtonClickInGoodsCell:(SCGoodsCell*)cell   ;
//-(void)gotoGoodsDetailInGoodsCell:(SCGoodsCell*)cell;
-(void)minusButtonClickInGoodsCell:(SCGoodsCell*)cell;
-(void)addButtonClickInGoodsCell:(SCGoodsCell*)cell;

@end

@class SVCGoods;

@interface SCGoodsCell : UITableViewCell
@property(nonatomic,strong)SVCGoods * goodsModel ;
@property(nonatomic,weak)id  <SCGoodsCellDelegate>  SCGoodsCellDelegate;
@end
