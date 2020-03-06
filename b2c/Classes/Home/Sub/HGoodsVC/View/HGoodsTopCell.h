//
//  HGoodsTopCell.h
//  b2c
//
//  Created by 0 on 16/4/25.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//




@class HGTopSubGoodsShopModel;
@class HGoodsBottomSubModel;
@class HGTopSubGoodsShopSubModel;
@class HGTopSepecificationModel;

@protocol HGoodsTopDelegae <NSObject>
/**跳转到对应的页面,点击titleView中的按钮，*/
- (void)endScrollSelectIndex:(id)index;
/**点击商品跳转到商品详情VC*/
- (void)clickGoodsActionToTheGoodsDetailVCWith:(HGoodsBottomSubModel *)goodModel;
/**跳转到店铺详情页面*/
- (void)ClickActionToShopDetailWith:(HGTopSubGoodsShopModel *)shopModel;

/**跳转到店铺的全部商品页面*/
- (void)HGoodsTopCellActionToShopAllGoodsVCWith:(HGTopSubGoodsShopSubModel *)allGoodsModel;
/**商品分享*/
- (void)HGoodsTopCellShar;

/**弹出选择窗口*/
- (void)HGoodsTopCellSelectGoodsSpecificationWith:(id)object;
/**店铺分享*/
- (void)HGoodsTopCellSHopSharWithShop:(HGTopSubGoodsShopModel *)shopModel;
/**上新*/
-(void)HGoodsTopCellactionToshangxin:(HGTopSubGoodsShopModel *)shopModel;
/**跳转到和卖家聊天界面*/
- (void)HGoodsTopCellConsultWithSeller:(HGTopSubGoodsShopModel *)shopModel;
@end

#import "GoodsTopCollection.h"
#import <UIKit/UIKit.h>
#import "HGoodsBaseCell.h"
#import "HGoodsVC.h"
@interface HGoodsTopCell : HGoodsBaseCell
/**点击按钮滑动到指定的页面*/
- (void)scrollviewToTargetIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic, weak) id <HGoodsTopDelegae>delegate;
@property (nonatomic, strong) GoodsTopCollection *col;
/**数组*/
@property (nonatomic, strong) NSMutableArray *backArr;
/**滑动都第一个item*/
- (void)scrollviewToFirstItem;

@end


