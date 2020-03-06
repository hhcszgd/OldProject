//
//  HGTopSubDetailCell.h
//  b2c
//
//  Created by 0 on 16/4/25.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//
@class HGoodsBottomSubModel;
@protocol HGTopSubDetailCellDelegate <NSObject>
/**点击商品跳转到商品详情页面*/
- (void)clickGoodsActionToTheGoodsDetailVCWith:(HGoodsBottomSubModel *)goodModel;

@end
#import <UIKit/UIKit.h>
#import "HGoodsBaseCell.h"
@interface HGTopSubDetailCell : HGoodsBaseCell
@property (nonatomic, weak) id <HGTopSubDetailCellDelegate>delegate;
@end
