//
//  HGTopSubGoodsShopCell.h
//  b2c
//
//  Created by 0 on 16/5/9.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//
@class HGTopSubGoodsShopModel;
@class HGTopSubGoodsShopSubModel;
@protocol HGTopSubGoodsShopCellDelegate <NSObject>

/**跳转到商品详情页面*/
- (void)actionToShopDetailVCWith:(HGTopSubGoodsShopModel*)shopModel;
/**跳转到店铺的全部商品页面*/
- (void)HGTopSubGoodsShopCellActionToShopAllGoodsVCWith:(HGTopSubGoodsShopSubModel *)allGoodsModel;
/**收藏店铺的情况*/
- (void)HGTopSubGoodsShopCellCollectionShop:(NSString *)promptInformation;

/**店铺分享*/
- (void)HGTopSubGoodsShopCellSHopSharWithShop:(HGTopSubGoodsShopModel *)shopModel;
/**跳转到上新页面*/
- (void)HGTopSubGoodsShopCellactionToshangxin:(HGTopSubGoodsShopModel *)shopModel;
/**跳转到和卖家聊天页面*/
- (void)HGTopSubGoodsShopCellConsultWithSeller:(HGTopSubGoodsShopModel *)shopModel;
@end
#import <UIKit/UIKit.h>
#import "HGTopSubGoodsShopModel.h"
@interface HGTopSubGoodsShopCell : UITableViewCell
@property (nonatomic, strong) HGTopSubGoodsShopModel *shopModel;

@property (nonatomic, weak) id <HGTopSubGoodsShopCellDelegate>delegate;
@end
