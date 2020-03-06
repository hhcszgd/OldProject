//
//  HGTopSubGoodsCell.h
//  b2c
//
//  Created by 0 on 16/4/25.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//


@class HGTopSubGoodsShopSubModel;
@class HGTopSubGoodsShopModel;
@class HGTopSepecificationModel;
@protocol HGTopSubGoodsCellDelegate <NSObject>
/**查看全部评价*/
- (void)checkAllEvluate;
/**商品分享*/
- (void)HGTopSubGoodsCellShar;

/**跳转到店铺详情页面*/
- (void)topSubGoodsactionToShopDetailWith:(HGTopSubGoodsShopModel *)shopModel;

/**跳转到店铺全部商品页面*/
- (void)HGTopSubGoodsCellActionToShopAllGoodsVCWith:(HGTopSubGoodsShopSubModel *)allGoodsModel;
/**选择商品规格*/
- (void)HGTopSubGoodsCellSelectGoodsSpecificationWith:(id)object;
/**店铺分享*/
- (void)HGTopSubGoodsCellSHopSharWithShop:(HGTopSubGoodsShopModel *)shopModel;
/**上新*/
-(void)HGTopSubGoodsCellactionToshangxin:(HGTopSubGoodsShopModel *)shopModel;
/**跳转到和卖家聊天界面*/
- (void)HGTopSubGoodsCellConsultWithSeller:(HGTopSubGoodsShopModel *)shopModel;
@end


#import <UIKit/UIKit.h>
#import "HGoodsBaseCell.h"
@interface HGTopSubGoodsCell : HGoodsBaseCell
@property (nonatomic, strong) UITableView *table;

@property (nonatomic, weak) id <HGTopSubGoodsCellDelegate>delegate;
@end
