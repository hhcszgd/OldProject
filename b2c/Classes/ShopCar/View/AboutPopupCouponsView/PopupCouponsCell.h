//
//  PopupCouponsCell.h
//  b2c
//
//  Created by wangyuanfei on 6/16/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "BaseCell.h"
@class PopupCouponsCell;

@protocol PopupCouponsCellDelegate <NSObject>

-(void)gotCouponsAction:(PopupCouponsCell*)view;

@end

@class HCCouponModel;
@interface PopupCouponsCell : BaseCell
@property(nonatomic,weak)id <PopupCouponsCellDelegate> PopupCouponsCellDelegate ;
@property(nonatomic,strong)HCCouponModel * couponModel ;
@end
