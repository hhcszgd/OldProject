//
//  HShopCouponCell.h
//  b2c
//
//  Created by 0 on 16/5/6.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//
@class HStoreSubModel;
@protocol HShopCouponCellDelegate <NSObject>

/**跳转到优惠券详情页面*/
- (void)HShopCouponCellActionToCouponsDeatilVCWith:(HStoreSubModel *)couponsModel;

@end


#import "HStoreBaseCell.h"

@interface HShopCouponCell : HStoreBaseCell

@property (nonatomic, weak) id <HShopCouponCellDelegate>delegate;

@end
